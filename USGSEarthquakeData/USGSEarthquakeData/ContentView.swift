//
//  ContentView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 1.11.2022.
//
//
//import SwiftUI
//
//struct ContentView: View {
//    
//    @EnvironmentObject var earthquakeDataViewModel: EarthquakeDataViewModel
//    
//    var body: some View {
//        
//        List {
//            ForEach(earthquakeDataViewModel.earthquakeData.earthquakes) {earthquake in
//                Text(earthquake.properties.location)
//            }
//        }.onAppear {
//            earthquakeDataViewModel.downloadEarthquakeData()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(EarthquakeDataViewModel())
//    }
//}
