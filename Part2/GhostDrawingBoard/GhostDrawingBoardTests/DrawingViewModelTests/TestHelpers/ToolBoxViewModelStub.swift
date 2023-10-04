//
//  ToolBoxViewModelSpy.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import Foundation
@testable import GhostDrawingBoard

final class ToolBoxViewModelStub: ToolBoxViewModelType {
    var defaultSelection: Int?
    
    var forceSelect: GhostDrawingBoard.ToolBarSelectCallBack?
    
    var tools: [GhostDrawingBoard.ToolBoxPresentable]?
    
    var toolBarSetUp: GhostDrawingBoard.ToolBarSetUpCallBack?
    
    func didClickTool(at index: Int) {
        selectToolCallBack?(index)
    }
    
    var selectToolCallBack: GhostDrawingBoard.ToolBarSelectCallBack?
            
}
