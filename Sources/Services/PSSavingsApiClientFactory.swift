import Foundation
import Alamofire
import PayseraCommonSDK

public class PSSavingsApiClientFactory {    
    public static func createClient(
        credentials: PSSavingsApiCredentials,
        tokenRefresher: TokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> PSSavingsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = AuthenticationRequestAdapter(credentials: credentials)
    
        return PSSavingsApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
