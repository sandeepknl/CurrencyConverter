//
//  LoginViewController.swift
//  CurrencyConverterApp
//
//  Created by Sandeep PV on 19/06/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func googleSignInAction(_ sender: GIDSignInButton) {
        socialLogin()
    }
    
    func socialLogin(){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              print(error?.localizedDescription ?? "Error")
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
                    
          else {
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in

                
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewController.home) as! HomeViewController
                self.navigationController?.pushViewController(homeViewController, animated: true)
                
                
            }
            
            
        }
        
        
    }
    

   
}
