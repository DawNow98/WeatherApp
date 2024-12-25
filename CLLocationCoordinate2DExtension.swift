//
//  CLLocationCoordinate2DExtension.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 11/12/2024.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
