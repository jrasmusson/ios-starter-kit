# UIStackView Basics

Let's say we want to build this model using a `UIStackView`.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/model.png" alt="drawing" width="400"/>

Let's say we want to build a basic form with a `UILabel` and `UITextField` side-by-side. If we drop a label and text field into a `UIStackView` we get this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-hugging.png" alt="drawing" width="400"/>

This is fine (not really) but what we are missing is the hugging and compression necessary to tell autolayout which control to expand, and which not to.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/chart.png" alt="drawing" width="800"/>

Usually in this situation we want the label to hold it's intrinsic width, and have the text field expand. So we **increase** the `UILabel` horizontal and vertical **hugging**, while **decreasing** the `UITextField` hugging and horizontal resistance.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/hugging-added.png" alt="drawing" width="400"/>

OK not bad. But what we need are some attributes on our stack views.

### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uistackview)
* [Apple Example](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1)


