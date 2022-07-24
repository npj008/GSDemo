**STRUCT**

# `GSAPIServices`

**Contents**

- [Properties](#properties)
  - `baseUrl`
- [Methods](#methods)
  - `init(baseUrl:)`
  - `fetchAPODDetails(date:completion:)`

```swift
public struct GSAPIServices: GSAPIServiceEntity
```

## Properties
<details><summary markdown="span"><code>baseUrl</code></summary>

```swift
let baseUrl: URL
```

</details>

## Methods
<details><summary markdown="span"><code>init(baseUrl:)</code></summary>

```swift
public init(baseUrl: URL)
```

</details>

<details><summary markdown="span"><code>fetchAPODDetails(date:completion:)</code></summary>

```swift
func fetchAPODDetails(date: Date, completion: @escaping (_: GSAPIServiceResult<PictureDetails>) -> Void)
```

Fetch APOD for the given date:

- Parameter date: Date object for which APOD needs to be fetched
- Parameter @escaping completion: Completion handler returning ServiceResult with PictureDetails

#### Parameters

| Name | Description |
| ---- | ----------- |
| date | Date object for which APOD needs to be fetched |
| @escaping completion | Completion handler returning ServiceResult with PictureDetails |

</details>