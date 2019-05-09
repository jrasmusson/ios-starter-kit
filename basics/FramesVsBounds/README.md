# Frames vs Bounds

- **frame** = a view’s location and size using the **parent view’s coordinate system** (important for placing the view in the parent)

- **bounds** = a view’s location and size using **its own coordinate system** (important for placing the view’s content or subviews within itself)

Frame in iOS are like the frames of a picture on the wall. They are relative to the superview. And they don't really change.

Bounds is the coordinate systems within the frame itself. There is a distinction. Because while the frame rarely changes, the bounds inside the view doesn. This is who `UIScrollViews` work as well as animations.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-rounded.png"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-rounded.png"/>

