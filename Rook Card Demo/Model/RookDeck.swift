//
//  RookDeck.swift
//  Rook Card Demo
//
//  Created by Steve Liddle on 10/4/18.
//  Copyright © 2018 IS 543. All rights reserved.
//

import Foundation

struct RookDeck {
    private var cards: [RookCard] = []

    init() {
        // Here we build a new deck in order of suit and rank.
        for suit in RookCard.Suit.validSuits {
            if suit == RookCard.Suit.rook {
                cards.append(RookCard())
            } else {
                for rank in RookCard.Rank.min ... RookCard.Rank.max {
                    cards.append(RookCard(suit: suit, rank: rank))
                }
            }
        }
    }

    subscript(index: Int) -> RookCard {
        get {
            return cards[index]
        }
        set {
            cards[index] = newValue
        }
    }

    var count: Int {
        return cards.count
    }

    mutating func remove(at index: Int) {
        cards.remove(at: index)
    }

    mutating func shuffle() {
        cards.shuffle()
    }
}
