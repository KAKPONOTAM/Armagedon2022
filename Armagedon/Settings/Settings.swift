import Foundation

enum Settings: String, CaseIterable {
    case unitOfMeasure
    case isDangerous
    
    var title: String {
        switch self {
        case .unitOfMeasure:
            return "Ед.изм.расстояний"
            
        case .isDangerous:
            return "Показывать только опасные"
        }
    }
    
    static func numberOfRowsInSection() -> Int {
        return allCases.count
    }
    
    static func getRow(atIndex index: Int) -> Settings {
        return allCases[index]
    }
}
