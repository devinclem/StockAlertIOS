//
//  trade.swift
//  StockAlert
//
//  Created by Devin C on 11/22/22.
//

import Foundation

class trade: Identifiable {
    var ticker: String
    var price: String
    var qty: String
    var dateString: Date = Date()
    var percentChange: String
    var type: String
    init(type: String, ticker: String, price: String, qty: String, dateString: String, percentChange: String) {
        self.type = type
        self.ticker = ticker
        self.price = price
        self.qty = qty
        self.percentChange = percentChange
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: dateString) {
                print(date)
                self.dateString = date
                
            }
        
    }
    
    func datetoString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self.dateString)
                
    }
    func toString() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let theDate = dateFormatter.string(from: self.dateString)
        return "Type: " + self.type + " Ticker: " + self.ticker + " Price: " + self.price + " Date: " + theDate
    }
    
}
