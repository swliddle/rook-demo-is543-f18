//
//  RookDeckViewController.swift
//  Rook Card Demo
//
//  Created by Steve Liddle on 10/8/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import UIKit

class RookDeckViewController : UIViewController {

    // MARK: - Constants

    private struct Storyboard {
        static let RookCardCellIdentifier = "RookCardCell"
    }

    // MARK: - Properties

    private var deck = RookDeck()

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Actions

    @IBAction func showAllCards(_ sender: UIBarButtonItem) {
        setCardsFaceUp(true)
        collectionView.reloadData()
    }

    @IBAction func shuffle(_ sender: UIBarButtonItem) {
        deck.shuffle()
        setCardsFaceUp(false)
        collectionView.reloadData()
    }

    // MARK: - Helpers

    private func flipCard(inCell rookCardCell: RookCardCell) {
        UIView.transition(with: rookCardCell.rookCardView,
                          duration: Animation.Duration,
                          options: .transitionFlipFromLeft,
                          animations: {
                              rookCardCell.rookCardView.isFaceUp.toggle()
                              rookCardCell.rookCardView.setNeedsDisplay()
                          })
    }

    private func setCardsFaceUp(_ isFaceUp: Bool) {
        for i in 0 ..< deck.count {
            deck[i].isFaceUp = isFaceUp
        }
    }
}

extension RookDeckViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.RookCardCellIdentifier,
                                                      for: indexPath)

        if let rookCardCell = cell as? RookCardCell {
            rookCardCell.rookCardView.card = deck[indexPath.row]
            rookCardCell.rookCardView.setNeedsDisplay()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deck.count
    }
}

extension RookDeckViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rookCardCell = collectionView.cellForItem(at: indexPath) as? RookCardCell {
            deck[indexPath.row].isFaceUp.toggle()
            flipCard(inCell: rookCardCell)
        }
    }
}
