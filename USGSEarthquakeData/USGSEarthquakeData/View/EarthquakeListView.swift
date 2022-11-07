//
//  EarthquakeListView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 3.11.2022.
//

import SwiftUI

struct EarthquakeListView: View {
    
    @EnvironmentObject var earthDataViewModel: EarthquakeDataViewModel
    
    var body: some View {
        

        List {
            
            ForEach(earthDataViewModel.earthquakeData.earthquakes) { earthquake in
                
                Button {
                    earthDataViewModel.changeEarthQuakeOnMap(earthquake: earthquake)
                } label: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(earthquake.properties.location)
                            .font(.headline)
        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
        

        
    }
}

struct EarthquakeListView_Previews: PreviewProvider {
    static var previews: some View {
        EarthquakeListView()
            .environmentObject(EarthquakeDataViewModel())
    }
}
