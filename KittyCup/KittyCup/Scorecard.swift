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

enum Club {
    case driver
    case threewood
    case fivewood
    case hybrid
    case fiveiron
    case sixiron
    case seveniron
    case eightiron
    case nineiron
    case pitchingwedge
    case gapwedge
    case sandwedge
    case lobwedge
    case putter
}

// BasicPlayerHoleData is collected for all players, whereas more
// detailed data is collected only for "you" (the user)
// The fields in BasicPlayerHoleData are just what's needed to
// calculate kitty points
class BasicPlayerHoleData : NSObject, NSCoding {
    var score : Int
    var puttCount : Int
    var sandShotCount : Int    // For greenside bunkers only.
    var upAndDown: Bool?       // Set to nil for n/a, meaning no up&down opportunity for this hole
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.score, forKey:"score")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

}

class DetailedPlayerHoleData: NSObject, NSCoding {
    var fairwayHit : Bool?     // Optional because only applies to par 4 and par 5 holes
    var penatltyStrokeCount : Int
    var teeShotClubUsed : Club
    var teeShotPushFlag : Bool
    var teeShotPullFlag : Bool
    var teeShotHookFlag : Bool
    var teeShotFatFlag : Bool
    var teeShotThinFlag : Bool
    var notes : String?
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.penatltyStrokeCount, forKey:"penaltyStrokeCount")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

}

class PlayerHoleData : NSObject, NSCoding {
    var basicData : BasicPlayerHoleData
    var detailedData : DetailedPlayerHoleData?
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.basicData, forKey:"basicData")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

}

class ScoreCardRow : NSObject, NSCoding {
    var playerName: String
    var playerHoleData : [PlayerHoleData]
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.playerName, forKey:"playerName")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }

}

class Scorecard : NSObject, NSCoding {
    
    
    var date : Date
    var course : GolfCourse
    var rows : [ScoreCardRow]
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.date, forKey:"date")
        aCoder.encode(self.course, forKey: "course")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
} 
 
