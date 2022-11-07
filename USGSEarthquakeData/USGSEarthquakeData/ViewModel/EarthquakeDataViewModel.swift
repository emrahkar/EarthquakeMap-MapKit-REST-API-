//
//  EarthquakeDataViewModel.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 1.11.2022.
//

import Foundation
import MapKit
import SwiftUI

class EarthquakeDataViewModel: ObservableObject {
    
    @Published var earthquakeData = EarthquakeData(earthquakes: [Earthquake]())
    @Published var mapEarthquakeRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var showAllEarthquakes: Bool = false
    @Published var earthquakeOnMap:Earthquake {
        didSet {
            updateMapEarthquakeRegion(earthquake: earthquakeOnMap)
        }
    }
    @Published var loading: Bool = false
    @Published var errorMsg: String? = nil

    let earthquakeDataLoader = NetworkingService()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    let detailedMapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    init() {
     
        
        self.earthquakeOnMap = Earthquake(id: "us7000im5c",
                                          properties: Property(mag: 4.9, location: "28 km S of Coalcomán de Vázquez Pallares, Mexico", magType: "mb", title: "M 4.7 - 28 km S of Coalcomán de Vázquez Pallares, Mexico", url: "https://earthquake.usgs.gov/earthquakes/eventpage/us7000im4p"),
                                          geometry: Geometry(coordinates: [-103.1235, 18.5182, 65.227]))
        self.updateMapEarthquakeRegion(earthquake: Earthquake(id: "us7000im5c",
                                                              properties: Property(mag: 4.9, location: "28 km S of Coalcomán de Vázquez Pallares, Mexico", magType: "mb", title: "M 4.7 - 28 km S of Coalcomán de Vázquez Pallares, Mexico", url: "https://earthquake.usgs.gov/earthquakes/eventpage/us7000im4p"),
                                                              geometry: Geometry(coordinates: [-103.1235, 18.5182, 65.227])))
    }
    
    func updateMapEarthquakeRegion(earthquake: Earthquake) {
        withAnimation(.easeInOut) {
            mapEarthquakeRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0]), span: mapSpan)
        }
    }
    
    func toggleEaryhquakeList() {
        withAnimation(.easeInOut) {
            showAllEarthquakes = !showAllEarthquakes
        }
    }
    
    func changeEarthQuakeOnMap(earthquake: Earthquake) {
        withAnimation(.easeInOut) {
            earthquakeOnMap = earthquake
            showAllEarthquakes = false
        }
    }
    func downloadEarthquakeData() {
        
        loading = true
        errorMsg = nil
        
        let url = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson")
        
        earthquakeDataLoader.fetchEarthquakeData(url: url) { [weak self] earthquakeData, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMsg = error.localizedDescription
                }
                print(error)
            } else if let earthquakeData = earthquakeData {
                DispatchQueue.main.async {
                    self?.loading = false
                    self?.earthquakeData = earthquakeData
                    self?.earthquakeOnMap = earthquakeData.earthquakes[0]
                    self?.updateMapEarthquakeRegion(earthquake: earthquakeData.earthquakes[0])
                }
            }
        }
    }
    
}
