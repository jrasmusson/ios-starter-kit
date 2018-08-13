//
//  ViewController.swift
//  ChainedAnimations
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-08-13.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!

    fileprivate func setUpLabels() {
        titleLabel.text = "Welcome"
        titleLabel.numberOfLines = 0
    }

    fileprivate func setUpStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8

        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Center stackView
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // Constrain width with padding (50pt each side)
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLabels()
        setUpStackView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
    }

    @objc fileprivate func handleTapAnimations() {

        // Chain the animations
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            // Slide to the left
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)

        }) { (_) in

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                // Fade the label
                self.titleLabel.alpha = 0

                // Slide up to top
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
            })

        }
    }
}

