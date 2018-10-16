# UICollectionViewCell

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UICollectionViewCell/images/cell.png" alt="drawing" width="400"/>

```swift
//
//  UserCell.swift
//  Twitter
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-10-11.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "profile_image")

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true

        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Brian Voong"
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@buildthatapp"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray

        return label
    }()

    let bioTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS Apps"
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.backgroundColor = .clear
        
        return textView
    }()

    let followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true

        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit // 1:1 ratio
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)

        return button
    }()

    let separatorLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray

        return view
    }()

    var user: User? {

        didSet {
            guard let user = user else { return }

            nameLabel.text = user.name
            usernameLabel.text = user.username
            bioTextView.text = user.bioText
            profileImageView.image = user.profileImage
        }

    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {

        backgroundColor = .white

        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(bioTextView)
        addSubview(followButton)
        addSubview(separatorLineView)

        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: followButton.leadingAnchor, constant: -8).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bioTextView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0).isActive = true
        bioTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 4).isActive = true
        bioTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        bioTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // for this guy set top, trailing, height and width, and then adjust others to clamp onto him (note the negative signs for spacing above)
        followButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        followButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        followButton.widthAnchor.constraint(equalToConstant: 120).isActive = true

        separatorLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

}

```

## Links that help

- [BuildTheApp Twitter NavBar](https://www.youtube.com/watch?v=zS-CCd4xmRY&list=PL0dzCUj1L5JE1wErjzEyVqlvx92VN3DL5&index=7)


