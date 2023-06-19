//
//  HomeViewController.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import UIKit
import iOSDropDown

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var dropDown : DropDown!

    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The list of array to display. Can be changed dynamically
        
        dropDown.optionArray = ["Option 1", "Option 2", "Option 3"]
       


        // The the Closure returns Selected Index and String
        dropDown.didSelect{(selectedText , index ,id) in
        self.dropDown.text = "Selected String: \(selectedText) \n index: \(index)"
        }

        // Do any additional setup after loading the view.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
