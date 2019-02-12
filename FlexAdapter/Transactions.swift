//
//  Dog.swift
//  FlexAdapter
//
//  Created by Алексей Папин on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import PromiseKit
import UIKit

protocol Transaction: TypeProtocol {
    var transactionType: String { get }
}

class BankTransaction: Codable, Transaction {
    var sectionId: String {
        return "\(date)"
    }
    
    var rowId: String {
        return "\(id)"
    }
    
    var row: RowProtocol {
        return Row<BankTransaction, BankTransactionCell>(self)
    }
    
    let id: String
    let date: Date
    let amount: Double
    let comment: String
    
    
    init(id: String, date: Date, amount: Double, comment: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.comment = comment
    }
    
    var transactionType: String {
        return "bank"
    }
}

class TelecomTransaction: Codable, Transaction {
    var sectionId: String {
        return "\(self.date)"
    }
    
    var rowId: String {
        return "\(self.type)"
    }

    var row: RowProtocol {
        return Row<TelecomTransaction, TelecomTransactionCell>(self)
    }
    
    let id: String
    let operatorName: String
    let date: Date
    let amount: Double
    let type: String

    init(id: String, operatorName: String, date: Date, amount: Double, type: String) {
        self.id = id
        self.operatorName = operatorName
        self.date = date
        self.amount = amount
        self.type = type
    }
    
    var transactionType: String {
        return "telecom"
    }
}

class PostTransaction: Codable, Transaction {
    var sectionId: String {
        return "\(date)"
    }
    
    var rowId: String {
        return "\(sender)"
    }
    
    var row: RowProtocol {
        return Row<PostTransaction, PostTransactionCell>(self)
    }
    
    let date: Date
    let weight: Double
    let sender: String
    let receiver: String
    
    init(date: Date, weight: Double, sender: String, receiver: String) {
        self.date = date
        self.weight = weight
        self.sender = sender
        self.receiver = receiver
    }
    
    var transactionType: String {
        return "post"
    }
}

class TransactionsLoader: LoaderProtocol {
    static let `default` = TransactionsLoader()
    
    static let payload: [TypeProtocol] =
        [
            BankTransaction(id: "1001", date: Date(timeIntervalSince1970: 2000), amount: 2000, comment: "Banks debet"),
            BankTransaction(id: "1002", date: Date(timeIntervalSince1970: 2100), amount: 1000, comment: "Banks debet"),
            BankTransaction(id: "1003", date: Date(timeIntervalSince1970: 2500), amount: 5000, comment: "Banks kredit"),
            BankTransaction(id: "1004", date: Date(timeIntervalSince1970: 3000), amount: 600, comment: "Banks service"),
            BankTransaction(id: "1005", date: Date(timeIntervalSince1970: 3500), amount: 2000, comment: "Fullfill account"),
            BankTransaction(id: "1006", date: Date(timeIntervalSince1970: 4000), amount: 3300, comment: "Banks debet"),
            BankTransaction(id: "1007", date: Date(timeIntervalSince1970: 4500), amount: 2300, comment: "Banks debet"),
            BankTransaction(id: "1008", date: Date(timeIntervalSince1970: 5000), amount: 900, comment: "Banks debet"),
            TelecomTransaction(id: "302-12", operatorName: "Megafon", date: Date(timeIntervalSince1970: 3000), amount: 300, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "302-13", operatorName: "Megafon", date: Date(timeIntervalSince1970: 4000), amount: 1300, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "302-14", operatorName: "Beeline", date: Date(timeIntervalSince1970: 5000), amount: 1500, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "302-15", operatorName: "Megafon", date: Date(timeIntervalSince1970: 3100), amount: 3300, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "303-01", operatorName: "MTS", date: Date(timeIntervalSince1970: 3200), amount: 3000, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-01", operatorName: "Megafon", date: Date(timeIntervalSince1970: 3300), amount: 1300, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "502-99", operatorName: "Yota", date: Date(timeIntervalSince1970: 3400), amount: 700, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "504-76", operatorName: "Beeline", date: Date(timeIntervalSince1970: 3500), amount: 1700, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-12", operatorName: "Yota", date: Date(timeIntervalSince1970: 3600), amount: 800, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-62", operatorName: "Megafon", date: Date(timeIntervalSince1970: 3600), amount: 500, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-72", operatorName: "MTS", date: Date(timeIntervalSince1970: 3600), amount: 100, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-82", operatorName: "Yota", date: Date(timeIntervalSince1970: 3600), amount: 10000, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "304-92", operatorName: "Beeline", date: Date(timeIntervalSince1970: 3700), amount: 300, type: "MONTHLY_PAYMENT"),
            TelecomTransaction(id: "306-12", operatorName: "Megafon", date: Date(timeIntervalSince1970: 3700), amount: 300, type: "MONTHLY_PAYMENT"),
            PostTransaction(date: Date(timeIntervalSince1970: 4000), weight: 12.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 4500), weight: 9.80, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 5000), weight: 3.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 5600), weight: 2.50, sender: "Pukin office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 4700), weight: 2.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 4800), weight: 2.50, sender: "Pukin office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 4900), weight: 2.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 4900), weight: 2.50, sender: "Red october", receiver: "Blue shift"),
            PostTransaction(date: Date(timeIntervalSince1970: 4000), weight: 2.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 3700), weight: 2.50, sender: "Apple", receiver: "Microsoft"),
            PostTransaction(date: Date(timeIntervalSince1970: 37000), weight: 2.50, sender: "Clown office", receiver: "Pukin office"),
            PostTransaction(date: Date(timeIntervalSince1970: 3600), weight: 2.50, sender: "Gazprom", receiver: "LUKOil")
    ]
    
    func fetch(offset: Int, count: Int) -> Promise<[TypeProtocol]> {
        return Promise<[TypeProtocol]> { resolver in
            DispatchQueue(label: "Network call mock").asyncAfter(deadline: .now() + 1.0) {
                guard offset < TransactionsLoader.payload.count else {
                    resolver.reject(NSError(domain: "", code: 99, userInfo: [NSLocalizedDescriptionKey: "Offset exeeds payload size"]))
                    return
                }
                let result = Array(TransactionsLoader.payload[(offset..<offset + count)])
                resolver.fulfill(result)
            }
        }
    }
}
