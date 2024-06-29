//
//  EarthquakesService.swift
//  Earthquakes
//
//


import Foundation

// EarthquakesService
class EarthquakesService {
    var urlSession = URLSession.shared

    func fetchEarthquakes(completion: @escaping ([Earthquake], Error?) -> Void) {
        let url = URL(string: "https://barfooz.net/earthquakes")!
        let urlRequest = URLRequest(url: url)
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion([], error)
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let earthquakeResponse = try jsonDecoder.decode(EarthquakeResponse.self, from: data)
                let earthquakes = earthquakeResponse.features.map { Earthquake(from: $0) }
                completion(earthquakes, nil)
            } catch {
                completion([], error)
            }
        }
        .resume()
    }

    func fetchEarthquakeDetails(forId id: String, completion: @escaping (Earthquake?, Error?) -> Void) {
        let url = URL(string: "https://barfooz.net/earthquakes/\(id)")!
        let urlRequest = URLRequest(url: url)
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let feature = try jsonDecoder.decode(Feature.self, from: data)
                let earthquake = Earthquake(from: feature)
                completion(earthquake, nil)
            } catch {
                completion(nil, error)
            }
        }
        .resume()
    }
}

//import Foundation
//
//class EarthquakesService {
//    var urlSession = URLSession.shared
//
//    func fetchEarthquakes(completion: @escaping ([Earthquake], Error?) -> Void) {
//        let url = URL(string: "https://barfooz.net/earthquakes")!
//        let urlRequest = URLRequest(url: url)
//        urlSession.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {
//                completion([], error)
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                let features = json?["features"] as? [[String: Any]]
//                let earthquakes = features?.compactMap { Earthquake(json: $0) } ?? []
//                completion(earthquakes, nil)
//            } catch {
//                completion([], error)
//            }
//        }
//        .resume()
//    }
//
//    func fetchEarthquakeDetails(forId id: String, completion: @escaping (Earthquake?, Error?) -> Void) {
//        let url = URL(string: "https://barfooz.net/earthquakes/\(id)")!
//        let urlRequest = URLRequest(url: url)
//        urlSession.dataTask(with: urlRequest) { data, response, error in
//            guard let data = data else {
//                completion(nil, error)
//                return
//            }
//
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                    throw NSError(domain: "JSONSerialization", code: -1, userInfo: nil)
//                }
//
//                let earthquake = Earthquake(json: json)
//                completion(earthquake, nil)
//            } catch {
//                completion(nil, error)
//            }
//        }
//        .resume()
//    }
//}
