**CLASS**

# `CoreDataManager`

**Contents**

- [Methods](#methods)
  - `init(modelName:)`
  - `saveAPODData(postDetail:)`
  - `toggleFavorite(isFavorite:postDetail:completion:)`
  - `retriveFavouriteAPOD(_:sortAscending:)`
  - `getAllRecentPosts(_:sortAscending:)`

```swift
final class CoreDataManager: CoreDataManagerEntity
```

## Methods
<details><summary markdown="span"><code>init(modelName:)</code></summary>

```swift
init(modelName: String)
```

</details>

<details><summary markdown="span"><code>saveAPODData(postDetail:)</code></summary>

```swift
func saveAPODData(postDetail: PictureDetails) -> PictureDetails?
```

Save individual pictureDetails
parameters:

- Parameter postDetail: Picture to save

#### Parameters

| Name | Description |
| ---- | ----------- |
| postDetail | Picture to save |

</details>

<details><summary markdown="span"><code>toggleFavorite(isFavorite:postDetail:completion:)</code></summary>

```swift
func toggleFavorite(isFavorite: Bool, postDetail: PictureDetails, completion: @escaping ((Bool) -> Void))
```

Change favorite flag for particular pictureDetails
parameters:

- Parameter isFavorite: Bool flag to indicate status of favorite
- Parameter postDetail: Post to update favorite status

#### Parameters

| Name | Description |
| ---- | ----------- |
| isFavorite | Bool flag to indicate status of favorite |
| postDetail | Post to update favorite status |

</details>

<details><summary markdown="span"><code>retriveFavouriteAPOD(_:sortAscending:)</code></summary>

```swift
func retriveFavouriteAPOD(_ sortedByDate: Bool = true,  sortAscending: Bool = true) -> [PictureDetails]
```

Retrieves all favourite pictureDetails items stored in the persistence layer, default (overridable)
parameters:

- Parameter sortedByDate: Bool flag to add sort rule: by Date
- Parameter sortAscending: Bool flag to set rule on sorting: Ascending / Descending date.
    
- Returns: [PictureDetails] with found photoDetails in datastore

#### Parameters

| Name | Description |
| ---- | ----------- |
| sortedByDate | Bool flag to add sort rule: by Date |
| sortAscending | Bool flag to set rule on sorting: Ascending / Descending date. |

</details>

<details><summary markdown="span"><code>getAllRecentPosts(_:sortAscending:)</code></summary>

```swift
func getAllRecentPosts(_ sortedByDate: Bool = true, sortAscending: Bool = true) -> [PictureDetails]
```

Retrieves all recent pictureDetails items stored in the persistence layer, default (overridable)
parameters:

- Parameter sortedByDate: Bool flag to add sort rule: by Date
- Parameter sortAscending: Bool flag to set rule on sorting: Ascending / Descending date.
    
- Returns: [PictureDetails] with found photoDetails in datastore

#### Parameters

| Name | Description |
| ---- | ----------- |
| sortedByDate | Bool flag to add sort rule: by Date |
| sortAscending | Bool flag to set rule on sorting: Ascending / Descending date. |

</details>