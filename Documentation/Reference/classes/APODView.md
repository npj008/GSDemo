**CLASS**

# `APODView`

**Contents**

- [Properties](#properties)
  - `viewModel`
  - `tableView`
- [Methods](#methods)
  - `init(viewModel:)`
  - `refreshUI()`
  - `init(coder:)`
  - `configureTableView()`

```swift
class APODView: UIView
```

## Properties
<details><summary markdown="span"><code>viewModel</code></summary>

```swift
var viewModel: APODViewModelEntity
```

</details>

<details><summary markdown="span"><code>tableView</code></summary>

```swift
lazy var tableView: UITableView = {
    let tbl = UITableView()
    tbl.translatesAutoresizingMaskIntoConstraints = false
    tbl.bounces = false
    tbl.showsVerticalScrollIndicator = false
    return tbl
}()
```

</details>

## Methods
<details><summary markdown="span"><code>init(viewModel:)</code></summary>

```swift
init(viewModel: APODViewModelEntity)
```

</details>

<details><summary markdown="span"><code>refreshUI()</code></summary>

```swift
func refreshUI()
```

</details>

<details><summary markdown="span"><code>init(coder:)</code></summary>

```swift
required init?(coder: NSCoder)
```

</details>

<details><summary markdown="span"><code>configureTableView()</code></summary>

```swift
func configureTableView()
```

</details>