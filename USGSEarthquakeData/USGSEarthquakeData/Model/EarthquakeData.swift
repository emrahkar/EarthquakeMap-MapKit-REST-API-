//
//  EarthquakeData.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 1.11.2022.
//

import Foundation
import SwiftUI

struct EarthquakeData: Codable {
    
    let earthquakes: [Earthquake]
    
    enum CodingKeys: String, CodingKey {
        case earthquakes = "features"
    }
}


struct Earthquake: Identifiable, Codable, Equatable {
  
    var id: String
    let properties: Property
    let geometry: Geometry
    
    static func == (lhs: Earthquake, rhs: Earthquake) -> Bool {
        lhs.id == rhs.id
    }
}


struct Property: Codable {
    
    let mag: Double
    let location: String
    let magType: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case mag
        case location = "place"
        case magType
        case title
        case url
    }
}


struct Geometry: Codable {
    
    let coordinates: [Double]
    
}
