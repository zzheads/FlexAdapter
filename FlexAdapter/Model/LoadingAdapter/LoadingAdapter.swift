//
//  LoadingAdapter.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit
import PromiseKit

class LoadingAdapter<Loader: LoaderProtocol>: Adapter, UITableViewDelegate where Loader.ItemType == TypeProtocol {
    var provider: Provider<Loader>!
    var isLoading: Bool = false {
        didSet {
            self.isLoading ? self.loadingIndicatorView.startAnimating() : self.loadingIndicatorView.stopAnimating()
        }
    }
    
    lazy var loadingIndicatorView: UIActivityIndicatorView = {
        let width: CGFloat = self.tableView.visibleCells.first?.bounds.width ?? self.tableView.bounds.width
        let height: CGFloat = 44
        let view = UIActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height)))
        view.style = .gray
        view.hidesWhenStopped = true
        view.isHidden = false
        return view
    }()
    
    init(_ tableView: UITableView, loader: Loader) {
        super.init(tableView)
        self.provider = Provider(adapter: self, loader: loader)
        self.tableView.delegate = self
        self.tableView.tableFooterView = self.loadingIndicatorView
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    public func fetchMore() -> Promise<[TypeProtocol]> {
        self.isLoading = true
        return Promise<[TypeProtocol]> { resolver in
            self.provider.fetch()
                .done { newItems in resolver.fulfill(newItems) }
                .catch { error in resolver.reject(error) }
                .finally { self.isLoading = false }
        }
    }
    
    // MARK: Delegate methods

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !self.isLoading && indexPath == self.lastElementIndexPath else {
            print("isLoading: \(isLoading), \(indexPath) != \(self.lastElementIndexPath)")
            return
        }
        self.fetchMore().cauterize()
    }
}


