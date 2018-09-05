# UIStackView Basics

Let's say we want to build this model using a `UIStackView`.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/model.png" alt="drawing" width="400"/>

We can start off with a `UILabel` and `UITextField` side-by-side. 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-hugging.png" alt="drawing" width="400"/>

But what we are missing is the hugging and compression necessary to tell autolayout which control to expand, and which not to.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/chart.png" alt="drawing" width="600"/>

Usually in this situation we want the label to hold it's intrinsic width, and have the text field expand. So we **increase** the `UILabel` horizontal and vertical **hugging**, while **decreasing** the `UITextField` hugging and horizontal resistance.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/hugging-added.png" alt="drawing" width="400"/>

OK not bad. But what we need are some attributes on our stack views.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/attributes.png" alt="drawing" width="600"/>

If we add those we get this

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/attributes-added.png" alt="drawing" width="400"/>

Now, if we want to add more label and text fields, and make it so everything is aligned, the trick is to make the widths of the various text fields the same. 

If we add more stack views, and don't make the text field widths the same we get this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-weight.png" alt="drawing" width="400"/>

When we add those, and apply these new constraints we get.

### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uistackview)
* [Apple Example](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1)


