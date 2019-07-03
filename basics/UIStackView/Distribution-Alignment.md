# Distribution & Alignment

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/distribution.png" alt="drawing" width="800"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/alignment.png" alt="drawing" width="800"/>

## Distribution

### Fill

* Fills all spaces 
* Default setting
* Uses intrinsic size, but is controlled via CHCR (hugging/compressing)
* Determines which control to stretch by noting which has lowest Content Hugging Priority (CHP)
* If all controls have same CHP, then Xcode will complain layout is ambiguous

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill.png" alt="drawing" width="400"/>

### Fill Equally

* Makes all controls the same size
* Only distribution NOT to use instrinsic size

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill-equally.png" alt="drawing" width="400"/>

### Fill Proportionally

* maintains same proportion as layout shrinks and grows
* Unlike previous two, needs intrinsic size
* Fill and Fill Equally tell controls how big they should be
* This one is opposite - controls say how big they should be - this just maintains proportions

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/fill-proportionally.png" alt="drawing" width="400"/>

### Equal Spacing

* Uses intrinsic size
* Maintains equal space between each control
* If ambiguity stack shrinks based on index in `arrangedSubviwes` array

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/equal-spacing.png" alt="drawing" width="400"/>

### Equal Centering

* Equally spaces the center of controls

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/equal-centering.png" alt="drawing" width="400"/>

Those are the distribution options using `UIStackView`. Fill and Fill Equally are optionated about controlling size of children. Others respect intrinsic size and try to space in different ways.

## Alignment


## Example Fill

This is an example of a fill distribution where normally the two controls we be evenly spaced. But because we want the Internet label to expand we drop its hugging power to 48 so that it will stretch, and then up the hugging power of the text label to 1000. Normally 251 would be OK. But for some reason 1000 is required here making it a required priority constraint.

```swift
//
//  LabelInAnExpandedStackView.swift
//  StackViewFun2
//
//  Created by Jonathan Rasmusson Work Pro on 2019-02-23.
//  Copyright © 2019 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let item1 = makeLabel(title: "Internet", color: .red)       // hug = 48 => stretch
        let item2 = makeTextField(title: "Ready", color: .green)    // hug = 251

        let stackView = makeStackView()

        stackView.addArrangedSubview(item1)
        stackView.addArrangedSubview(item2)

        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }

    func makeLabel(title: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = color
        
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)

        return label
    }

    func makeTextField(title: String, color: UIColor) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = title
        textField.backgroundColor = color

        // default IB
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal) // important!
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
        
        return textField
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        
        return stackView
    }

}

```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/example-fill.png" alt="drawing" width="400"/>

### Links that help

* [Apple docs distribution](https://developer.apple.com/documentation/uikit/uistackview/distribution)
* [Apple docs alignment](https://developer.apple.com/documentation/uikit/uistackview/alignment)
* [Visual example where images came from](https://spin.atomicobject.com/2016/06/22/uistackview-distribution/)
* [NSHipster](https://nshipster.com/uistackview/)
