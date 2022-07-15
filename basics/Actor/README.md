# Actor

`Actors` serialize access to mutable state.

```swift
actor Counter {
	var value = 0
	
	func increment() -> Int [
		value = value + 1
		return value
	}
}

let counter = Counter()
Task.detached {
	print(counter.increment()) // 2
}

Task.detached {
	print(counter.increment()) // 1
}
```


### Links that help

- [WWDC 2022 Protect mutable state with Swift Actors](https://developer.apple.com/videos/play/wwdc2021/10133)
