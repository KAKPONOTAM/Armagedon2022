import Foundation

class TrashManager {
    static let shared = TrashManager()
    private init() {}
    var onDeleteAsteroidArray = [NearEarthObjects]()
}
