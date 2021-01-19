//
//  TokenRow.swift
//  Portfolio
//
//  Created by Artur Guseinov on 14.01.2021.
//

import SwiftUI

struct TokenRow: View {
	
	// MARK: Dependencies
	
    let balance: TokenBalance
	
	// MARK: View
	
    var body: some View {
        HStack {
			
			RemoteImage(urlString: URLs.tokenAssetUrl(for: balance.token), placeholder: "token_placeholder")
				.frame(width: 32.0, height: 32.0)
				.clipShape(Circle())
				.shadow(radius: 2)
            
            VStack(alignment: .leading) {
				Text(balance.token.name).font(.headline)
				Text(balance.localizedAmount)
					.font(.subheadline)
					.foregroundColor(.gray)
            }
        }
    }
}
