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

protocol CellRegistrator {
    func registerIfNeeded(cellClass: AnyClass, for cellId: String)
}

class Adapter: NSObject {
    weak var tableView: UITableView!
    private var sections: [Section] = []
    
    var rows: [RowProtocol] {
        return self.sections.compactMap({ $0.rows }).reduce([], +)
    }
    
    public var lastSectionIndex: Int {
        return self.sections.count > 0 ? self.sections.count - 1 : 0
    }
    
    public var lastElementIndexPath: IndexPath {
        return IndexPath(row: self.sections[self.lastSectionIndex].lastRowIndex, section: self.lastSectionIndex)
    }
    
    init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    private func item(at indexPath: IndexPath) -> TypeProtocol {
        return self.sections[indexPath.section].rows[indexPath.row].item
    }
    
    enum Update {
        case insertSections([Section], IndexSet)
        case updateSections([Section], IndexSet)
        case deleteSections(IndexSet)
        case insertRows([RowProtocol], [IndexPath])
        case updateRows([RowProtocol], [IndexPath])
        case deleteRows([Int], [Range<Int>])
    }
    
    public func handle(_ update: Update, with animation: UITableView.RowAnimation = .automatic) {
        self.tableView.beginUpdates()
        switch update {
        case .insertSections(let sections, let set):
            for i in set { self.sections.insert(sections[i], at: i) }
            self.tableView.insertSections(set, with: animation)
        case .updateSections(let sections, let set):
            for i in set { self.sections[i] = sections[i] }
            self.tableView.reloadSections(set, with: animation)
        case .deleteSections(let set):
            for i in set { self.sections.remove(at: i) }
            self.tableView.deleteSections(set, with: animation)
            
        case .insertRows(let rows, let indexPaths):
            for i in 0..<rows.count {
                self.sections[indexPaths[i].section].rows.insert(rows[i], at: indexPaths[i].row)
                self.registerIfNeeded(cellClass: rows[i].cellClass, for: rows[i].cellId)
            }
            self.tableView.insertRows(at: indexPaths, with: animation)
        case .updateRows(let rows, let indexPaths):
            for i in 0..<rows.count {
                self.sections[indexPaths[i].section].rows[i] = rows[i]
            }
            self.tableView.reloadRows(at: indexPaths, with: animation)
        case .deleteRows(let sectionIndexes, let rowsRanges):
            var indexPaths = [IndexPath]()
            for i in sectionIndexes {
                self.sections[i].rows.removeSubrange(rowsRanges[i])
                for j in rowsRanges[i] {
                    indexPaths.append(IndexPath(row: j, section: i))
                }
            }
            self.tableView.deleteRows(at: indexPaths, with: animation)
        }
        self.tableView.endUpdates()
    }    
}

extension Adapter: CellRegistrator {
    private var registeredCellIds: Set<String> {
        return Set(self.rows.compactMap({ $0.cellId }))
    }
    
    private func isRegistered(cellId: String) -> Bool {
        return self.registeredCellIds.contains(cellId)
    }
    
    public func registerIfNeeded(cellClass: AnyClass, for cellId: String) {
        if !isRegistered(cellId: cellId) {
            self.tableView.register(cellClass, forCellReuseIdentifier: cellId)
        }
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
