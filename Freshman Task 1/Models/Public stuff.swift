//
//  Public stuff.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/7.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import Foundation
import UIKit

//PublicData

var currentYear :Int = 0
var currentMonthIndex : Int = 0
var presentYear:Int = 0
var presentMonthIndex:Int = 0
var months = ["Jan","Feb","March","April","May","June","July","Aug","Sept","Oct","Nov","Dec"]
var weekDays = ["Mon","Tues","Wed","Thur","Fri","Sat","Sun"]
var firstWeekDayOfMonth: Int = 0
var numOfDaysInEachMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
var dateOfToday : Int = 0
var currentDay : Int = 0

struct thingsOfDay {
    var year : Int?
    var month : Int?
    var day : Int?
    var doHaveThing : Bool?
}






//PublicData End⬆️

//DataSaveLocal


func getUUID () -> String{
    let userid = UserDefaults.standard.string(forKey: "Macsed")
    if(userid != nil){
        return userid!
    }else{
        let uuidRef = CFUUIDCreate(nil)
        let uuidStringRef = CFUUIDCreateString(nil, uuidRef)
        let uuid = uuidStringRef as! String
        UserDefaults.standard.set(uuid, forKey: "Macsed")
        return uuid
    }
}

func saveThings (things : String , currentday : Int , index : Int) {
    let userDefault = UserDefaults.standard
    userDefault.set(things, forKey: "\(currentYear)-\(currentMonthIndex)-\(currentday)-\(index)")
    let numOfThings = userDefault.integer(forKey: "\(currentYear)-\(currentMonthIndex)-\(currentday)")
    userDefault.set(numOfThings+1, forKey: "\(currentYear)-\(currentMonthIndex)-\(currentday)")
}

func getThings (currentday : Int , index : Int) -> String {
    let userDefault = UserDefaults.standard
    let things = userDefault.string(forKey: "\(currentYear)-\(currentMonthIndex)-\(currentday)-\(index)")
    return things!
}

func getNumOfThings () ->Int {
    let userDefault = UserDefaults.standard
    let numOfThings = userDefault.integer(forKey: "\(currentYear)-\(currentMonthIndex)-\(currentDay)")
    return numOfThings
}









//DataSaveLocal End





//PublicFuncs
func InitTime (){
    presentYear = Calendar.current.component(.year, from: Date())
    presentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    currentYear = presentYear
    currentMonthIndex=presentMonthIndex
    dateOfToday = Calendar.current.component(.day, from: Date())
    firstWeekDayOfMonth = getFirstWeekDayOfMonth()
    
}



func getFirstWeekDayOfMonth() -> Int {
    let day = ("\(currentYear)-\(currentMonthIndex+1)-01".date?.firstDayOfTheMonth.weekday)! - 1
    return day
}

func changeMonth(step : Int){
    if (step==1){
        currentMonthIndex += 1
        if currentMonthIndex > 11 {
            currentMonthIndex = 0
            currentYear += 1
        }
    }else{
        currentMonthIndex -= 1
        if currentMonthIndex < 0 {
            currentMonthIndex = 11
            currentYear -= 1
        }
    }
    
    
}

//PublicFuncs End





//Extensions
extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var firstDayOfTheMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
    }
}

extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var date: Date? {
        return String.dateFormatter.date(from: self)
    }
}

//Extensions End

