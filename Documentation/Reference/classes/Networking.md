**CLASS**

# `Networking`

**Contents**

- [Properties](#properties)
  - `configuration`
  - `session`
  - `encodableBody`
  - `query`
  - `fake`
  - `decoder`
- [Methods](#methods)
  - `init(configuration:)`
  - `sendRequest(_:queueType:completion:)`

```swift
class Networking<T: Codable>: NSObject
```

## Properties
<details><summary markdown="span"><code>configuration</code></summary>

```swift
let configuration: URLSessionConfiguration?
```

</details>

<details><summary markdown="span"><code>session</code></summary>

```swift
lazy var session: URLSession = {
    if let config = self.configuration {
        return URLSession(configuration: config)
    }
    return URLSession.shared
}()
```

</details>

<details><summary markdown="span"><code>encodableBody</code></summary>

```swift
var encodableBody: Encodable?
```

</details>

<details><summary markdown="span"><code>query</code></summary>

```swift
var query: [String: String]?
```

</details>

<details><summary markdown="span"><code>fake</code></summary>

```swift
var fake: String?
```

</details>

<details><summary markdown="span"><code>decoder</code></summary>

```swift
lazy var decoder: JSONDecoder = {
    let d = JSONDecoder()
    d.dateDecodingStrategy = .millisecondsSince1970
    return d
}()
```

</details>

## Methods
<details><summary markdown="span"><code>init(configuration:)</code></summary>

```swift
public init(configuration: URLSessionConfiguration? = nil)
```

</details>

<details><summary markdown="span"><code>sendRequest(_:queueType:completion:)</code></summary>

```swift
public func sendRequest(_ request: URLRequest, queueType: NetworkingQueueType = .concurrent, completion: @escaping (NetworkingResult<T>) -> Void)
```

</details>