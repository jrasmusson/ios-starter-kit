# Core Animation

Core Animation is the graphics system that powers UIKit Views. It's fundamental class is the `CALayer`.

```swift
import QuartzCore

let newLayer = CALayer()
newLayer.frame = CGRectMake(0, 0, 100, 100)
newLayer.backgroundColor = UIColor.redColor().CGColor
newLayer.cornerRadius = 10
```

Everything you do in `UIView` is backed by a `CALayer`.

```swift
public class UIView {
   public var layer: CALayer { get }
}
```

While it provides the visual content, it is the `UIView` that provides the other things like layout, touch, and gesture recognizers.

## Deeply integated with UIView

`CALayer` and `UIView` are tightly integrated. Many times, when interacting with a UIView, you are actually affecting the CALayer.

```swift
public class UIView {
   public var frame: CGRect {
      get {
         return self.layer.frame
}
      set {
         self.layer.frame = newValue
      }
  }
}

let newLayer = CALayer()
view.layer.addSublayer(newLayer)
```

## Mapping Contents to CALayer

You can map a bitmap to a layer by access it's `.contents`.

```swift
let trySwiftLogo = self.trySwiftLogo() as UIImage

let trySwiftLayer = CALayer()
trySwiftLayer.contents = trySwiftLogo.CGImage
```

This is very similar to a `UIIMageView`.

## Masking CALayer Objects

Here is how you can take a layer and set it as the mask property of another layer.

```swift
let myLayer = CALayer()
myLayer.contents = self.makeRedCircleImage().CGImage

let myMask = CALayer()
myMask.contents = self.makeMaskImage().CGImage

myLayer.mask = myMask
```

This is the affect you can use for onboarding and tutorials.

## Adding Shadoes to CALayer

Whenever you are working with shadows in CA, you should always make sure to set the `.shadowPath` property. This will tell CA in advance what the shape of the shadow will be, reducing render time.

```swift
let myLayer = view.layer
 myLayer.shadowColor = UIColor.blackColor().CGColor
 myLayer.shadowOpacity = 0.75
 myLayer.shadowOffset = CGSizeMake(5, 10)
 myLayer.shadowRadius = 10

// IMPORTANT FOR PERFORMANCE
let myShadowPath = UIBezierPath(roundedRect:
                     view.bounds, cornerRadius: 10)

myLayer.shadowPath = myShadowPath.CGPath
```

### Links that help

- [Advanced Graphics with Core Animation - Tim Oliver](https://academy.realm.io/posts/tryswift-tim-oliver-advanced-graphics-with-core-animation/)

