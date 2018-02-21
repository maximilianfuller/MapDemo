//
//  DataManager.swift
//  MapDemo
//
//  Created by Max Fuller on 2/21/18.
//  Copyright © 2018 Max Fuller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    
    static let instance: DataManager = DataManager()
    
    var base: String = ""
    var table: String = ""
    var view: String = ""
    
    var data: [[String]] = []
    var fieldNames: [String] = []
    
    let MAX_ROWS = 1000
    let API_KEY = "keyB1vGhVW0BcM4lc"
    
    func refreshData() {
        let scheme = "https"
        let host = "api.airtable.com"
        let path = "/v0/" + base + "/" + table
        let keyQ = URLQueryItem(name: "api_key", value: API_KEY)
        let recordsQ = URLQueryItem(name: "maxRecords", value: String(MAX_ROWS))
        let viewQ = URLQueryItem(name: "view", value: "Grid view")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [keyQ, recordsQ, viewQ]
        guard let urlString = urlComponents.url?.absoluteString else {
            data = []
            fieldNames = []
            print("invalid data")
            return
        }
        
        Alamofire.request(urlString).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let json = JSON(responseData.result.value!)
                print(json)
                self.fieldNames = []
                self.data = []
                for (key, _) in json["records"][0]["fields"] {
                    self.fieldNames.append(key)
                }
                
                for subJson in json["records"].arrayValue {
                    var fields : [String] = []
                    for fieldName in self.fieldNames {
                        if let val = subJson["fields"][fieldName].string {
                            fields.append(val)
                        }
                    }
                    self.data.append(fields)
                }
                
                print(self.data)
                print(self.fieldNames)
            }
        }
    }
}
