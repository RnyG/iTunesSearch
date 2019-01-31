//
//  PreviewVC.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 31/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import UIKit
import VersaPlayer

class PreviewVC: UIViewController {

    @IBOutlet weak var playerView: VersaPlayerView!
    @IBOutlet weak var controls: VersaPlayerControls!
    @IBOutlet weak var panda: UIImageView!
    
    var url = ""
    var mediaType: MediaType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.use(controls: controls)
        if let url = URL.init(string: url) {
            let item = VersaPlayerItem(url: url)
            playerView.set(item: item)
        }
        if mediaType == .Music{
            playerView.controls!.behaviour!.shouldHideControls = false
            playerView.backgroundColor = .clear
            panda.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playerView.pause()
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
