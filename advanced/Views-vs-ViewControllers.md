# Views vs ViewControllers

What's not always apparent when composing apps is whether you should make a view a `UIView` or a `UIViewController`.

Here is how you do it, and here are the pros and cons of both ways.

Use a `UIViewController` if

* you need/rely on life cycle events
* you need a lot of interaction with the view (in the way of events)
* and it needs to behave like a proper ViewController, treat is as such

Use a `UIView` if

* your view is dumb
* it basically displays information
* and it does little in the way of interations

## ViewController example

If you do embed a ViewController here be sure to 

* add the viewController as a child on the parent
* call `beginAppearanceTransition` on the child it's views are about to appear, and then
* `endAppearanceTransition` to tell the child it's view transition is complete

It should all look something like this

```swift
    func setupViews() {

        // how to add child ViewController
        statusViewController = StatusViewController()
        addChild(statusViewController) // important! else bad things happen (i.e. UIResponderChain events missed)
        statusViewController.beginAppearanceTransition(true, animated: false) 
        statusViewController.endAppearanceTransition()
```

You would want to do this if you are creating a viewController this is going to contain or facilitate the interaction of other view controllers. This is called a `containerViewController` and is a thing in iOS.

### Links that help

- [Container ViewControllers](https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/ImplementingaContainerViewController.html)



