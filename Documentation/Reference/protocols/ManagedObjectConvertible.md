**PROTOCOL**

# `ManagedObjectConvertible`

```swift
protocol ManagedObjectConvertible
```

Protocol to provide functionality for Core Data managed object conversion.

## Methods
<details><summary markdown="span"><code>toManagedObject(in:)</code></summary>

```swift
func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
```

Converts a conforming instance to a managed object instance.

- Parameter context: The managed object context to use.
- Returns: The converted managed object instance.

#### Parameters

| Name | Description |
| ---- | ----------- |
| context | The managed object context to use. |

</details>