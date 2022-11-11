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
        VStack(alignment:.leading, spacing: 20){
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0]), span: earthquakeDataViewModel.detailedMapSpan)),
                annotationItems: [earthquake]) { earthquake in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])) {
                      AnnotationView()
                }
            }
            .frame(height: UIScreen.main.bounds.height/2)
            .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 20)
            
            VStack(alignment: .leading, spacing: 10){
                Text(earthquake.properties.location)
                    .font(.title2)
                    .fontWeight(.black)
                    .padding(.bottom, 10)
                Divider()
                
                Text("Magnitude: \(earthquake.properties.mag, specifier: "%.1f")")
                    .font(.headline)
                    
                Text("Magnitude Type: " + earthquake.properties.magType)
                    .font(.headline)
                 
                Text("Coordinates")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .padding(.vertical, 5)
                Text("Longitude: \(earthquake.geometry.coordinates[1], specifier: "%.4f")")
                    .font(.headline)
                  
                Text("Latitude: \(earthquake.geometry.coordinates[0], specifier: "%.4f")")
                    .font(.headline)
                   
                Text("Depth: \(earthquake.geometry.coordinates[2], specifier: "%.4f")")
                    .font(.headline)
                Divider()
                
                if let url = URL(string: earthquake.properties.url) {
                    Link("Details on (USGS) website", destination: url)
                        .font(.headline)
                }
            }
            .padding()
            
            Spacer()
            
            
        }
        .ignoresSafeArea()
        .background(
            LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottom)
        
        )
        .overlay(
            Button(
            action: {
            earthquakeDataViewModel.earthquakeDetailSheet = nil
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding()
                .padding(.top, 10)
               
      
                   
        }),
        alignment: .topLeading)
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
