//
//  RookCardViewController.swift
//  Rook Card Demo
//
//  Created by Steve Liddle on 10/4/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class RookCardViewController : UIViewController {

    // MARK: - Constants

    private struct Animation {
        static let Duration = 0.5
    }

    // MARK: - Outlets

    @IBOutlet weak var rookCardView: RookCardView!

    // MARK: - Actions

    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        UIView.transition(with: rookCardView,
                          duration: Animation.Duration,
                          options: sender.direction == .right ?
                                        .transitionFlipFromLeft :
                                        .transitionFlipFromRight,
                          animations: {
                            self.rookCardView.card.isFaceUp.toggle()
                            self.rookCardView.setNeedsDisplay()
                          },
                          completion: nil)
    }
}
