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
        let adapter = LoadingAdapter(self.tableView, loader: TransactionsLoader.default)
        return adapter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.fetchMore().cauterize()
    }
}
