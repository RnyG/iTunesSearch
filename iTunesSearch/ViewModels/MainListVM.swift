//
//  MainListVM.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import Kingfisher

class MainListVM: NSObject {
    
    var media: Array<Media> = []
    //var musicFiltered: Array<media> = []
    var mediaType: MediaType!
    var total = 0
    private let mediaCellIdentifier = "mediaCell"
    
    func fetchMediaData(term: String, media: String, offset: Int, limit: Int, successHandler:@escaping(Int) -> Void, errorHandler:@escaping(String) -> Void){
        
        mediaType = MediaType(rawValue: media)
        Network.getMedia(term: term,media: media, offset: offset, limit: limit, success: { (results,total) in
            self.total = total
            if offset == 0 || self.mediaType.rawValue != media{
                self.media = []
            }
            self.media += results
            
            successHandler(total)
        }, error: { (error) in
            errorHandler("Ha ocurrido un error obteniendo el contenido")
        }) { (error) in
            errorHandler(error.errorDescription ?? "No se pudo conectar con el servidor")
        }
    }
    
    func numberOfMediaInSection() -> Int{
        return self.media.count
    }
    
    func cellAtIndexPath(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mediaCellIdentifier, for: indexPath)
        
        let artWork = cell.viewWithTag(1) as! UIImageView
        let trackName = cell.viewWithTag(2) as! UILabel
        let artistName = cell.viewWithTag(3) as! UILabel
        let longDescription = cell.viewWithTag(4) as! UILabel
        
        let media = mediaAtIndexPath(indexPath: indexPath)
        
        let url = URL(string: media.artworkUrl100 ?? "")
        artWork.kf.setImage(with: url)
        artWork.layer.cornerRadius = 16
        
        trackName.text = media.trackName ?? ""
       
        artistName.text = mediaType != .Movie ? media.artistName : ""
        
        longDescription.text = mediaType != .Music ? media.longDescription : ""
        
        return cell
    }
    
    func mediaAtIndexPath(indexPath: IndexPath) -> Media{
        
        return media[indexPath.row]
        
    }
    
    func selectedMediaAtIndexPath(indexPath: IndexPath) -> Media{
        
        return media[indexPath.row]
    }
    
}
