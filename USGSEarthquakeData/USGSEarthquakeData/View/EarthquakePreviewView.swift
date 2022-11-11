//
//  EarthquakePreviewView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 7.11.2022.
//

import SwiftUI
struct EarthquakePreviewView: View {
    
    @EnvironmentObject private var earthquakeDataViewModel: EarthquakeDataViewModel
    let earthquake: Earthquake
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Magnitude: \(earthquake.properties.mag, specifier: "%.1f")")
                .font(.title)
            
            
            HStack {
                Button {
                    earthquakeDataViewModel.earthquakeDetailSheet = earthquake
                } label: {
                    Text("Details")
                        .font(.headline)
                        .frame(width: 125, height: 35)
                        .foregroundColor(.white)
                        .background(.primary)
                        .cornerRadius(12)
                }
              
                
                Button {
                    earthquakeDataViewModel.nextEarthquake(earthquake: earthquake)
                } label: {
                    Text("Next")
                        .font(.headline)
                        .frame(width: 125, height: 35)
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(12)
                }

            }
        }
        .frame(width:360, height: 200)
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}

struct EarthquakePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakePreviewView(earthquake: Earthquake(id: "us7000im5c",
                                                     properties: Property(mag: 4.9, location: "28 km S of Coalcomán de Vázquez Pallares, Mexico", magType: "mb", title: "M 4.7 - 28 km S of Coalcomán de Vázquez Pallares, Mexico", url: "https://earthquake.usgs.gov/earthquakes/eventpage/us7000im4p"),
                                                     geometry: Geometry(coordinates: [-103.1235, 18.5182, 65.227])))
            .environmentObject(EarthquakeDataViewModel())
    }
}
