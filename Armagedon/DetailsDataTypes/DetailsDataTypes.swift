import Foundation

enum DetailsDataTypes: CaseIterable {
    case kilometersPerHour
    case milesPerHour
    case kilometersPerSecond
    case closeApproachData
    case exactApproachData
    case metersDiameter
    case milesDiameter
    case feetDiameter
    case kmDistanceToEarth
    case lunarDistanceToEarth
    case isDangerous
    case orbitingBody
    
    static func getNumberOfRows() -> Int {
        return allCases.count
    }
    
    static func getRow(index: Int) -> DetailsDataTypes {
        return allCases[index]
    }
    
    var title: String {
        switch self {
        case .kilometersPerHour:
            return "Скорость в км/ч"
        case .milesPerHour:
            return "Скорость в ми/с"
        case .kilometersPerSecond:
            return "Скорость в км/с"
        case .closeApproachData:
            return "Подлетает"
        case .exactApproachData:
            return "Дата макс. сближения"
        case .kmDistanceToEarth:
            return "На расстоянии(км)"
        case .lunarDistanceToEarth:
            return "На расстоянии(л.орб.)"
        case .milesDiameter:
            return "Диаметр(мили)"
        case .feetDiameter:
            return "Диаметр(фут.)"
        case .metersDiameter:
            return "Диаметр(м)"
        case .isDangerous:
            return "Оценка"
        case .orbitingBody:
            return "По орбите"
        }
    }
    
    func getValue(from nearObjectData: NearEarthObjects) -> String {
        guard let firstObject = nearObjectData.closeApproachData.first else { return ""}
        
        let approachDateCorrectFormat = Date.changeAsteroidApproachDateFormat(approachDate: firstObject.asteroidApproachCloseData)
        let metersDiameter = nearObjectData.asteroidEstimatedDiameter.meters.asteroidMaximalDiameter
        let milesDiameter = nearObjectData.asteroidEstimatedDiameter.miles.asteroidMaximalDiameter.rounded(toPlaces: 2)
        let feetDiameter = Int(nearObjectData.asteroidEstimatedDiameter.feet.asteroidMaximalDiameter)
        let kilometersPerSecond = firstObject.relativeVelocity.kilometersPerSecond.removeFractional
        let kilometersPeHour = firstObject.relativeVelocity.kilometersPerHour.removeFractional
        let milesPerHour = firstObject.relativeVelocity.milesPerHour.removeFractional
        let kmDistanceToEarth = firstObject.distanceToEarth.kilometers.removeFractional
        let kmDistanceCorrectFormate = kmDistanceToEarth.distanceToEarthChangeValueFormat(distance: kmDistanceToEarth)
        let exactApproachData = firstObject.asteroidExactTimeApproachData
        let lunarDistanceToEarth = firstObject.distanceToEarth.lunar.removeFractional
        let orbitingBody = firstObject.orbitingBody
        
        switch self {
        case .kilometersPerHour:
            return kilometersPeHour
        case .milesPerHour:
            return milesPerHour
        case .kilometersPerSecond:
            return kilometersPerSecond
        case .closeApproachData:
            return approachDateCorrectFormat
        case .exactApproachData:
            return exactApproachData
        case .metersDiameter:
            return String(metersDiameter).removeFractional
        case .milesDiameter:
            return String(milesDiameter)
        case .feetDiameter:
            return String(feetDiameter)
        case .kmDistanceToEarth:
            return kmDistanceCorrectFormate
        case .lunarDistanceToEarth:
            return lunarDistanceToEarth
        case .orbitingBody:
            return orbitingBody.localized
        case .isDangerous:
            return nearObjectData.isPotentiallyHazardousAsteroid ? "опасен" : "не опасен"
        }
    }
}
