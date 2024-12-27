//
//  DashbordCollectionViewCell.swift
//  TeamLedger Hub
//
//  Created by ucf 2 on 23/12/2024.
//

import UIKit

class DashbordCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var cView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //     viewShadow(view: curveView)
        
        // Set up shadow properties
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4.0
        layer.masksToBounds = false
        
        // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed
        
        
    }
}
