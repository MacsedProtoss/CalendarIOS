//
//  MonthView.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/5.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import Foundation
import UIKit

protocol MonthViewDelegate: class {
    
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthView : UIView {
    var delegate: MonthViewDelegate?
    
    let PrevMonthButton :UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.gray, for: .disabled)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTouchRespond(sender:)), for: .touchUpInside)
        return button
    }()
    
    let NextMonthButton :UIButton = {
        let button = UIButton()
        button.setTitle(">", for: .normal)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTouchRespond(sender:)), for: .touchUpInside)
        return button
    }()
    
    let monthLabel : UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    func setupLayout (){
        
        self.addSubview(PrevMonthButton)
        PrevMonthButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        PrevMonthButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        PrevMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        PrevMonthButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(NextMonthButton)
        NextMonthButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        NextMonthButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        NextMonthButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        NextMonthButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        self.addSubview(monthLabel)
        monthLabel.leadingAnchor.constraint(equalTo: PrevMonthButton.trailingAnchor).isActive = true
        monthLabel.trailingAnchor.constraint(equalTo: NextMonthButton.leadingAnchor).isActive = true
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        monthLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        PrevMonthButton.isEnabled = false
    }
    
    @objc func buttonTouchRespond (sender: UIButton){
        if sender == NextMonthButton{
            changeMonth(step:1)
        }else{
            changeMonth(step:0)
        }
        monthLabel.text = "\(months[currentMonthIndex])  \(currentYear)"
        PrevMonthButton.isEnabled = currentMonthIndex>presentMonthIndex && currentYear==presentYear || currentYear > presentYear
        self.delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
