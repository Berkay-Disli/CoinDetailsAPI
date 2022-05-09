//
//  CoinViewModel.swift
//  CoinsAPI
//
//  Created by Berkay Disli on 8.05.2022.
//

import Foundation
import SwiftUI

class CoinViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var selectedCoin = Coin(id: "", name: "", symbol: "", rank: 0, is_new: false, is_active: false, type: "")
    init() {
        getCoins()
    }
    
    // bunu backgroundda yapmayı dene!
    func getCoins() {
        guard let url = URL(string: "https://api.coinpaprika.com/v1/coins") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode([Coin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = self.limitArray(limit: 20, coinArray: result)
                    
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func limitArray(limit: Int, coinArray: [Coin]) -> [Coin] {
        let limitedArray = Array(coinArray.prefix(limit))
        
        return limitedArray
    }
    
    func deleteCoin(indexSet: IndexSet) {
        self.coins.remove(atOffsets: indexSet)
    }
    
    func filterArray(){
        let filtered = coins.filter { coin in
            return coin.rank == 5
        }
        
        coins = filtered
    }
    
    func searchArray(searchText: String) {
        if !searchText.isEmpty {
            getCoins()
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                let newArray = self.coins.filter { coin in
                    return coin.name.contains(searchText)
                }
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        self.coins = newArray
                    }
                }
            }
        } else {
            getCoins()
        }
    }
    
    func coinClicked(showSheet: inout Bool, selectedCoin: Coin) {
        withAnimation(.easeInOut) {
            showSheet.toggle()
        }
        self.selectedCoin = selectedCoin
    }
    
    func closeDetailsPopup(showSheet: inout Bool) {
        withAnimation(.easeInOut) {
            showSheet.toggle()
        }
    }
}
