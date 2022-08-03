//
//  ListViewController.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 29/7/2565 BE.
//

import UIKit
import RealmSwift

class ListActivityViewController: UITableViewController {

    var activities: Results<Activity>?
    
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        
        navBar.tintColor = .systemBackground
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemBackground]
        
        loadData()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        if let items = activities?[indexPath.row]{
            cell.textLabel?.text = items.title
        } else{
            cell.textLabel?.text = "Add some activity that you thinking about."
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func loadData(){
        
        activities = realm.objects(Activity.self)
        
        tableView.reloadData()
        
    }
    
    func deleteData(at indexPath: IndexPath){
        if let selectedItem = activities?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(selectedItem)
                    tableView.reloadData()
                }
            } catch {
                print("Error delete data. \(error)")
            }
        }
    }
    
    
    @IBAction func newActivity(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "listToNewActivity", sender: self)
    }
}
