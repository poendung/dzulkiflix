//
//  CircleProgressView.swift
//  Dzulkiflix
//
//  Created by Apple on 23/07/21.
//

import Foundation
import UIKit

class CircleProgressView : UIView {
    var margin: CGFloat = 4
    var lineWidth: CGFloat = 4
    var strokeColor: CGColor = UIColor.green.cgColor {
        didSet { setNeedsDisplay() }
    }
    var maskColor: CGColor = UIColor.systemGreen.cgColor {
        didSet { setNeedsDisplay() }
    }
    var progressLayer: CAShapeLayer = CAShapeLayer()
    var backgroundMask: CAShapeLayer = CAShapeLayer()
    var progress: CGFloat = 0.75 {
        didSet { setNeedsDisplay() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    func setupLayers() {
        backgroundMask.lineWidth = lineWidth
        backgroundMask.fillColor = nil
        layer.addSublayer(backgroundMask)

        progressLayer.lineWidth = lineWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: margin + lineWidth, dy: margin + lineWidth))
        backgroundMask.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = strokeColor
        
        backgroundMask.strokeColor = maskColor
    }
}
