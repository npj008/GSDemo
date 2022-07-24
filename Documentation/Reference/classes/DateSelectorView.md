**CLASS**

# `DateSelectorView`

**Contents**

- [Properties](#properties)
  - `delegate`
  - `txtField`
- [Methods](#methods)
  - `init()`
  - `init(coder:)`
  - `setupUI()`
  - `resetUI()`
  - `setupTextField()`
  - `cancelAction()`
  - `doneAction()`

```swift
class DateSelectorView: UIView
```

## Properties
<details><summary markdown="span"><code>delegate</code></summary>

```swift
weak var delegate: DateSelectorViewDelegate?
```

</details>

<details><summary markdown="span"><code>txtField</code></summary>

```swift
lazy var txtField: UITextField = {
    let txt = UITextField()
    txt.translatesAutoresizingMaskIntoConstraints = false
    return txt
}()
```

</details>

## Methods
<details><summary markdown="span"><code>init()</code></summary>

```swift
init()
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

<details><summary markdown="span"><code>resetUI()</code></summary>

```swift
func resetUI()
```

</details>

<details><summary markdown="span"><code>setupTextField()</code></summary>

```swift
func setupTextField()
```

</details>

<details><summary markdown="span"><code>cancelAction()</code></summary>

```swift
func cancelAction()
```

</details>

<details><summary markdown="span"><code>doneAction()</code></summary>

```swift
func doneAction()
```

</details>