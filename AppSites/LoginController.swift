
import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class LoginController: UIViewController {
    

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButton(_ sender: Any) {
        peticionAlamo()
    }
    func peticionAlamo(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let url = delegate.urlService + "/login"
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["email": userText.text!, "password" : passText.text!]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headers).responseJSON { response in
            
            switch(response.result){
            case .failure:
                self.alert(title: "Error", message: "Login failed")
                
            case .success:
                if (response.response?.statusCode == 200)
                {
                    //capturamos el token
                    let json = JSON(response.value!)
                    UserDefaults.standard.set(json["data"].string, forKey: "LOGIN")
                    //ingresamos a la App
                    self.performSegue(withIdentifier: "segueInicio", sender: self)
                }
                else
                {
                    self.alert(title: "ERROR", message: "Login fail")
                }
            }
        }
    }
    func alert(title:String, message:String){
        
        let window = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Accept", style: .default, handler: nil)
        window.addAction(alertButton)
        self.present(window, animated: true, completion: nil)
    }
}
    
    
    
    
    
    
    

