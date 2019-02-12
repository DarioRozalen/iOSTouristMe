
import Foundation
import UIKit
import Alamofire

class RegisterController: UIViewController
{
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var repeatPassText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let password = passText.text
        let confirmpass = repeatPassText.text
        
        if password == confirmpass
        {
            postPetition()
        }
        else
        {
            self.alert(title: "Aviso", message: "Las claves no coinciden")
        }
    }
    
    @IBAction func returnLogin(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func postPetition()
    {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let url = delegate.urlService + "/register"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let params = ["name" : userText.text!, "password" : passText.text!,
                      "email" : emailText.text!]
        
        print(params)
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding(), headers: headers).responseJSON{
           response in
            
            switch(response.result)
            {
            case .success:
                self.alert(title: "AVISO", message: "Usuario registrado")
            
            case .failure:
                self.alert(title: "ERROR", message: "Error al registrar el usuario")
                
            }
            print(response.result.value!)
        }
    }
    
    func alert(title:String, message:String){
        
        let window = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        window.addAction(buttonOK)
        self.present(window, animated: true, completion: nil)
        
    }
}
