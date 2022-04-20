import Foundation

struct AsteroidData: Decodable {
    let nearEarthObjects: [String: [NearEarthObjects]]
    
    enum CodingKeys: String, CodingKey {
        case nearEarthObjects = "near_earth_objects"
    }
}
