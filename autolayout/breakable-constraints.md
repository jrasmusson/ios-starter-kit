# Breakable constraints

## Example

Say you want a view to resize itself based on whether a button is visible or not. Create a breakable constraint from the bottom of the label to the bottom, and then turn off the constraints surrounding the button when it disappears.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-design.png" width="400"  alt="drawing" />

(https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-demo.gif)

## Example in Interface Builder Xcode

Here is an example of a breakable contraint. Say you want a label to be at least 20px from the top, but flexible enough to be more if needed.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable1.png" width="400"  alt="drawing" />

You could do this by adding two constraints. One saying the spacing needs to be 20 (but give it a lower priority). And another saying spacing needs to be at least 20 or greater and make that a requirement (default priority 250 or 1000).

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable2.png" width="400"  alt="drawing" />

The first constraint we call breakable because it is of a lower priority than the default and the others ones relative to it.

This technique is how minimum spacing is acheived, while providing designs enough flexibility to shrink and grow.



### Links that help
- [Apple Intrinsic Size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
