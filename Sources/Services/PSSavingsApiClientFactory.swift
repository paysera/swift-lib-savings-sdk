import Foundation
import Alamofire

public class PSSavingsApiClientFactory {
    
    public static func createClient(
        credentials: PSSavingsApiCredentials,
        tokenRefresher: TokenRefresherProtocol? = nil
    ) -> PSSavingsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = AuthenticationRequestAdapter(credentials: credentials)
    
        return PSSavingsApiClient(sessionManager: sessionManager, credentials: credentials, tokenRefresher: tokenRefresher)
    }
}
