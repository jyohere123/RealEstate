//
//  FavoritesManager.swift
//  RealEstate
//
//  Created by HM on 11/5/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import Foundation

protocol FavoritesDelegate
{
    func favoriteItemWithID (id : Int)
    func unFavoriteItemWithID (id : Int)
    func isFavoriteItem (id: Int) -> Bool
}

// This class uses NSUserDefaults for saving favorites
// The implementation can be moved to Core Data later for efficiency.

class FavoritesManager: NSObject, FavoritesDelegate
{
    private let kFavoritesKey = "favorites"
    static let sharedManager: FavoritesManager = FavoritesManager()

    private override init()
    {
    
    }

    private func favoriteItems() -> Array<Int>?
    {
        let defaults = UserDefaults()
        let favoritesArray = defaults.object(forKey: kFavoritesKey);
    
        return favoritesArray as! Array<Int>?;
    }
    
    private func saveFavoriteItems(favoriteItems: Array<Int>)
    {
        let defaults = UserDefaults()
        defaults.set(favoriteItems, forKey: kFavoritesKey)
        defaults.synchronize()
    }
    
    // Mark - FavoritesDelegate Implementation
    
    func favoriteItemWithID(id : Int)
    {
       if var favoriteItems = self.favoriteItems()
       {
            favoriteItems.append(id)
            saveFavoriteItems(favoriteItems: favoriteItems)
        }
        else
       {
            var favoriteIems = Array<Int>()
            favoriteIems.append(id)
            saveFavoriteItems(favoriteItems: favoriteIems)
        }
    }
    
    func unFavoriteItemWithID(id : Int)
    {
        if var favoriteItems = self.favoriteItems()
        {
            if let index = favoriteItems.index(of: id)
            {
                favoriteItems.remove(at: index)
                saveFavoriteItems(favoriteItems: favoriteItems)
            }
        }
    }
    
    func isFavoriteItem(id: Int) -> Bool
    {
        var isFavorite = false;
        
        if let favoriteItems = self.favoriteItems()
        {
            if let _ = favoriteItems.index(of: id)
            {
                isFavorite  = true
            }
        }
     
        return isFavorite
    }
    
}
