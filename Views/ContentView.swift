//
//  ContentView.swift
//  FitBreak
//
//  Created by Alberto Hernández Pintor on 14/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .createRoutines

    enum Tab {
        case createRoutines
        case myRoutines
        case weather
        case nearlyPlaces
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NewRoutineHome()
                .tabItem {
                    Label("Nueva rutina", systemImage: "plus.circle")
                }
                .tag(Tab.createRoutines)
            
            MyRoutinesList()
                .tabItem {
                    Label("Mis rutinas", systemImage: "list.bullet")
                }
                .tag(Tab.myRoutines)
            
            Weather()
                .tabItem {
                    Label("Tiempo", systemImage: "cloud.sun.fill")
                }
                .tag(Tab.weather)
            
            NearlyPlaces()
                .tabItem {
                    Label("Gimnasios cercanos", systemImage: "mappin.and.ellipse")
                }
                .tag(Tab.nearlyPlaces)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
