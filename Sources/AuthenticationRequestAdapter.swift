import Foundation
import Alamofire

public class AuthenticationRequestAdapter: RequestAdapter {
    private let credentials: PSSavingsApiCredentials
    
    init(credentials: PSSavingsApiCredentials) {
        self.credentials = credentials
    }
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue("Bearer " + (credentials.token?.string ?? ""), forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
}
