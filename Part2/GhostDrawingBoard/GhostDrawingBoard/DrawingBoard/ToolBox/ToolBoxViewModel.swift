//
//  ToolBoxViewModelType.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import UIKit

typealias ToolBarSetUpCallBack = ([ToolBoxPresentable]?) -> ()
typealias ToolBarSelectCallBack = (Int) -> ()

protocol ToolBoxViewModelType: ToolBoxInteractor {
    var tools: [ToolBoxPresentable]? { get set }
    var defaultSelection: Int? { get set }
    var toolBarSetUp: ToolBarSetUpCallBack? { get set }
    func didClickTool(at index: Int)
    var forceSelect: ToolBarSelectCallBack? {get set }
}

protocol GhostDrawTool {
    var color: UIColor { get }
    var ghostTime: Double { get }
    var linewidth: CGFloat { get }
}

enum ToolDisplayType {
    case fillColor(UIColor)
    case text(String)
}

protocol ToolBoxPresentable {
    var toolDisplayType: ToolDisplayType { get }
}

protocol ToolBoxInteractor {
    var selectToolCallBack: ToolBarSelectCallBack? { get set }
}

final class ToolBoxViewModel: ToolBoxViewModelType {
    var defaultSelection: Int? {
        didSet {
            forceSelect?(defaultSelection ?? 0)
        }
    }
    var selectToolCallBack: ToolBarSelectCallBack?
    var tools: [ToolBoxPresentable]? {
        didSet {
            toolBarSetUp?(tools)
        }
    }
    var toolBarSetUp: ToolBarSetUpCallBack?
    var forceSelect: ToolBarSelectCallBack?
    func didClickTool(at index: Int) {
        selectToolCallBack?(index)
    }
}
