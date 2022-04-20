import Foundation

struct NearEarthObjects: Decodable {
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachData]
    let name: String 
    let asteroidEstimatedDiameter: EstimatedDiameters
    
    enum CodingKeys: String, CodingKey {
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case name
        case closeApproachData = "close_approach_data"
        case asteroidEstimatedDiameter = "estimated_diameter"
    }
}
