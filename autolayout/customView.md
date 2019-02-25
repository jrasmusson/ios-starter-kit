# Custom View

Here are some things you need to know about creating custom views in iOS.

* don't set width/height constraints in custom views
* just do your layout relative to the bounds of the view you are in, but let the container control how you appear in the super view via it's contraints and let it set the hugging and compressing
* do give your views an intrinsic size if you can. This will help them with various autolayout configurations and get rid of ambiguous layout. It will also help with `UIStackView`

## Example Custom View

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/turn-off-debug-console.png" alt="drawing" width="400"/>


## Example Custom View in StackView


### Links that help

* [Apple Docs - Intrinsic Content Size](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - Views with intrinsic content size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
* [Apple Docs - Intrinsic Content Size Equations](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
* [What is tntrinsic content size](https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3)
* [Custom view in swift done right](https://blog.usejournal.com/custom-uiview-in-swift-done-right-ddfe2c3080a)
* [Guide to creating custom uiview](https://samwize.com/2017/11/01/guide-to-creating-custom-uiview/)
