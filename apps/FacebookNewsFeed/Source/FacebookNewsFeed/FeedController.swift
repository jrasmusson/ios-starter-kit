//
//  ViewController.swift
//  FacebookNewsFeed
//
//  Created by Jonathan Rasmusson Work Pro on 2018-09-03.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize  {
        return CGSize(width: view.frame.width, height: 400)
    }
    
}

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Kevin Flynn", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nFebruary 10 • San Francisco ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        // check mark
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_icon")
        attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        return label
        
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Prepare to enter the grid."
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true // cut off extra pixels
        imageView.image = UIImage(named: "kevin-flynn-400x225")
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "488 Likes    10.7K Comments"
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    let likeButton = makeButton(title: "Like", imageName: "like")
    let commentButton = makeButton(title: "Comment", imageName: "comment")
    let shareButton = makeButton(title: "Share", imageName: "share")
    
    static func makeButton(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        
        return button
    }
    
    func setupViews() {
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)

        // profileImageView
        profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        // nameLabel
        nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
        // statusTextView
        statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4).isActive = true
        statusTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        statusTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        statusTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // statusImageView
        statusImageView.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 4).isActive = true
        statusImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        statusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        
        // likesCommentLabel
        likesCommentsLabel.topAnchor.constraint(equalTo: statusImageView.bottomAnchor, constant: 8).isActive = true
        likesCommentsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        likesCommentsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        
        // dividerLineView
        dividerLineView.topAnchor.constraint(equalTo: likesCommentsLabel.bottomAnchor, constant: 8).isActive = true
        dividerLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        // buttons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(likeButton)
        stackView.addArrangedSubview(commentButton)
        stackView.addArrangedSubview(shareButton)

        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: dividerLineView.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

        likeButton.widthAnchor.constraint(equalTo: commentButton.widthAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalTo: shareButton.widthAnchor).isActive = true
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}

