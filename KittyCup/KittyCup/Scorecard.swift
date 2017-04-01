//
//  Scorecard.swift
//  KittyCup
//
//  Created by Scott Kuhn on 4/1/17.
//  Copyright © 2017 kuhn. All rights reserved.
//

import Foundation

let kCoursesDirectory = "Courses"
let kCourseExtension = ".kittycupcourse"

class GolfCourse : NSObject, NSCoding {
    
    var name : String
    var holeParValues : [Int]  // Hole 1 stored at index 0
    
    /* 
     TODO:
       Hole by hole yardages from each set of tees
       Slope / rating for each set of tees
       Hole handicap for each set of tees
    */
    class func coursesDirectory() -> String {
        // TODO: Don't use hard coded path separators, use the file manager to help
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentsPath + "/" + kCoursesDirectory + "/"
    }
    
    class func createCoursesDirectory() {
        do {
            try FileManager.default.createDirectory(atPath: GolfCourse.coursesDirectory(), withIntermediateDirectories: true, attributes: nil)
            print("W00t: Created courses directory.")
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
    }

    func dumpToConsole() {
        print("-------------")
        print("Course: \(self.name)")
        for i in 0..<holeParValues.count {
            print("Hole: \(i+1) Par: \(self.holeParValues[i])")
        }
        print("-------------")
    }
    
    // Memberwise initializer
    init(_ name : String, _ holeParValues : [Int]) {
        self.name = name
        self.holeParValues = holeParValues
    }
    
    public func encode(with aCoder: NSCoder) {
        print("GolfCourse Encode IN for \(self.name)")
        aCoder.encode(self.name, forKey:"name")
        aCoder.encode(self.holeParValues, forKey:"holeParValues")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObject(forKey: "name") as? String,
            let holeParValues = aDecoder.decodeObject(forKey:"holeParValues") as? [Int]
        else {return nil}
        
        self.init(name, holeParValues)
    }
    
    class func load(_ name : String) -> GolfCourse? {
        let filename = GolfCourse.coursesDirectory() + name + kCourseExtension
        let course = NSKeyedUnarchiver.unarchiveObject(withFile: filename) as? GolfCourse
        return course

    }
}

/*
class Scorecard : NSObject, NSCoding {
    
    
    var date : Date
    var course : GolfCourse
    
    
    
    
    
    public func encode(with aCoder: NSCoder) {
        
    }
    
    public required init?(coder aDecoder: NSCoder) {

    }
} 
 */
