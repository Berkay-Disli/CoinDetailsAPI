//
//  CoinDetails.swift
//  CoinsAPI
//
//  Created by Berkay Disli on 10.05.2022.
//

import SwiftUI

struct CoinDetails: View {
    let coin: Coin
    var body: some View {
        VStack {
            // header
            VStack(alignment: .leading, spacing: 4) {
                Text("This is \(coin.name)")
                    .font(.system(size: 40)).bold()
                HStack {
                    Text(coin.symbol)
                    Spacer()
                    Text("Rank: \(coin.rank)")
                }
                .font(.system(size: 30)).foregroundColor(.gray)
            }
            
            Divider()
            
            // details
            HStack {
                Text("ID: \(coin.id)").bold()
                Spacer()
                Capsule().fill(.gray)
                    .frame(width: 0.9, height: 25)
                Spacer()
                Text("Type: \(coin.type)").bold()
            }
            .font(.system(size: 25))
            .foregroundColor(Color(uiColor: .darkGray))
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 20, height: 250)
        .background(.white)
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetails(coin: Coin(id: "Coin?", name: "Bitcoin", symbol: "BTC", rank: 1, is_new: false, is_active: true, type: "Who knows"))
    }
}
