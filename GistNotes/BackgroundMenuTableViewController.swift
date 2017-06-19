//
//  backgroundMenuTableViewController.swift
//  gratis
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import UIKit

class BackgroundMenuTableViewController: UITableViewController {

    var menu = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menu = ["Gists", "Notes", "All in one"]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = menu[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuName = menu[indexPath.row]
        
        if menuName == "Gists" {
            
            let layout = UICollectionViewFlowLayout()
            let navigationController = UINavigationController(rootViewController: GistsViewController(collectionViewLayout: layout))
            
            self.revealViewController().pushFrontViewController(navigationController, animated: true)
        
        }
        else if menuName == "Notes" {
        
            let layout = UICollectionViewFlowLayout()
            let gistsVC = GistsViewController(collectionViewLayout: layout)
            gistsVC.onlyWithNotes = true
            let navigationController = UINavigationController(rootViewController: gistsVC)
            
            self.revealViewController().pushFrontViewController(navigationController, animated: true)
            
        }
        
        else if menuName == "All in one" {
            
            
            let icon1 = UITabBarItem(title: "", image: UIImage(named: "gist"), tag: 0)
            icon1.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

            let icon2 = UITabBarItem(title: "", image: UIImage(named: "notes"), tag: 1)
            icon2.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            
            let layout1 = UICollectionViewFlowLayout()
            
            let gistsVC = GistsViewController(collectionViewLayout: layout1)
            let navigationController1 = UINavigationController(rootViewController: gistsVC)
            
            let layout2 = UICollectionViewFlowLayout()

            let gistsWithNotesVC = GistsViewController(collectionViewLayout: layout2)
            gistsWithNotesVC.onlyWithNotes = true
            let navigationController2 = UINavigationController(rootViewController: gistsWithNotesVC)

            
            let tabBarVC = UITabBarController()
            tabBarVC.viewControllers = [navigationController1, navigationController2];
            
            navigationController1.tabBarItem = icon1
            navigationController2.tabBarItem = icon2
            
            self.revealViewController().pushFrontViewController(tabBarVC, animated: true)
        }

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
