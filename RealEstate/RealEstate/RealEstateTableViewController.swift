//
//  RealEstateTableViewController.swift
//  RealEstate
//
//  Created by HM on 11/1/16.
//  Copyright © 2016 MyLabSolutions. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let kRealEstateCellIdentifier = "RealEstateCell"

class RealEstateTableViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapButton: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let realEstateViewModelHelper = RealEstateViewModelHelper()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        self.title = "Real Estate"
        self.emptyLabel.isHidden = true;
        
        self.setupTableView()
        self.setupTableViewDataSource()
    }
    
    private func setupTableView()
    {
        let nibName = UINib(nibName: kRealEstateCellIdentifier, bundle:nil)
        self.tableView.register(nibName, forCellReuseIdentifier: kRealEstateCellIdentifier)
        
        self.tableView.estimatedRowHeight = 180;
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    private func setupTableViewDataSource()
    {
        let realEstateItems = realEstateViewModelHelper.fetchRealEstateItems().asDriver(onErrorJustReturn: [])
        
        realEstateItems
            .drive(tableView.rx.items(cellIdentifier: kRealEstateCellIdentifier, cellType: RealEstateCell.self)) {
                tableView, realEstateViewModel, cell in
                
                self.stopAnimating()//TO DO: Need to do this based on the api fetch activity

                cell.realEstateViewModel = realEstateViewModel
            }
            .addDisposableTo(disposeBag)
        

        realEstateItems
            .map { $0.count != 0 }
            .drive(self.emptyLabel.rx.isHidden)
            .addDisposableTo(disposeBag)

    }
    
    private func stopAnimating()
    {
        if(self.activityIndicator.isAnimating)
        {
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func showMapView()
    {
        let controller = (self.storyboard?.instantiateViewController(withIdentifier: "RealEstateMapViewController"))! as! RealEstateMapViewController
        controller.realEstateItems = realEstateViewModelHelper.realEstateViewModelItems
        let navController = UINavigationController.init(rootViewController: controller)
        self.present(navController, animated: true, completion: nil)
    }
}
