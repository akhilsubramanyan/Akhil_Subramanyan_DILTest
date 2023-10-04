//
//  DrawSessionCompleteSpy.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import Foundation
@testable import GhostDrawingBoard

class DrawSessionCompleteSpy {
    var viewModel: GhostCanvasContainerViewModelType?
    var didCallDrawSessionComplete: Bool = false
    
    func bindViewModel() {
        viewModel?.resetDrawCanvas = { [weak self] image in
            self?.didCallDrawSessionComplete = true
        }
    }
}
