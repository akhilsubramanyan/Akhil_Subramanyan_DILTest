//
//  GhostCanvasView.swift
//  GhostDrawingBoard
//
//  Created by Akhil Subramanyan on 03/10/23.
//

import UIKit

final class GhostCanvasView: UIView {
    
    private var drawingLayer: CALayer?

    var inputImage: UIImage? {
        didSet {
            if let inputImage = inputImage {
                backgroundColor = UIColor(patternImage: inputImage)
            }
        }
    }

    var viewModel: GhostCanvasViewModelType? 

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let touch = touches.first {
            let startPoint = touch.location(in: self)
            viewModel?.didStartTouchAt(point: startPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            viewModel?.didMoveTo(point: currentPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewModel?.didEndTouch()
    }
    
    func bindViewModel() {
        
        viewModel?.canvasImageCallBack = { [weak self] in
            return self?.flattenCanvasToImage()
        }
        
        viewModel?.drawLineCallBack = { [weak self] (startPoint: CGPoint,
                                                    lineWidth: CGFloat,
                                                    intermediatePoints: [CGPoint],
                                                    color: UIColor)  in
            self?.drawLine(startPoint: startPoint,
                           lineWidth: lineWidth,
                           intermediatePoints: intermediatePoints,
                           color: color)
        }
    }
    
    private func drawPath(_ path: UIBezierPath,
                  lineWidth: CGFloat,
                  color: UIColor) {

        setupDrawingLayerIfNeeded()

        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.fillColor = UIColor.clear.cgColor
        drawingLayer?.addSublayer(lineLayer)
        setNeedsDisplay()
    }

    func drawLine(startPoint: CGPoint,
                          lineWidth: CGFloat,
                          intermediatePoints: [CGPoint],
                          color: UIColor) {

        let linePath = UIBezierPath()
        linePath.lineWidth = lineWidth
        linePath.lineCapStyle = .round
        linePath.move(to: startPoint)
        intermediatePoints.forEach { currentPoint in
            linePath.addLine(to: currentPoint)
            drawPath(linePath,
                     lineWidth: lineWidth,
                     color: color)
        }
    }
    
    private func setupDrawingLayerIfNeeded() {
        guard drawingLayer == nil else { return }
        let sublayer = CALayer()
        sublayer.contentsScale = UIScreen.main.scale
        sublayer.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(sublayer)
        drawingLayer = sublayer
    }
    
    
    func flattenCanvasToImage() -> UIImage? {
        var outputImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {

            // keep old drawings
            if let image = inputImage {
                image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            }
            drawingLayer?.backgroundColor = UIColor.white.cgColor

            // add new drawings
            drawingLayer?.render(in: context)

            outputImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
       return outputImage
    }
}
