//
//  ListViewController.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 29/7/2565 BE.
//

import UIKit

class ListActivityViewController: UITableViewController {

    
    var todoList = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        
        navBar.tintColor = .systemBackground
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemBackground]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    @IBAction func newActivity(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "listToNewActivity", sender: self)
    }
    
}
