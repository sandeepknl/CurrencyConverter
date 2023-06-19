//
//  CurrencyList.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import Foundation

class CurrencyConverterModel : Decodable {
    
    @objc dynamic var rates : [String:Double] = [:]
    @objc dynamic var base : String?
   
    
    
    enum CodingKeys: String, CodingKey {
        
        case rates = "rates"
        case base = "base"
        
        
    }
    
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rates = try values.decodeIfPresent([String:Double].self, forKey: .rates)!
        base = try values.decodeIfPresent(String.self, forKey: .base)

    
    }
}
