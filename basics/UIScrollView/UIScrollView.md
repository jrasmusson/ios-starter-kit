# UIScrollView


`UIScrollView`s aren't that bad so long as you remember that there are two sets of constraints:

1. The outer constraints between the `UIScrollView` and the outside world.
2. And the inner constraints between the inner content and the insides of the `UIScrollView` itself.

## View with a label

Scroll views work well when you:

- Add a view
- Pin it to the edges of the scroll view
- Set the views width equal to the parent of the scroll view width

### Setting up the view

- Add a view, set it's background to orange, and rename it `Content View`.

![](images/1.png)

- Embed it in a scroll view.
- Pin the scroll view to the `Safe Area` of the parent view.
- And then drag the scroll view out to the safe area edges of the view.

![](images/2.png)

- Stretch the `Content View` to the edges of the scroll view.

![](images/3.png)

- Pin the `Content View` to the `Content Layout Guide` of the scroll view.
- Don't use the attribute tool in the bottom.
- Instead drag each one one-at-a-time like this.

![](images/4.png)

- Set the width of the `Content View` = width of the parent view of the scroll view (not the scroll view itself)


### Links that help

* [Manually Scrolling](https://jayeshkawli.ghost.io/manually-scrolling-uiscrollview-ios-swift/)
* [Understanding UIScrollView](https://oleb.net/blog/2014/04/understanding-uiscrollview/)
* [Apple UIScrollView docs](https://developer.apple.com/documentation/uikit/uiscrollview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/scroll-views/)
* [Auto Layout UIScrollView](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1)
* [Example](https://blog.alltheflow.com/scrollable-uistackview)
