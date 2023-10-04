//
//  CanvasViewModelSpy.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import UIKit
@testable import GhostDrawingBoard

final class CanvasViewModelStub: GhostCanvasContainerViewModelType {
    var selectedColor: UIColor?
    var selectedGhostTime: Double?
    var selectedLineWidth: CGFloat?

    func getGhostViewModel() -> GhostDrawingBoard.GhostCanvasViewModelType? {
        return nil
    }
    
    var resetDrawCanvas: GhostDrawingBoard.ResetImageView?
    
    func updateCanvasPresentation(lineColor: UIColor,
                                  ghostTime: Double,
                                  lineWidth: CGFloat) {
        self.selectedColor = lineColor
        self.selectedGhostTime = ghostTime
        self.selectedLineWidth = lineWidth
    }
}
