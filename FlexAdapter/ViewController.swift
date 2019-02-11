//
//  ViewController.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var adapter: LoadingAdapter<TransactionsLoader> = {
        let adapter = LoadingAdapter(self.tableView, loader: TransactionsLoader.default, delegate: self)
        return adapter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.fetchMore().cauterize()
    }
}

extension ViewController: ProviderDelegate {
    func makeUpdates(items: [TypeProtocol]) -> [Adapter.Update] {
        var result = [Adapter.Update]()
        result.append(.insertSections([Section(), Section(), Section()], IndexSet(0..<3)))
        for i in 0..<items.count {
            if let bank = items[i] as? BankTransaction {
                let row = Row<BankTransaction, BankTransactionCell>(bank)
                result.append(.insertRows([row], [IndexPath(row: i, section: 0)]))
            }
            if let telecom = items[i] as? TelecomTransaction {
                let row = Row<TelecomTransaction, TelecomTransactionCell>(telecom)
                result.append(.insertRows([row], [IndexPath(row: i, section: 1)]))
            }
            if let post = items[i] as? PostTransaction {
                let row = Row<PostTransaction, PostTransactionCell>(post)
                result.append(.insertRows([row], [IndexPath(row: i, section: 2)]))
            }
        }
        return result
    }
}

