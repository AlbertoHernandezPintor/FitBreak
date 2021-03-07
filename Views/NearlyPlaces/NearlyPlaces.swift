//
//  NearlyPlaces.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 7/3/21.
//

import SwiftUI
import MapKit

struct NearlyPlaces: View {
    
    @ObservedObject var locationManager = LocationManager()
    @State private var landmarks: [Landmark] = [Landmark]()
    
    private func getNearlyPLaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gym"
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(landmarks: landmarks)
            
            Text("Buscar gimnasios cercanos")
                .foregroundColor(.white)
                .font(.title2)
                .padding()
                .overlay(Capsule().stroke(Color.white, lineWidth: 4))
                .background(Color.init(UIColor(named: "SecondaryColor")!))
                .clipShape(Capsule())
                .offset(y: 44)
                .onTapGesture {
                    getNearlyPLaces()
                }
        } // Fin ZStack
    } // Fin body
}

struct NearlyPlaces_Previews: PreviewProvider {
    static var previews: some View {
        NearlyPlaces()
    }
}
