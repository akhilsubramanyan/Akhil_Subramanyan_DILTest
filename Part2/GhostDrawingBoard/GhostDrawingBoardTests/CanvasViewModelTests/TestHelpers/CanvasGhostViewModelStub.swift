//
//  CanvasGhostViewModelStub.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//
import UIKit
import Foundation
@testable import GhostDrawingBoard

class CanvasGhostViewModelStub: GhostCanvasViewModelType {
    
    var selectedColor: UIColor?
    var selectedGhostTime: Double?
    var selectedLineWidth: CGFloat?
    
    var drawLineCallBack: GhostDrawingBoard.DrawLineCallBack?
    
    var canvasImageCallBack: GhostDrawingBoard.CanvasImageCallBack?
    
    func didStartTouchAt(point: CGPoint) { }
    
    func didMoveTo(point: CGPoint) { }
    
    func didEndTouch() { }
    
    var drawSessionCompletion: GhostDrawingBoard.DrawSessionCompletion?
    
    func updateCanvasPresentation(lineColor: UIColor,
                                  ghostTime: Double,
                                  lineWidth: CGFloat) {
        self.selectedColor = lineColor
        self.selectedGhostTime = ghostTime
        self.selectedLineWidth = lineWidth
    }
}
