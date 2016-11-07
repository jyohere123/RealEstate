//
//  RealEstateCell.swift
//  RealEstate
//
//  Created by HM on 11/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import UIKit
import SDWebImage

class RealEstateCell: UITableViewCell
{
    @IBOutlet weak var realEstateImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var realEstateViewModel : RealEstateViewModel?
    {
        didSet
        {
            self.titleLabel.text = realEstateViewModel?.title
            self.addressLabel.text = realEstateViewModel?.address
            self.priceLabel.text = (realEstateViewModel?.price)!
            self.favoriteButton.isSelected = favoritesDelegate.isFavoriteItem(id: (realEstateViewModel?.id)!)
            
            realEstateImageView.sd_setImage(with: NSURL(string: (realEstateViewModel?.imageURL)!) as URL!,
                                            placeholderImage: UIImage(named:"placeholder.png"));
        }
    }
    
    private var favoritesDelegate : FavoritesDelegate
    {
        return FavoritesManager.sharedManager //Can be replaced with any other implementation of FavoritesManager later
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
        self.containerView.layer.shadowOpacity = 0.2
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton)
    {
        if(!sender.isSelected)
        {
            favoritesDelegate.favoriteItemWithID(id: (self.realEstateViewModel?.id)!)
        }
        else
        {
            favoritesDelegate.unFavoriteItemWithID(id: (self.realEstateViewModel?.id)!)
        }
        
        sender.isSelected = !sender.isSelected
    }
}
