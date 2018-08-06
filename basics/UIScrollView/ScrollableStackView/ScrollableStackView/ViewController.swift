//
//  ViewController.swift
//  ScrollableStackView
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-04.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Scroll view, vertical
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        // 2. Content is a stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fill
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // Attaching the content's edges to the scroll view's edges
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Satisfying size constraints
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])
        
        // Add arranged subviews:
        for i in 0...20 {
            // A simple green view.
            let greenView = UIView()
            greenView.backgroundColor = .green
            stackView.addArrangedSubview(greenView)
            greenView.translatesAutoresizingMaskIntoConstraints = false
            // Doesn't have intrinsic content size, so we have to provide the height at least
            greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            
            // Label (has instrinsic content size)
            let label = UILabel()
            label.backgroundColor = .orange
            label.text = "I'm label \(i)."
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
        }
    }

}

