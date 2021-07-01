//
//  TableFooterView.swift
//  TableFullExample
//
//  Created by Rasmusson, Jonathan on 2021-06-30.
//

import UIKit

class TableFooterView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var messageLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 80)
    }

    private func commonInit() {
        let bundle = Bundle(for: TableFooterView.self)
        bundle.loadNibNamed("TableFooterView", owner: self, options: nil)
        addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        contentView.backgroundColor = .systemGray5
    }

    func configure(with details: Transfer) {
        messageLabel.text = details.message
        messageLabel.layoutIfNeeded()
    }
}
