//
//  GhostDrawToolViewModel.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 03/10/23.
//

import UIKit

typealias  DidSelectToolCallBack = (SelectedToolDisplayable) -> ()

protocol GhostDrawingBoardViewModelType {
    func getCanvasViewModel() -> GhostCanvasContainerViewModelType?
    func getToolBoxViewModel() -> ToolBoxViewModelType?
    func bind()
    var didSelectToolCallBack: DidSelectToolCallBack? { get set }
}

protocol SelectedToolDisplayable {
    var displayName: String { get }
    var displayColor: UIColor { get }
}

struct GhostDrawToolViewModel: GhostDrawTool,
                               ToolBoxPresentable,
                               SelectedToolDisplayable {
    // GhostDraw
    let color: UIColor
    let ghostTime: Double
    let linewidth: CGFloat
    
    //ToolBoxPresentation
    let toolDisplayType: ToolDisplayType
    
    //SelectedToolDisplay
    let displayName: String
    let displayColor: UIColor
}

final class GhostDrawingBoardViewModel: GhostDrawingBoardViewModelType {
    var didSelectToolCallBack: DidSelectToolCallBack?
    
    private struct Constants {
        static let defaultLineWidth = 2.0
        static let eraserWidth = 10.0
        static let defaultSelectIndex = 0
    }
    let drawTools = [GhostDrawToolViewModel(color: .red,
                                            ghostTime: 1.0,
                                            linewidth: Constants.defaultLineWidth,
                                            toolDisplayType: .fillColor(.red),
                                            displayName: "Red",
                                            displayColor: .red),
                     GhostDrawToolViewModel(color: .blue,
                                            ghostTime: 3.0,
                                            linewidth: Constants.defaultLineWidth,
                                            toolDisplayType: .fillColor(.blue),
                                            displayName: "Blue",
                                            displayColor: .blue),
                     GhostDrawToolViewModel(color: .green,
                                            ghostTime: 5.0,
                                            linewidth: Constants.defaultLineWidth,
                                            toolDisplayType: .fillColor(.green),
                                            displayName: "Green",
                                            displayColor: .green),
                     GhostDrawToolViewModel(color: .white,
                                            ghostTime: 2.0,
                                            linewidth: Constants.eraserWidth,
                                            toolDisplayType: .text("Eraser"),
                                            displayName: "Eraser",
                                            displayColor: .black)]
    
    var defaultDrawTool: GhostDrawToolViewModel? {
        drawTools[Constants.defaultSelectIndex]
    }
    
    var canvasViewModel: GhostCanvasContainerViewModelType = GhostCanvasContainerViewModel()
    var toolBoxViewModel: ToolBoxViewModelType =  ToolBoxViewModel()
    
    func getCanvasViewModel() -> GhostCanvasContainerViewModelType? {
        return canvasViewModel
    }
    func getToolBoxViewModel() -> ToolBoxViewModelType? {
        return toolBoxViewModel
    }
    
    func bind() {
        toolBoxViewModel.tools = drawTools
        toolBoxViewModel.defaultSelection = Constants.defaultSelectIndex
        toolBoxViewModel.selectToolCallBack = { [weak self] toolIndex in
             let selectedTool = self?.drawTools[toolIndex]
            self?.updateCanvasTool(tool: selectedTool)
            self?.updateSelectedTool(tool: selectedTool)
        }
        updateCanvasTool(tool: defaultDrawTool)
    }
    
    private func updateCanvasTool(tool: GhostDrawTool?) {
        guard let tool = tool else {
            return
        }
        canvasViewModel.updateCanvasPresentation(lineColor: tool.color,
                                                 ghostTime: tool.ghostTime,
                                                 lineWidth: tool.linewidth)
    }
    
    private func updateSelectedTool(tool: SelectedToolDisplayable?) {
        guard let tool = tool else {
            return
        }
        didSelectToolCallBack?(tool)
    }
}
