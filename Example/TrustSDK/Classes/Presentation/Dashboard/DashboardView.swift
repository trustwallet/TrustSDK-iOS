//
//  DashboardView.swift
//  Portfolio
//
//  Created by Artur Guseinov on 14.01.2021.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject
    var viewModel: DashboardViewModel
    
    var body: some View {
				
        NavigationView {
			VStack {
				Text("Binance Smart Chain balance")
					.font(.subheadline)
					.foregroundColor(.gray)
				Text(viewModel.balance.localizedAmount)
					.font(.largeTitle)
					.frame(height: 50.0)
				List(viewModel.tokenBalanceList) { balance in
					TokenRow(balance: balance)
				}
			}
        }
    }
}
