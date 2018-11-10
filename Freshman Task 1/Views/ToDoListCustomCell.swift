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
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = UIColor.clear
        label.text = "DOING"
        label.textColor = UIColor.red
        return label
    }()
    
    let thingLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.text = "default"
        return label
    }()
    
    func setupSubViews(){
        addSubview(stateLabel)
        stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stateLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
        stateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        stateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addSubview(thingLabel)
        thingLabel.leadingAnchor.constraint(equalTo: stateLabel.trailingAnchor, constant: 10).isActive = true
        thingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        thingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    
    
    
}
