public protocol ApiRequestProtocol {
    var method: HttpMethod { get }
    var url: String { get }
    var body: Encodable? { get }
    var header: [String : String]? { get }
}
