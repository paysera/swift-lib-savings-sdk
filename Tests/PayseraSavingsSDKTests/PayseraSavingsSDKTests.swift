import XCTest
import PayseraSavingsSDK
import PayseraCommonSDK
import JWTDecode

class PayseraSavingsSDKTests: XCTestCase {
    private var client: PSSavingsApiClient!
    
    override func setUp() {
        super.setUp()
        
        self.client = createClient()
    }
    
    func createClient() -> PSSavingsApiClient {
        let credentials = PSApiJWTCredentials()
        
        let token = "insert_me"
        
        credentials.token = try! decode(jwt: token)
        
        return PSSavingsApiClientFactory.createClient(credentials: credentials)
    }
    
    func testGetSavingsAccounts() {
        let expectation = XCTestExpectation(description: "")
        
        let filter = PSSavingsAccountFilter()
        filter.accountNumbers = ["EVP1910005103180"]
        
        self.client
            .getSavingsAccounts(filter: filter)
            .done { response in
                print(response)
            }.catch { error in
                print((error as? PSApiError)?.toJSON() ?? "")
            }.finally {
                expectation.fulfill()
            }
    
        wait(for: [expectation], timeout: 10.0)
    }
}
