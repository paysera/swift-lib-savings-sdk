import Alamofire
import Foundation

public enum PSSavingsApiRequestRouter: URLRequestConvertible {
    case getSavingsAccounts(filter: PSSavingsAccountFilter)
    case createSavingsAccount(userId: String, request: PSCreateSavingsAccountRequest)
    case setSavingsAccountGoal(accountNumber: String, goal: PSSetSavingsAccountGoal)
    case deleteSavingsAccountGoal(accountNumber: String)
    case createAutomatedFill(request: PSCreateAutomatedFillRequest)
    case getAutomatedFills(filter: PSAutomatedFillsFilter)
    case getAutomatedFill(id: String)
    case cancelAutomatedFill(id: String)
    
    // MARK: - Declarations
    static let baseURL = URL(string: "https://savings.paysera.com/savings/rest/v1")!
    
    private var method: HTTPMethod {
        switch self {
        case .getSavingsAccounts,
             .getAutomatedFill,
             .getAutomatedFills:
            return .get
        
        case .createSavingsAccount,
             .createAutomatedFill:
            return .post
        
        case .setSavingsAccountGoal:
            return .put
        
        case .deleteSavingsAccountGoal,
             .cancelAutomatedFill:
            return .delete
        }
    }
    
    private var path: String {
        switch self {
        case .getSavingsAccounts:
            return "savings-accounts"
        case .createSavingsAccount(let userId, _):
            return "users/\(userId)/savings-accounts"
        case .setSavingsAccountGoal(let accountNumber, _):
            return "savings-accounts/\(accountNumber)/goal"
        case .deleteSavingsAccountGoal(let accountNumber):
            return "savings-accounts/\(accountNumber)/goal"
        case .createAutomatedFill(let request):
            return "savings-accounts/\(request.toAccount!)/automated-fills"
        case .getAutomatedFills:
            return "automated-fills"
        case .getAutomatedFill(let id):
            return "automated-fills/\(id)"
        case .cancelAutomatedFill(let id):
            return "automated-fills/\(id)"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .setSavingsAccountGoal( _, let request):
            return request.toJSON()
        case .createAutomatedFill(let request):
            return request.toJSON()
        case .createSavingsAccount( _, let request):
            return request.toJSON()
        case .getSavingsAccounts(let filter):
            return filter.toJSON()
        case .getAutomatedFills(let filter):
            return filter.toJSON()
        default:
            return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        let url = Self.baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        switch method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        case .post:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .put:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        default:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
