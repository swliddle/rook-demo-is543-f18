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
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!

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

    @IBAction func toggleSize(_ sender: Any) {
        collectionView.layoutIfNeeded()

        if collectionViewBottomConstraint.constant > 0 {
            collectionViewBottomConstraint.constant = 0
        } else {
            collectionViewBottomConstraint.constant = collectionView.bounds.height / 2
        }

        UIView.animate(withDuration: Animation.Duration,
                       delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
                           self.view.layoutIfNeeded()
                       })
    }

    // MARK: - Helpers

    private func flipCard(inCell rookCardCell: RookCardCell, at indexPath: IndexPath) {
        UIView.transition(with: rookCardCell.rookCardView,
                          duration: Animation.Duration,
                          options: .transitionFlipFromLeft,
                          animations: {
                              rookCardCell.rookCardView.isFaceUp.toggle()
                              rookCardCell.rookCardView.setNeedsDisplay()
                          },
                          completion: {
                              _ in
                              self.deck.remove(at: indexPath.row)
                              self.collectionView.deleteItems(at: [indexPath])
                          })
    }

    private func setCardsFaceUp(_ isFaceUp: Bool) {
        for i in 0 ..< deck.count {
            deck[i].isFaceUp = isFaceUp
        }
    }
}

// MARK: - Collection view data source

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

// MARK: - Collection view delegate

extension RookDeckViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rookCardCell = collectionView.cellForItem(at: indexPath) as? RookCardCell {
            deck[indexPath.row].isFaceUp.toggle()
            flipCard(inCell: rookCardCell, at: indexPath)
        }
    }
}
