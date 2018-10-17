import Foundation
import Alamofire

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
    static var baseURLString = "https://savings.paysera.com/savings/rest/v1"
    
    private var method: HTTPMethod {
        switch self {
            case .getSavingsAccounts( _),
                .getAutomatedFill( _),
                .getAutomatedFills( _):
                    return .get
            
            case .createSavingsAccount( _, _),
                 .createAutomatedFill( _):
                return .post
            
            case .setSavingsAccountGoal( _, _):
                return .put
            
            case .deleteSavingsAccountGoal( _),
                 .cancelAutomatedFill( _):
                return .delete
        }
    }
    
    private var path: String {
        switch self {
            case .getSavingsAccounts( _):
                return "savings-accounts"
            case .createSavingsAccount(let userId, _):
                return "users/\(userId)/savings-accounts"
            case .setSavingsAccountGoal(let accountNumber, _):
                return "savings-accounts/\(accountNumber)/goal"
            case .deleteSavingsAccountGoal(let accountNumber):
                return "savings-accounts/\(accountNumber)/goal"
            case .createAutomatedFill(let request):
                return "savings-account/\(String(describing: request.toAccount))/automated-fills"
            case .getAutomatedFills( _):
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
            default:
                return nil
        }
    }
    
    // MARK: - Method
    public func asURLRequest() throws -> URLRequest {
        let url = try! PSSavingsApiRequestRouter.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        
            case (_) where method == .get:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .post:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            case (_) where method == .put:
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            
            default:
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
