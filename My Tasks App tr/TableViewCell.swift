//
//  TableViewCell.swift
//  My Tasks App tr
//
//  Created by Muhammad Elbagoury on 1/20/19.
//  Copyright © 2019 Developers2Be. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDescLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(task: Tasks) {
        taskNameLabel.text = task.taskName
        taskDescLabel.text = task.taskDesc
        taskDateLabel.text = ((task.taskDate) ?? Date()).convertDateToString(format: dateFormat)
        //let dateString = dateFormatter.string(from: (task.taskDate ?? Date() as NSDate) as Date)
    }
    
}
