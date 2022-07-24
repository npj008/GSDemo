**PROTOCOL**

# `PhotoViewModelEntity`

```swift
protocol PhotoViewModelEntity
```

## Properties
<details><summary markdown="span"><code>pictureDetails</code></summary>

```swift
var pictureDetails: PictureDetails?
```

</details>

<details><summary markdown="span"><code>refreshUI</code></summary>

```swift
var refreshUI: (() -> ())?
```

</details>

<details><summary markdown="span"><code>toggleLoadingStatus</code></summary>

```swift
var toggleLoadingStatus: ((Bool, String) -> ())?
```

</details>

<details><summary markdown="span"><code>currentImage</code></summary>

```swift
var currentImage: UIImage?
```

</details>

## Methods
<details><summary markdown="span"><code>loadPhotoView()</code></summary>

```swift
func loadPhotoView()
```

</details>

<details><summary markdown="span"><code>closePhotoView()</code></summary>

```swift
func closePhotoView()
```

</details>