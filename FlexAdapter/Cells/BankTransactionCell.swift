//
//  BankTransactionCell.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

final class BankTransactionCell: UITableViewCell {
    var item: BankTransaction?
    
    lazy var labelId: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelAmount: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelComment: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(labelId)
        self.contentView.addSubview(labelDate)
        self.contentView.addSubview(labelAmount)
        self.contentView.addSubview(labelComment)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            self.labelId.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelId.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelId.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.labelId.heightAnchor.constraint(equalToConstant: 22.0),

            self.labelDate.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelDate.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelDate.topAnchor.constraint(equalTo: labelId.bottomAnchor),
            self.labelDate.heightAnchor.constraint(equalToConstant: 22.0),

            self.labelAmount.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelAmount.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelAmount.topAnchor.constraint(equalTo: labelDate.bottomAnchor),
            self.labelAmount.heightAnchor.constraint(equalToConstant: 22.0),
            
            self.labelComment.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelComment.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelComment.topAnchor.constraint(equalTo: labelAmount.bottomAnchor),
            self.labelComment.heightAnchor.constraint(equalToConstant: 22.0)
            ])
    }
}

extension BankTransactionCell: ConfigurableCell {
    func configure(with item: BankTransaction) {
        self.item = item
        self.labelId.text = item.id
        self.labelDate.text = "\(item.date)"
        self.labelAmount.text = "$ \(item.amount)"
        self.labelComment.text = item.comment
    }
}
