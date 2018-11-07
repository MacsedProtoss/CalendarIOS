//
//  WeekView.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/5.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit

class WeekDayView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
        
        setupLayout()
    }
    
    
    let weekStackView : UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    func setupLayout (){
        for i in 0...6{
            let label = UILabel()
            label.text = weekDays[i]
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.clear
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            weekStackView.addArrangedSubview(label)
        }
        addSubview(weekStackView)
        weekStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        weekStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weekStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        weekStackView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

