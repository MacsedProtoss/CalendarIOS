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
        addLongPressFunc()
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
            saveThings(things: "\(thing.text ?? "")", currentday: currentDay, index: getNumOfThings()+1)
            self.tableView.reloadData()
            })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
        
    }
    
    func addLongPressFunc (){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpressed(sender:)))
        self.tableView.addGestureRecognizer(longPress)
    }
    
    
    @objc func longpressed (sender : UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let pressPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: pressPoint){
                let alertController = UIAlertController(title: "Operating this Event", message: "Delete operation can't be undo", preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {ACTION in
                    deleteThing(index : indexPath.row + 1)
                    self.tableView.reloadData()
                })
                let doneAction = UIAlertAction(title: "Done", style: .default, handler: {ACTION in
                    changeState(index : indexPath.row + 1)
                    self.tableView.reloadData()
                })
                let doingAction = UIAlertAction(title: "Doing", style: .default, handler: {ACTION in
                    changeState(index: indexPath.row + 1)
                    self.tableView.reloadData()
                })
                alertController.addAction(cancelAction)
                alertController.addAction(deleteAction)
                
                let currentState = getState(index: indexPath.row+1)
                if currentState == "DONE" {
                    alertController.addAction(doingAction)
                }else{
                    alertController.addAction(doneAction)
                }
                
                self.present(alertController,animated: true,completion: nil)
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.thingLabel.text = getThings(currentday: currentDay, index: indexPath.row+1)
        let state = getState(index: indexPath.row+1)
        if state == "DONE" {
            cell.stateLabel.text = "DONE"
            cell.stateLabel.textColor = UIColor.blue
        }else{
            cell.stateLabel.text = "DOING"
            cell.stateLabel.textColor = UIColor.red
        }
        cell.backgroundColor = UIColor.lightGray
        cell.setupSubViews()
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = getNumOfThings()
        return num
    }
    
    
    
    
    
    
    
}
