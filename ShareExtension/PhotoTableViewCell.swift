//
//  PhotoTableViewCell.swift
//  ShareExtension
//
//  Created by Marcin Jackowski on 15/08/2017.
//  Copyright © 2017 Marcin Jackowski. All rights reserved.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func set(data:  Data) {
        photoImageView.image = UIImage(data: data)
    }
}
