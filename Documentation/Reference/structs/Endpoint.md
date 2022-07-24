**STRUCT**

# `Endpoint`

**Contents**

- [Properties](#properties)
  - `encoder`
  - `baseUrl`
  - `path`
  - `method`
- [Methods](#methods)
  - `init(baseUrl:path:method:)`
  - `createRequest(body:)`
  - `createRequest()`
  - `createRequest(query:)`
  - `setAuthorizationHeader(token:)`

```swift
struct Endpoint
```

## Properties
<details><summary markdown="span"><code>encoder</code></summary>

```swift
static let encoder = JSONEncoder()
```

</details>

<details><summary markdown="span"><code>baseUrl</code></summary>

```swift
let baseUrl: URL
```

</details>

<details><summary markdown="span"><code>path</code></summary>

```swift
let path: String
```

</details>

<details><summary markdown="span"><code>method</code></summary>

```swift
let method: Method
```

</details>

## Methods
<details><summary markdown="span"><code>init(baseUrl:path:method:)</code></summary>

```swift
init(baseUrl: URL, path: String, method: Method)
```

</details>

<details><summary markdown="span"><code>createRequest(body:)</code></summary>

```swift
func createRequest<T: Encodable>(body: T?) -> URLRequest
```

</details>

<details><summary markdown="span"><code>createRequest()</code></summary>

```swift
func createRequest() -> URLRequest
```

</details>

<details><summary markdown="span"><code>createRequest(query:)</code></summary>

```swift
func createRequest(query: [String: String]?) -> URLRequest
```

</details>

<details><summary markdown="span"><code>setAuthorizationHeader(token:)</code></summary>

```swift
mutating func setAuthorizationHeader(token: String)
```

</details>