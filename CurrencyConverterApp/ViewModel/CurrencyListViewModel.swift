//
//  CurrencyListViewModel.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import Foundation

class CurrencyListViewModel: NSObject{
    
    
    func currencyList(success:@escaping((_ currencyData:[String:Double])->Void), failure:@escaping((_ message:String)->Void)) {
        
        APIManager.shared.getCurrency(parameters: [:], completion: {(status,message,response,error) in
            let currencyListModel = response as! CurrencyConverterModel
            let currencyRate = currencyListModel.rates
            success(currencyRate)
            
        })
        
        
        
    }
                                                    
    }
    


