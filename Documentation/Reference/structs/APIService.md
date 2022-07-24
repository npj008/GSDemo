**STRUCT**

# `APIService`

**Contents**

- [Properties](#properties)
  - `baseUrl`
  - `shared`

```swift
struct APIService
```

## Properties
<details><summary markdown="span"><code>baseUrl</code></summary>

```swift
static let baseUrl = URL(string: NetworkingConstants.baseURL)!
```

</details>

<details><summary markdown="span"><code>shared</code></summary>

```swift
static var shared = GSAPIServices.init(baseUrl: baseUrl)
```

</details>
