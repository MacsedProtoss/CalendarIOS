//
//  ViewController.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/4.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor=UIColor.darkGray
        setupViews()
        
    }
    
    let monthview : MonthView = {
        let temp = MonthView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    let weekdayview : WeekDayView = {
        let temp = WeekDayView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    let collectionView : CalendarCollectionView = {
        let temp = CalendarCollectionView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    
    
    
    func setupViews(){
        
        view.addSubview(monthview)
        monthview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        monthview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        monthview.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive=true
        monthview.heightAnchor.constraint(equalToConstant: 50).isActive=true
        monthview.delegate = collectionView
        
        view.addSubview(weekdayview)
        weekdayview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        weekdayview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
        weekdayview.topAnchor.constraint(equalTo: monthview.bottomAnchor).isActive=true
        weekdayview.heightAnchor.constraint(equalToConstant: 50).isActive=true
        
        InitTime()
        monthview.monthLabel.text = "\(months[presentMonthIndex])  \(presentYear)"
        
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: weekdayview.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }

}

