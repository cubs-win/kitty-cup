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
    let numHoles : Int
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
        self.numHoles = holeParValues.count
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
    
    // TODO: Replace this w/ the ability to download course info from the cloud
    class func createHardCodedCourses() {
        GolfCourse.createCoursesDirectory()
        var courseName = "Naperbrook"
        var filename = GolfCourse.coursesDirectory() + courseName + kCourseExtension
        
         let naperbrookHoleParValues = [4, 4, 5, 3, 4, 4, 5, 3, 4, 4, 4, 3, 4, 5, 3, 4, 4, 5]
         var course = GolfCourse(courseName, naperbrookHoleParValues)
         
         print("Persisting course info to file: \(filename)")
         var succ = NSKeyedArchiver.archiveRootObject(course, toFile: filename)
         print("Archive status: Naperbrook: \(succ)")
        
        courseName = "Village Links 18 Hole"
        filename = GolfCourse.coursesDirectory() + courseName + kCourseExtension
        let vlogeParValues = [4, 5, 3, 4, 4, 5, 4, 3, 4, 4, 3, 4, 4, 4, 5, 5, 3, 4]
        course = GolfCourse(courseName, vlogeParValues)
        print ("Persisting course info to file: \(filename)")
        succ = NSKeyedArchiver.archiveRootObject(course, toFile: filename)
        print("Archive status: Village Links 18-Hole Course: \(succ)")
        
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
    var holePar : Int
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
    
    public init(holePar par : Int) {
        holePar = par
        score =  par
        puttCount = 2
        sandShotCount = 0
        upAndDown=nil
        super.init()
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
    
    public required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public override init() {
        penatltyStrokeCount = 0
        teeShotClubUsed = .driver
        teeShotPullFlag = false
        teeShotPushFlag = false
        teeShotHookFlag = false
        teeShotFatFlag = false
        teeShotThinFlag = false
        super.init()
    }
    
}

class PlayerHoleData : NSObject, NSCoding {
    var isBlank : Bool
    var basicData : BasicPlayerHoleData
    var detailedData : DetailedPlayerHoleData?
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.basicData, forKey:"basicData")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public init(withDetail detailFlag : Bool, andHolePar parValue : Int) {
        isBlank = true
        basicData = BasicPlayerHoleData(holePar: parValue)
        if (true == detailFlag) {
            detailedData = DetailedPlayerHoleData()
        } else {
            detailedData = nil
        }
    }

}

class ScoreCardRow : NSObject, NSCoding {
    var playerName: String
    var includeDetailedData : Bool
    var playerHoleData : [PlayerHoleData]
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.playerName, forKey:"playerName")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    public init(playerName name : String, numHoles holeCount : Int, includeDetail detailFlag : Bool, holeParValues parValues : [Int]) {
        playerName = name
        includeDetailedData = detailFlag
        playerHoleData = [PlayerHoleData]()
        for i in 0..<holeCount {
            playerHoleData.append(PlayerHoleData(withDetail: includeDetailedData, andHolePar: parValues[i]))
        }
    }

}

public class Scorecard : NSObject, NSCoding {
    
    
    var date : Date
    var course : GolfCourse
    var rows : [ScoreCardRow]
    
    public var numPlayers : Int {
        get {
            return rows.count
        }
    }
    
    
        
    // Memberwise initializer
    public init?(courseName : String, playerNames : [String]) {
        GolfCourse.createHardCodedCourses()
        if let aCourse = GolfCourse.load(courseName) {
            course = aCourse
            date = Date()
            rows = [ScoreCardRow]()
            if (playerNames.count < 1 || playerNames.count > 4) {
                print("Error - must initialize ScoreCard with 1-4 players.")
                return nil
            }
            var idx = 0
            // This is sloppy but for now I'm just going to assume
            // that the player at index 0 (which is always present since minimum of 1 player)
            // will use detailed per-hole data, all others will not.
            for player in playerNames {
                if (0 == idx) {
                    rows.append(ScoreCardRow(playerName:player, numHoles:aCourse.numHoles, includeDetail: true, holeParValues: aCourse.holeParValues))
                } else {
                    rows.append(ScoreCardRow(playerName:player, numHoles:aCourse.numHoles, includeDetail: false, holeParValues: aCourse.holeParValues))
                }
                idx += 1
            }
            print("Scorecard init OK")
        } else {
            print("Error, can't load course named \(courseName)")
            return  nil
        }
    }
    
    func isValidHoleNumber(_ holeNumber : Int) -> Bool {
        if (holeNumber < 1 || holeNumber > course.numHoles) {
            return false
        }
        return true
    }
    
    func isValidPlayerIndex(_ playerIndex : Int) -> Bool {
        if (playerIndex < 0 || playerIndex >= self.numPlayers) {
            return false;
        }
        return true;
    }
    
    public func parValue(forHole holeNumber : Int) -> Int? {
        if (!isValidHoleNumber(holeNumber)) {
            return nil
        }
        return course.holeParValues[holeNumber-1]
    }
    
    public func setBlankFlag(forHole holeNumber: Int, forPlayer playerIndex : Int, toValue flag : Bool) {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            self.rows[playerIndex].playerHoleData[holeNumber-1].isBlank = flag
        }
    }
    
    
    public func setScore(forHole holeNumber: Int, forPlayer playerIndex : Int, toValue value : Int) {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.score = value
        }
    }
    
    public func getScore(forHole holeNumber: Int, forPlayer playerIndex: Int) -> Int? {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            if (self.rows[playerIndex].playerHoleData[holeNumber-1].isBlank) {
                return nil;
            }
            return self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.score;
        }
        return nil;
    }
    
    public func setPuttCount(forHole holeNumber: Int, forPlayer playerIndex : Int, toValue value : Int) {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.puttCount = value
        }
    }
    
    public func getPuttCount(forHole holeNumber: Int, forPlayer playerIndex: Int) -> Int? {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            if (self.rows[playerIndex].playerHoleData[holeNumber-1].isBlank) {
                return nil;
            }
            return self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.puttCount;
        }
        return nil;
    }

    
    public func setSandShotCount(forHole holeNumber: Int, forPlayer playerIndex : Int, toValue value : Int) {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.sandShotCount = value
        }
    }
    
    public func getSandShotCount(forHole holeNumber: Int, forPlayer playerIndex: Int) -> Int? {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            if (self.rows[playerIndex].playerHoleData[holeNumber-1].isBlank) {
                return nil;
            }
            return self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.sandShotCount;
        }
        return nil;
    }

    
    public func setUpAndDown(forHole holeNumber: Int, forPlayer playerIndex : Int, toValue value : Bool?) {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.upAndDown = value
        }
        
    }
    
    public func getUpAndDown(forHole holeNumber: Int, forPlayer playerIndex: Int) -> Bool? {
        if (isValidHoleNumber(holeNumber) && isValidPlayerIndex(playerIndex)) {
            if (self.rows[playerIndex].playerHoleData[holeNumber-1].isBlank) {
                return nil;
            }
            return self.rows[playerIndex].playerHoleData[holeNumber-1].basicData.upAndDown;
        }
        return nil;
    }


    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.date, forKey:"date")
        aCoder.encode(self.course, forKey: "course")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    
} 
 
