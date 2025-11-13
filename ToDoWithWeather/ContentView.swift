//
//  ContentView.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/11.
//

import SwiftUI
import CoreLocation
import SwiftData

class GlobalString: ObservableObject {
    static let shared = GlobalString()
  @Published var latitude = ""
  @Published var longitude = ""
}

struct ContentView: View {

    var locationManager = LocationManager()
    
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView().environmentObject(GlobalString())
            }
            Tab("Completed", systemImage: "checkmark.rectangle.fill") {
                CompletedTaskView()
            }
        }.onAppear {
            locationManager.getUserLocation()
        }
        
    }
}

#Preview {
    ContentView()
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var lastKnownLocation: CLLocation?

    func getUserLocation() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func startUpdating() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        guard let location = locations.last else { return }
        lastKnownLocation = location
        GlobalString.shared.latitude = "\(location.coordinate.latitude)"
        GlobalString.shared.longitude = "\(location.coordinate.longitude)"
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager failed with error: \(error.localizedDescription)")
    }
}

