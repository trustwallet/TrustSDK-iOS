//
//  Request.swift
//  Portfolio
//
//  Created by Artur Guseinov on 16.01.2021.
//

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
