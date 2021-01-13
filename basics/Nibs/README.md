# Working with Nibs

## Loading Nib into View Controller

Simplest thing you can do is create a nib and then associated it with a View Controller.

- Create the nib (same name as view controller).
- Set it's File's Owner to the `ViewController`.
- Point the File's Owner `view` to the nib view

![](images/a.png)

![](images/b.png)

![](images/c.png)

![](images/d.png)


## Making a Nib IBDesignable

You can make a Nib appear in Interface Builder (IB) with designable attributes by doing the following.
Create your new nib

- Create nib (i.e. `RedView.xib`).
- Create nib view (i.e. `RedView.swift`).
- Associate nib with view.

Then add it to your parent nib as a view by:

- Adding a plain `View` control to the parent
- Associate the plan `View` to your newly create nib view 

### Create your new nib

Create a plain old nib.

![](images/aa.png)

Create the view backing the nib. Make it `IBDesignable` and give it an intrinsic content size to simplify Auto Layout constraints.

![](images/bb.png)

```swift
import UIKit

@IBDesignable
class RedView: UIView {
    
    @IBInspectable var myColor: UIColor = .systemRed
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = myColor
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
```


Associate the view with the nib.

![](images/cc.png)

Your nib is now good to go.

### Add it your your parent

To add your newly created nib to your parent, drag out a plain old `View` onto your parent nib canvas. Give it some constraints (but don't worry about size).

![](images/dd.png)

Then associate this view with the newly created nib view created above.

![](images/ee.png)

This will automatically detect that it is `@IBDesignable`, use it's intrinsic content size, and layout it out.

![](images/ee.png)

![](images/ff.png)


## How to load a nib programmatically

When you want to compose nibs into other nibs, you need to load them manually. Going through the same steps we went through before to create a `RedView`, let's create a `InnerView` and add it programmatically to the `RedView`.

Create a `InnerView.xib` and hook it up to it's `InnerView.swift`.

![](images/gg.png)

Then modify `RedView.swift` to load the `InnerView.xib` manually and lay it out using Auto Layout.

**RedView.swift**

```swift
import UIKit

@IBDesignable
class RedView: UIView {
    
    @IBInspectable var myColor: UIColor = .systemRed
    
    var innerView: InnerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = myColor
        
        innerView = Bundle(for: InnerView.self).loadNibNamed("\(InnerView.self)", owner: self)![0] as? InnerView
        
        translatesAutoresizingMaskIntoConstraints = false
        innerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.widthAnchor.constraint(equalTo: widthAnchor),
            innerView.topAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 2),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
}
```

Now we have a nib within a nib loaded and laid out programmatically.

![](images/hh.png)

## Apple Documentation notes

Xibs

- designed for working with Views
- is an object graph 
- containing views and relationships

File's Owner

- this is a placeholder that you set when you load your nib
- it is the controller for the nib and it receives all the events
- typically you use outlets in the File's Owner to reference objects in the nib

Each View Controllers Manages its Own Nib File

- UIViewController support the automatically loading of their own associated nib file

Loading Nib Files Programmatically

- NSBundle supports loading of nib files
- loadNibNamed:owner:options: instance method


### Links that help
* [Apple Docs Nib Files](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html)
