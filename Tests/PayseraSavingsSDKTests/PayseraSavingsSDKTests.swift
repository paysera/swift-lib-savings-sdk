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
        
        let token =  "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJldnBiYW5rIiwiaXNzIjoibW9rZWppbWFpIiwicHNyOnMiOlsicGIiLCJhOkVWUDI4MTAwMDEyNDg2Mzc6bSIsImE6RVZQMTYxMDAwMTg0NTc0NDptIiwiYTpFVlA4NjEwMDAxNjcwMjM5Om0iLCJhOkVWUDkwMTAwMDE2NTAxMzY6bSJdLCJwc3I6dSI6NDUxNzQ1LCJleHAiOjE1MzI2ODc5MTgsImlhdCI6MTUzMjY4NDMxOH0.foUJj-A5sCTKHnrJb_RGEd8QfXqRf74SsOzn_ZgFb7VSGyr_VvU-tjX98pfeuR2JbuRJGVQpFXoIGjyY-9sOajRjQ4Ln31DG5e5fukCNrrv7Mb2L1lexWN0j3s3-l5mdaF2-9lc7BHar6tPR5YRiLx-929V9GUNZ47FH-G1mkTf8iMjRTc3gGtJRRrYbgiGbgobxqVU16rK50s1jNQhni8Jwz5kbUhfU0-Wz8HtF-CkTWHljn3By037nSt6Q2hY7vVx4kyNlsIIh8VkJGmAxnicBKPcJ_c4uS3Vb6E_ugKcXk_SIROy7GHifoitmkc7ERJ4hj4CbRt2rJbMX0pS93tRGbu7PwtxMaFLcBmZ5QW6lIBbp9oV-_vVenvBPRv5m1F8fTlnIOCum17iPZSGAyHBEzU-hStpwflzlwXvRKUCGfcyaDZdmh80zwQUx5PP_Mr7tUMSiJ2c2JiWEdPN-Dw6h_DVJSezj-IJ7eFHaFOf9pXVidUwbgSmeY-qsK39szad5OjYGTwbWvKg2lBKg-SljRCEI4K_hc1wIcQ-HSf7TqKvShDaYO5cuuC28sBMFHiPSnM6mR--MVr3cTk2tHnCkQm1eMtMZPv5fxq65nxv_2pKvARhLWhkrQf4DQM-ojx_EhLAoMoo76Veq5_7WXvuvwiwybH33Y1dmJ2qimjQ"
        
        credentials.token = try! decode(jwt: token)
        
        return PSSavingsApiClientFactory.createClient(credentials: credentials)
    }
}
