//
//  ToDoListCustomCell.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/7.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit

protocol checkBoxdelegate {
    func checkBox (state :Bool , index :Int?)
}

class TaskCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let checkBox :UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    
}
