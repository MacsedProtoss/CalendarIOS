//
//  CustomCell.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/5.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//









import UIKit
class CalendarCustomCell : UICollectionViewCell{
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
    }
    
    let label : UILabel = {
        let lbl = UILabel()
        lbl.text = "00"
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.white
        lbl.backgroundColor = UIColor.clear
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    let notificateImage : UIImageView = {
        let Image = UIImageView()
        Image.translatesAutoresizingMaskIntoConstraints = false
        //Image.image = UIImage.init(imageLiteralResourceName: "dot")
        return Image
    }()
    
    func setupLayout (){
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        addSubview(notificateImage)
        notificateImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        notificateImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        notificateImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        notificateImage.widthAnchor.constraint(equalTo: notificateImage.heightAnchor).isActive = true
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
