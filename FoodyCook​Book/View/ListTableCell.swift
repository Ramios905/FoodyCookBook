//
//  ListTableCell.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import UIKit
import Kingfisher

class ListTableCell: UITableViewCell {
    
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var mainCourceModel : MealCourceViewModel? {
        didSet {
            FoodUtility().loadImageWithUrl(imageVW: imageVw, urlStr: mainCourceModel?.imgStr ?? "",completion: { (status) in
                
            })
            nameLbl.text = mainCourceModel?.name
            desLbl.text = mainCourceModel?.desStr
            favBtn.isHidden = true
            if (mainCourceModel?.id.count)! > 1 {
                
                let img = UIImage(named: "unfav")                
                
                favBtn.isHidden = false
                if CoredataLayer().isFavMeal(id: mainCourceModel!.id) {
                    favBtn.setImage(UIImage(named: "fav"), for: .normal)
                }else{
                    favBtn.setImage(UIImage(named: "unfav"), for: .normal)
                }
            }else{
            }
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class var reuseIdentifier: String {
        return "listCell"
    }
    class var nibName: String {
        return "ListTableCell"
    }
}
