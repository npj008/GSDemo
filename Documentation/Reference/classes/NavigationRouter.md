**CLASS**

# `NavigationRouter`

**Contents**

- [Properties](#properties)
  - `shared`
  - `mainNavigation`
  - `currentViewController`
- [Methods](#methods)
  - `presentAlertWithTitle(title:message:onDismiss:)`
  - `navigateToPhotoDetails(photoDetails:)`
  - `dismissFromPhotoDetails()`
  - `openURLExternally(url:)`

```swift
final class NavigationRouter
```

## Properties
<details><summary markdown="span"><code>shared</code></summary>

```swift
static let shared = NavigationRouter()
```

</details>

<details><summary markdown="span"><code>mainNavigation</code></summary>

```swift
var mainNavigation: UINavigationController?
```

</details>

<details><summary markdown="span"><code>currentViewController</code></summary>

```swift
var currentViewController: UIViewController?
```

</details>

## Methods
<details><summary markdown="span"><code>presentAlertWithTitle(title:message:onDismiss:)</code></summary>

```swift
func presentAlertWithTitle(title: String, message : String, onDismiss: (() -> Void)? = nil)
```

Method to Present Alert on `currentViewController`
 - Parameter title: Title for Alert view
 - Parameter message: Alert view message content
 - Parameter onDismiss: On dismiss completion handler

#### Parameters

| Name | Description |
| ---- | ----------- |
| title | Title for Alert view |
| message | Alert view message content |
| onDismiss | On dismiss completion handler |

</details>

<details><summary markdown="span"><code>navigateToPhotoDetails(photoDetails:)</code></summary>

```swift
func navigateToPhotoDetails(photoDetails: PictureDetails)
```

Method to navigate photo full screen view
 - Parameter photoDetails: Reference picture details for which Image needs to be shown

#### Parameters

| Name | Description |
| ---- | ----------- |
| photoDetails | Reference picture details for which Image needs to be shown |

</details>

<details><summary markdown="span"><code>dismissFromPhotoDetails()</code></summary>

```swift
func dismissFromPhotoDetails()
```

Method to dismiss photo detail view

</details>

<details><summary markdown="span"><code>openURLExternally(url:)</code></summary>

```swift
func openURLExternally(url: URL)
```

Method to open URL extenally
 - Parameter url: URL to open

#### Parameters

| Name | Description |
| ---- | ----------- |
| url | URL to open |

</details>