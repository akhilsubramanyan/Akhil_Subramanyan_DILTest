//
//  GhostCanvasContainerViewType.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 28/09/23.
//

import UIKit

protocol GhostCanvasContainerViewType {
    var viewModel: GhostCanvasContainerViewModelType? { get set }
}

final class GhostCanvasContainerViewController: UIViewController,
                                    GhostCanvasContainerViewType {

    private var ghostViewSession: GhostCanvasView?

    var viewModel: GhostCanvasContainerViewModelType? 

    func bindViewModel() {
        viewModel?.resetDrawCanvas = { [weak self] oldSessionImage in
            self?.resetDrawSession(oldSessionImage)
        }
        initializeCanvasViewDrawSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}

private extension GhostCanvasContainerViewController {
    
    func initializeCanvasViewDrawSession(inputImage: UIImage? = nil) {
        addGhostCanvasView()
        bindGhostSessionView(inputImage: inputImage)
    }

    func resetDrawSession(_ oldSessionImage: UIImage?) {
        removeGhostCanvasView()
        initializeCanvasViewDrawSession(inputImage: oldSessionImage)
    }
    
    func bindGhostSessionView(inputImage: UIImage?) {
        ghostViewSession?.viewModel = viewModel?.getGhostViewModel()
        ghostViewSession?.inputImage = inputImage
        ghostViewSession?.bindViewModel()
    }
    
    func removeGhostCanvasView() {
        ghostViewSession?.removeFromSuperview()
        ghostViewSession = nil
    }
    
    func addGhostCanvasView() {
        ghostViewSession = GhostCanvasView()
        guard let canvasView = ghostViewSession else {
            return
        }
        canvasView.layer.masksToBounds = true
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.leftAnchor.constraint(equalTo: view.leftAnchor),
            canvasView.rightAnchor.constraint(equalTo: view.rightAnchor),
            canvasView.topAnchor.constraint(equalTo: view.topAnchor),
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
