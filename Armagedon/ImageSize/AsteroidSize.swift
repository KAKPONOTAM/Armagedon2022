import Foundation
import UIKit

enum AsteroidSize {
    case small
    case medium
    case big
    
    static func size(for diameter: Int) -> AsteroidSize {
        switch diameter {
        case 0...80:
            return .small
        case 81...200:
            return .medium
            
        default:
            return big
        }
    }
    
    var asteroidImage: UIImage {
        switch self {
        case .small:
            guard let smallAsteroidImage = UIImage(named: "small") else { return UIImage() }
            return smallAsteroidImage
        case .medium:
            guard let mediumAsteroidImage = UIImage(named: "medium") else { return UIImage() }
            return mediumAsteroidImage
        case .big:
            guard let bigAsteroidImage = UIImage(named: "big") else { return UIImage() }
            return bigAsteroidImage
        }
    }
}
