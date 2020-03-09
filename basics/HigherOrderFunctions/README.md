# Higher Order Functions

## Map

Apply same operation to each element in an array and return the transformed array.

```swift
var numbers2 = [1, 2, 3]
var strings2 = numbers2.map { "\($0)" } // closure
```

### Compact Map

Same as `map` but returns only _non-nil_ results.

```swift
let numbers = ["101", "102", "103", "11"]
let unsortedInts = numbers.compactMap { Int($0) } // [101, 102, 103, 11]
```

### Map with if

```swift
  var arr = [11, 12, 13, 14, 15]
  arr = arr.map { elem in
      if elem == 15 { return 1 } else { return 0 }
  }
```
## Filter


Select only those elements which satisfy a certain condition.

```swift
var numbers3 = [1, 2, 3, 4, 5, 6, 7, 8]
var evenNumbers = numbers3.filter { $0 % 2 == 0 } // [2, 4, 6, 8]
var oddNumbers  = numbers3.filter { $0 % 2 == 1 } // [1, 3, 5, 7]
```

## Reduce

Combines all the values into one.

```swift
var numbers4 = [1, 2, 3, 4, 5]
var sum = numbers4.reduce(0) { $0 + $1 } // 15
```

# Examples

## How to numerically sort an array of numeric strings

```swift
let numbers = ["101", "102", "103", "11"]
let sorted = numbers.compactMap { Int($0) }.sorted(by: <).compactMap { String($0) } // ["11", "101", "102", "103"]
```

