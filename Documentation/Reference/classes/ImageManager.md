**CLASS**

# `ImageManager`

**Contents**

- [Properties](#properties)
  - `shared`
  - `currentPictureQualityMode`
  - `concurrentQueueForImages`
  - `concurrentQueueForDataTasks`
- [Methods](#methods)
  - `downloadImage(with:completionHandler:placeholderImage:)`
  - `cleanupCache(completion:)`

```swift
final class ImageManager
```

## Properties
<details><summary markdown="span"><code>shared</code></summary>

```swift
static let shared = ImageManager()
```

</details>

<details><summary markdown="span"><code>currentPictureQualityMode</code></summary>

```swift
var currentPictureQualityMode: PhotoViewMode = .sd
```

</details>

<details><summary markdown="span"><code>concurrentQueueForImages</code></summary>

```swift
let concurrentQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)
```

</details>

<details><summary markdown="span"><code>concurrentQueueForDataTasks</code></summary>

```swift
let concurrentQueueForDataTasks = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)
```

</details>

## Methods
<details><summary markdown="span"><code>downloadImage(with:completionHandler:placeholderImage:)</code></summary>

```swift
func downloadImage(with imageUrlString: String?,
                   completionHandler: @escaping (UIImage?, Bool) -> Void,
                   placeholderImage: UIImage?)
```

Downloads and returns images through the completion closure to the caller
 - Parameter imageUrlString: The remote URL to download images from
 - Parameter completionHandler: A completion handler which returns two parameters. First one is an image which may or may
 not be cached and second one is a bool to indicate whether we returned the cached version or not
 - Parameter placeholderImage: Placeholder image to display as we're downloading them from the server

#### Parameters

| Name | Description |
| ---- | ----------- |
| imageUrlString | The remote URL to download images from |
| completionHandler | A completion handler which returns two parameters. First one is an image which may or may not be cached and second one is a bool to indicate whether we returned the cached version or not |
| placeholderImage | Placeholder image to display as we’re downloading them from the server |

</details>

<details><summary markdown="span"><code>cleanupCache(completion:)</code></summary>

```swift
func cleanupCache(completion: @escaping (() -> Void))
```

Cleanup local storage after some storage limit or constraint reached
  - Parameter completion: Closure when clearning is done

#### Parameters

| Name | Description |
| ---- | ----------- |
| completion | Closure when clearning is done |

</details>