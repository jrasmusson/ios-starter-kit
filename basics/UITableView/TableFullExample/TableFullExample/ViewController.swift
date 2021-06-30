//
//  ViewController.swift
//  TableFullExample
//
//  Created by Rasmusson, Jonathan on 2021-06-30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var sections: [TableSection] = []

    var transfer: Transfer? {
        didSet {
            setupTableHeader()
//            setupTableFooter()
//            populateTable()
            tableView.reloadData()
        }
    }

    override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Transaction Details"
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Load data now that we've displayed
        let message = "Thanks for the lawn maintenance."
        let transfer = Transfer(amount: "$100",
                                receivedDate: Date(),
                                fromAccount: AccountModel(name: "Kevin Flynn", number: "111111", emailAddress: "kevin@thegrid.com"),
                                depositAccount: AccountModel(name: "Sam Flynn", number: "222222", emailAddress: "sam@encom.com"),
                                message: message)

        self.transfer = transfer
    }
}

// MARK: - Setup
extension ViewController {

    private func setup() {
        tableView.dataSource = self
        tableView.rowHeight = 64
        tableView.backgroundColor = .white

//        tableView.register(ETransferDetailsReceivedTableCell.self)

        // Need to set to 0 because using grouped tableview style
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0

        setupTableHeader()
//        setupTableFooter()
//        fetchData()
    }

    private func setupTableHeader() {
        // Don't try to set up header if no details
        guard let details = transfer else { return }

        let header = TableHeaderView(frame: .zero)

        // Set frame size before populate view to have initial size
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        header.configure(with: details.amount)

        // Recalculate header size after populated with content
        size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size

        tableView.tableHeaderView = header
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: ETransferDetailsReceivedTableCell = tableView.dequeueResuableCell(for: indexPath)
//        let rowType = self.sections[indexPath.section].rows[indexPath.row]
//        cell.configure(rowType: rowType)
//        return cell
        return UITableViewCell()
    }
}

// MARK: - TableSection
extension ViewController {

    struct TableSection {

        enum RowType {
            case fromAccount(AccountModel)
            case depositAccount(AccountModel)
            case receivedDate(Date)

            var fieldLabel: String {
                switch self {
                case .fromAccount(_): return "From"
                case .depositAccount(_): return "Deposit account"
                case .receivedDate(_): return "Date received"
                }
            }
        }

        let title: String
        let rows: [RowType]
    }
}

struct Transfer {
    let amount: String
    let receivedDate: Date
    let fromAccount: AccountModel
    let depositAccount: AccountModel
    let message: String
}

struct AccountModel {
    let name: String
    let number: String
    let emailAddress: String?
}
