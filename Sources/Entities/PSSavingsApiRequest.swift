import Foundation
import PromiseKit

class PSSavingsApiRequest {
    let requestEndPoint: PSSavingsApiRequestRouter
    let pendingPromise: (promise: Promise<Any>, resolver: Resolver<Any>)
    
    init(pendingPromise: (promise: Promise<Any>, resolver: Resolver<Any>), requestEndPoint: PSSavingsApiRequestRouter) {
        self.pendingPromise = pendingPromise
        self.requestEndPoint = requestEndPoint
    }   
}
