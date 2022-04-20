import Foundation

class SettingsButtonsStatements: Codable {
    var isDangerous: Bool
    var selectedIndex: Int
    
    init(isDangerous: Bool, selectedIndex: Int) {
        self.isDangerous = isDangerous
        self.selectedIndex = selectedIndex
    }
    
    enum CodingKeys: CodingKey {
        case isDangerous
        case selectedIndex
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isDangerous, forKey: .isDangerous)
        try container.encode(selectedIndex, forKey: .selectedIndex)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isDangerous = try container.decode(Bool.self, forKey: .isDangerous)
        selectedIndex = try container.decode(Int.self, forKey: .selectedIndex)
    }
}
