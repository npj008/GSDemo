**CLASS**

# `PhotoViewModel`

**Contents**

- [Properties](#properties)
  - `pictureDetails`
  - `toggleLoadingStatus`
  - `refreshUI`
  - `currentImage`
- [Methods](#methods)
  - `loadPhotoView()`
  - `closePhotoView()`

```swift
class PhotoViewModel: PhotoViewModelEntity
```

## Properties
<details><summary markdown="span"><code>pictureDetails</code></summary>

```swift
var pictureDetails: PictureDetails?
```

</details>

<details><summary markdown="span"><code>toggleLoadingStatus</code></summary>

```swift
var toggleLoadingStatus: ((Bool, String) -> ())?
```

Observers for data bindings

</details>

<details><summary markdown="span"><code>refreshUI</code></summary>

```swift
var refreshUI: (() -> ())?
```

</details>

<details><summary markdown="span"><code>currentImage</code></summary>

```swift
private(set) var currentImage = GlobalConstants.placeholderImage
```

</details>

## Methods
<details><summary markdown="span"><code>loadPhotoView()</code></summary>

```swift
func loadPhotoView()
```

Method to load image in full screen view using current picture details

</details>

<details><summary markdown="span"><code>closePhotoView()</code></summary>

```swift
func closePhotoView()
```

Method to pop viewcontroller

</details>