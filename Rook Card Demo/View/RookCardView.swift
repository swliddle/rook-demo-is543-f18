//
//  RookCardView.swift
//  Rook Card Demo
//
//  Created by Steve Liddle on 10/4/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

@IBDesignable
class RookCardView : UIView {

    // MARK: - Constants

    private struct Card {
        static let backImageName = "RookBack"
        static let cornerRookImageName = "RookSquareTurquoise"
        static let fontName = "Palatino-Bold"
        static let rookImageName = "RookSquare"
        static let underlinedRanks = [ 6, 9 ]
    }

    // MARK: - Properties

    @IBInspectable var isFaceUp: Bool = true
    @IBInspectable var rank: Int = 1
    @IBInspectable var suit: String = "green"

    // MARK: - Computed properties

    // See slides for explanations of the uses of these computed properties

    var centerFontSize       : CGFloat { return bounds.width * 0.55 }
    var centerImageMargin    : CGFloat { return bounds.width * 0.15 }
    var cornerImageWidth     : CGFloat { return bounds.width * 0.18 }
    var cornerRadius         : CGFloat { return bounds.width * 0.05 }
    var cornerRankFontSize   : CGFloat { return bounds.width * 0.2 }
    var cornerSuitFontSize   : CGFloat { return bounds.width * 0.0666 }
    var cornerSuitOffset     : CGFloat { return bounds.width * 0.01 }
    var cornerXOffset        : CGFloat { return bounds.width * 0.0556 }
    var cornerYOffset        : CGFloat { return bounds.width * 0.0667 }
    var squareMargin         : CGFloat { return bounds.width * 0.189 }
    var squareStrokeWidth    : CGFloat { return bounds.width * 0.005 }
    var underlineOffset      : CGFloat { return bounds.width * 0.0333 }
    var underlineInset       : CGFloat { return bounds.width * 0.0222 }
    var underlineStrokeWidth : CGFloat { return bounds.width * 0.0111 }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.clear
        isOpaque = false
    }

    // MARK: - Drawing

    override func draw(_ rect: CGRect) {
        drawBaseCard()

        if isFaceUp {
            drawFaceUp()
        } else {
            drawFaceDown()
        }
    }

    private func drawBaseCard() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        roundedRect.addClip()
        UIColor.white.setFill()
        UIRectFill(bounds)
    }

    private func drawFaceDown() {

    }

    private func drawFaceUp() {

    }
}
