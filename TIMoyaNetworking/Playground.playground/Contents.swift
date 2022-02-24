import TIMoyaNetworking
import TINetworking
import Moya
import TIFoundationUtils
import Foundation

// MARK: - Models

enum ErrorType: String, Codable {

    // 400
    case incorrectLoginAndPasswordGiven = "Incorrect login and password given"

    // 401
    case invalidJwtToken = "Invalid JWT Token"

    // 403
    case userAlreadyExists = "User already exists"

    // 404
    case userNotFound = "User not found"
    case sessionNotFound = "Session not found"

    // 500
    case internalError = "Internal error"

    // 503
    case cannotSendCode = "Cannot send code"

    // Unknown
    case unknown = "Unknown error"

    init(_ rawValue: String, `default`: ErrorType = .unknown) {
        self = ErrorType(rawValue: rawValue) ?? `default`
    }
}

struct ErrorResponse: Codable {
    let errorCode: ErrorType
    let message: String
}

struct LoginRequestBody: Encodable {
    var login: String
    var password: String
}

struct Profile: Codable {
    var name: String
}

enum ApiResponse<ResponseType> {
    case ok(ResponseType)
    case error(ErrorResponse)
}

// MARK: - Request

extension EndpointRequest {
    static func apiV3MobileAuthLoginPassword(body: LoginRequestBody) -> EndpointRequest<LoginRequestBody> {
        .init(templatePath: "/api/v3/mobile/auth/login/password/",
              method: .post,
              body: body,
              acceptableStatusCodes: [200, 400, 403, 500],
              server: Server(baseUrl: "https://server.base.url"))
    }
}

// MARK: - Services

struct JsonCodingService {
    let jsonEncoder: JSONEncoder
    let jsonDecoder: JSONDecoder

    init(dateFormattersReusePool: DateFormattersReusePool) {
        self.jsonEncoder = JSONEncoder()
        self.jsonDecoder = JSONDecoder()

        guard let userInfoKey = CodingUserInfoKey.dateFormattersReusePool else {
            assertionFailure("Unable to create dateFormattersReusePool CodingUserInfoKey")
            return
        }

        jsonDecoder.userInfo.updateValue(dateFormattersReusePool, forKey: userInfoKey)
        jsonEncoder.userInfo.updateValue(dateFormattersReusePool, forKey: userInfoKey)
    }
}

final class ProjectNetworkService: DefaultJsonNetworkService {
    init(jsonCodingService: JsonCodingService) {
        super.init(session: SessionFactory(timeoutInterval: 60).createSession(),
                   jsonDecoder: jsonCodingService.jsonDecoder,
                   jsonEncoder: jsonCodingService.jsonEncoder)
    }

    func process<B: Encodable, S: Decodable>(request: EndpointRequest<B>,
                                             decodableSuccessStatusCodes: Set<Int>? = nil,
                                             decodableFailureStatusCodes: Set<Int>? = nil) async -> ApiResponse<S> {

        await process(request: request,
                      decodableSuccessStatusCodes: decodableSuccessStatusCodes,
                      decodableFailureStatusCodes: decodableFailureStatusCodes,
                      mapSuccess: ApiResponse.ok,
                      mapFailure: ApiResponse.error,
                      mapMoyaError: { ApiResponse.error($0.convertToErrorModel()) })
    }
}

private extension MoyaError {
    func convertToErrorModel() -> ErrorResponse {
        switch self {
        case .underlying:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Нет соединения с сетью 😔 Проверьте соединение с сетью и повторите попытку")

        case .objectMapping:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Ошибка 😔")

        default:
            return ErrorResponse(errorCode: .unknown,
                                 message: "Ошибка 😔")
        }
    }
}

let reusePool = DateFormattersReusePool()
let jsonCodingService = JsonCodingService(dateFormattersReusePool: reusePool)

let networkSerice = ProjectNetworkService(jsonCodingService: jsonCodingService)

let body = LoginRequestBody(login: "qwe", password: "asd")

let profileResponse: ApiResponse<Profile> = await networkSerice.process(request: .apiV3MobileAuthLoginPassword(body: body))

//switch profileResponse {
//case let .ok(profile):
//    showUser(name: profile.name)
//case let .error(errorResponse):
//    showAlert(with: errorResponse.message)
//}
