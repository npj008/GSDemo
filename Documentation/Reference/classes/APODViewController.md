**CLASS**

# `APODViewController`

**Contents**

- [Properties](#properties)
  - `segmentControl`
  - `dateSelector`
  - `viewModel`
- [Methods](#methods)
  - `viewDidLoad()`
  - `configureViewModel()`
  - `resetCache()`
  - `switchViewMode()`
  - `segmentAction(_:)`

```swift
class APODViewController: BaseViewController
```

## Properties
<details><summary markdown="span"><code>segmentControl</code></summary>

```swift
lazy var segmentControl: UISegmentedControl = {
   let segment = UISegmentedControl(items: ["Search", "Favorite"])
    segment.translatesAutoresizingMaskIntoConstraints = false
    segment.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
    segment.selectedSegmentIndex = 0
    return segment
}()
```

</details>

<details><summary markdown="span"><code>dateSelector</code></summary>

```swift
lazy var dateSelector: DateSelectorView = {
   let dateSelect = DateSelectorView()
    dateSelect.translatesAutoresizingMaskIntoConstraints = false
    dateSelect.delegate = self
    return dateSelect
}()
```

</details>

<details><summary markdown="span"><code>viewModel</code></summary>

```swift
var viewModel: APODViewModelEntity = APODViewModel()
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

<details><summary markdown="span"><code>resetCache()</code></summary>

```swift
@objc func resetCache()
```

</details>

<details><summary markdown="span"><code>switchViewMode()</code></summary>

```swift
@objc func switchViewMode()
```

</details>

<details><summary markdown="span"><code>segmentAction(_:)</code></summary>

```swift
@objc func segmentAction(_ segmentedControl: UISegmentedControl)
```

</details>