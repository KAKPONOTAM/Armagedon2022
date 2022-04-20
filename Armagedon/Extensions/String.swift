import Foundation
extension String {
    func distanceToEarthChangeValueFormat(distance: Self) -> Self {
        var separator = ""
        if distance.contains(".") { separator = "." }
        if distance.contains(",") { separator = "," }
        
        guard let tempNum = distance.filter({ $0 != " " }).components(separatedBy: separator).first else { return "" }
        var num: [Character] = [Character](tempNum).reversed()
        
        for i in (0..<num.count).reversed() {
            if i % 3 == 0 && i != 0 {
                num.insert(" ", at: i)
            }
        }
        
        return String(num.reversed())
    }
    
    var changeAsteroidNameFormat: Self {
        var filtered = self.filter { $0 != "(" && $0 != ")" }.components(separatedBy: " ")
        
        if filtered.count > 2 {
            filtered.removeFirst()
        }
        
        return filtered.joined(separator: " ")
    }
    
    var removeFractional: Self {
        let mainPart = self.components(separatedBy: ".").first
        return mainPart ?? self
    }
    
    var localized: Self {
           return NSLocalizedString(self, comment: "")
       }
}
