//
//  ToDoListViewController.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/7.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit



class ToDoListViewController: UITableViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.darkGray
        //data.
        self.tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 50
        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBtnAction))
        self.navigationItem.rightBarButtonItem = addBtn
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        refreshController.addTarget(self, action: #selector(addNew), for: UIControl.Event.valueChanged)
        
        let customView : UIView = {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 50)
            view.backgroundColor = UIColor.darkGray
            return view
        }()
        
        customView.addSubview(customLabel)
        customLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor).isActive = true
        customLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor).isActive = true
        customLabel.topAnchor.constraint(equalTo: customView.topAnchor).isActive = true
        customLabel.heightAnchor.constraint(equalTo: customView.heightAnchor).isActive = true
        
        //refreshController.addSubview(customView)
        self.tableView.addSubview(refreshController)
        
        
        leftGesture.direction = .left
        view.addGestureRecognizer(leftGesture)
        
        
        
       // addLongPressFunc()
    }
    
    
    let refreshController = UIRefreshControl()
    
    
    let customLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.text = "Add New"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    
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
            
            self.animateTable(state: "add")
            })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
        
    }
    
    
    //func addLongPressFunc (){
    //    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longpressed(sender:)))
    //    self.tableView.addGestureRecognizer(longPress)
    //}
 
    /*
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
    */
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TaskCell") as! TaskCell
        cell.thingLabel.text = getThings(currentday: currentDay, index: indexPath.row+1)
        let state = getState(index: indexPath.row+1)
        if state == "DONE" {
            cell.stateLabel.text = "DONE"
            cell.stateLabel.textColor = lightBlueColor
        }else{
            cell.stateLabel.text = "UNDO"
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
    
    
    
    
    
    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction:UITableViewRowAction = UITableViewRowAction(style: .destructive, title: "DELETE", handler: {(action, indexPath) in
            deleteThing(index : indexPath.row + 1)
            self.tableView.reloadData()})
        let undoAction:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "UNDO", handler: {(action, indexPath) in
            changeState(index: indexPath.row + 1)
            self.tableView.reloadData()})
        let doneAction:UITableViewRowAction = UITableViewRowAction(style: .normal, title: "DONE", handler: {(action, indexPath) in
            changeState(index : indexPath.row + 1)
            self.tableView.reloadData()})
        
        let currentState = getState(index: indexPath.row+1)
        if currentState == "DONE" {
            return [undoAction,deleteAction]
        }else{
            return [doneAction,deleteAction]
        }
        
    }
   */
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        let deleteAction:UIContextualAction = UIContextualAction(style: .destructive, title: "DELETE") { (action, sourceView, completionHandler) in
            deleteThing(index : indexPath.row + 1)
            self.tableView.reloadData()
            completionHandler(true)
        }
        let doAction:UIContextualAction = UIContextualAction(style: .normal, title: "DONE") { (action, sourceView, completionHandler) in
            changeState(index: indexPath.row + 1)
            self.tableView.reloadData()
        }
        doAction.backgroundColor = UIColor.blue
        //let cancelAction:UIContextualAction = UIContextualAction(style: .normal, title: "CANCEL") { (action, sourceView, /completionHandler) in
        //}
        
        let currentState = getState(index: indexPath.row+1)
        if currentState == "DONE" {
            doAction.title = "UNDO"
        }else{
            doAction.title = "DONE"
        }
        
        let actions : [UIContextualAction] = [deleteAction,doAction]
        let action:UISwipeActionsConfiguration = UISwipeActionsConfiguration(actions: actions)
        action.performsFirstActionWithFullSwipe = true
        return action
        
    }
    
    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
////        let transition = Rectangle()
////
////        transition.transitionMode = .dismiss
////        transition.rectangleColor = UIColor.lightGray
////        transition.startingPoint = startPoint
////
////        return transition
//
//        print("\(navigationController) \(operation.rawValue)")
//        let transition = CircularTransition()
//        if operation == .push {
//            transition.transitionMode = .present
//            transition.circleColor = UIColor.lightGray
//            transition.startingPoint = startPoint
//            print("\(transition.transitionMode)")
//            return transition
//        }else if operation == .pop {
//            let transition = CircularTransition()
//            transition.transitionMode = .dismiss
//            transition.circleColor = UIColor.lightGray
//            transition.startingPoint = startPoint
//            print("\(transition.transitionMode)")
//            return transition
//        }
//        return nil
//    }
//
    
    func animateTable(state:String) {
        if state == "normal"{
            self.tableView.reloadData()
            let cells = self.tableView.visibleCells
            let tableHeight: CGFloat = self.tableView.bounds.size.height
            for (index, cell) in cells.enumerated() {
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
                
                UIView.animate(withDuration: 1.0, delay: 0.1 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);}, completion: nil)
                
            }
        }else if state == "add" {
            
            self.tableView.reloadData()
            let cells = self.tableView.visibleCells
            let tableHeight: CGFloat = self.tableView.bounds.size.height
            
            var count = 0
            for (_, _) in cells.enumerated() {
                count += 1
            }
            
            for (index, cell) in cells.enumerated() {
                if index == count-1 {
                    cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
                
                    UIView.animate(withDuration: 1.0, delay: 0.0 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);}, completion: nil)
                
                }
            }
            
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateTable(state: "normal")
    }
    
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if (sender.direction == .left) {
            //monthview.buttonTouchRespond(sender: monthview.NextMonthButton)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    @objc func addNew (){
        addBtnAction()
        self.refreshController.endRefreshing()
        self.tableView.reloadData()
    }
    
    
}
