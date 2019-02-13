
import UIKit
import Foundation
import Alamofire

class TableSite: UITableViewController {
    
    var name = ""
    var startDate = ""
    var endDate = ""
    
    @IBOutlet var siteTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siteTable.rowHeight = 120
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        alamoRequest()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSite.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellSite
        
        cell.titleCell.text = savedSite[indexPath.row].title
        cell.sinceCell.text = savedSite[indexPath.row].since.description
        cell.toCell.text = savedSite[indexPath.row].to.description
        cell.commentSite = savedSite[indexPath.row].description
        cell.coordinateX = savedSite[indexPath.row].x_coordinate
        cell.coordinateY = savedSite[indexPath.row].y_coordinate
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailSite = segue.destination as! DetailSite
        let pressedCell = sender as! CellSite
        
        detailSite.titleDetail = pressedCell.titleCell.text!
        detailSite.sinceDetail = pressedCell.sinceCell.text!
        detailSite.toDetail = pressedCell.toCell.text!
        detailSite.commentDetail = pressedCell.commentSite
        detailSite.x_coordinate = pressedCell.coordinateX
        detailSite.y_coordinate = pressedCell.coordinateY
    }
    
    func alamoRequest(){
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let url = delegate.urlService + "/places"
        let Token = UserDefaults.standard.object(forKey: "LOGIN")! as! String
        //print(Token)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization":Token
        ]
        
        
        Alamofire.request(url, method: .get, headers: headers).responseJSON { response in
            
            switch(response.result){
                
            case .failure:
                
                self.alert(title: "ERROR", message: "Error al crear sitio")
                
            case .success:
                
                if (response.response?.statusCode == 200)
                {
                    
                    let jsonPlaces = response.result.value
                    
                    let places = jsonPlaces as! [String:[[String:Any]]]
                    
                    savedSite.removeAll()
                    
                    for place in places["MySites"]!{
                        let site = Site(title: place["name"] as! String, since: place["start_date"] as! String, to: place["end_date"] as! String, description: place["description"] as! String, x_coordinate: place["coordinate_x"] as! Double, y_coordinate: place["coordinate_y"] as! Double)
                        savedSite.append(site)
                    }
                    self.tableView.reloadData()
                }
                else
                {
                    self.alert(title: "ERROR", message: "Error al cargar lugar")
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
