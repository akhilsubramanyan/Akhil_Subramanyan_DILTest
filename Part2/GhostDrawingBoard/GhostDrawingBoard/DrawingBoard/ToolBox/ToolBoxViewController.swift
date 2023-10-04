//
//  ToolBoxViewController.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 28/09/23.
//

import UIKit

protocol ToolBoxViewType {
    var viewModel: ToolBoxViewModelType? { get set }
}

final class ToolBoxViewController: UIViewController,
                                   ToolBoxViewType {
    
    var viewModel: ToolBoxViewModelType?
    
    @IBOutlet weak var toolBoxStack: UIStackView!
    private var toolBarButtons: [UIButton] = []
    
    @objc func didClickToolButton(sender: UIButton) {
        viewModel?.didClickTool(at: sender.tag)
        selectButton(at: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func selectButton(at Index: Int) {
        for i in 0..<toolBarButtons.count {
            toolBarButtons[i].layer.borderWidth =  i == Index ? 5.0 : 0.0
        }
    }
    
    func bindViewModel() {
        viewModel?.toolBarSetUp = { [weak self] toolItems in
            self?.layoutToolButtons(tools: toolItems)
        }
        
        viewModel?.forceSelect = { [weak self] index in
            self?.selectButton(at: index)
        }
    }
    
    private func layoutToolButtons(tools: [ToolBoxPresentable]?) {
        guard let tools = tools else {
            return
        }
        for i in 0..<tools.count {
            
            switch tools[i].toolDisplayType {
            case .fillColor(let color):
                addToolButton(text: nil,
                              backgroundColor: color,
                              titleColor: nil,
                              tag: i)
            case .text(let text):
                addToolButton(text: text,
                              backgroundColor: .white,
                              titleColor: .black,
                              tag: i)
            }
        }
    }
    
    private func addToolButton(text: String?,
                               backgroundColor: UIColor,
                               titleColor: UIColor?,
                               tag: Int) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.didClickToolButton(sender:)), for: .touchUpInside)
        button.tag = tag
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(titleColor, for: .normal)
        button.setTitle(text ?? "", for: .normal)
        button.backgroundColor = backgroundColor
        toolBoxStack.addArrangedSubview(button)
        toolBarButtons.append(button)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalTo: toolBoxStack.heightAnchor)
        ])
    }
}
