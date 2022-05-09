//
//  Coin.swift
//  CoinsAPI
//
//  Created by Berkay Disli on 8.05.2022.
//

import Foundation

struct Coin: Hashable, Codable {
    let id: String
    let name: String
    let symbol: String
    let rank: Int
    let is_new: Bool
    let is_active: Bool
    let type: String
}
