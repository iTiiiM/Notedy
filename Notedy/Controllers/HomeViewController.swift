//
//  ViewController.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 29/7/2565 BE.
//

import UIKit

class HomeViewController: UIViewController {
    let appName = "Follow your think with your notedy."
    @IBOutlet weak var titleName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleName.text = ""
        var index = 0.0
        for letter in appName{
            Timer.scheduledTimer(withTimeInterval: 0.2 * index, repeats: false) { (timer) in
                self.titleName.text?.append(letter)
            }
            index += 1
        }
    }
}

