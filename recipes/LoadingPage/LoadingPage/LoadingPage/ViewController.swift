//
//  ViewController.swift
//  LoadingPage
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-08-30.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loadingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingImageView = UIImageView(image: SharedImage.largeGreyAnimatedDots)
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingImageView)

        NSLayoutConstraint.activate([
            loadingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: 70.0),
            loadingImageView.heightAnchor.constraint(equalToConstant: 18.0),
            ])
    }

    @IBAction func showLoadingIndicator(_ sender: Any) {
        loadingImageView.isHidden = false
    }

    @IBAction func hideLoadingIndicator(_ sender: Any) {
        loadingImageView.isHidden = true
    }

}

public struct SharedImage {

    public static var largeGreyAnimatedDots: UIImage? {
        let animation = [
            UIImage.inFramework(named: "loading_dots_large_grey1")!,
            UIImage.inFramework(named: "loading_dots_large_grey2")!,
            UIImage.inFramework(named: "loading_dots_large_grey3")!,
            UIImage.inFramework(named: "loading_dots_large_grey4")!,
            UIImage.inFramework(named: "loading_dots_large_grey5")!,
            UIImage.inFramework(named: "loading_dots_large_grey6")!,
            UIImage.inFramework(named: "loading_dots_large_grey7")!,
            UIImage.inFramework(named: "loading_dots_large_grey8")!,
            UIImage.inFramework(named: "loading_dots_large_grey9")!,
            UIImage.inFramework(named: "loading_dots_large_grey10")!,
            UIImage.inFramework(named: "loading_dots_large_grey11")!,
            UIImage.inFramework(named: "loading_dots_large_grey12")!,
            ]
        return UIImage.animatedImage(with: animation, duration: 1.0)
    }

}
private extension UIImage {
    static func inFramework(named name: String, compatibleWith traits: UITraitCollection? = nil) -> UIImage? {
        return UIImage(named: name, in: Bundle(identifier: "com.rsc.LoadingPage"), compatibleWith: traits)
    }
}


