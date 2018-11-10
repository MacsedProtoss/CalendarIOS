//
//  ToDoListViewController.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/7.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit



class ToDoListViewController: UITableViewController {

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.darkGray
        //data.
        self.tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 50
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnAction))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        return button
    }()
    
    @objc func addBtnAction (){
        let alertController = UIAlertController(title: "New Event", message: "Type things below", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "Event & Detail"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
            let thing = alertController.textFields!.first!
            saveThings(things: "\(String(describing: thing.text))", currentday: currentDay, index: getNumOfThings()+1)
            })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.thingLabel.text = getThings(currentday: currentDay, index: indexPath.row+1)
        cell.backgroundColor = UIColor.lightGray
        cell.setupSubViews()
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = getNumOfThings()
        return num
    }
    
    
}
