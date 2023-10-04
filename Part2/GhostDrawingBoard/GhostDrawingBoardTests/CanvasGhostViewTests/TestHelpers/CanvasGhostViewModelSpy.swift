//
//  CanvasGhostViewModelSpy.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import UIKit
@testable import GhostDrawingBoard

class CanvasGhostViewModelSpy {
    var testImage = UIImage()
    var didCalledCanvasImageCallBack = false
    var viewModel: GhostCanvasViewModelType?
    
    var lineStartPoint: CGPoint?
    var lineWidth: CGFloat?
    var linePoints: [CGPoint]?
    var lineColor: UIColor?

    var completeDrawCallBack: ((UIImage?) -> ())?
    func bindViewModel() {
        viewModel?.canvasImageCallBack = { [weak self]  in
            return self?.testImage
        }
        viewModel?.drawLineCallBack = { [weak self] (startPoint: CGPoint,
                                                     lineWidth: CGFloat,
                                                     intermediatePoints: [CGPoint],
                                                     color: UIColor)  in
            self?.lineStartPoint = startPoint
            self?.lineWidth = lineWidth
            self?.linePoints = intermediatePoints
            self?.lineColor = color
         }
        
        viewModel?.drawSessionCompletion = { [weak self]  image in
            self?.didCalledCanvasImageCallBack =  true
            self?.completeDrawCallBack?(image)
        }
    }
}
