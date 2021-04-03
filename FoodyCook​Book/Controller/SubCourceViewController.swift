//
//  HomeViewController.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import UIKit

class SubCourceViewController: UIViewController {
        
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var mainCourseData : MealCourceViewModel?
    var subCourseData = [MealCourceViewModel]()
    var filterCourseData = [MealCourceViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // registerNib()
        listTable.register(UINib.init (nibName: ListTableCell.nibName, bundle: nil), forCellReuseIdentifier: ListTableCell.reuseIdentifier)
        self.listTable.tableFooterView = UIView(frame: .zero)
        updateData()
      
        
    }
    func updateData() {
        SystemAlert().showLoading()
        DispatchQueue.main.async { [self] in
            MealDataClass().getSubCourseList(id : (mainCourseData?.name)!) { [self] (status, data) in
                SystemAlert().removeLoader()
                if(status == 1){
                    self.subCourseData = data!
                    self.filterCourseData = data!
                    listTable.reloadData()
                }else{
                    SystemAlert().basicActionAlert(withTitle: "", message: "No Items Found", actions: [.cancelAlert]) { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.hideTabBar()
    }
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        updateData()
    }
    @objc func selectFavBtn(_ sender : UIButton) {
        
        let mealObject = filterCourseData[sender.tag]
        if CoredataLayer().isFavMeal(id: mealObject.id) {
            CoredataLayer().deleteFavMeal(id: mealObject.id)
            listTable.reloadData()
        }else{
            
            SystemAlert().showLoading()
            
            MealDataClass().getSubCourseDetails(object: mealObject) { [self] (status, result) in
                SystemAlert().removeLoader()
                if(status == 1){
                    CoredataLayer().insertFavMeal(mealObject: .init(foodData: .init(idMeal: mealObject.id, strMeal: (result?.strMeal)!, strInstructions: (result?.strInstructions)!, strMealThumb: (result?.strMealThumb)!, strYoutube: (result?.strYoutube)!, strTags: (result?.strTags)!)))
                }else{
                    SystemAlert().basicNonActionAlert(withTitle: "", message: StrConstant.requestTimedOut, alert: .cancelAlert)
                }
                listTable.reloadData()
            }
        }
    }
    
}
extension SubCourceViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCourseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.reuseIdentifier, for: indexPath) as! ListTableCell
        cell.mainCourceModel = filterCourseData[indexPath.row]
        cell.favBtn.addTarget(self, action: #selector(selectFavBtn(_:)), for: .touchUpInside)
        cell.favBtn.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
   
    
}
// MARK: - SerchBar Delegates
extension SubCourceViewController :UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterCourseData.removeAll()
            filterCourseData = subCourseData
        } else {
            filterCourseData = subCourseData.filter {
                $0.name.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        listTable.reloadData()
    
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
    }
}
