
import Foundation
import UIKit

class CellSite: UITableViewCell {
    
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var sinceCell: UILabel!
    @IBOutlet weak var toCell: UILabel!
    
    var commentSite = ""
    var coordinateX : Double = 0.0
    var coordinateY : Double = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
