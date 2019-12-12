# Frames vs Bounds

- **frame** = a view’s location and size using the **parent view’s coordinate system** (important for placing the view in the parent)

- **bounds** = a view’s location and size using **its own coordinate system** (important for placing the view’s content or subviews within itself)

Frame in iOS are like the frames of a picture on the wall. They are relative to the superview. And they don't really change.

Bounds is the coordinate systems within the frame itself. There is a distinction. Because while the frame rarely changes, the bounds inside the view does. This is how `UIScrollViews` work as well as animations. They change their bounds but leave their frames.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/FramesVsBounds/images/frame1.png"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/FramesVsBounds/images/frame2.png"/>

