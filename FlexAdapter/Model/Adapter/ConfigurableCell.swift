//
//  ConfigurableCell.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype T
    static var reuseIdentifier: String { get }
    static var cellClass: Self.Type { get }
    func configure(with item: T)
}

extension ConfigurableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var cellClass: Self.Type {
        return self
    }
}
