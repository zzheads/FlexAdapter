//
//  Provider.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit
import PromiseKit

protocol ProviderDelegate {
    func makeUpdates(items: [TypeProtocol]) -> [Adapter.Update]
}

class Provider<Loader: LoaderProtocol> where Loader.ItemType == TypeProtocol {
    enum RequestResult {
        case success(Int)
        case failure(Int, Int, Error)
        
        var receivedItems: Int {
            switch self {
            case .success(let count)    : return count
            case .failure(_)            : return 0
            }
        }
    }
    
    let loader: Loader
    let delegate: ProviderDelegate
    weak var adapter: LoadingAdapter<Loader>!
    var pageSize: Int
    var log: [RequestResult] = []
    var receivedItems: Int {
        return self.log.compactMap({ $0.receivedItems }).reduce(0, +)
    }
    
    init(adapter: LoadingAdapter<Loader>, loader: Loader, delegate: ProviderDelegate, pageSize: Int = 5) {
        self.adapter = adapter
        self.loader = loader
        self.delegate = delegate
        self.pageSize = pageSize
    }

    func fetch(offset: Int? = nil, count: Int? = nil) -> Promise<[Adapter.Update]> {
        return Promise<[Adapter.Update]> { resolver in
            self.loader.fetch(offset: offset ?? self.receivedItems, count: count ?? self.pageSize)
                .done { newItems in
                    let updates = self.delegate.makeUpdates(items: newItems)
                    for update in updates {
                        self.adapter.handle(update)
                    }
                    resolver.fulfill(updates)
                }
                .catch { error in resolver.reject(error) }
        }
    }
}
