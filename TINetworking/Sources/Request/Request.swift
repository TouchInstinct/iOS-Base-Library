import Alamofire

public struct Request<Content: BodyContent> {

    public var templatePath: String
    public var method: HTTPMethod
    public var requestBodyContent: Content
    public var queryParameters: [String: Parameter<LocationQuery>]
    public var pathParameters: [String: Parameter<LocationPath>]
    public var headerParameters: HTTPHeaders?
    public var cookieParameters: [String: Parameter<LocationCookie>]
    public var acceptableStatusCodes: Set<Int>
    public var customServer: Server?
    public var customServerVariables: [KeyValueTuple<String, String>]

    public var path: String {
        PathParameterEncoding(templateUrl: templatePath).encode(parameters: pathParameters)
    }

    public init(templatePath: String,
                method: HTTPMethod,
                requestBodyContent: Content,
                queryParameters: [String: Parameter<LocationQuery>] = [:],
                pathParameters: [String: Parameter<LocationPath>] = [:],
                headerParameters: HTTPHeaders? = nil,
                cookieParameters: [String: Parameter<LocationCookie>] = [:],
                acceptableStatusCodes: Set<Int> = [200],
                customServer: Server? = nil,
                customServerVariables: [KeyValueTuple<String, String>] = []) {

        self.templatePath = templatePath
        self.method = method
        self.requestBodyContent = requestBodyContent
        self.queryParameters = queryParameters
        self.pathParameters = pathParameters
        self.headerParameters = headerParameters
        self.cookieParameters = cookieParameters
        self.acceptableStatusCodes = acceptableStatusCodes
        self.customServer = customServer
        self.customServerVariables = customServerVariables
    }
}