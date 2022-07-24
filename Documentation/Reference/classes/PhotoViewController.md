**CLASS**

# `PhotoViewController`

**Contents**

- [Properties](#properties)
  - `viewModel`
  - `zoomGesture`
  - `currentPost`
  - `closeButton`
  - `imgView`
- [Methods](#methods)
  - `viewDidLoad()`
  - `configureViewModel()`
  - `closeTapped(sender:)`
  - `resetCache()`
  - `zoomImage(sender:)`

```swift
class PhotoViewController: BaseViewController
```

## Properties
<details><summary markdown="span"><code>viewModel</code></summary>

```swift
var viewModel: PhotoViewModelEntity = PhotoViewModel()
```

</details>

<details><summary markdown="span"><code>zoomGesture</code></summary>

```swift
lazy var zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(zoomImage(sender:)))
```

</details>

<details><summary markdown="span"><code>currentPost</code></summary>

```swift
var currentPost: PictureDetails?
```

</details>

<details><summary markdown="span"><code>closeButton</code></summary>

```swift
lazy var closeButton: UIButton = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    let img = UIImage(systemName: "play")
    btn.setBackgroundImage(img, for: .normal)
    btn.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
    btn.tintColor = .white
    btn.isHidden = true
    return btn
}()
```

</details>

<details><summary markdown="span"><code>imgView</code></summary>

```swift
lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.translatesAutoresizingMaskIntoConstraints = false
    imgView.image = GlobalConstants.placeholderImage
    imgView.contentMode = .scaleAspectFit
    return imgView
}()
```

</details>

## Methods
<details><summary markdown="span"><code>viewDidLoad()</code></summary>

```swift
override func viewDidLoad()
```

</details>

<details><summary markdown="span"><code>configureViewModel()</code></summary>

```swift
func configureViewModel()
```

</details>

<details><summary markdown="span"><code>closeTapped(sender:)</code></summary>

```swift
@objc func closeTapped(sender: UIButton)
```

</details>

<details><summary markdown="span"><code>resetCache()</code></summary>

```swift
@objc func resetCache()
```

</details>

<details><summary markdown="span"><code>zoomImage(sender:)</code></summary>

```swift
@objc func zoomImage(sender: UIPinchGestureRecognizer)
```

</details>