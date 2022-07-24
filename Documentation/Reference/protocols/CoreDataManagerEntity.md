**PROTOCOL**

# `CoreDataManagerEntity`

```swift
protocol CoreDataManagerEntity
```

## Methods
<details><summary markdown="span"><code>saveAPODData(postDetail:)</code></summary>

```swift
func saveAPODData(postDetail: PictureDetails) -> PictureDetails?
```

</details>

<details><summary markdown="span"><code>toggleFavorite(isFavorite:postDetail:completion:)</code></summary>

```swift
func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void))
```

</details>

<details><summary markdown="span"><code>getAllRecentPosts(_:sortAscending:)</code></summary>

```swift
func getAllRecentPosts(_ sortedByDate: Bool, sortAscending: Bool) -> [PictureDetails]
```

</details>

<details><summary markdown="span"><code>retriveFavouriteAPOD(_:sortAscending:)</code></summary>

```swift
func retriveFavouriteAPOD(_ sortedByDate: Bool,  sortAscending: Bool) -> [PictureDetails]
```

</details>