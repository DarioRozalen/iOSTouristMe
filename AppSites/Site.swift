
import Foundation

class Site {
    
    var title : String
    var description : String
    var since: String
    var to: String
    var x_coordinate : Double
    var y_coordinate : Double
    
    init(title : String, since : String, to : String, description: String, x_coordinate : Double, y_coordinate : Double) {
        
        self.title = title
        self.description = description
        self.since = since
        self.to = to
        self.x_coordinate = x_coordinate
        self.y_coordinate = y_coordinate
    }
}
