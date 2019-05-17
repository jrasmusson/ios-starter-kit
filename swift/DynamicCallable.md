# DynamicCallable

Something you can do in Swift is make an entire data structure callable simply by instantiating it.

Say for example we have a struct with a method that looks like this

```swift
struct ChatNotifier {

    func notify() {
      // code
    }    
}
```

You can convert it into a dynamicCallable (meaning instantiating the struct execute it).

```swift
@dynamicCallable
struct ChatNotifier {

    func dynamicallyCall(withArguments: [Any]) {
      // code
    }    
}
```

So now instead of instantiating and callling explicitly 

```swift
let notifier = ChatNotifier()
notifier.call()
```

You can simply instantiate the stuct and by appending `()` at the end it will automatically call the `dynamicallyCall`able method.

```swift
let notifier = ChatNotifier()()
```


### Links that help

* http://www.alwaysrightinstitute.com/swift-dynamic-callable/