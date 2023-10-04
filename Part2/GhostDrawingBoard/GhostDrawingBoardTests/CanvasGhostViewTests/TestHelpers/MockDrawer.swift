//
//  MockDrawer.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import UIKit
@testable import GhostDrawingBoard

class MockDrawer {
    var ghostTime: Double = 5.0
    var lineColor: UIColor = .white
    var lineWidth: CGFloat = 5.0
    
    var startpoint = CGPoint(x: 23, y: 23)
    var intermediatePoints = [
        CGPoint(x: 40, y: 40),
        CGPoint(x: 50, y: 50),
        CGPoint(x: 60, y: 60),
        CGPoint(x: 70, y: 70)
    ]

    var viewModel: GhostCanvasViewModelType?
    
    func updateToolParams(lineColor: UIColor,
                          ghostTime: Double,
                          lineWidth: CGFloat) {
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.ghostTime = ghostTime

    }
    func mockDrawing() {
        viewModel?.updateCanvasPresentation(lineColor: lineColor,
                                            ghostTime: ghostTime,
                                            lineWidth: lineWidth)
        viewModel?.didStartTouchAt(point: startpoint)
        intermediatePoints.forEach { point in
            self.viewModel?.didMoveTo(point: point)
        }
        self.viewModel?.didEndTouch()
    }
}
