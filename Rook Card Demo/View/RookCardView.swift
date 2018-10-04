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
        static let suitColors: [RookCard.Suit : UIColor] = [
            .rook   : UIColor(r:  34, g: 193, b: 196),
            .red    : UIColor(r: 237, g:  37, b:  50),
            .green  : UIColor(r:  36, g: 193, b:  80),
            .yellow : UIColor(r: 242, g: 199, b:  58),
            .black  : UIColor.black
        ]
        static let underlinedRanks = [ 6, 9 ]
    }

    // MARK: - Properties

    var card = RookCard()

    // MARK: - Computed properties

    @IBInspectable var isFaceUp: Bool {
        get {
            return card.isFaceUp
        }
        set {
            card.isFaceUp = newValue
        }
    }

    @IBInspectable var rank: Int {
        get {
            return card.rank
        }
        set {
            card.rank = newValue
        }
    }

    @IBInspectable var suit: String {
        get {
            return card.suit.description
        }
        set {
            if let newSuit = RookCard.Suit(rawValue: newValue) {
                card.suit = newSuit
            }
        }
    }

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

    private func drawCenterImage() {
        guard let rookImage = UIImage(named: Card.rookImageName) else {
            return
        }

        let width = bounds.width - 2 * centerImageMargin
        let rookImageRect = CGRect(x: centerImageMargin,
                                   y: (bounds.height - width) / 2,
                                   width: width,
                                   height: width)
        rookImage.draw(in: rookImageRect)
    }

    private func drawCenterSquare() {

    }

    private func drawCenterText() {

    }

    private func drawCornerText() {
        let font = rookCardFont(ofSize: centerFontSize)
        let rankText = NSAttributedString(string: "\(rank)",
            attributes: [
                .font: font,
                .foregroundColor: suitColor()
            ])
        var textBounds = CGRect.zero

        textBounds.size = rankText.size()
        textBounds.origin = CGPoint(x: (bounds.width - textBounds.width) / 2,
                                    y: (bounds.height - textBounds.height) / 2)
        rankText.draw(in: textBounds)

        if Card.underlinedRanks.contains(rank) {
            drawCenterUnderline(using: textBounds, with: font)
        }
    }

    private func drawCenterUnderline(using textBounds: CGRect, with font: UIFont) {

    }

    private func drawFaceDown() {

    }

    private func drawFaceUp() {
        if card.suit == RookCard.Suit.rook {
            drawCenterImage()
        } else {
            drawCenterText()
            drawCenterSquare()
        }

        drawCornerText()
    }

    // MARK: - Helpers

    private func rookCardFont(ofSize fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: Card.fontName, size: fontSize) {
            return font
        }

        return UIFont.preferredFont(forTextStyle: .body)
    }

    private func suitColor() -> UIColor {
        if let color = Card.suitColors[card.suit] {
            return color
        }

        return UIColor.black
    }
}
