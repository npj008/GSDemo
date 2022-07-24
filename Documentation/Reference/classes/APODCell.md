**CLASS**

# `APODCell`

**Contents**

- [Properties](#properties)
  - `delegate`
  - `selecteImagethumbnail`
  - `photoPostCellViewModel`
  - `playVideo`
  - `expandImage`
  - `likeButton`
  - `playVideoButton`
  - `imgView`
  - `alphaView`
  - `photoDate`
  - `detailStackView`
  - `photoTitle`
  - `photoExplaination`
  - `spinner`
- [Methods](#methods)
  - `init(style:reuseIdentifier:)`
  - `init(coder:)`
  - `setupUI()`
  - `likeTapped(sender:)`
  - `playVideoTapped(sender:)`
  - `imageTapped(_:)`
  - `prepareForReuse()`

```swift
class APODCell: UITableViewCell
```

## Properties
<details><summary markdown="span"><code>delegate</code></summary>

```swift
weak var delegate: FavoritablePictureProtocol?
```

</details>

<details><summary markdown="span"><code>selecteImagethumbnail</code></summary>

```swift
var selecteImagethumbnail: UIImage?
```

</details>

<details><summary markdown="span"><code>photoPostCellViewModel</code></summary>

```swift
var photoPostCellViewModel : APODCellViewModel?
```

</details>

<details><summary markdown="span"><code>playVideo</code></summary>

```swift
var playVideo: ((URL) -> ())?
```

</details>

<details><summary markdown="span"><code>expandImage</code></summary>

```swift
var expandImage: ((PictureDetails) -> ())?
```

</details>

<details><summary markdown="span"><code>likeButton</code></summary>

```swift
lazy var likeButton: UIButton = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.tag = 200
    btn.setImage(GlobalConstants.likeEmptyImage, for: .normal)
    btn.tintColor = .systemRed
    btn.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
    return btn
}()
```

</details>

<details><summary markdown="span"><code>playVideoButton</code></summary>

```swift
lazy var playVideoButton: UIButton = {
    let btn = UIButton()
    btn.translatesAutoresizingMaskIntoConstraints = false
    let img = UIImage(systemName: "play")
    btn.setBackgroundImage(img, for: .normal)
    btn.addTarget(self, action: #selector(playVideoTapped), for: .touchUpInside)
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
    imgView.contentMode = .scaleToFill
    imgView.setContentHuggingPriority(.required, for: .vertical)
    return imgView
}()
```

</details>

<details><summary markdown="span"><code>alphaView</code></summary>

```swift
lazy var alphaView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemBackground.withAlphaComponent(0.9)
    view.clipsToBounds = true
    return view
}()
```

</details>

<details><summary markdown="span"><code>photoDate</code></summary>

```swift
lazy var photoDate: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.backgroundColor = .clear
    lbl.textColor = .label
    lbl.font = .preferredFont(forTextStyle: .title1)
    lbl.numberOfLines = 1
    lbl.textAlignment = .left
    return lbl
}()
```

</details>

<details><summary markdown="span"><code>detailStackView</code></summary>

```swift
lazy var detailStackView : UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.distribution = .fillProportionally
    stack.alignment = .fill
    stack.spacing = 5.0
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.setContentCompressionResistancePriority(.required, for: .vertical)
    stack.addArrangedSubview(photoTitle)
    stack.addArrangedSubview(photoExplaination)
    return stack
}()
```

</details>

<details><summary markdown="span"><code>photoTitle</code></summary>

```swift
lazy var photoTitle: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.backgroundColor = .clear
    lbl.textColor = .label
    lbl.text = photoPostCellViewModel?.post.title
    lbl.numberOfLines = 0
    lbl.textAlignment = .center
    lbl.font = .preferredFont(forTextStyle: .title3)
    lbl.setContentHuggingPriority(.required, for: .vertical)
    lbl.clipsToBounds = true
    return lbl
}()
```

</details>

<details><summary markdown="span"><code>photoExplaination</code></summary>

```swift
lazy var photoExplaination: UILabel = {
    let lbl = UILabel()
    lbl.translatesAutoresizingMaskIntoConstraints = false
    lbl.backgroundColor = .systemGray.withAlphaComponent(0.1)
    lbl.textColor = .label
    lbl.text = "explaination"
    lbl.numberOfLines = 0
    lbl.text = photoPostCellViewModel?.post.explanation
    lbl.font = .preferredFont(forTextStyle: .body)
    lbl.setContentHuggingPriority(.required, for: .vertical)
    lbl.layer.cornerRadius = 5.0
    lbl.clipsToBounds = true
    return lbl
}()
```

</details>

<details><summary markdown="span"><code>spinner</code></summary>

```swift
lazy var spinner: UIActivityIndicatorView = {
    let act = UIActivityIndicatorView()
    act.translatesAutoresizingMaskIntoConstraints = false
    act.color = .label
    act.style = .large
    act.backgroundColor = .systemBackground.withAlphaComponent(0.5)
    return act
}()
```

</details>

## Methods
<details><summary markdown="span"><code>init(style:reuseIdentifier:)</code></summary>

```swift
override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
```

</details>

<details><summary markdown="span"><code>init(coder:)</code></summary>

```swift
required init?(coder: NSCoder)
```

</details>

<details><summary markdown="span"><code>setupUI()</code></summary>

```swift
func setupUI()
```

</details>

<details><summary markdown="span"><code>likeTapped(sender:)</code></summary>

```swift
@objc func likeTapped(sender: UIButton)
```

</details>

<details><summary markdown="span"><code>playVideoTapped(sender:)</code></summary>

```swift
@objc func playVideoTapped(sender: UIButton)
```

</details>

<details><summary markdown="span"><code>imageTapped(_:)</code></summary>

```swift
@objc func imageTapped(_ sender: UITapGestureRecognizer)
```

</details>

<details><summary markdown="span"><code>prepareForReuse()</code></summary>

```swift
override func prepareForReuse()
```

</details>