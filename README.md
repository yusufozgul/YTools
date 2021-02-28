# A few tools for iOS - MacOS apps and Simple Network Manager

### UIKit Tools
- Some Device info
- Convert `Int` - `Double` - `Float` - `Data` to `String` eg: `SomeData.stringValue`
- `UIImage`: `averageColor: UIColor?` & `resizeImage(targetSize: CGSize) -> UIImage`
- `UIImageView`: `setImageColor(color: UIColor)`
- `UILabel`: `calculateMaxLines() -> Int`
- `UIView`: Auto loadable from xib

### Combine Netorking
Flexible, cancellable, error safe

```swift

import YNetworkKit

ApiConstant.apiDefault.set(defaultDomain: "https://api.mocki.io")

class Interactor: Networkable {
    var someDataRequests: BaseRequestModel?
    
    func getSomeData(result: @escaping (Result<TestResponse, Error>) -> Void) {
        someDataRequests = BaseRequestModel(path: "/v1/d0e7928e", method: .GET([]))
        guard let someDataRequests = someDataRequests else { return }
        send(requestData: someDataRequests, modelType: TestResponse.self, result: result)
    }
    
    func cancel() {
        someDataRequests?.cancel()
    }
}
```
### Networkable
```swift
public protocol Networkable {
    func send<T>(requestData: BaseRequestProtocol,
                 modelType: T.Type,
                 decoder: JSONDecoder,
                 urlSession: NetworkProtocol,
                 result: @escaping (Result<T, Error>) -> Void) where T : Decodable
}
```

#### For Tests

When you used MockURLSession, json file from url last path and uses

```swift

public class MockURLSession: NetworkProtocol {
    let bundle: Bundle
    
    /// MockURLSession: Request handle json file content
    /// - Parameter bundle: Your json file bundle
    public init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    public func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        let stubReply = request.url?.lastPathComponent ?? "stub_error"
        return URLSession.shared.dataTaskPublisher(for: bundle.url(forResource: stubReply, withExtension: "json")!)
    }
}


// Send Request with mock URLSession
send(requestData: someDataRequests,
             modelType: TestResponse.self,
             urlSession: MockURLSession.init(bundle: Bundle(for: type(of: self))),
             result: result)
```
