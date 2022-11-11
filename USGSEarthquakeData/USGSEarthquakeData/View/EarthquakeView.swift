//
//  EarthquakeView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 3.11.2022.
//

import SwiftUI
import MapKit

struct EarthquakeView: View {
    
    @EnvironmentObject var earthquakeDataViewModel: EarthquakeDataViewModel
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $earthquakeDataViewModel.mapEarthquakeRegion,
                annotationItems: earthquakeDataViewModel.earthquakeData.earthquakes,
                annotationContent: { earthquake in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])) {
                            AnnotationView()
                            .scaleEffect(earthquakeDataViewModel.earthquakeOnMap == earthquake ? 1.0 : 0.6)
                            
                            
                    }
                }
            )
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    Button {
                        earthquakeDataViewModel.toggleEaryhquakeList()
                    } label: {
                        Text(earthquakeDataViewModel.earthquakeOnMap.properties.location)
                            .font(.headline)
                            .fontWeight(.black)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .overlay(alignment: .leading){
                                Image(systemName: "arrow.down")
                                    .font(.title3)
                                    .foregroundColor(Color.blue)
                                    .padding(10)
                                    .rotationEffect(Angle(degrees: earthquakeDataViewModel.showAllEarthquakes ? 180 : 0))
                                
                            }
                      }
                    
                    if earthquakeDataViewModel.showAllEarthquakes {
                        EarthquakeListView()
                    }
                }
                .background(.ultraThickMaterial)
                .cornerRadius(12)
                .padding(6)
                .shadow(color: Color.black.opacity(0.8), radius: 15, x: 0, y: 20)
                
                Spacer()
                
                ZStack {
                    ForEach(earthquakeDataViewModel.earthquakeData.earthquakes) { earthquake in
                        
                        if earthquakeDataViewModel.earthquakeOnMap == earthquake {
                            EarthquakePreviewView(earthquake: earthquake)
                                .shadow(color: Color.black.opacity(0.8), radius: 20)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom),
                                    removal: .move(edge: .top)))
                        }
                    }
                }
            }
        
        }
        .onAppear {
            earthquakeDataViewModel.downloadEarthquakeData()
            
        }
        .sheet(item: $earthquakeDataViewModel.earthquakeDetailSheet, onDismiss: nil) { earthquake in
            EarthquakeDetailedView(earthquake: earthquake)
        }
    }
}

struct EarthquakeView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeView()
            .environmentObject(EarthquakeDataViewModel())
    }
}
