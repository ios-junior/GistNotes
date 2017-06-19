//
//  GistsViewController.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//
import CoreData
import UIKit

class GistsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var gists = [Gist]()
    
    let urlGists = "https://api.github.com/gists/public"
    let cellId = "cell"
    let refreshControl = UIRefreshControl()
    var onlyWithNotes = false
    
    
    func fetchGists() {
    
        let url = URL(string: urlGists)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error ) in
            
            if error != nil {
                print(error!)
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for gistInfo in json as! [[String: AnyObject]] {
                    Gist.createGist(gistInfo)
                }
            
                
                if self.onlyWithNotes {
                    self.gists = Gist.fetchGistForNote()
                }
                else {
                    self.gists = Gist.fetchGist()
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
                
            catch let jsonError {
                print(jsonError)
            }
            
            
            
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchGists()
        
        navigationItem.title = "Gists"
        let leftItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self.revealViewController(), action: #selector(self.revealViewController().revealToggle(_:)))
            
        navigationItem.leftBarButtonItem = leftItem
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        collectionView?.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        collectionView?.register(GistCell.self, forCellWithReuseIdentifier: "cell")
        
        
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(actionRefresh(_:)), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
        collectionView!.alwaysBounceVertical = true
        
    }
    
    func actionRefresh(_: Any) {
        
        print("refresh")
        fetchGists()
        refreshControl.endRefreshing()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> GistCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GistCell
        cell.navigationController = navigationController
        cell.gist = gists[indexPath.item]
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        let gistViewController = GistViewController()
        gistViewController.gist = gists[indexPath.item]
        navigationController?.pushViewController(gistViewController, animated: true)
        
    }


}
