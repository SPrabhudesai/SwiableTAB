//
//  AppDelegate.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class AlamofireServices: NSObject {
    var data:[String:Any] = [:]
    class func requestGETNewS(_ strUrl:String,parm:[String:AnyObject]?,header:[String: String]?, succses: @escaping(Data?) -> Void, failure: @escaping(Error)-> Void){
        Alamofire.request(strUrl, method: .get, parameters: parm, headers: header).responseJSON { (respone) in
            print("Response ==>>\(respone)")
            if respone.result.isSuccess {
                let data = respone.data
                succses(data)
            }
            if respone.result.isFailure {
                let error = respone.result.error!
                failure(error)
            }
        }
    }
}
 
