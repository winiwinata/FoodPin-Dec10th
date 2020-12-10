//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2020/11/5.
//  Copyright © 2020 NDHU_CSIE. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!
    
    var restaurant = Restaurant()

    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
                    
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
        cell.iconImageView.image = UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        cell.shortTextLabel.text = restaurant.phone
        cell.selectionStyle = .none
                    
        return cell
        case 1:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
        cell.iconImageView.image = UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        cell.shortTextLabel.text = restaurant.location
        cell.selectionStyle = .none
                    
        return cell
        case 2:
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
        cell.descriptionLabel.text = restaurant.description
        cell.selectionStyle = .none
        
        return cell
         
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailSeparatorCell.self), for: indexPath) as! RestaurantDetailSeparatorCell
            cell.titleLabel.text = "HOW TO GET HERE"
            cell.selectionStyle = .none
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            cell.selectionStyle = .none
            cell.configure(location: restaurant.location)
            
            return cell
            
        default:
        fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    
    // MARK: - Table view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        // Configure header view
        headerView.nameLabel.text = restaurant.name
        headerView.typeLabel.text = restaurant.type
        headerView.headerImageView.image = UIImage(named: restaurant.image)
        headerView.heartImageView.isHidden = (restaurant.isVisited) ? false : true
        
        headerView.ratingImageView.image = UIImage(named: restaurant.rating)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
        else if segue.identifier == "showReview"{
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        }
        
    }
    @IBAction func close(segue: UIStoryboardSegue)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            self.restaurant.rating = rating
            self.headerView.ratingImageView.image = UIImage(named: rating)
        }
        
        dismiss(animated: true, completion: nil)
    }

    

}
