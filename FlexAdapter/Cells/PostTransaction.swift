//
//  PostTransaction.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 12/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

final class PostTransactionCell: UITableViewCell {
    var item: PostTransaction?
    
    lazy var labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelSender: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelReceiver: UILabel = {
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
        self.contentView.addSubview(labelDate)
        self.contentView.addSubview(labelWeight)
        self.contentView.addSubview(labelSender)
        self.contentView.addSubview(labelReceiver)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            self.labelDate.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelDate.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelDate.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.labelDate.heightAnchor.constraint(equalToConstant: 22.0),
            
            self.labelWeight.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelWeight.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelWeight.topAnchor.constraint(equalTo: labelDate.bottomAnchor),
            self.labelWeight.heightAnchor.constraint(equalToConstant: 22.0),
            
            self.labelSender.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelSender.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelSender.topAnchor.constraint(equalTo: labelWeight.bottomAnchor),
            self.labelSender.heightAnchor.constraint(equalToConstant: 22.0),
            
            self.labelReceiver.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.labelReceiver.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.labelReceiver.topAnchor.constraint(equalTo: labelSender.bottomAnchor),
            self.labelReceiver.heightAnchor.constraint(equalToConstant: 22.0)
            ])
    }
}

extension PostTransactionCell: ConfigurableCell {
    func configure(with item: PostTransaction) {
        self.item = item
        self.labelDate.text = "\(item.date)"
        self.labelWeight.text = "\(item.weight) kg"
        self.labelSender.text = item.sender
        self.labelReceiver.text = item.receiver
    }
}
