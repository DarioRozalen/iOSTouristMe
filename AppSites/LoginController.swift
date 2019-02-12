
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
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "email": userText.text!, "password" : passText.text!
        ]
        
        //print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding(), headers: headers).responseJSON { response in
            
            //print(response.result.value!)
            //print(response.response?.statusCode ?? 400)
            switch(response.result){
                
            case .failure:
                
                self.alert(title: "ERROR", message: "Error en el servicio de autenticacion")
                
            case .success:
                
                if (response.response?.statusCode == 200)
                {
                    //capturamos el token
                    
                    let json = JSON(response.value!)
                    
                    // delegate.Token = delegate.Token + json["data"].string!
                    
                    //print(delegate.Token)
                    
                    UserDefaults.standard.set(json["data"].string, forKey: "LOGIN")
                    
                    
                    //ingresamos a la App
                    self.performSegue(withIdentifier: "segueInicio", sender: self)
                }
                else
                {
                    self.alert(title: "ERROR", message: "Error en el usuario o contraseña")
                }
            }
        }
    }
    
    func alert(title:String, message:String){
        
        let window = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        window.addAction(alertButton)
        self.present(window, animated: true, completion: nil)
        
    }
    
}
    
    
    
    
    
    
    

