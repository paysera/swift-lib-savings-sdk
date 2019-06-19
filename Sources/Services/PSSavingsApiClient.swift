import Foundation
import Alamofire
import ObjectMapper
import PromiseKit
import PayseraCommonSDK

public class PSSavingsApiClient {
    private let sessionManager: SessionManager
    private let tokenRefresher: TokenRefresherProtocol?
    private let credentials: PSSavingsApiCredentials
    private let logger: PSLoggerProtocol?
    private var requestsQueue = [PSSavingsApiRequest]()
    
    public init(
        sessionManager: SessionManager,
        credentials: PSSavingsApiCredentials,
        tokenRefresher: TokenRefresherProtocol?,
        logger: PSLoggerProtocol? = nil
    ) {
        self.sessionManager = sessionManager
        self.tokenRefresher = tokenRefresher
        self.credentials = credentials
        self.logger = logger
    }
    
    public func getSavingsAccounts(filter: PSSavingsAccountFilter) -> Promise<PSMetadataAwareResponse<PSSavingsAccount>> {
        let request = createRequest(.getSavingsAccounts(filter: filter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func createSavingsAccount(userId: String, request: PSCreateSavingsAccountRequest) -> Promise<PSSavingsAccount> {
        let request = createRequest(.createSavingsAccount(userId: userId, request: request))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func setSavingsAccountGoal(accountNumber: String, goal: PSSetSavingsAccountGoal) -> Promise<PSSavingsAccountGoal> {
        let request = createRequest(.setSavingsAccountGoal(accountNumber: accountNumber, goal: goal))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func deleteSavingsAccountGoal(accountNumber: String) -> Promise<Any> {
        let request = createRequest(.deleteSavingsAccountGoal(accountNumber: accountNumber))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func createAutomatedFill(request: PSCreateAutomatedFillRequest) -> Promise<PSAutomatedFill> {
        let request = createRequest(.createAutomatedFill(request: request))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getAutomatedFills(filter: PSAutomatedFillsFilter) -> Promise<PSMetadataAwareResponse<PSAutomatedFill>> {
        let request = createRequest(.getAutomatedFills(filter: filter))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func getAutomatedFill(id: String) -> Promise<PSAutomatedFill> {
        let request = createRequest(.getAutomatedFill(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    public func cancelAutomatedFill(id: String) -> Promise<Any> {
        let request = createRequest(.cancelAutomatedFill(id: id))
        makeRequest(apiRequest: request)
        
        return request
            .pendingPromise
            .promise
            .then(createPromise)
    }
    
    // MARK: - Private request methods
    private func makeRequest(apiRequest: PSSavingsApiRequest) {
        let lockQueue = DispatchQueue(label: String(describing: tokenRefresher), attributes: [])
        lockQueue.sync {
            if let tokenRefresher = tokenRefresher, tokenRefresher.isRefreshing() {
                requestsQueue.append(apiRequest)
            } else {
                self.logger?.log(level: .INFO, message: "--> \(apiRequest.requestEndPoint.urlRequest!.url!.absoluteString)")
                
                sessionManager
                    .request(apiRequest.requestEndPoint)
                    .responseJSON { (response) in
                        var logMessage = "<-- \(apiRequest.requestEndPoint.urlRequest!.url!.absoluteString)"
                        if let statusCode = response.response?.statusCode {
                            logMessage += " (\(statusCode))"
                        }
                        
                        self.logger?.log(level: .INFO, message: logMessage)
                        
                        let responseData = response.result.value
                        
                        guard let statusCode = response.response?.statusCode else {
                            let error = self.mapError(body: responseData)
                            apiRequest.pendingPromise.resolver.reject(error)
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            apiRequest.pendingPromise.resolver.fulfill(responseData)
                        } else {
                            let error = self.mapError(body: responseData)
                            if statusCode == 401 {
                                guard let tokenRefresher = self.tokenRefresher else {
                                    apiRequest.pendingPromise.resolver.reject(error)
                                    return
                                }
                                lockQueue.sync {
                                    if self.credentials.hasRecentlyRefreshed() {
                                        self.makeRequest(apiRequest: apiRequest)
                                        return
                                    }
                                    
                                    self.requestsQueue.append(apiRequest)
                                    
                                    if !tokenRefresher.isRefreshing() {
                                        tokenRefresher
                                            .refreshToken()
                                            .done { result in
                                                self.resumeQueue()
                                            }.catch { error in
                                                self.cancelQueue(error: error)
                                        }
                                    }
                                }
                            } else {
                                apiRequest.pendingPromise.resolver.reject(error)
                            }
                        }
                }
            }
        }
    }
    
    private func resumeQueue() {
        for request in requestsQueue {
            makeRequest(apiRequest: request)
        }
        requestsQueue.removeAll()
    }
    
    private func cancelQueue(error: Error) {
        for requests in requestsQueue {
            requests.pendingPromise.resolver.reject(error)
        }
        requestsQueue.removeAll()
    }
    
    private func createPromise<T: Mappable>(body: Any) -> Promise<T> {
        guard let object = Mapper<T>().map(JSONObject: body) else {
            return Promise(error: mapError(body: body))
        }
        return Promise.value(object)
    }
    
    private func createPromise(body: Any) -> Promise<Any> {
        return Promise.value(body)
    }
    
    private func mapError(body: Any?) -> PSApiError {
        if let apiError = Mapper<PSApiError>().map(JSONObject: body) {
            return apiError
        }
        
        return PSApiError.unknown()
    }
    
    private func createRequest(_ endpoint: PSSavingsApiRequestRouter) -> PSSavingsApiRequest {
        return PSSavingsApiRequest(
            pendingPromise: Promise<Any>.pending(),
            requestEndPoint: endpoint
        )
    }
}
