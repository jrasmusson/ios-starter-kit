# Performance

## Structs over Strings

Strings are indirectly allocated on the heap, while structs are always on the stack. So if you need a key for a dictionary, a struct is actually better.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/turn-off-debug-console.png" alt="drawing" width="400"/>

### Links that help

- [WWDC Understanding Swift Performance](https://developer.apple.com/videos/play/wwdc2016/416/)



