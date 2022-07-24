**PROTOCOL**

# `APODViewModelEntity`

```swift
protocol APODViewModelEntity: ViewModelOveservers,
                              FavoritablePictureProtocol
```

## Properties
<details><summary markdown="span"><code>currentPictureQualityMode</code></summary>

```swift
var currentPictureQualityMode: PhotoViewMode
```

</details>

<details><summary markdown="span"><code>totalCells</code></summary>

```swift
var totalCells: Int
```

</details>

<details><summary markdown="span"><code>selectedDate</code></summary>

```swift
var selectedDate: Date?
```

</details>

<details><summary markdown="span"><code>currentMode</code></summary>

```swift
var currentMode: APODViewModelStete
```

</details>

## Methods
<details><summary markdown="span"><code>getCellViewModel(at:)</code></summary>

```swift
func getCellViewModel(at indexPath: IndexPath) -> APODCellViewModel
```

</details>

<details><summary markdown="span"><code>initialise()</code></summary>

```swift
func initialise()
```

</details>

<details><summary markdown="span"><code>setCurrentMode(mode:)</code></summary>

```swift
func setCurrentMode(mode: APODViewModelStete)
```

</details>

<details><summary markdown="span"><code>cleanupCache(completion:)</code></summary>

```swift
func cleanupCache(completion: @escaping (() -> Void))
```

</details>

<details><summary markdown="span"><code>playVideo(url:)</code></summary>

```swift
func playVideo(url: URL)
```

</details>

<details><summary markdown="span"><code>expandImage(postDetails:)</code></summary>

```swift
func expandImage(postDetails: PictureDetails)
```

</details>