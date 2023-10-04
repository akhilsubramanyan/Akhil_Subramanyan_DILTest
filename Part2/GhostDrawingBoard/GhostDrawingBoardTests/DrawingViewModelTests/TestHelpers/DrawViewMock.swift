//
//  DrawViewMock.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import UIKit

@testable import GhostDrawingBoard

class DrawViewModelBindMock {
    var selectedToolColor: UIColor?
    var selectedToolDisplayName: String?
    
    var viewModel: GhostDrawingBoardViewModelType?
    
    func bind() {
        viewModel?.didSelectToolCallBack = { [weak self] tool in
            self?.selectedToolDisplayName = tool.displayName
            self?.selectedToolColor = tool.displayColor
        }
    }
}
