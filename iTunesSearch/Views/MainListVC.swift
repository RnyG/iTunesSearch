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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure(){
        viewModel = MainListVM()
        mediaTV.delegate = self
        mediaTV.dataSource = self
        self.searchTF.returnKeyType = .search
        self.searchTF.delegate = self
        mediaTV.estimatedRowHeight = 150
        mediaTV.rowHeight = UITableView.automaticDimension
        viewModel.fetchMediaData(term: "jack", media: "movie", offset: 0, limit: 2, successHandler: { (response) in
  
            self.mediaTV.reloadData()
        }) { (error) in
        }
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
