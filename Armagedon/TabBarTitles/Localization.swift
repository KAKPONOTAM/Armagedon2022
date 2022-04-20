import Foundation

enum Localization: String {
    case destroy
    case asteroid
    case armageddon
    case filter
    case detailed
    case back
    case done
    
    var title: String {
        switch self {
        case .destroy:
            return "Уничтожение"
        case .asteroid:
            return "Астероиды"
        case .armageddon:
            return "Армагеддон 2022"
        case .filter:
            return "Фильтр"
        case.detailed:
            return "Подробная информация"
        case .back:
            return "Назад"
        case .done:
            return "Применить"
        }
    }
}
