//
//  USGSEarthquakeDataApp.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 1.11.2022.
//

import SwiftUI

@main
struct USGSEarthquakeDataApp: App {
    
    @StateObject var earthquakeDataViewModel = EarthquakeDataViewModel()
    var body: some Scene {
        WindowGroup {
            EarthquakeView()
                .environmentObject(earthquakeDataViewModel)
        }
    }
}
