//
//  MainVC.swift
//  CountryList
//
//  Created by Megat Syafiq on 13/07/2019.
//  Copyright © 2019 Megat Syafiq. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UISearchResultsUpdating {
    
    var details = [CountyList]()
    var filteredTableData = [CountyList]()
    var resultSearchController = UISearchController()
    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.isTranslucent = true
            controller.searchBar.barTintColor = UIColor(red:0.26, green:0.26, blue:0.26, alpha:1.0)
            
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()

        getCountryList()
        
    }
    var searchString = ""
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        if searchController.searchBar.text == "" {
            searchString = ""
            self.tableView.reloadData()
        } else {
            searchString = searchController.searchBar.text!
            let searchString = searchController.searchBar.text
            filteredTableData = details.filter {
                $0.countryName.localizedCaseInsensitiveContains(searchString!)
                    || ($0.countryCode.localizedCaseInsensitiveContains(searchString!))
            }
            
            self.tableView.reloadData()
        }
 
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchString = searchBar.text
        filteredTableData = details.filter {
            $0.countryName.localizedCaseInsensitiveContains(searchString!)
                || ($0.countryCode.localizedCaseInsensitiveContains(searchString!))
        }
        
        self.tableView.reloadData()
    }
    

    
    func getCountryList () {
        let url = "https://api.printful.com/countries"
        Alamofire.request(url).validate(statusCode: 200..<300).responseJSON { response in
            if (response.result.isSuccess){
                
                if let data = response.result.value as? NSDictionary {
                    
                    if let result = data["result"] as? NSArray {
                        
                        for element in result {
                            if let data2 = element as? NSDictionary {
                                if let countryname = data2["name"] as? String {
                                    
                                    let countrycode = data2["code"] as? String
                                    
                                    let country = CountyList(countryName: countryname, countryCode: countrycode!)
                                    
                                    self.details.append(country)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if  (resultSearchController.isActive) {
            return filteredTableData.count
        } else {
            return details.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countrycell") as? CountryCell
        let country: CountyList
        
        if (resultSearchController.isActive) {
            if searchString == "" {
                country = details[indexPath.row]
            } else {
                country = filteredTableData[indexPath.row]
            }
           
        }
        else {
            country = details[indexPath.row]
        }
        
        
        
        cell!.countryName.text = country.countryName
        cell!.countryCode.text = country.countryCode
        return cell!
        
    }
}

