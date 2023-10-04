//
//  GhostDrawingBoardViewController.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 28/09/23.
//

import UIKit

final class GhostDrawingBoardViewController: UIViewController {
    
    @IBOutlet private var selectionLabel: UILabel!
    
    var viewModel: GhostDrawingBoardViewModelType =  GhostDrawingBoardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "toolBox":
            if var toolBox = segue.destination as? ToolBoxViewType {
                toolBox.viewModel = viewModel.getToolBoxViewModel()
            }
        case "canvas":
            if var canvas = segue.destination as? GhostCanvasContainerViewType {
                canvas.viewModel = viewModel.getCanvasViewModel()
            }
        default:
            break
        }
    }

    func bindViewModel() {
        viewModel.didSelectToolCallBack = { [weak self] selectTool in
            self?.selectionLabel.text = selectTool.displayName
            self?.selectionLabel.textColor = selectTool.displayColor
        }
        viewModel.bind()
    }
}

