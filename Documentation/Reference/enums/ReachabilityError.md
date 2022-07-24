**ENUM**

# `ReachabilityError`

**Contents**

- [Cases](#cases)
  - `failedToCreateWithAddress(_:_:)`
  - `failedToCreateWithHostname(_:_:)`
  - `unableToSetCallback(_:)`
  - `unableToSetDispatchQueue(_:)`
  - `unableToGetFlags(_:)`

```swift
public enum ReachabilityError: Error
```

## Cases
### `failedToCreateWithAddress(_:_:)`

```swift
case failedToCreateWithAddress(sockaddr, Int32)
```

### `failedToCreateWithHostname(_:_:)`

```swift
case failedToCreateWithHostname(String, Int32)
```

### `unableToSetCallback(_:)`

```swift
case unableToSetCallback(Int32)
```

### `unableToSetDispatchQueue(_:)`

```swift
case unableToSetDispatchQueue(Int32)
```

### `unableToGetFlags(_:)`

```swift
case unableToGetFlags(Int32)
```
