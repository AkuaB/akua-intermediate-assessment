//
//  HomeViewModel.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import Foundation

@Observable
class HomeViewModel: ObservableObject {
    
    private let networkManager = WeatherNetworkManager()
    
    var current: CurrentDetails?
    var astromony: AstronomyDetails?
    var astro: AstroDetails?
    var latitude: String?
    var longitude: String?
    
    
    var temperature: String {
        String(format: "%.1f °C", current?.tempC ?? 0.0)
    }
    
    var imageURL: String {
        "https:" + (current?.condition?.icon ?? "")
    }
    
    var sunset: String {
        astro?.sunset ?? ""
    }

    var sunrise: String {
        astro?.sunrise ?? ""
    }
    
    var coordinates: String {
        "\(latitude ?? ""), \(longitude ?? "")"
    }
    
    func setCoordinates(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
    
    func getWeatherDetails() async {
        async let astromonyDetails =  await networkManager.getSearchResults(searchTerm: coordinates.isEmpty ? coordinates : "Sandton", type: .astronomy, dateString: getCurrentDate())
            async let currentDetails =  await networkManager.getSearchResults(searchTerm: coordinates.isEmpty ? coordinates : "Sandton", type: .current)
            
            astro =  await astromonyDetails.astronomy?.astro ?? AstroDetails()
            current =  await currentDetails.current ?? CurrentDetails()
        
    }
}
