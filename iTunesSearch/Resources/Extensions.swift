//
//  Extensions.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 28/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func cleanNav(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
