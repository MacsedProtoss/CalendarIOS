//
//  CollectionView.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/5.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit

class CalendarCollectionView : UIView,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MonthViewDelegate {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let layoutCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    func setupLayout (){
        addSubview(layoutCollectionView)
        layoutCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        layoutCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        layoutCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        layoutCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        layoutCollectionView.delegate = self
        layoutCollectionView.dataSource = self
        layoutCollectionView.register(CalendarCustomCell.self, forCellWithReuseIdentifier: "CalendarCell")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfDaysInEachMonth[currentMonthIndex]+firstWeekDayOfMonth-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCustomCell
        cell.backgroundColor = UIColor.clear
        cell.setupLayout()
        if indexPath.item <= firstWeekDayOfMonth-2 {
            cell.isHidden = true
        }else{
            let  cellDate = indexPath.row - firstWeekDayOfMonth + 2
            cell.isHidden = false
            cell.label.text = "\(cellDate)"
            if cellDate < dateOfToday && currentMonthIndex == presentMonthIndex && currentYear == presentYear {
                cell.isUserInteractionEnabled = false
                cell.label.textColor = UIColor.lightGray
            }else{
                cell.isUserInteractionEnabled = true
                cell.label.textColor = UIColor.white
            }
        }
        
        cell.setupLayout()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
        let label = cell?.subviews[1] as! UILabel
        label.textColor=UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor=UIColor.clear
        let label = cell?.subviews[1] as! UILabel
        label.textColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/7-8
        let height : CGFloat = 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        firstWeekDayOfMonth = getFirstWeekDayOfMonth()
        layoutCollectionView.reloadData()
    }
    
    
}

