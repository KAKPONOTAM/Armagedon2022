import Foundation

extension Date {
    static func changeAsteroidApproachDateFormat(approachDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: approachDate) else { return "" }
        dateFormatter.locale = NSLocale(localeIdentifier: "ru_Ru") as Locale
        dateFormatter.dateFormat = "d MMMM yyy"
        
        return dateFormatter.string(from: date)
    }

    func getDistanceCorrectFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
