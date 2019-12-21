//
//  MainViewController.swift
//  PaginationDemo
//


import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    var hitsArray:Array<Hits> = Array()
    var selectedIndexes:Array<Int> = Array()
    
    var pageNumber:Int = 1
    var selectedCount = 0
    var totalPages = 0
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUpViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //API CALL to fetch  Data
        self.apiCallToGetData()
    }
    
    //Refresh Controls for Pull to Refresh
    @objc func refresh(sender:AnyObject) {
        
        self.pageNumber = 1
        self.apiCallToGetData()
    }
    
    /// Funcations to set intial property for views and subviews.
    ///
    /// - returns: void
    func setUpViews(){
        
        self.navigationItem.title = MESSAGES.totalItems + self.selectedCount.toString()!
        
        //Tableview Properties
        self.tblList.tableFooterView = UIView.init()
        self.tblList.estimatedRowHeight = 70
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to fetch latest data")
        refreshControl.tintColor = UIColor.blue
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
        self.tblList.addSubview(refreshControl)
        
    }

    //MARK : WEB API CALLS
    
    /// Funcations to call api for Hits data fetching
    
    func apiCallToGetData(){
        
        let requestUrl = APITAG.story + APITAG.page + pageNumber.toString()!
        
        API.sharedInstance.getAllData(requestUrl) { (status, json) in
            if(status)
            {
                if(json != nil)
                {
                    if(self.pageNumber == 1)
                    {
                        self.totalPages = json![APIKey.nbPages].intValue
                        self.selectedCount = 0
                        self.hitsArray.removeAll()
                        self.selectedIndexes.removeAll()
                        self.navigationItem.title = MESSAGES.totalItems + self.selectedCount.toString()!
                    }
                    
                    let arrResults = json![APIKey.results].arrayValue
                    
                    for obj in arrResults {
                        
                        let objHit = Hits.init(fromJson: obj)
                        self.hitsArray.append(objHit)
                    }
                    self.tblList.reloadData()
                    
                    if(self.refreshControl.isRefreshing == true)
                    {
                        self.refreshControl.endRefreshing()
                    }
                    
                }
                else
                {
                    Functions.displayAlert(MESSAGES.serverError)
                }
                
            }
            else
            {
                
            }
        }
    }
    
    //End  WEB API CALLS
    
}

//MARK:- table datasource/delegate
extension MainViewController: UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate{
    
    //Pagination
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
        if ((tblList.contentOffset.y + tblList.frame.size.height) >= tblList.contentSize.height)
        {
            if(self.pageNumber != self.totalPages)
            {
                self.pageNumber = self.pageNumber + 1
                self.apiCallToGetData()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DataCell
        cell.selectionStyle = .none
        cell.swSwitch.tag = indexPath.row
        
        cell.swSwitch.isOn = false
        
        if(self.selectedIndexes.contains(indexPath.row))
        {
            cell.swSwitch.isOn = true
        }
        
        cell.swSwitch.isEnabled = false
        
        let object = self.hitsArray[indexPath.row]
        cell.lblTitle.text = object.title
        
        let strDate = object.createdAt.replacingOccurrences(of: "Z", with: "")
        
        cell.lblDate.text = Date.convertStringToGiventUTCformate(strDate, currntStringForamte: "yyyy-MM-dd'T'HH:mm:ss.SSS", convertedtoformate: "dd MMM yyyy hh:mm a")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(selectedIndexes.contains(indexPath.row))
        {
            self.selectedIndexes.removeObjectFromArray(indexPath.row)
            self.selectedCount = self.selectedCount - 1
        }
        else
        {
            self.selectedIndexes.append(indexPath.row)
            self.selectedCount = self.selectedCount + 1
        }
        self.tblList.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        self.navigationItem.title = MESSAGES.totalItems + self.selectedCount.toString()!
        
    }
}
