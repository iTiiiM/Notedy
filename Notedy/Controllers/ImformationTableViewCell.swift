//
//  ActivityTableViewCell.swift
//  Notedy
//
//  Created by Nuntapat Hirunnattee on 4/8/2565 BE.
//

import UIKit

class ImformationTableViewCell: UITableViewCell {

    static let identifer = "listCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: Activity?) {
        if let item = item {
            titleLabel.text = item.title
            timeLabel.text = item.time
            dateTime.text = item.date
            locationLabel.text = item.location.isEmpty ?  "No location": item.location
            detailLabel.text = item.detail.isEmpty ? "No detail" : item.detail
        } else {
            textLabel?.text = "No activity."
        }
    }

}
