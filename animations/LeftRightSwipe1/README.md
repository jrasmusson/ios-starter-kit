# Left / Right Swipe Animation

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/LeftRightSwipe1/images/demo.gif)

This example shows how to swipe left/right on button presses using `UIViewController` `add/remove` functionality. Core of demo is how viewControllers are added and removed.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/LeftRightSwipe1/images/demo.png" alt="drawing" width="400"/>

```swift
    @objc func button1Pressed() {
        if container.children.first == viewControllers[0] { return }

        // 1. Add
        container.add(viewControllers[0])

        // 2. Animate
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) {success in
            // 3. Remove
            self.viewControllers[1].remove()
        }
    }
```

We basically look for button presses in our tabBar viewController, and then add > animate > remove viewControllers appropriately.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/LeftRightSwipe1/images/reveal.png" alt="drawing" width="400"/>

## Full Source

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        view.backgroundColor = .white

        let firstViewController = ViewController1()
        let secondViewController = ViewController2()

        firstViewController.title = "Playlists"
        secondViewController.title = "Podcasts"
        
        let viewControllers = [firstViewController, secondViewController]

        let spotifyTabBar = SpotifyTabBarController(viewControllers: viewControllers)

        // Note: No autolayout required
        add(spotifyTabBar)
        
        spotifyTabBar.selectedIndex = 0
    }
}

class ViewController1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}
```

```swift
import UIKit

class SpotifyTabBarController: UIViewController {

    private var _selectedIndex = 0

    private let viewControllers: [UIViewController]
    private let container = SpotifyTabBarContainer()

    var selectedIndex: Int {
        get {
            return _selectedIndex
        }
        set {
            _selectedIndex = newValue
            if newValue == 0 {
                button1Pressed()
            } else {
                button2Pressed()
            }
        }
    }

    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .yellow

        // buttons
        let button1 = makeButton(title: viewControllers[0].title ?? "Default1")
        button1.addTarget(self, action: #selector(button1Pressed), for: .touchUpInside)

        view.addSubview(button1)

        button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 44).isActive = true

        let button2 = makeButton(title: viewControllers[1].title ?? "Default2")
        button2.addTarget(self, action: #selector(button2Pressed), for: .touchUpInside)

        view.addSubview(button2)

        button2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 8).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // container
        guard let containerView = container.view else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(containerView)

        containerView.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func button1Pressed() {
        if container.children.first == viewControllers[0] { return }

        // 1. Add
        container.add(viewControllers[0])

        // 2. Animate
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) {success in
            // 3. Remove
            self.viewControllers[1].remove()
        }
    }

    @objc func button2Pressed() {
        if container.children.first == viewControllers[1] { return }

        container.add(viewControllers[1])

        animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1]) {success in
            self.viewControllers[0].remove()
        }
    }

    func animateTransition(fromVC: UIViewController, toVC: UIViewController, completion: @escaping ((Bool) -> Void)) {
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                return
        }

        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        UIView.animate(withDuration: 0.5, animations: {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        }, completion: {success in
            completion(success)
        })
    }

    func getIndex(forViewController vc: UIViewController) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }

}

// MARK: - Factories

extension SpotifyTabBarController {

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)

        return button
    }

}
```

```swift
import UIKit

class SpotifyTabBarContainer: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

}
```

```swift
import UIKit

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
```

### Links that help
* [Sundell Container View](https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/)
