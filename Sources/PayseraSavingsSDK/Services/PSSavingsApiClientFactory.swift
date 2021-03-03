import Alamofire
import PayseraCommonSDK

public class PSSavingsApiClientFactory {    
    public static func createClient(
        credentials: PSApiJWTCredentials,
        tokenRefresher: PSTokenRefresherProtocol? = nil,
        logger: PSLoggerProtocol? = nil
    ) -> PSSavingsApiClient {
        let interceptor = PSRequestAdapter(credentials: credentials)
        let session = Session(interceptor: interceptor)
        
        return PSSavingsApiClient(
            session: session,
            credentials: credentials,
            tokenRefresher: tokenRefresher,
            logger: logger
        )
    }
}
