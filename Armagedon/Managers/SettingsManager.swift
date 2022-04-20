import Foundation
import UIKit

class SettingsManager {
    static let shared = SettingsManager()
    
    private init() {}
    
    func saveSettingsButtonsStatement(settingsButtonsStatements: SettingsButtonsStatements) {
        UserDefaults.standard.setValue(encodable: settingsButtonsStatements, forKey: UserDefaultsKeys.settings.rawValue)
    }
    
    func receiveSettingsButtonsStatement() -> SettingsButtonsStatements? {
        guard let model = UserDefaults.standard.loadValue(SettingsButtonsStatements.self, forKey: UserDefaultsKeys.settings.rawValue) else { return nil }
        return model
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.settings.rawValue)
    }
}
