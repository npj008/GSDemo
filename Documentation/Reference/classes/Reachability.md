**CLASS**

# `Reachability`

**Contents**

- [Properties](#properties)
  - `whenReachable`
  - `whenUnreachable`
  - `reachableOnWWAN`
  - `allowsCellularConnection`
  - `notificationCenter`
  - `currentReachabilityString`
  - `currentReachabilityStatus`
  - `connection`
  - `notifierRunning`
  - `flags`
- [Methods](#methods)
  - `init(reachabilityRef:queueQoS:targetQueue:notificationQueue:)`
  - `init(hostname:queueQoS:targetQueue:notificationQueue:)`
  - `init(queueQoS:targetQueue:notificationQueue:)`
  - `deinit`

```swift
public class Reachability
```

## Properties
<details><summary markdown="span"><code>whenReachable</code></summary>

```swift
public var whenReachable: NetworkReachable?
```

</details>

<details><summary markdown="span"><code>whenUnreachable</code></summary>

```swift
public var whenUnreachable: NetworkUnreachable?
```

</details>

<details><summary markdown="span"><code>reachableOnWWAN</code></summary>

```swift
public let reachableOnWWAN: Bool = true
```

</details>

<details><summary markdown="span"><code>allowsCellularConnection</code></summary>

```swift
public var allowsCellularConnection: Bool
```

Set to `false` to force Reachability.connection to .none when on cellular connection (default value `true`)

</details>

<details><summary markdown="span"><code>notificationCenter</code></summary>

```swift
public var notificationCenter: NotificationCenter = NotificationCenter.default
```

</details>

<details><summary markdown="span"><code>currentReachabilityString</code></summary>

```swift
public var currentReachabilityString: String
```

</details>

<details><summary markdown="span"><code>currentReachabilityStatus</code></summary>

</details>

<details><summary markdown="span"><code>connection</code></summary>

```swift
public var connection: Connection
```

</details>

<details><summary markdown="span"><code>notifierRunning</code></summary>

```swift
fileprivate(set) var notifierRunning = false
```

</details>

<details><summary markdown="span"><code>flags</code></summary>

```swift
fileprivate(set) var flags: SCNetworkReachabilityFlags?
```

</details>

## Methods
<details><summary markdown="span"><code>init(reachabilityRef:queueQoS:targetQueue:notificationQueue:)</code></summary>

```swift
required public init(reachabilityRef: SCNetworkReachability,
                     queueQoS: DispatchQoS = .default,
                     targetQueue: DispatchQueue? = nil,
                     notificationQueue: DispatchQueue? = .main)
```

</details>

<details><summary markdown="span"><code>init(hostname:queueQoS:targetQueue:notificationQueue:)</code></summary>

```swift
public convenience init(hostname: String,
                        queueQoS: DispatchQoS = .default,
                        targetQueue: DispatchQueue? = nil,
                        notificationQueue: DispatchQueue? = .main) throws
```

</details>

<details><summary markdown="span"><code>init(queueQoS:targetQueue:notificationQueue:)</code></summary>

```swift
public convenience init(queueQoS: DispatchQoS = .default,
                        targetQueue: DispatchQueue? = nil,
                        notificationQueue: DispatchQueue? = .main) throws
```

</details>

<details><summary markdown="span"><code>deinit</code></summary>

```swift
deinit
```

</details>