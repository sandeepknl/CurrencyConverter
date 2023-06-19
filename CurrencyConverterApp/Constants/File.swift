//
//  File.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import Foundation

typealias WebserviceHandler = (_ status: Bool, _ message: String?, _ response: AnyObject?, _ error: NSError?) -> Void

typealias APIHandler = (Swift.Result<AnyObject?, Error>) -> Void


struct Constants {
    
    struct ViewController {
        
       static let home = "homeViewController"
        static let login = "loginViewController"
        
    }
    
    struct Data{
        static let email = "email"
    }
    
}
