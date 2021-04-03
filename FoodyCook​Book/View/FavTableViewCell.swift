//
//  FavTableViewCell.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var hdrLbl: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var subNameLbl: UILabel!
    @IBOutlet weak var linkBtn: UIButton!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var detailCourceModel : MealDetailViewModel? {
        didSet {
            FoodUtility().loadImageWithUrl(imageVW: imgVw, urlStr: detailCourceModel?.strMealThumb ?? "",completion: { (status) in
            })
            hdrLbl.text = detailCourceModel?.strMeal
            subNameLbl.text = detailCourceModel?.strTags
            desLbl.text = detailCourceModel?.strInstructions
            linkBtn.setTitle(detailCourceModel?.strYoutube, for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class var reuseIdentifier: String {
        return "favCell"
    }
    class var nibName: String {
        return "FavTableViewCell"
    }
}
