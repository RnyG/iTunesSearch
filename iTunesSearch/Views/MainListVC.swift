//
//  MainListVC.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MainListVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var mediaTV: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var heightOfSearch: NSLayoutConstraint!
    @IBOutlet weak var topTable: NSLayoutConstraint!
    @IBOutlet weak var bottomTable: NSLayoutConstraint!
    @IBOutlet weak var loadMoreIndicator: UIActivityIndicatorView!
    @IBOutlet weak var adviceLbl: UILabel!
    @IBOutlet weak var bears: UIImageView!
    
    private var viewModel: MainListVM!
    var mediaType: MediaType!
    var searching = false
    var fetching = false
    var totalOfMedia = 0
    var countOfMedia = 0
    var limit = 10
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure(){
        self.cleanNav()
        viewModel = MainListVM()
        mediaTV.delegate = self
        mediaTV.dataSource = self
        self.searchTF.returnKeyType = .search
        self.searchTF.delegate = self
        mediaTV.estimatedRowHeight = 150
        mediaTV.rowHeight = UITableView.automaticDimension
        mediaTV.isHidden = true
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("Music \u{25BE}", for: .normal)
        button.addTarget(self, action: #selector(self.clickOnButton), for: .touchUpInside)
        self.navigationItem.titleView = button
        mediaType = .Music
        
    }
    func fetchData(offset: Int){
        fetching = true
        if searchTF.text! == ""{
            fetching = false
            self.mediaTV.isHidden = true
            return
        }
        if offset == 0 {
            self.startAnimating(nil, message: "", messageFont: nil, type: .lineScale, color: #colorLiteral(red: 0, green: 0.5607843137, blue: 0.8235294118, alpha: 1), padding: 0.0, displayTimeThreshold: 0, minimumDisplayTime: 0, backgroundColor: UIColor.clear, textColor: UIColor.clear, fadeInAnimation: nil)
        }
        viewModel.fetchMediaData(term: searchTF.text!, media: mediaType.rawValue, offset: offset, limit: limit, successHandler: { (response) in
            self.countOfMedia = response
            self.fetching = false
            self.totalOfMedia = self.viewModel.numberOfMediaInSection()
            if self.totalOfMedia > 0{
                self.bears.isHidden = true
                self.mediaTV.isHidden = false
                self.mediaTV.reloadData()
            }else{
                self.bears.isHidden = false
                self.mediaTV.isHidden = true
                self.adviceLbl.text = "There is no Media. Try with another term... "
                self.bears.image = #imageLiteral(resourceName: "sadBears")
            }
            self.bottomTable.constant = 0
            self.stopAnimating()
            self.loadMoreIndicator.stopAnimating()
            UIView.animate(withDuration: 0.5) {
                self.loadMoreIndicator.alpha = 0
                self.view.layoutIfNeeded()
            }
        }) { (error) in
            self.fetching = false
            self.bottomTable.constant = 0
            self.stopAnimating()
            self.loadMoreIndicator.stopAnimating()
            UIView.animate(withDuration: 0.5) {
                self.loadMoreIndicator.alpha = 0
                self.view.layoutIfNeeded()
            }
            self.showAlert(title: "Error", msg: error)
        }
        
    }
    @objc func clickOnButton(sender: UIButton){
        
        let alert = UIAlertController(title: "Filter", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Music", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("Music \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "music")
            self.fetchData(offset: 0)
        }))
        
        alert.addAction(UIAlertAction(title: "TV Show", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("TV Show \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "tvShow")
            self.fetchData(offset: 0)
        }))
        
        alert.addAction(UIAlertAction(title: "Movie", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("Movie \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "movie")
            self.fetchData(offset: 0)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    @IBAction func search(sender: UIBarButtonItem){
        
        if searching{
            self.heightOfSearch.constant = 0
            self.topTable.constant = 0
            UIView.animate(withDuration: 0.5) {
                self.searchView.alpha = 0
                self.view.layoutIfNeeded()
            }
            self.view.endEditing(true)

        }else{
            self.heightOfSearch.constant = 41
            self.topTable.constant = 23
            UIView.animate(withDuration: 0.5) {
                self.searchView.alpha = 1
                self.view.layoutIfNeeded()
            }
            self.searchTF.becomeFirstResponder()
        }

        searching = !searching
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let pvc = segue.destination as! PreviewVC
        pvc.url = sender as! String
        pvc.mediaType = mediaType
        
    }
    

}

extension MainListVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalOfMedia
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellAtIndexPath(tableView: tableView,indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = viewModel.selectedPreviewAtIndexPath(indexPath: indexPath)
        if url != ""{
            self.performSegue(withIdentifier: "SeguePreview", sender: url)
        }else{
            self.showAlert(title: "Ops!", msg: "This \(mediaType.rawValue) doesn't have a Preview.")
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == totalOfMedia && !fetching && countOfMedia == limit {
            fetchData(offset: totalOfMedia)
            self.bottomTable.constant = 40
            self.loadMoreIndicator.startAnimating()
            UIView.animate(withDuration: 0.5) {
                self.loadMoreIndicator.alpha = 1
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension MainListVC: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            self.view.endEditing(true)
            fetchData(offset: 0)
        }
        return true
    }
    
}
