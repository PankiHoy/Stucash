//
//  QRFrameView.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import QuartzCore
import UIKit

final class QRFrameView: UIView {
    let topLeftLine: CAShapeLayer
    let topRightLine: CAShapeLayer
    let bottomLeftLine: CAShapeLayer
    let bottomRightLine: CAShapeLayer
    
    override init(frame: CGRect) {
        self.topLeftLine = CAShapeLayer()
        self.topRightLine = CAShapeLayer()
        self.bottomLeftLine = CAShapeLayer()
        self.bottomRightLine = CAShapeLayer()
        
        super.init(frame: .zero)
        
        for line in self.lines {
            line.strokeColor = UIColor.stucashGold?.cgColor
            line.fillColor = UIColor.clear.cgColor
            line.lineWidth = 4.0
            line.lineCap = .round
            self.layer.addSublayer(line)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var lines: [CAShapeLayer] {
        return [
            self.topLeftLine,
            self.topRightLine,
            self.bottomLeftLine,
            self.bottomRightLine
        ]
    }
    
    override func layoutSubviews() {
        let cornerRadius: CGFloat = 6.0
        
        let lineLength = self.bounds.size.width / 2.0 - cornerRadius
        let targetLineLength = 24.0
        let fraction = targetLineLength / lineLength
        let strokeFraction = (1.0 - fraction) / 2.0
        let strokeStart = strokeFraction
        let strokeEnd = 1.0 - strokeFraction
        
        let topLeftPath = CGMutablePath()
        topLeftPath.move(to: CGPoint(x: 0.0, y: self.bounds.size.height / 2.0))
        topLeftPath.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -.pi, endAngle: -.pi / 2.0, clockwise: false)
        topLeftPath.addLine(to: CGPoint(x: self.bounds.size.width / 2.0, y: 0.0))
        self.topLeftLine.path = topLeftPath
        self.topLeftLine.strokeStart = strokeStart
        self.topLeftLine.strokeEnd = strokeEnd
        
        let topRightPath = CGMutablePath()
        topRightPath.move(to: CGPoint(x: self.bounds.size.width / 2.0, y: 0.0))
        topRightPath.addArc(center: CGPoint(x: self.bounds.size.width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: -.pi / 2.0, endAngle: 0.0, clockwise: false)
        topRightPath.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height / 2.0))
        self.topRightLine.path = topRightPath
        self.topRightLine.strokeStart = strokeStart
        self.topRightLine.strokeEnd = strokeEnd
        
        let bottomRightPath = CGMutablePath()
        bottomRightPath.move(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height / 2.0))
        bottomRightPath.addArc(center: CGPoint(x: self.bounds.size.width - cornerRadius, y: self.bounds.size.height - cornerRadius), radius: cornerRadius, startAngle: 0.0, endAngle: .pi / 2.0, clockwise: false)
        bottomRightPath.addLine(to: CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height))
        self.bottomRightLine.path = bottomRightPath
        self.bottomRightLine.strokeStart = strokeStart
        self.bottomRightLine.strokeEnd = strokeEnd
        
        let bottomLeftPath = CGMutablePath()
        bottomLeftPath.move(to: CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height))
        bottomLeftPath.addArc(center: CGPoint(x: cornerRadius, y: self.bounds.size.height - cornerRadius), radius: cornerRadius, startAngle: .pi / 2.0, endAngle: .pi, clockwise: false)
        bottomLeftPath.addLine(to: CGPoint(x: 0.0, y: self.bounds.size.height / 2.0))
        self.bottomLeftLine.path = bottomLeftPath
        self.bottomLeftLine.strokeStart = strokeStart
        self.bottomLeftLine.strokeEnd = strokeEnd
        
        for line in self.lines {
            line.frame = CGRect(origin: .zero, size: self.bounds.size)
        }
    }
}
