import Foundation

enum AlertsTitle {
    case askForAction
    case messageDescription
    case congrats
    case congratsDescription
    case ok
    case cancel
    
    var title: String {
        switch self {
        case .askForAction:
            return "Вы уверены что хотите отправить бригаду на уничтожение?"
        case .messageDescription:
            return "данное действие отправит бригаду Брюса Уиллиса на астероид и уничтожит его"
        case .congrats:
            return "Поздравляю!"
        case .congratsDescription:
            return "Бригада Брюса Уиллиса скоро будет доставлена на выбранные астероиды"
        case .ok:
            return "Ok"
        case .cancel:
            return "Cancel"
        }
    }
}
