//
//  GlobalLocation.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import Foundation

class GlobalLocation: ObservableObject {
    static let shared = GlobalLocation()
  @Published var latitude = ""
  @Published var longitude = ""
}
