//
//  HomeViewModelTests.swift
//  ToDoWithWeatherTests
//
//  Created by Akua Afrane-Okese on 2025/11/11.
//

import XCTest
@testable import ToDoWithWeather

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testCoordinatesWithSuccess() throws {
        viewModel.setCoordinates(latitude: "24", longitude: "43")
        XCTAssertEqual(viewModel.coordinates, "24,43")
    }
    
    func testCurrentDateWithSuccess() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        XCTAssertEqual(viewModel.getCurrentDate(), currentDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
