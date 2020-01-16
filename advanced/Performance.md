# Performance

## Structs over Strings

Strings are indirectly allocated on the heap, while structs are always on the stack. So if you need a key for a dictionary, a struct is actually faster. Now if we cache the image in the dictionary, there is no heap allocation.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/performance/string-key.png" alt="drawing" width="300"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/performance/structs-over-strings.png" alt="drawing" width="600"/>

## Other improvements

Before

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/performance/before.png" alt="drawing" width="600"/>

After

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/performance/after.png" alt="drawing" width="600"/>

- UUID instead of string
- Enum over string for mimetype

## Three axis of performance

- stack vs heap
- retain counts (retain/release)
- method dispatch

Static method dispatch is when the compiler can figure out what method needs to be called at compile time. Very fast. Very efficient. Statically dispatched methods are also candidates for inlining and other optimizations.

Dynamic dispatch is when the compiler can't figure it out at compile time, and you can only figure out with a table lookup at runtime. That's not too bad. What is bad is that dynamic dispatches can't be optimized.

So static dispatching is preferred, and in Swift we get static dispatch with:

- marking classes as final (final classes can all be statically dispatched and inlined)
- use structs
- doing protocol oriented programming over classical inheritance

## Protocol oriented programming

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/performance/protocol-oriented.png" alt="drawing" width="600"/>





### Links that help

- [WWDC Understanding Swift Performance](https://developer.apple.com/videos/play/wwdc2016/416/)



