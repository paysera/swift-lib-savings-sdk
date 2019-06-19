import Foundation
import XCTest
import PayseraSavingsSDK
import PromiseKit
import JWTDecode
import ObjectMapper

class SavingsSDKTests: XCTestCase {
    private var client: PSSavingsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.client = createClient()
    }
    
    func createClient() -> PSSavingsApiClient {
        let credentials = PSSavingsApiCredentials()
        
        let token = "change_me"
        
        credentials.token = try! decode(jwt: token)
        
        return PSSavingsApiClientFactory.createClient(credentials: credentials)
    }
}
