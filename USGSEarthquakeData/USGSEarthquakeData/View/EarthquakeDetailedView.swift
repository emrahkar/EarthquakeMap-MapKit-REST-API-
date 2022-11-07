//
//  EarthquakeDetailedView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 7.11.2022.
//

import SwiftUI
import MapKit

struct EarthquakeDetailedView: View {
    
    @EnvironmentObject private var earthquakeDataViewModel: EarthquakeDataViewModel
    let earthquake: Earthquake
    
    var body: some View {
        VStack{
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0]), span: earthquakeDataViewModel.detailedMapSpan)),
                annotationItems: [earthquake]) { earthquake in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])) {
                      AnnotationView()
                }
            }
            .frame(height: UIScreen.main.bounds.height/2)
            .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 20)
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct EarthquakeDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeDetailedView(earthquake: Earthquake(id: "us7000im5c",
                                                      properties: Property(mag: 4.9, location: "28 km S of Coalcomán de Vázquez Pallares, Mexico", magType: "mb", title: "M 4.7 - 28 km S of Coalcomán de Vázquez Pallares, Mexico", url: "https://earthquake.usgs.gov/earthquakes/eventpage/us7000im4p"),
                                                      geometry: Geometry(coordinates: [-103.1235, 18.5182, 65.227])))
            .environmentObject(EarthquakeDataViewModel())
    }
}
