import Foundation

enum DistanceFormat: Int, CaseIterable {
    case kilometers
    case lunar
    
    var distanceFormat: String {
        switch self {
        case .lunar:
            return "л.орб."
        case .kilometers:
            return "км"
        }
    }
    
    static func getFormat(atIndex index: Int) -> DistanceFormat {
        return self.allCases[index]
    }
}
