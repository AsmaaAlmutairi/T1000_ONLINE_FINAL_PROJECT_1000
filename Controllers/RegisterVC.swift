//
//  RegisterVC.swift
//  T1000_ONLINE_FINAL_PROJECT_1000
//
//  Created by ا on 11/01/1444 AH.
//

import UIKit

class RegisterVC: UIViewController {
   //MARK: OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNametextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
   
    //MARK: LIFE CYCEL METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//MARK: ACTIONS
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        UserAPI.registerNewUser(firstName: firstNameTextField.text!, lastName: lastNametextField.text!, email: emailTextField.text!) { User,errorMessage  in
            if errorMessage != nil {
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Success", message: "User Created", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)            }
        }
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
