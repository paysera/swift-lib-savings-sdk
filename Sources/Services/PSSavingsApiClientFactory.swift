import Foundation
import Alamofire
import PayseraCommonSDK

public class PSSavingsApiClientFactory {    
    public static func createClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> PSSavingsApiClient {
        let sessionManager = SessionManager()
        sessionManager.adapter = PSRequestAdapter(credentials: credentials)
    
        return PSSavingsApiClient(
            sessionManager: sessionManager,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
