//
//  ViewController.swift
//  My Tasks App tr
//
//  Created by Muhammad Elbagoury on 1/20/19.
//  Copyright © 2019 Developers2Be. All rights reserved.
//

import UIKit
import UserNotifications

class TasksViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tasksTable: UITableView!
    @IBOutlet weak var searchTxt: UITextField!
    
    var savedTasks = [Tasks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateUI()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { (approved, error) in
            if approved {
                print("Approved!!!")
            }
        }
    }
    
    func updateUI() {
        
        title = "My Tasks App"
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tasksTable.register(nib, forCellReuseIdentifier: tasksCellID)
        tasksTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        savedTasks = CoreDataHandler.getDataFromCoreData() ?? []
        tasksTable.reloadData()
    }
    
    @IBAction func textingInTxtBegin(_ sender: UITextField) {
        
        (sender.text?.isEmpty ?? false) ? (savedTasks = CoreDataHandler.getDataFromCoreData() ?? []) : (savedTasks = CoreDataHandler.getSpecificItemFromCoreData(itemName: searchTxt.text ?? "") ?? [])
        
        tasksTable.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tasksCellID, for: indexPath) as? TableViewCell else {
            print("Can not find the cell")
            return UITableViewCell()
        }
        cell.configureCell(task: savedTasks[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            savedTasks = CoreDataHandler.deleteObjectFromCoreData(task: savedTasks[indexPath.row]) ?? []
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.savedTasks = CoreDataHandler.deleteObjectFromCoreData(task: self.savedTasks[indexPath.row]) ?? []
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let moreAction = UITableViewRowAction(style: .default, title: "More") { (rowAction, indexPath) in
            
            let optionsMenu = UIAlertController(title: nil, message: "Choose an Option", preferredStyle: .actionSheet)
            
//            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
//                self.savedTasks = CoreDataHandler.deleteObjectFromCoreData(task: self.savedTasks[indexPath.row]) ?? []
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
                optionsMenu.dismiss(animated: true, completion: nil)
            })
        
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                self.performSegue(withIdentifier: "ToEdit", sender: self.savedTasks[indexPath.row])
            })
            
            optionsMenu.addAction(cancelAction)
            optionsMenu.addAction(editAction)
            self.present(optionsMenu, animated: true, completion: nil)
            
        }
        moreAction.backgroundColor = UIColor.gray
        return [deleteAction, moreAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToEdit" {
            let secondVC = segue.destination as? AddTaskViewController
            secondVC?.taskInfo = sender as? Tasks
            
        }
    }
    
    
    
    
    
    
    
    
    
}

