//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business] = []
    let searchBar = UISearchBar()
    var isMoreDataLoading = false
    var dataLimit = 20;
    var defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if defaults.object(forKey: "searchText") != nil {
            searchWith(term: defaults.object(forKey: "searchText") as! String, offset: 0)
        } else {
            searchWith(term: "Asian", offset:0)
            defaults.set("Asian", forKey: "searchText")
        }
        

        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func searchWith(term: String, offset:Int) {
        Business.searchWithTerm(term: term, offset:offset, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            if offset == 0 {
                print("offset is 0")
                self.businesses = businesses!
            } else {
                self.businesses = self.businesses + businesses!
            }
            self.isMoreDataLoading = false


            self.tableView.reloadData()
            
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            }
        )
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideLoadingView), userInfo: nil, repeats: false)

    }
    
    func hideLoadingView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for a restaurant or cuisine"
        searchBar.showsCancelButton = false
        self.navigationItem.titleView = searchBar
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text)
        if (searchBar.text != nil && searchBar.text! != "") {
            if searchBar.text! != defaults.object(forKey: "searchText") as? String {
                defaults.set(searchBar.text!, forKey: "searchText")
                searchWith(term: defaults.object(forKey: "searchText") as! String, offset:0)
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                searchWith(term: defaults.object(forKey: "searchText") as! String, offset: self.businesses.count)
                isMoreDataLoading = true
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destinationViewController = segue.destination as! MapViewController
        destinationViewController.businessArray = self.businesses
    }
    
    
}
