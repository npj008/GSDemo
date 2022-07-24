**CLASS**

# `APODCellViewModel`

**Contents**

- [Properties](#properties)
  - `post`
  - `type`
- [Methods](#methods)
  - `init(post:)`
  - `getCurrentFavoriteStatus()`
  - `fetchCellImage(completion:)`

```swift
class APODCellViewModel
```

## Properties
<details><summary markdown="span"><code>post</code></summary>

```swift
var post: PictureDetails
```

</details>

<details><summary markdown="span"><code>type</code></summary>

```swift
var type: PostType
```

Returns current type

</details>

## Methods
<details><summary markdown="span"><code>init(post:)</code></summary>

```swift
init(post: PictureDetails)
```

</details>

<details><summary markdown="span"><code>getCurrentFavoriteStatus()</code></summary>

```swift
func getCurrentFavoriteStatus() -> Bool
```

Method to get current favorite status

</details>

<details><summary markdown="span"><code>fetchCellImage(completion:)</code></summary>

```swift
func fetchCellImage(completion: @escaping ((UIImage?, Bool) -> Void))
```

Method to load image from remote server and cache it.
 - Parameter completion: completion returning image instance and status of completion

#### Parameters

| Name | Description |
| ---- | ----------- |
| completion | completion returning image instance and status of completion |

</details>