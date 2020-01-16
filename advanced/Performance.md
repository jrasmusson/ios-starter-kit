# Performance

## Structs over Strings

Strings are indirectly allocated on the heap, while structs are always on the stack. So if you need a key for a dictionary, a struct is actually faster. Now if we cache the image in the dictionary, there is no heap allocation.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/string-key.png" alt="drawing" width="300"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/struct-over-strings.png" alt="drawing" width="600"/>

### Links that help

- [WWDC Understanding Swift Performance](https://developer.apple.com/videos/play/wwdc2016/416/)



