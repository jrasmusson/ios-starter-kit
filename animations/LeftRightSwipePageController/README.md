# Left / Right Swipe PageController

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/LeftRightSwipePageController/images/demo.gif)

This examples does left right swiping using `UIPageViewController`.

Advantage of this method is we get animations, gestures, and transitions for free.

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

```swift
import UIKit

class SpotifyTabBarController: UIViewController {

    private var _selectedIndex = 0

    private let viewControllers: [UIViewController]
    private let container = PageViewController()

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
        guard let currentViewController = container.viewControllers?.first else { return }
        guard let nextViewController = container.dataSource?.pageViewController(container, viewControllerAfter: currentViewController) else { return }
        container.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }

    @objc func button2Pressed() {
        guard let currentViewController = container.viewControllers?.first else { return }
        guard let previousViewController = container.dataSource?.pageViewController(container, viewControllerBefore: currentViewController) else { return }
        container.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
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

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        let initialPage = 0
        let page1 = ViewController1()
        let page2 = ViewController2()

        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController) else { return nil }

        return index == 0 ? nil : pages[index - 1] // do nothing if first page, else page left
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let index = pages.firstIndex(of: viewController) else { return nil }

        if index < pages.count - 1 {
            return pages[index + 1] // page right
        }

        return nil // don't wrap
    }
}
```

### Links that help

- [Turn pages programatically](https://stackoverflow.com/questions/30489920/ios-swift-uipageviewcontroller-turning-page-programmatically/37893961)
