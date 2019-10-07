//
//  AppDelegate.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import Foundation

public class Reachability {
    class func isConnectedToNetwork() -> Bool  {
        return NetworkReachabilityManager()!.isReachable
    }
}
