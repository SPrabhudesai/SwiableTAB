//
//  PlashSereenViewController.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit

class PlashSereenViewController: UIViewController {
    @IBOutlet weak var progressBar: SimpleSpinner!
    var timer: Timer?
    
    //MARK: VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        showAlert()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        progressBar.startAnimating()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK: UPDATE UI TO VIEW
    fileprivate func updateUI() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: ALERT FUNCTION
    fileprivate func showAlert() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(PlashSereenViewController.dismissAlert), userInfo: nil, repeats: false)
        showActivityIndicatory()
    }
    
    //MARK: DISMISS ALERT
    @objc fileprivate func dismissAlert(){
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            let vc = self.storyboard!.instantiateViewController(withIdentifier: StoryboardIdentifier.ACCEPT_TICKET_VC) as! AcceptTicketViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: SHOW INDICTOR FUNCTION
    fileprivate func showActivityIndicatory() {
        self.progressBar.tintColor = .white
        progressBar.startAnimating()
    }
}
