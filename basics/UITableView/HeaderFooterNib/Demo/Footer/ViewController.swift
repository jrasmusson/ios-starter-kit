//
//  ViewController.swift
//  Footer
//
//  Created by jrasmusson on 2021-08-28.
//

import UIKit

// Data Model
enum TransactionType: String {
    case pending = "Pending"
    case posted = "Posted"
}

struct Transaction {
    let firstName: String
    let lastName: String
    let amount: String
    let type: TransactionType
}

struct TransactionSection {
    let title: String
    let transactions: [Transaction]
}

struct TransactionViewModel {
    let sections: [TransactionSection]
}

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let cellId = "cellId"
    var viewModel: TransactionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}

// MARK: - Setup
extension ViewController {
    func setup() {
        setupTableView()
        setupTableViewHeader()
        setupTableViewFooter()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView() // hide empty rows
        
        tableView.register(PendingCell.self) // using ReusableView extensions
        tableView.register(PostedCell.self)
    }
    
    private func setupTableViewHeader() {
        let header = HeaderView(frame: .zero)
        
        // Set frame size before populate view to have initial size
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        // Recalculate header size after populated with content
        size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
    private func setupTableViewFooter() {
        let footer = FooterView(frame: .zero)
        
        // Set frame size before populate view to have initial size
        var size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        footer.frame.size = size
        
        // Recalculate header size after populated with content
        size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        footer.frame.size = size
        
        tableView.tableFooterView = footer
    }
}

// MARK: - Networking
extension ViewController {
    private func fetchData() {
        let tx1 = Transaction(firstName: "Kevin", lastName: "Flynn", amount: "$100", type: .pending)
        let tx2 = Transaction(firstName: "Allan", lastName: "Bradley", amount: "$200", type: .pending)
        let tx3 = Transaction(firstName: "Ed", lastName: "Dillinger", amount: "$300", type: .pending)

        let tx4 = Transaction(firstName: "Sam", lastName: "Flynn", amount: "$400", type: .posted)
        let tx5 = Transaction(firstName: "Quorra", lastName: "Iso", amount: "$500", type: .posted)
        let tx6 = Transaction(firstName: "Castor", lastName: "Barkeep", amount: "$600", type: .posted)
        let tx7 = Transaction(firstName: "CLU", lastName: "MCU", amount: "$700", type: .posted)
        
        let section1 = TransactionSection(title: "Pending transfers", transactions: [tx1, tx2])
        let section2 = TransactionSection(title: "Posted transfers", transactions: [tx4, tx5])

        viewModel = TransactionViewModel(sections: [section1, section2])
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel else { return UITableViewCell() }

        let section = indexPath.section
        let transaction = vm.sections[section].transactions[indexPath.row]
        let fullName = "\(transaction.firstName) \(transaction.lastName)"
        let amount = transaction.amount

        switch transaction.type {
        case .pending:
            let cell: PendingCell = tableView.dequeueResuableCell(for: indexPath)
            cell.nameLabel.text = fullName
            cell.amountLabel.text = amount
            
            return cell
        case .posted:
            let cell: PostedCell = tableView.dequeueResuableCell(for: indexPath)
            cell.nameLabel.text = fullName
            cell.amountLabel.text = amount
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.sections[section].transactions.count
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = SectionFooterView()
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = viewModel?.sections else { return 0 }
        return sections.count
    }
}

