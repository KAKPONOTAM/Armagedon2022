import Foundation

struct CloseApproachData: Decodable {
    let asteroidApproachCloseData: String
    let distanceToEarth: DistanceToEarth
    let orbitingBody: String
    let asteroidExactTimeApproachData: String
    let unixTimeApproachCloseData: Int
    let relativeVelocity: RelativeVelocity
    
    enum CodingKeys: String, CodingKey {
        case asteroidApproachCloseData = "close_approach_date"
        case distanceToEarth = "miss_distance"
        case orbitingBody = "orbiting_body"
        case asteroidExactTimeApproachData = "close_approach_date_full"
        case unixTimeApproachCloseData = "epoch_date_close_approach"
        case relativeVelocity = "relative_velocity"
    }
}
