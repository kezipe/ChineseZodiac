import Foundation

public enum ChineseZodiac: Int, CaseIterable, Zodiac {
    case rat
    case ox
    case tiger
    case rabbit
    case dragon
    case snake
    case horse
    case goat
    case monkey
    case rooster
    case dog
    case pig
}

extension ChineseZodiac: CustomStringConvertible {
    public var description: String {
        switch self {
        case .rat: return "Rat"
        case .ox: return "Ox"
        case .tiger: return "Tiger"
        case .rabbit: return "Rabbit"
        case .dragon: return "Dragon"
        case .snake: return "Snake"
        case .horse: return "Horse"
        case .goat: return "Goat"
        case .monkey: return "Monkey"
        case .rooster: return "Rooster"
        case .dog: return "Dog"
        case .pig: return "Pig"
        }
    }
}
