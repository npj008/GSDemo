**ENUM**

# `NetworkingError`

**Contents**

- [Cases](#cases)
  - `dataReturnedNil(_:)`
  - `serverError`
  - `unauthorized`
  - `noInternetConnection`
  - `invalidStatusCode(_:)`
  - `jsonParsing(_:)`
  - `custom(_:)`
  - `forbidden`
  - `apiLimitReached`
- [Methods](#methods)
  - `error(forStatusCode:)`

```swift
public enum NetworkingError: Error
```

Representation of the type of networking error.

## Cases
### `dataReturnedNil(_:)`

```swift
case dataReturnedNil(String?)
```

There was no data retruned

### `serverError`

```swift
case serverError
```

Remote server error

### `unauthorized`

```swift
case unauthorized
```

Provided auth was not valid

### `noInternetConnection`

```swift
case noInternetConnection
```

Internet is not online

### `invalidStatusCode(_:)`

```swift
case invalidStatusCode(Int)
```

Status code not expected

### `jsonParsing(_:)`

```swift
case jsonParsing(String)
```

Could not parse json data

### `custom(_:)`

```swift
case custom(String)
```

Another error occurred

### `forbidden`

```swift
case forbidden
```

Access is not allowed

### `apiLimitReached`

```swift
case apiLimitReached
```

API Limit reached

## Methods
<details><summary markdown="span"><code>error(forStatusCode:)</code></summary>

```swift
static func error(forStatusCode code: Int) -> NetworkingError?
```

Provides interface to check and return `NetworkError` type as per status code.
- Parameter code: the http status code recieved from server.

#### Parameters

| Name | Description |
| ---- | ----------- |
| code | the http status code recieved from server. |

</details>