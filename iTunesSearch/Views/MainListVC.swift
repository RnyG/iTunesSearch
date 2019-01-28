//
//  MainListVC.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import UIKit

class MainListVC: UIViewController {

    @IBOutlet weak var mediaTV: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var heightOfSearch: NSLayoutConstraint!
    @IBOutlet weak var topTable: NSLayoutConstraint!
    
    private var viewModel: MainListVM!
    var mediaType: MediaType!
    var searching = false
    
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
        let button =  UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("Music \u{25BE}", for: .normal)
        button.addTarget(self, action: #selector(self.clickOnButton), for: .touchUpInside)
        self.navigationItem.titleView = button
        mediaType = .Music
        fetchData()
        
    }
    func fetchData(){
        viewModel.fetchMediaData(term: "jack", media: mediaType.rawValue, offset: 0, limit: 2, successHandler: { (response) in
            
            self.mediaTV.reloadData()
        }) { (error) in
        }
    }
    @objc func clickOnButton(sender: UIButton){
        
        let alert = UIAlertController(title: "Filter", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Music", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("Music \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "music")
            self.fetchData()
        }))
        
        alert.addAction(UIAlertAction(title: "TV Show", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("TV Show \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "tvShow")
            self.fetchData()
        }))
        
        alert.addAction(UIAlertAction(title: "Movie", style: .default , handler:{ (UIAlertAction)in
            sender.setTitle("Movie \u{25BE}", for: .normal)
            self.navigationItem.titleView = sender
            self.mediaType = MediaType(rawValue: "movie")
            self.fetchData()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            
        })
        
    }
    @IBAction func search(sender: UIBarButtonItem){
        
        self.heightOfSearch.constant = searching ? 0:41
        self.topTable.constant = searching ? 23:0
        
        UIView.animate(withDuration: 0.5) {
            self.searchView.alpha = self.searching ? 0:1
            self.view.layoutIfNeeded()
        }
        searching = !searching
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainListVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMediaInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellAtIndexPath(tableView: tableView,indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MainListVC: UITextFieldDelegate{
    
    
}
