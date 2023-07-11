//
//  WebServiceManager.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import Foundation
import Alamofire


class WebServiceManager{
    
    static let shared = WebServiceManager()
    
    func request<T>(with url: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?,encoding: ParameterEncoding, decodable: T.Type,
                               completion: @escaping WebserviceHandler) where T: Decodable {
        
                
                AF.request(url,method: method,parameters: parameters,encoding: encoding, headers: headers)
                    .validate()
                    .responseData(completionHandler: { response in
                        print("API REQUEST : \(String(describing: response.request!))")
                        switch response.result{
                        case .success(let jsonData):
                            if let code = response.response?.statusCode{
                                switch code {
                                case 200...299:
                                    
                                    do {
                                        let decoder = JSONDecoder()
                                        if let decoded = try? decoder.decode(decodable, from: jsonData) {
                                            print("API RESPONSE : \(decoded)")

                                            completion(true, "Success", decoded as AnyObject, nil)
                                        }  else {
                                            
                                            do {
                                                let decoded = try decoder.decode(decodable, from: jsonData)
                                                completion(true, "Success", decoded as AnyObject, nil)
                                            } catch let DecodingError.dataCorrupted(context) {
                                                print(context)
                                            } catch let DecodingError.keyNotFound(key, context) {
                                                print("Key '\(key)' not found:", context.debugDescription)
                                                print("codingPath:", context.codingPath)
                                            } catch let DecodingError.valueNotFound(value, context) {
                                                print("Value '\(value)' not found:", context.debugDescription)
                                                print("codingPath:", context.codingPath)
                                            } catch let DecodingError.typeMismatch(type, context)  {
                                                print("Type '\(type)' mismatch:", context.debugDescription)
                                                print("codingPath:", context.codingPath)
                                            } catch {
                                                print("error: ", error)
                                            }
                                            
                                            
                                        }
                                        
                                    } catch let error {
                                        print(String(data: jsonData, encoding: .utf8) ?? "nothing received")
                                        completion(false, "Failure", nil, error as NSError)
                                    }
                                default:
                                    let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                                    print(error.localizedDescription)
                                    completion(false, "Failure", nil, error as NSError)
                                }
                            }
                        case .failure(let error):
                            completion(false, "Failure", nil, error as NSError)
                        }
                    })
                
            
        }
    
}




//    func request(){
//
//        let url = URL(string: "api.myplatform.com/endpoint")!
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//          if error == nil {
//            guard let data = data else { return }
//            do {
//              let model = try JSONDecoder().decode(User.self, from: data)
//              // start using your model here
//             } catch let error {
//                //error handling
//             }
//           }
//        }.resume()
//
//
//    }


//let urlRequest = buildURLRequest(hostname: "api.myplatform.com", path: "endpoint", parameters: ["name":"yalcin"], body: [:], method: "PUT")
//URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//  // response handling
//}.resume()


//https://blog.appnation.co/how-to-handle-json-responses-using-jsondecoder-in-swift-the-most-efficient-way-96315b71ed6d
