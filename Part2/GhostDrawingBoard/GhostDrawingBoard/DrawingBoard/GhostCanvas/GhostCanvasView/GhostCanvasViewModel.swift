//
//  GhostCanvasViewModel.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 03/10/23.
//

import UIKit

typealias DrawSessionCompletion = (UIImage?) -> ()

private struct Line {
    let startPoint: CGPoint
    let color: UIColor
    let width: CGFloat
    let ghostTime: Double
    var interMediatePoints: [CGPoint] = []
    var isValid: Bool {
        return !interMediatePoints.isEmpty
    }
}

typealias DrawLineCallBack = (_ startPoint: CGPoint,
                             _ lineWidth: CGFloat,
                             _ intermediatePoints: [CGPoint],
                             _ color: UIColor) -> ()
typealias CanvasImageCallBack = () -> UIImage?


protocol GhostCanvasViewInteractorModelType: GhostCanvasPresenter {
    var drawSessionCompletion: DrawSessionCompletion? { get set }
}

protocol GhostCanvasViewModelType: GhostCanvasViewInteractorModelType {
    var drawLineCallBack: DrawLineCallBack? { get set }
    var canvasImageCallBack: CanvasImageCallBack? { get set }
    func didStartTouchAt(point: CGPoint)
    func didMoveTo(point: CGPoint)
    func didEndTouch()
}


final class GhostCanvasViewModel: GhostCanvasViewModelType {
    private struct CanvasGhostViewPresentation {
        let lineColor: UIColor
        let ghostTime: Double
        let lineWidth: CGFloat
    }
    
    var drawLineCallBack: DrawLineCallBack?
    var canvasImageCallBack: CanvasImageCallBack?
    var drawSessionCompletion: DrawSessionCompletion?
    
    private var currentLine: Line?
    
    private var presentation: CanvasGhostViewPresentation?
    
    func updateCanvasPresentation(lineColor: UIColor,
                                  ghostTime: Double,
                                  lineWidth: CGFloat) {
        presentation = CanvasGhostViewPresentation(lineColor: lineColor,
                                                   ghostTime: ghostTime,
                                                   lineWidth: lineWidth)
    }
    func didStartTouchAt(point: CGPoint) {
        guard let presentation = presentation else {
            return
        }
        currentLine = Line(startPoint: point,
                           color: presentation.lineColor,
                           width: presentation.lineWidth,
                           ghostTime: presentation.ghostTime)
    }
    func didMoveTo(point: CGPoint) {
        currentLine?.interMediatePoints.append(point)
    }
    
    func didEndTouch() {
        enqueueCurrentLineForDraw()
    }
    
    func enqueueCurrentLineForDraw() {
        guard let line = currentLine,
              line.isValid else {
            return
        }
        let delayInSeconds: Double = line.ghostTime
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            self?.drawLineCallBack?(line.startPoint,
                                   line.width,
                                   line.interMediatePoints,
                                   line.color)
            
            let canvasImage = self?.canvasImageCallBack?()
            self?.drawSessionCompletion?(canvasImage)
        }
        currentLine = nil
    }
    
}
