//
//  AnnotationView.swift
//  USGSEarthquakeData
//
//  Created by Emrah Karabulut on 3.11.2022.
//

import SwiftUI

struct AnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
                .background(Color.blue)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.blue)
                .frame(width: 16, height: 16)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -5)
                .padding(.bottom, 40)
        }
        .shadow(color: Color.black.opacity(0.8), radius: 20, x: 0, y: 15)
    }
}

struct AnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationView()
    }
}
