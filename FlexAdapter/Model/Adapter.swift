//
//  Adapter.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

protocol TypeProtocol {
    
}

class Adapter: NSObject {
    var tableView: UITableView
    var sections: [Section] = []
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    func item(at indexPath: IndexPath) -> TypeProtocol {
        return self.sections[indexPath.section].rows[indexPath.row].item
    }
}

extension Adapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.cellId, for: indexPath)
        row.configure(cell: cell)
        return cell
    }
}
