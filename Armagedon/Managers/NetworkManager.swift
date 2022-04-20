import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var currentRequestDay = Date()
    var dayToRequest: String {
        return currentRequestDay.getDistanceCorrectFormat("yyyy-MM-dd")
    }
    
    private init() {}
    
    func sendRequestAboutAsteroid(completion: @escaping (AsteroidData) -> ()) {
        let urlString = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(dayToRequest)&end_date=\(dayToRequest)&api_key=eKTvGzcwezwDnNA502odiYMTgrTkQI0UulcWadld"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil,
               let data = data {
                do {
                    let asteroidData = try JSONDecoder().decode(AsteroidData.self, from: data)
                    DispatchQueue.main.async {
                        completion(asteroidData)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}
