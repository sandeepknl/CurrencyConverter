//
//  APIManager.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import Foundation
import Alamofire

class APIManager{
    
    static let shared = APIManager()
    
    
    // To get the user current location
    func getCurrency(completion: @escaping WebserviceHandler){
        
        let url:String = ""
        let method:HTTPMethod = .get
        let params: Parameters = [:]
        

        WebServiceManager.shared.request(with: url, method: method, parameters: params, headers: nil, encoding: URLEncoding.default, decodable: CurrencyConverterModel.self) { status,message,response,error in
            completion(status,message,response,error)
        }
    }
    
    
}
