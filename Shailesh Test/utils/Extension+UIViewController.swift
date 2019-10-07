//
//  Extension+UIViewController.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit


extension UIViewController {
    internal func showAlertMessage(vc: UIViewController, title: String, message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
