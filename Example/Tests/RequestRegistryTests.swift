import XCTest
@testable import TrustSDK

struct MockRequest: CallbackRequest {
    typealias Response = String
    
    let command: TrustSDK.Command
    var callback: ((Result<String, Error>) -> Void)
    
    func resolve(with components: URLComponents) {
        callback(Result.success("test"))
    }
}

class RequestRegistryTests: XCTestCase {
    var registry: RequestRegistry!
    
    override func setUp() {
        super.setUp()
        registry = RequestRegistry()
    }
    
    func testResolve() {
        let expect = expectation(description: "Command resolved")
        
        let key = registry.register(request: MockRequest(command: .getAccounts(coins: []), callback: { _ in
            expect.fulfill()
        }))
        
        registry.resolve(request: key, with: URLComponents(string: "http://trustwallet.com")!)
        
        wait(for: [expect], timeout: 1)
    }
}
