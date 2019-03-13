# How to add corner and shadow

```swift
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        view.addShadow()

        buildSubviews()
    }
    
    public extension UIView {
    
    @objc public func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.40
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 2
        layer.masksToBounds = false
    }
    
    @objc public func removeShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
    }
```

