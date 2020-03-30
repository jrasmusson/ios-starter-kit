# UIProgressView

Simple example of using a Timer to update a _UIProgressView_.

![Table](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIProgressView/images/progress.gif)

```swift
import UIKit

class ViewController: UIViewController {

    let progress = Progress(totalUnitCount: 50)

    let button: UIButton = {
        let button = makeButton(withText: "Fib")
        button.addTarget(self, action: #selector(buttonPressed), for: .primaryActionTriggered)
        return button
    }()

    let progressView: UIProgressView = {
        let progressView = makeProgressView()
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    func layout() {
        view.addSubview(button)
        view.addSubview(progressView)

        button.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        progressView.topAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 3).isActive = true
        progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }

    @objc
    func buttonPressed() {
        progressView.progress = 0

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in

            guard self.progress.isFinished == false else {
                timer.invalidate()
                return
            }

            self.progress.completedUnitCount += 1

            let fractionCompleted = Float(self.progress.fractionCompleted)
            self.progressView.setProgress(fractionCompleted, animated: true)
        }
    }

}

func makeProgressView() -> UIProgressView {
    let progressView = UIProgressView(progressViewStyle: .default)
    progressView.translatesAutoresizingMaskIntoConstraints = false
    progressView.tintColor = .gray

    return progressView
}
```


### Links that help

* [Apple Docs](https://developer.apple.com/documentation/uikit/uiprogressview)
