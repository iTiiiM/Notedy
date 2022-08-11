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
        
        title = "Activity List"
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.") }
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemBackground]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImformationTableViewCell.identifer, for: indexPath) as? ImformationTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(item: activities?[indexPath.row])
        return cell
    }
    
    func loadData(){
        activities = realm.objects(Activity.self)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listToEditActivity", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let destinationVC = segue.destination as! EditActivityViewController
            destinationVC.selectedActivity = activities?[indexPath.row]
        }
    }
    
    
    @IBAction func addActivity(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "listToNewActivity", sender: self)
    }
}
