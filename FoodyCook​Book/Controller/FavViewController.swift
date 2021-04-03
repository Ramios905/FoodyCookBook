//
//  SettingsViewController.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import UIKit

class FavViewController: UIViewController {
    @IBOutlet weak var listTable: UITableView!
    var mealDetailData = [MealDetailViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // registerNib()
        self.title = StrConstant.homeTitle
        listTable.register(UINib.init (nibName: FavTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FavTableViewCell.reuseIdentifier)
        self.listTable.tableFooterView = UIView(frame: .zero)
       
      
        
    }
    func updateData() {
        
        DispatchQueue.main.async { [self] in
            mealDetailData.removeAll()
            let allFavData = CoredataLayer().getAllFavMeals()
            if allFavData.count > 0{
                _ = allFavData.map({ (detailObj) in
                    mealDetailData.append(.init(foodData: .init(idMeal: (detailObj.idMeal)!, strMeal: (detailObj.strMeal)!, strInstructions: (detailObj.strInstructions)!, strMealThumb: (detailObj.strMealThumb)!, strYoutube: (detailObj.strYoutube)!, strTags: (detailObj.strTags)!)))
                })
            }
            listTable.reloadData()
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.showTabBar()
        updateData()
    }
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        updateData()
    }
    @objc func deleteBtn(_ sender : UIButton) {
        
        let mealObject = mealDetailData[sender.tag]
        CoredataLayer().deleteFavMeal(id: mealObject.idMeal)
        mealDetailData.remove(at: sender.tag)
        listTable.reloadData()

    }
    @objc func clickOnYoutubeAction(_ sender : UIButton) {
        let mealObject = mealDetailData[sender.tag]
        let appURL = NSURL(string: "\(mealObject.strYoutube)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
        }

    }
    
}

extension FavViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealDetailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavTableViewCell.reuseIdentifier, for: indexPath) as! FavTableViewCell
        cell.detailCourceModel = mealDetailData[indexPath.row]
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtn(_:)), for: .touchUpInside)
        cell.linkBtn.addTarget(self, action: #selector(clickOnYoutubeAction(_:)), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
}
