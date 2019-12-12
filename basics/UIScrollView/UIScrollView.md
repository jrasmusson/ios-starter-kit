# UIScrollView

`UIScrollView`s aren't that bad so long as you remember that there are two sets of constraints:

1. The outer constraints between the `UIScrollView` and the outside world.
2. And the inner constraints between the inner content and the insides of the `UIScrollView` itself.

That and the fact the `UIScrollView` requires your content to have an intrinsic size. If you are purely using elements that already have an intrinsic size already set (`UILabel` and `UIImageView` you don't need to do anything. But if not you have to give your views a height or something else the layout won't work.

Here is a simple [example](https://blog.alltheflow.com/scrollable-uistackview) that places a `UIStackView` along with some labels inside a `UIScrollView`.

```swift
//
//  ViewController.swift
//  ScrollableStackView
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-04.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Scroll view, vertical
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // 2. Content is a stack view
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fill
        scrollView.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true

        // Add arranged subviews:
        for i in 0...20 {
            // A simple green view.
            let greenView = UIView()
            greenView.backgroundColor = .green
            stackView.addArrangedSubview(greenView)
            greenView.translatesAutoresizingMaskIntoConstraints = false
            // Doesn't have intrinsic content size, so we have to provide the height at least
            greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            greenView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

            // Label (has instrinsic content size)
            let label = UILabel()
            label.backgroundColor = .orange
            label.text = "I'm label \(i)."
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }

        // get rid of gap at top
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

    }

}
``` 

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIScrollView/images/demo.gif)

Note: If you don't know the intrinsic size of a view in the `UIStackView` you need to set it yourself. One quick way to make it the height of the screen is as follows

```swift
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        let chatView = ChatView()
        chatView.heightAnchor.constraint(equalToConstant: screenHeight).isActive = true
        stackView.addArrangedSubview(chatView)
```

## The trick to understanding ScrollViews

The trick to understanding scroll views is you can't just rely on your contents intrinsic height to layout the scroll views content. You need an unbroken chain of constraints to the scroll view can calculate is scrollable area.

For example, if we add a lable to a scroll view, but don't fully pin it to all the edge of the scroll view (and try to rely solely on it's intrinsic size like, this, we will get a warning.

```swift
label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true\
```

`Warning: Constraints for scrollable content height are missing.`

And that's because even though the label has an intrinsic content size, the scroll view can't determine how much of the view is scrollable. The fix is to add the bottom constraint to fully define it.

```label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true```

Apple in their [docs](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html) describes it like this:

> IMPORTANT
>
> Your layout must fully define the size of the content view (except where defined in steps 5 and 6). To set the height based on the intrinsic size of your content, you must have an unbroken chain of constraints and views stretching from the content view’s top edge to its bottom edge. Similarly, to set the width, you must have an unbroken chain of constraints and views from the content view’s leading edge to its trailing edge.
> 
> If your content does not have an intrinsic content size, you must add the appropriate size constraints, either to the content view or to the content.
> 
> When the content view is taller than the scroll view, the scroll view enables vertical scrolling. When the content view is wider than the scroll view, the scroll view enables horizontal scrolling. Otherwise, scrolling is disabled by default.
> 

## How to programmatically scroll

You can scroll to a position in your scroll view based on an offset.

```swift
override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let contentSizeHeight = scrollView.contentSize.height
        let boundsHeight = scrollView.bounds.size.height
        let bottomOffset = CGPoint(x:0, y: contentSizeHeight - boundsHeight)
        scrollView.setContentOffset(bottomOffset, animated: true)

       // scrollView.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
    }
```

> Note: This may not work in `viewDidLoad()` as view will not have been totally sized and rendered.


### Links that help

* [Undserstanding UIScrollView](https://oleb.net/blog/2014/04/understanding-uiscrollview/)
* [Apple UIScrollView docs](https://developer.apple.com/documentation/uikit/uiscrollview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/scroll-views/)
* [Auto Layout UIScrollView](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1)
* [Example](https://blog.alltheflow.com/scrollable-uistackview)
