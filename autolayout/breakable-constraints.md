# Breakable constraints

Here is an example of a breakable contraint. Say you want a label to be at least 20px from the top, but flexible enough to be more if needed.

image1

You could do this by adding two constraints. One saying the spacing needs to be 20 (but give it a lower priority). And another saying spacing needs to be at least 20 or greater and make that a requirement (default priority 250 or 1000).

image2

The first constraint we call breakable because it is of a lower priority than the default and the others ones relative to it.

This technique is how minimum spacing is acheived, while providing designs enough flexibility to shrink and grow.



### Links that help
- [Apple Intrinsic Size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
