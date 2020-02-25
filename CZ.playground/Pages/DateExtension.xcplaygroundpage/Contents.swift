import Foundation


let a_date = Date()

print(a_date.getStemBranch())

extension Date {
    func getStemBranch() -> String {
        let dateFormatter = DateFormatter()
        let chinese = Calendar(identifier: Calendar.Identifier.chinese)
        dateFormatter.calendar = chinese
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.dateStyle = .long
        let formattedDate = dateFormatter.string(from: self)
        
        // Isolate for Year and Stem Branch
        let comma: Character = ","
        let pos: Int?
        if let idx = formattedDate.characters.index(of: comma) {
            pos = formattedDate.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos = 0
        }
        let index = formattedDate.index(formattedDate.startIndex, offsetBy: pos! + 2)
        let yearWithStemBranch = formattedDate[index...]
        
        // Year with Stem Branch separated:
        let leftBracket: Character = "("
        let pos2: Int?
        if let idx = yearWithStemBranch.characters.index(of: leftBracket) {
            pos2 = yearWithStemBranch.characters.distance(from: formattedDate.startIndex, to: idx)
        }
        else {
            print("Not found")
            pos2 = 0
        }
        let index2 = yearWithStemBranch.index(formattedDate.startIndex, offsetBy: pos2!)
        let stemBranchWithBrackets = yearWithStemBranch[index2...]
        let range = stemBranchWithBrackets.index(stemBranchWithBrackets.startIndex, offsetBy: 1)..<stemBranchWithBrackets.index(stemBranchWithBrackets.endIndex, offsetBy: -1)
        let stemBranch = stemBranchWithBrackets[range]

        return String(stemBranch)
    }
}
