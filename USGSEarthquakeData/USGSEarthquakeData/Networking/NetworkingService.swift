//
//  NetworkingService.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 1.11.2022.
//

import Foundation

struct NetworkingService {
    
    func fetchEarthquakeData(url: URL?, completionHandler: @escaping(_ earthquakeData: EarthquakeData?, _ error: NetworkingError?) -> ()) {
        
        guard let url = url else{
            let error = NetworkingError.badURL
            completionHandler(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completionHandler(nil, NetworkingError.badURL)
            } else if let response = response as? HTTPURLResponse, !(response.statusCode >= 200 && response.statusCode < 300) {
                completionHandler(nil, NetworkingError.badURLResponse(url: url))
                print(response.statusCode)
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let earthquakeData = try decoder.decode(EarthquakeData.self, from: data)
                    completionHandler(earthquakeData, nil)
                } catch  {
                    completionHandler(nil, NetworkingError.unknown)
                    print(error)
                }
            }
        }
        task.resume()
    }
}
