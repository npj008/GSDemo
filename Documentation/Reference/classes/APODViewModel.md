**CLASS**

# `APODViewModel`

**Contents**

- [Properties](#properties)
  - `currentPictureQualityMode`
  - `refreshUI`
  - `resetUI`
  - `showAlert`
  - `toggleLoadingStatus`
  - `totalCells`
  - `coreDataManager`
  - `currentMode`
  - `allCellVMs`
  - `selectedDate`
  - `apiService`
- [Methods](#methods)
  - `init(coreDataService:)`
  - `initialise()`
  - `setCurrentMode(mode:)`
  - `getCellViewModel(at:)`
  - `getCellViewModel(title:)`
  - `toggleFavorite(isFavorite:postDetail:completion:)`
  - `playVideo(url:)`
  - `expandImage(postDetails:)`
  - `cleanupCache(completion:)`

```swift
class APODViewModel: APODViewModelEntity
```

## Properties
<details><summary markdown="span"><code>currentPictureQualityMode</code></summary>

```swift
var currentPictureQualityMode: PhotoViewMode
```

Setting this will refresh UI with updated picture quality

</details>

<details><summary markdown="span"><code>refreshUI</code></summary>

```swift
var refreshUI: (() -> ())?
```

</details>

<details><summary markdown="span"><code>resetUI</code></summary>

```swift
var resetUI: (() -> ())?
```

</details>

<details><summary markdown="span"><code>showAlert</code></summary>

```swift
var showAlert: ((String?) -> ())?
```

</details>

<details><summary markdown="span"><code>toggleLoadingStatus</code></summary>

```swift
var toggleLoadingStatus: ((Bool, String) -> ())?
```

</details>

<details><summary markdown="span"><code>totalCells</code></summary>

```swift
var totalCells: Int
```

</details>

<details><summary markdown="span"><code>coreDataManager</code></summary>

```swift
let coreDataManager: CoreDataManagerEntity
```

</details>

<details><summary markdown="span"><code>currentMode</code></summary>

```swift
private(set) var currentMode: APODViewModelStete = .search(date: nil)
```

Holds current mode value

</details>

<details><summary markdown="span"><code>allCellVMs</code></summary>

```swift
private(set) var allCellVMs: [APODCellViewModel] = [APODCellViewModel]()
```

Setting this cell VMs will refresh main UI

</details>

<details><summary markdown="span"><code>selectedDate</code></summary>

```swift
private(set) var selectedDate: Date?
```

</details>

<details><summary markdown="span"><code>apiService</code></summary>

```swift
private(set) var apiService: GSAPIServiceEntity?
```

</details>

## Methods
<details><summary markdown="span"><code>init(coreDataService:)</code></summary>

```swift
init(coreDataService: CoreDataManagerEntity = CoreDataManager(modelName: "GS_Demo"))
```

</details>

<details><summary markdown="span"><code>initialise()</code></summary>

```swift
func initialise()
```

Initiate viewmodel

</details>

<details><summary markdown="span"><code>setCurrentMode(mode:)</code></summary>

```swift
func setCurrentMode(mode: APODViewModelStete)
```

</details>

<details><summary markdown="span"><code>getCellViewModel(at:)</code></summary>

```swift
func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel
```

</details>

<details><summary markdown="span"><code>getCellViewModel(title:)</code></summary>

```swift
func getCellViewModel(title: String) -> APODCellViewModel?
```

</details>

<details><summary markdown="span"><code>toggleFavorite(isFavorite:postDetail:completion:)</code></summary>

```swift
func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void))
```

To update current favorite state of picture details and cache it locally
 - Parameter isFavorite: Either liked or not
 - Parameter postDetail: Post for which favorite status needs to be changed
 - Parameter completion: Completion handler indicating operation is completed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| isFavorite | Either liked or not |
| postDetail | Post for which favorite status needs to be changed |
| completion | Completion handler indicating operation is completed. |

</details>

<details><summary markdown="span"><code>playVideo(url:)</code></summary>

```swift
func playVideo(url: URL)
```

Method for open video url in external browser
 - Parameter url: Video URL

#### Parameters

| Name | Description |
| ---- | ----------- |
| url | Video URL |

</details>

<details><summary markdown="span"><code>expandImage(postDetails:)</code></summary>

```swift
func expandImage(postDetails: PictureDetails)
```

Method for full screen picture view navigation
 - Parameter postDetails: Pincture details for which Image needs to display

#### Parameters

| Name | Description |
| ---- | ----------- |
| postDetails | Pincture details for which Image needs to display |

</details>

<details><summary markdown="span"><code>cleanupCache(completion:)</code></summary>

```swift
func cleanupCache(completion: @escaping (() -> Void))
```

Method to clear local cache data
 - Parameter completion: Completion handler once cleanup task is done

#### Parameters

| Name | Description |
| ---- | ----------- |
| completion | Completion handler once cleanup task is done |

</details>