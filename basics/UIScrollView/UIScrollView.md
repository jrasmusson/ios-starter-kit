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
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        // 2. Content is a stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Attaching the content's edges to the scroll view's edges
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Satisfying size constraints
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        
        // Add arranged subviews:
        for i in 0...20 {
            // A simple green view.
            let greenView = UIView()
            greenView.backgroundColor = .green
            stackView.addArrangedSubview(greenView)
            greenView.translatesAutoresizingMaskIntoConstraints = false
            // Doesn't have intrinsic content size, so we have to provide the height at least
            greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
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


### Links that help

* [Apple UIScrollView docs](https://developer.apple.com/documentation/uikit/uiscrollview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/scroll-views/)
* [Auto Layout UIScrollView](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1)
* [Example](https://blog.alltheflow.com/scrollable-uistackview)
