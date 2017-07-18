import Foundation

public class Helper {
    public static func match(person1: Int, person2: Int) -> Int {
        let match = [[2,6,2,6,6,3,1,4,5,1,5,5],
                     [6,2,1,5,1,6,1,1,2,6,5,4],
                     [2,1,1,2,6,1,6,3,1,5,5,6],
                     [6,5,2,2,2,1,2,6,6,1,6,6],
                     [6,1,6,2,3,6,2,1,5,5,1,3],
                     [3,6,1,1,6,1,3,1,3,6,2,1],
                     [1,1,6,2,2,3,1,6,2,1,2,5],
                     [4,1,3,6,1,1,6,5,5,2,1,6],
                     [5,6,1,6,5,3,2,5,3,2,5,1],
                     [1,6,5,1,5,6,1,2,2,1,1,2],
                     [5,2,5,6,1,2,2,1,5,1,2,5],
                     [5,4,6,6,3,1,5,6,1,2,5,3]]
        return match[person1 - 1][person2 - 1]
    }
    
    public static func getZodiac(fromIndex: Int) -> String {
        let zodiac = [1:"Rat", 2:"Ox", 3:"Tiger", 4:"Rabbit", 5:"Dragon", 6:"Snake", 7:"Horse", 8:"Goat", 9:"Monkey", 10:"Rooster", 11:"Dog", 12:"Pig"]
        return zodiac[fromIndex]!
    }
}
