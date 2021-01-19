// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation

struct Request {
    
    // MARK: Properties
    
    let baseUrl: URL
    let method: HTTPMethod
    var path: String? = nil
    var parameters: [String: Any]? = nil
    var headers: [String: String]? = nil
    
    // MARK: Initialization
    
    init(baseUrl: URL, method: HTTPMethod) {
        self.baseUrl = baseUrl
        self.method = method
    }
    
	// MARK: Methods
	
    func asUrlRequest() throws -> URLRequest {
		
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path ?? ""),
                                          resolvingAgainstBaseURL: true) else {
            throw RequestError.wrongPath
        }
        
        if method == .get, let parameters = parameters {
            guard let parameters = parameters as? [String: String] else {
                throw RequestError.wrongGetParameters
            }
            components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw RequestError.unknown
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .post, let parameters = parameters {
			let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
			request.httpBody = data
        }
        
        if let headers = headers {
            request.allHTTPHeaderFields = headers
        }
        
        return request
    }
}
