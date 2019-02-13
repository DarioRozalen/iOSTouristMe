
import UIKit
import MapKit
import Foundation

class DetailSite: UIViewController {
    
    var titleDetail = ""
    var commentDetail = ""
    var sinceDetail = ""
    var toDetail = ""
    var x_coordinate : Double = 0.0
    var y_coordinate : Double = 0.0
    
    @IBOutlet weak var titleLabelDetail: UILabel!
    @IBOutlet weak var sinceLabelDetail: UILabel!
    @IBOutlet weak var toLabelDetail: UILabel!
    @IBOutlet weak var descriptionLabelDetail: UITextView!
    @IBOutlet weak var mapDetail: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pin = MKPointAnnotation()
        
        titleLabelDetail.text = titleDetail
        descriptionLabelDetail.text = commentDetail
        sinceLabelDetail.text = sinceDetail
        toLabelDetail.text = toDetail
        
        print(x_coordinate)
        pin.coordinate.latitude = x_coordinate
        pin.coordinate.longitude = y_coordinate
        
        self.mapDetail.addAnnotation(pin)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        dismiss(animated: true, completion: nil)
    }
    
}
