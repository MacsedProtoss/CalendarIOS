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
    
    
    let checkBox :UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        //button.setImage(UIImage.init(imageLiteralResourceName: "check"), for: .normal)
        //button.setImage(UIImage.init(imageLiteralResourceName: "round_check"), for: .highlighted)
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.isEnabled = true
        return button
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
        addSubview(checkBox)
        checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        checkBox.widthAnchor.constraint(equalToConstant: 50).isActive = true
        checkBox.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkBox.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addSubview(thingLabel)
        thingLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 10).isActive = true
        thingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        thingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
