//
//  HomeViewController.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import UIKit
import iOSDropDown
import FirebaseAuth

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var convertedLabel: UILabel!
    @IBOutlet weak var dropDown : DropDown!
    
    @IBOutlet weak var conversionCurrencyDropDown: DropDown!
    
    let currencyViewModel = CurrencyListViewModel()
    var countryList = [String]()
    var currencyValue = [Double]()
    var homeCurrencyIndex = Int()
    var convertedCurrencyIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyList()
        

        dropDown.delegate = self
        conversionCurrencyDropDown.delegate = self
        
       
        // The the Closure returns Selected Index and String
        dropDown.didSelect{(selectedText , index ,id) in
        self.dropDown.text = "\(selectedText)"
            self.homeCurrencyIndex = index
            
        }
        
        conversionCurrencyDropDown.didSelect{(selectedText , index ,id) in
        self.conversionCurrencyDropDown.text = "\(selectedText)"
            self.convertedCurrencyIndex = index
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    func currencyList(){
        
        currencyViewModel.currencyList(success: {data in
            
            for (key,value) in data{
                self.countryList.append(key)
                self.currencyValue.append(value)
            }
            
            self.dropDown.optionArray = self.countryList
            self.conversionCurrencyDropDown.optionArray = self.countryList
            
        },failure: {error in
            print(error)
        })
    }

    @IBAction func convertAction(_ sender: UIButton) {
        
        let homeCurrencyValue = self.currencyValue[homeCurrencyIndex]
        let convertCurrencyValue = self.currencyValue[convertedCurrencyIndex]
        
        let conversionValue = convertCurrencyValue / homeCurrencyValue
        
        print(conversionValue)
        convertedLabel.text = "1 \(self.dropDown.text ?? "") = \(conversionValue) \(self.conversionCurrencyDropDown.text ?? "")"
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewController.login) as! LoginViewController
            self.navigationController?.pushViewController(loginViewController, animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.inputView = UIView()
    }
    
    
    
}
