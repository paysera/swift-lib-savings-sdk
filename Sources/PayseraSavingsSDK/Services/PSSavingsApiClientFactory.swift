import Foundation
import Alamofire
import PayseraCommonSDK

public class PSSavingsApiClientFactory {    
    public static func createClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> PSSavingsApiClient {
        let interceptor = PSRequestAdapter(credentials: credentials)
        let trustedSession = PSTrustedSession(
            interceptor: interceptor,
            hosts: ["savings.paysera.com"]
        )
        
        return PSSavingsApiClient(
            session: trustedSession,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
