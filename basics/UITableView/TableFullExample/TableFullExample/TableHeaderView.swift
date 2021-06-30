//
//  TableHeaderView.swift
//  TableFullExample
//
//  Created by Rasmusson, Jonathan on 2021-06-30.
//

import UIKit

class TableHeaderView: UIView {

    @IBOutlet var contentView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 40)
    }

    private func commonInit() {
        let bundle = Bundle(for: TableHeaderView.self)
        bundle.loadNibNamed("TableHeaderView", owner: self, options: nil)
        addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        setup()
    }

    private func setup() {
        titleLabel.text = "Header View"
        contentView.backgroundColor = .systemRed
    }

    func configure(with amount: String) {
        amountLabel.text = amount
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct TableHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let headerView = TableHeaderView()
                headerView.configure(with: "$100")
                return headerView
            }
        }.previewLayout(.sizeThatFits)
        .padding(10)
    }
}
#endif
