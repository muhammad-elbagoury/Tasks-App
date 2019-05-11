//
//  AddTaskViewController.swift
//  My Tasks App tr
//
//  Created by Muhammad Elbagoury on 1/20/19.
//  Copyright © 2019 Developers2Be. All rights reserved.
//

import UIKit
import UserNotifications

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskNameTxt: UITextField!
    @IBOutlet weak var taskDescTxt: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    
    var taskInfo: Tasks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Task"

        // Do any additional setup after loading the view.
        
        taskNameTxt.text = taskInfo.taskName ?? ""
        taskDescTxt.text = taskInfo.taskDesc ?? ""
        taskDatePicker.date = ((taskInfo.taskDate) ?? Date())
    }
    
    @IBAction func doneBtnTapped(_ sender: UIBarButtonItem) {
        
        let task = Tasks(context: CoreDataHandler.getCoreDataObject())
        task.taskName = taskNameTxt.text
        task.taskDesc = taskDescTxt.text
        task.taskDate = taskDatePicker.date
        
        giveAlertForTask()
        
        CoreDataHandler.saveIntoCoreData(taskItem: task)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func giveAlertForTask() {
        
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = taskNameTxt.text ?? ""
        content.body = taskDescTxt.text ?? ""
        content.badge = 1
        
        
//        let dateComponents = taskDatePicker.calendar.dateComponents([.day, .month, .year], from: taskDatePicker.date)
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "N1", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                print("Notification appeared")
            }
        }
        
    }
    



}
