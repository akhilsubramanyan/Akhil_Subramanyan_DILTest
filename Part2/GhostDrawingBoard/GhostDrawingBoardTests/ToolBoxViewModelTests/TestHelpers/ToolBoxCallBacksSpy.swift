//
//  ToolBoxCallBacksSpy.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import Foundation
@testable import GhostDrawingBoard

class ToolBoxCallBacksSpy {
    var viewModel: ToolBoxViewModelType?
    var didCallToolBarSetUp = false
    var selectedIndex:Int?
    
    func bindViewModel() {
        viewModel?.toolBarSetUp = { [weak self] _ in
            self?.didCallToolBarSetUp = true
        }
        viewModel?.selectToolCallBack = { [weak self] selectedIndex in
            self?.selectedIndex = selectedIndex
        }
    }
}
