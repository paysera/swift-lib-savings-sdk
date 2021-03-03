import PayseraCommonSDK
import PromiseKit

public class PSSavingsApiClient: PSBaseApiClient {
    public func getSavingsAccounts(
        filter: PSSavingsAccountFilter
    ) -> Promise<PSMetadataAwareResponse<PSSavingsAccount>> {
        doRequest(requestRouter: PSSavingsApiRequestRouter.getSavingsAccounts(filter: filter))
    }
    
    public func createSavingsAccount(
        userId: String,
        request: PSCreateSavingsAccountRequest
    ) -> Promise<PSSavingsAccount> {
        doRequest(
            requestRouter: PSSavingsApiRequestRouter.createSavingsAccount(
                userId: userId,
                request: request
            )
        )
    }
    
    public func setSavingsAccountGoal(
        accountNumber: String,
        goal: PSSetSavingsAccountGoal
    ) -> Promise<PSSavingsAccountGoal> {
        doRequest(
            requestRouter: PSSavingsApiRequestRouter.setSavingsAccountGoal(
                accountNumber: accountNumber,
                goal: goal
            )
        )
    }
    
    public func deleteSavingsAccountGoal(accountNumber: String) -> Promise<Any> {
        doRequest(
            requestRouter: PSSavingsApiRequestRouter.deleteSavingsAccountGoal(
                accountNumber: accountNumber
            )
        )
    }
    
    public func createAutomatedFill(
        request: PSCreateAutomatedFillRequest
    ) -> Promise<PSAutomatedFill> {
        doRequest(requestRouter: PSSavingsApiRequestRouter.createAutomatedFill(request: request))
    }
    
    public func getAutomatedFills(
        filter: PSAutomatedFillsFilter
    ) -> Promise<PSMetadataAwareResponse<PSAutomatedFill>> {
        doRequest(requestRouter: PSSavingsApiRequestRouter.getAutomatedFills(filter: filter))
    }
    
    public func getAutomatedFill(id: String) -> Promise<PSAutomatedFill> {
        doRequest(requestRouter: PSSavingsApiRequestRouter.getAutomatedFill(id: id))
    }
    
    public func cancelAutomatedFill(id: String) -> Promise<Any> {
        doRequest(requestRouter: PSSavingsApiRequestRouter.cancelAutomatedFill(id: id))
    }
}
