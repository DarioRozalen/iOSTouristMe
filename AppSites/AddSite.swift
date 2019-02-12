
import UIKit
import MapKit
import Foundation
import Alamofire
import SwiftyJSON

class AddSite: UIViewController {
    
    @IBOutlet weak var titleSite: UITextField!
    
    @IBOutlet weak var commentSite: UITextField!
    
    @IBOutlet weak var sincePicker: UIDatePicker!
    
    @IBOutlet weak var toPicker: UIDatePicker!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    
    
    var sinceDate: String?
    var toDate: String?
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    @IBAction func newSite(_ sender: UIButton) {
        
        
        convertPicker()
        petitionAlamo()
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let pinLocation = sender.location(in: self.mapView)
        coordinate = mapView.convert(pinLocation, toCoordinateFrom: mapView)
        let anotation = MKPointAnnotation()
        
        
        anotation.coordinate = coordinate
        anotation.title = titleSite.text!
        anotation.subtitle = commentSite.text!
        
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapView.addAnnotation(anotation)
        
        
    }
    
    func petitionAlamo(){
        
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let url = delegate.urlService + "/places"
        let Token = UserDefaults.standard.object(forKey: "LOGIN")! as! String
        print(Token)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization":Token
        ]
        let parameters: Parameters = [
            "placeName": titleSite.text!, "xCoordinate" : coordinate.latitude, "yCoordinate" : coordinate.longitude, "description":commentSite.text!, "startDate": sinceDate!, "endDate":toDate!
            ] as [String : Any]
        
        
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
            
            //print(response.response!)
            //print(response.result)
            //print(response.response?.statusCode ?? 400)
            
            switch(response.result){
                
            case .failure:
                
                self.alert(title: "ERROR", message: "Error al crear sitio")
                
            case .success:
                
                if (response.response?.statusCode == 200)
                {
                    
                    //sitio añadido
                    let siteNew = Site(title: self.titleSite.text!, since: self.sinceDate!, to: self.toDate!, description: self.commentSite.text!, x_coordinate: self.coordinate.latitude, y_coordinate: self.coordinate.longitude)
                    savedSite.append(siteNew)
                    
                    self.tabBarController?.selectedIndex = 0
                    self.alert(title: "SITIO CREADO", message: "Eres una máquina")
                }
                else
                {
                    self.alert(title: "ERROR", message: "Error al crear lugar")
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
    
    func convertPicker(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        sinceDate = dateFormatter.string(from: sincePicker.date)
        toDate = dateFormatter.string(from: toPicker.date)
    }
}
