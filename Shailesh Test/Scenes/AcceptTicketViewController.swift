//
//  DemoViewController.swift
//  Shailesh Test
//
//  Created by Shailesh Prabhudesai on 05/10/19.
//  Copyright © 2019 Shailesh Prabhudesai. All rights reserved.
//

import UIKit

//MARK: PROTOCOL TO SEND DATA
protocol DetailMovieProtocol:class {
    func DetailMovieData(MovieImage:URL,MovieTitle:String,MovieReleseYear:Int,MovieRating:Double,MovieGener:String)
}

class AcceptTicketViewController: UIViewController {
    @IBOutlet weak var segmentedView: MXSegmentedControl!
    @IBOutlet weak var ticketTableView: UITableView!
    @IBOutlet weak var detalilMovieImage: UIImageView!
    @IBOutlet weak var detailMovieTitle: UILabel!
    @IBOutlet weak var detailMovieGenerLabel: UILabel!
    @IBOutlet weak var detailMovieReleseLabel: UILabel!
    @IBOutlet weak var detailMovieRatingLabel: UILabel!
    @IBOutlet weak var loader: SimpleSpinner!
    @IBOutlet weak var mainView: UIView!
    
    weak var delegate:DetailMovieProtocol?
    fileprivate var movieArray:[MainBOElement] = []
    
    //MARK: VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        segUI()
        getMovieDetails()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: UPDATE UI TO VIEW
    fileprivate func segUI() {
        mainView.isHidden = true
        segmentedView.append(title: BottomTabName.BOTTOM_TAB1).set(title: UIColor.init(rgb: 0x25B8F7), for: .selected).set(title: UIColor.darkGray, for: .normal)
        segmentedView.append(title: BottomTabName.BOTTOM_TAB2).set(title: UIColor.init(rgb: 0x25B8F7), for: .selected).set(title: UIColor.darkGray, for: .normal)
        segmentedView.font = UIFont.boldSystemFont(ofSize: 13)
        segmentedView.indicator.lineView.backgroundColor = UIColor.init(rgb: 0x25B8F7)
        segmentedView.indicator.lineHeight = 2.0
        segmentedView.addTarget(self, action: #selector(changeIndex(segmentedControl:)), for: .valueChanged)
    }
    
    @objc func changeIndex(segmentedControl: MXSegmentedControl) {
        print(segmentedControl.selectedIndex)
        if let segment = segmentedControl.segment(at: segmentedControl.selectedIndex) {
            segmentedControl.indicator.boxView.backgroundColor = segment.titleColor(for: .selected)
            segmentedControl.indicator.lineView.backgroundColor = UIColor.init(rgb: 0x25B8F7)
        }
        if segmentedView.selectedIndex == 0 {
        }
        else if segmentedView.selectedIndex == 1 {
        }
    }
    
    //MARK: GET MOVIE LIST API CALL
    fileprivate func getMovieDetails() {
    let network = Reachability.isConnectedToNetwork()
    if network == true{
        loader.isHidden = false
        loader.startAnimating()
        loader.tintColor = .white
        AlamofireServices.requestGETNewS(APIList.MOVIE_API, parm: [:], header: [:], succses: { (response) in
            do{
                let movie = try JSONDecoder().decode([MainBOElement].self, from: response!)
                for i in movie{
                    self.movieArray.append(i)
                }
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
                    self.ticketTableView.reloadData()
                    self.mainView.isHidden = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }else{
        showAlertMessage(vc: self, title: AlertMessage.ERROR_ALERT, message: AlertMessage.NETWORK_ALERT)
     }
  }
}

//MARK: TABLEVIEW METHOD
extension AcceptTicketViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.TICKET_CELL, for: indexPath) as! TicketTableViewCell
        cell.populateCell(movie: movieArray[indexPath.row])
        cell.showDetailButton.tag = indexPath.row
        cell.showDetailButton.addTarget(self, action: #selector(showDetailButtonFunction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
    
    //MARK: SHOWDETAIL BUTTON ACTION
    @objc func showDetailButtonFunction(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        print(movieArray[indexPath.row].title as Any)
        print(movieArray[indexPath.row].rating as Any)
        print(movieArray[indexPath.row].releaseYear as Any)
        print(movieArray[indexPath.row].image as Any)
        let string = movieArray[indexPath.row].genre!.joined(separator: " , ")
        delegate?.DetailMovieData(MovieImage: movieArray[indexPath.row].image ?? URL(string: "")!, MovieTitle: movieArray[indexPath.row].title ?? "" , MovieReleseYear: movieArray[indexPath.row].releaseYear ?? 0, MovieRating: movieArray[indexPath.row].rating ?? 0.0, MovieGener: string)
        segmentedView.select(index: 1, animated: true)
    }
}

//MARK: DETAIL MOVIE METHOD
extension AcceptTicketViewController:DetailMovieProtocol{
    func DetailMovieData(MovieImage: URL, MovieTitle: String, MovieReleseYear: Int,MovieRating:Double,MovieGener:String) {
        detalilMovieImage.sd_setImage(with: MovieImage, placeholderImage: UIImage(named: "placeholder.png"))
        detailMovieTitle.text = MovieTitle
        detailMovieReleseLabel.text = "\(MovieReleseYear)"
        detailMovieRatingLabel.text = "\(MovieRating)"
        detailMovieGenerLabel.text = MovieGener
    }
    
}
