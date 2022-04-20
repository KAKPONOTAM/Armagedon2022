import Foundation

struct Meters: Decodable {
    let asteroidMaximalDiameter: Double
    
    enum CodingKeys: String, CodingKey {
        case asteroidMaximalDiameter = "estimated_diameter_max"
    }
}
