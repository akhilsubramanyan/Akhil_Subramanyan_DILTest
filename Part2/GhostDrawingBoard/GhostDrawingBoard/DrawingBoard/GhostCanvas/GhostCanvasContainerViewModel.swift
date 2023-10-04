//
//  GhostCanvasContainerViewModel.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 03/10/23.
//

import UIKit

typealias ResetImageView = (UIImage?) -> ()

protocol GhostCanvasPresenter {
    func updateCanvasPresentation(lineColor: UIColor,
                                  ghostTime: Double,
                                  lineWidth: CGFloat)
}

protocol GhostCanvasContainerViewModelType: GhostCanvasPresenter {
    func getGhostViewModel() -> GhostCanvasViewModelType?
    var resetDrawCanvas: ResetImageView? { get set }
}

final class GhostCanvasContainerViewModel: GhostCanvasContainerViewModelType {
    var resetDrawCanvas: ResetImageView?
    
    var ghostViewModel: GhostCanvasViewModelType? = GhostCanvasViewModel()
    
    func getGhostViewModel() -> GhostCanvasViewModelType? {
        return ghostViewModel
    }
    
    
    func updateCanvasPresentation(lineColor: UIColor,
                                  ghostTime: Double,
                                  lineWidth: CGFloat) {
        ghostViewModel?.updateCanvasPresentation(lineColor: lineColor,
                                                ghostTime: ghostTime,
                                                lineWidth: lineWidth)
        ghostViewModel?.drawSessionCompletion = { [weak self] image in
            self?.resetDrawCanvas?(image)
        }
    }
}
