//
//  Section.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

class Section {
    var rows: [RowProtocol] = []
    
    public var lastRowIndex: Int {
        return self.rows.count > 0 ? self.rows.count - 1 : 0
    }
}