//
//  TableCell.swift
//  TableFullExample
//
//  Created by Rasmusson, Jonathan on 2021-06-30.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        secondaryLabel.isHidden = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        secondaryLabel.isHidden = true
    }
}

extension TableCell {
    typealias RowType = ViewController.TableSection.RowType

    func configure(rowType: RowType) {
        fieldLabel.text = rowType.fieldLabel

        switch rowType {
        case .fromAccount(let fromAccount):
            primaryLabel.text = fromAccount.name
            if let emailAddress = fromAccount.emailAddress {
                secondaryLabel.text = emailAddress
                secondaryLabel.isHidden = false
            }
        case .depositAccount(let depositAccount):
            primaryLabel.text = depositAccount.name
            secondaryLabel.text = "(\(depositAccount.number))"
            secondaryLabel.isHidden = false
        case .receivedDate(let date):
            primaryLabel.text = "\(date)"
        }
    }
}
