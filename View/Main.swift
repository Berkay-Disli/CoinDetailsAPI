//
//  Main.swift
//  CoinsAPI
//
//  Created by Berkay Disli on 8.05.2022.
//

import SwiftUI

struct Main: View {
    @StateObject var viewModel = CoinViewModel()
    @State private var searchText = ""
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
            
                
                VStack {
                    // after coins have loaded
                    if !viewModel.coins.isEmpty {
                        
                        // search bar
                        
                        
                        // coin list
                        List {
                            VStack {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                    TextField("", text: $searchText)
                                        .placeholder(when: searchText.isEmpty) {
                                            Text("Search").foregroundColor(Color("c"))
                                        }
                                        .onChange(of: searchText) { newValue in
                                            viewModel.searchArray(searchText: searchText)
                                        }
                                }
                                .padding(.top)
                                
                                Capsule().fill(Color("c"))
                                    .frame(height: 1)
                                    
                            }
                            
                            ForEach(viewModel.coins, id: \.self) { coin in
                                Button {
                                    viewModel.coinClicked(showSheet: &showSheet, selectedCoin: coin)
                                } label: {
                                    HStack {
                                        Text(coin.name)
                                            .font(.title2).bold()
                                            .foregroundColor(Color("c"))
                                        Spacer()
                                        Text(coin.symbol)
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                    }
                                }

                            }
                            .onDelete { indexSet in
                                viewModel.deleteCoin(indexSet: indexSet)
                            }
                        }
                        
                        .listStyle(.plain)
                    } else {
                        ProgressView()
                            .transition(AnyTransition.opacity.animation(.easeInOut))
                    }
                }
                
                if showSheet {
                        Button {
                            viewModel.closeDetailsPopup(showSheet: &showSheet)
                        } label: {
                            Color.black.opacity(0.3).ignoresSafeArea()
                                
                        }
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    
                    CoinDetails(coin: viewModel.selectedCoin)
                        .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.3)))
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.getCoins()
                    } label: {
                        Text("Reset")
                            .bold()
                            .foregroundColor(Color("c"))
                    }
                }
            })
            .navigationTitle("Coins")
        }
        
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
