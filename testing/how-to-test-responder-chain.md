# How to test Responder Chain

## Create a Responder Capturer

```swift
import Foundation
import UIKit

/*
 This class inserts itself into the responder chain and records the action and sender
 of actions it receives as part of a test.
 */

class ResponderActionCapturer: UIViewController {

    public var capturedAction: Selector? = nil
    public var capturedSender: Any? = nil
    public var capturedUserInfo: Any? = nil

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        capturedAction = action
        capturedSender = sender

        return false
    }

    public func setOriginator(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    public func setOriginator(_ view: UIView) {
        let viewController = UIViewController()
        viewController.view = view
        setOriginator(viewController)
    }
}
```

## Fire a Responder Action within App

```swift
@objc protocol ResponderAction: AnyObject {
    func didSelectRowAt(_ sender: GameTableViewController)
}

UIApplication.shared.sendAction(#selector(ResponderAction.didSelectRowAt(_:)), to: nil, from: self, for: nil)
```

## Capture in a unit test

```swift
func testExample() {
    let indexPath = IndexPath(item: 0, section: 0)
    viewController.gameTableViewController.performDidSelectRow(at: indexPath)

    XCTAssertEqual(capturer.capturedAction, #selector(ResponderAction.didSelectRowAt(_:)))
}
```

# Full Source

**ViewController.swift**

```swift
import UIKit
import Foundation

class ViewController: UIViewController {

    let cellId = "cellId"
    var tableView = UITableView()

    var gameView = GameView()
    var gameTableViewController = GameTableViewController(gameService: GameService())

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        gameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameView)

        // x3 things
        view.addSubview(gameTableViewController.view)
        addChild(gameTableViewController)
        gameTableViewController.didMove(toParent: self)

        guard let gameTableView = gameTableViewController.view else { return }
        gameTableView.translatesAutoresizingMaskIntoConstraints = false

        gameView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        gameView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: gameView.trailingAnchor, multiplier: 3).isActive = true

        gameTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        gameTableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: gameTableView.trailingAnchor, multiplier: 1).isActive = true
        view.bottomAnchor.constraint(equalToSystemSpacingBelow: gameTableView.bottomAnchor, multiplier: 1).isActive = true
    }
}

extension ViewController: ResponderAction {
    func didSelectRowAt(_ sender: GameTableViewController) {
        guard let indexPath = sender.selectedIndexPath else { return }

        let game = sender.games[indexPath.row]

        gameView.alpha = 0

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
            self.gameView.game = game
            self.gameView.alpha = 1
        })
    }
}
```

**GameView.swift**

```swift
import UIKit

class GameView: UIView {

    var game: Game? {
        didSet {
            guard let game = game else { return }
            profileImage.image = UIImage(named: game.imageName)
            titleLabel.text = game.name
            bodyLabel.text = game.description
        }
    }

    lazy var profileImage: UIImageView = {
        return makeProfileImageView(withName: "space-invaders")
    }()

    lazy var titleLabel: UILabel = {
        return makeTitleLabel(withTitle: "Space Invaders")
    }()

    lazy var bodyLabel: UILabel = {
        return makeLabel(withTitle: "Space Invaders is a Japanese shooting video game released in 1978 by Taito. It was developed by Tomohiro Nishikado, who was inspired by other media: Breakout, The War of the Worlds, and Star Wars.")
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        let stackView = makeVerticalStackView()

        addSubview(stackView)

        stackView.addArrangedSubview(profileImage)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(bodyLabel)

        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0).isActive = true
        stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0).isActive = true
        trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0).isActive = true
        bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 0).isActive = true
    }

}
```

**GameTableViewController.swift**

```swift
import UIKit

class GameTableViewController: UIViewController {

    let cellId = "cellId"
    let gameService: GameService

    var tableView = UITableView()
    var games = [Game]()
    var selectedIndexPath: IndexPath?

    init(gameService: GameService) {
        self.gameService = gameService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }

    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }

    func loadData() {
        GameService().fetchGames { [weak self] result in
            switch result {
            case .success(let games):
                self?.games = games
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    override func loadView() {
        view = tableView
    }
}

extension GameTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performDidSelectRow(at: indexPath)
    }

    func performDidSelectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
        UIApplication.shared.sendAction(#selector(ResponderAction.didSelectRowAt(_:)), to: nil, from: self, for: nil)
    }
}

extension GameTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

@objc protocol ResponderAction: AnyObject {
    func didSelectRowAt(_ sender: GameTableViewController)
}
```

**GameService**

```swift
import Foundation

struct Game {
    let name: String
    let description: String
    let imageName: String
}

class GameService {

    func fetchGames(completion: @escaping ((Result<[Game], Error>) -> Void)) {
        let games = [Game(name: "Space Invaders", description: "Space Invaders is a Japanese shooting video game released in 1978 by Taito. It was developed by Tomohiro Nishikado, who was inspired by other media: Breakout, The War of the Worlds, and Star Wars.", imageName: "space-invaders"),
                     Game(name: "Discs of Tron", description: "Discs of Tron, is the second arcade game based on the Disney film Tron. While the first Tron arcade game had several mini-games based on scenes in the movie, Discs of Tron is a single game inspired by Tron's disc-battle sequences and set in an arena similar to the one in the Jai Alai–style sequence. ", imageName: "tron"),
                     Game(name: "Frogger", description: "Frogger is a 1981 arcade game developed by Konami and originally published by Sega. In North America, it was published jointly by Sega and Gremlin Industries. The object of the game is to direct frogs to their homes one by one by crossing a busy road and navigating a river full of hazards.", imageName: "frogger"),
                     Game(name: "Joust", description: "Joust is an arcade game developed by Williams Electronics and released in 1982. It popularized the concept of two-player cooperative gameplay by being more successful at it than its predecessors. The player uses a button and joystick to control a knight riding a flying ostrich.", imageName: "joust")
                    ]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(Result.success(games))
        }
    }
}
```

**Factories**

```swift
import UIKit

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

func makeTitleLabel(withTitle title: String) -> UILabel {
    let label = makeLabel(withTitle: title)
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    return label
}

func makeLabel(withTitle title: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = title
    label.textAlignment = .center
    label.textColor = .black
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true

    return label
}

func makeVerticalStackView() -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8.0

    return stack
}

func makeProfileImageView(withName name: String) -> UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: name)
    imageView.layer.cornerRadius = 34
    imageView.layer.masksToBounds = true

    return imageView
}
```