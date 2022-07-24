**CLASS**

# `AppDelegate`

**Contents**

- [Properties](#properties)
  - `window`
  - `coreData`
- [Methods](#methods)
  - `application(_:didFinishLaunchingWithOptions:)`

```swift
class AppDelegate: UIResponder, UIApplicationDelegate
```

## Properties
<details><summary markdown="span"><code>window</code></summary>

```swift
var window: UIWindow?
```

</details>

<details><summary markdown="span"><code>coreData</code></summary>

```swift
private(set) var coreData: CoreDataManager?
```

</details>

## Methods
<details><summary markdown="span"><code>application(_:didFinishLaunchingWithOptions:)</code></summary>

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
```

</details>