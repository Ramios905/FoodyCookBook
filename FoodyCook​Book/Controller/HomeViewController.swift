//
//  HomeViewController.swift
//  FoodyCook​Book
//
//  Created by Ram on 03/04/21.
//

import UIKit

class HomeViewController: UIViewController {
        
    @IBOutlet weak var listTable: UITableView!
    var mainCourseData = [MealCourceViewModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // registerNib()
        self.title = StrConstant.homeTitle
        listTable.register(UINib.init (nibName: ListTableCell.nibName, bundle: nil), forCellReuseIdentifier: ListTableCell.reuseIdentifier)
        self.listTable.tableFooterView = UIView(frame: .zero)
        updateData()
      
        
    }
    func updateData() {
        SystemAlert().showLoading()
        DispatchQueue.main.async {
            MealDataClass().getMainCourseList { [self] (status, data) in
                SystemAlert().removeLoader()
                if(status == 1){
                    self.mainCourseData = data!
                    listTable.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.showTabBar()
    }
    @IBAction func clickOnRefreshBtn(_ sender: Any) {
        updateData()
    }
    
}
extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainCourseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.reuseIdentifier, for: indexPath) as! ListTableCell
        cell.mainCourceModel = mainCourseData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = self.getController(fromStoryboard: .main, with: .subCourceVC) as! SubCourceViewController
        nextVC.mainCourseData = mainCourseData[indexPath.row]
        nextVC.title = mainCourseData[indexPath.row].name
        self.navigationController?.pushViewController(nextVC, animated: true)
       
    }
   
    
}
