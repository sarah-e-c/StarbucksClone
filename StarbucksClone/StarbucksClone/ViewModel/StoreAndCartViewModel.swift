//
//  StoreAndCartViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import Foundation

import SwiftUI
import MapKit

class StoreAndCartViewModel: ObservableObject {
    let CHAPEL_HILL_LATITUDE = 35.913200
    let CHAPEL_HILL_LONGITUDE = -79.0558
    var cartService = CartService.shared
    var starAndMoneyService = StarAndMoneyService.shared
    @Published var updated = 0
    @Published var currentProduct = Product.example
    @Published var selectedLocation: Location? = nil
    var locationManager = LocationManager()
    var renderingLocations: [Location] = []
    
    init() {
        var stateString =  LocationService.shared.stateAbbreviations[locationManager.userState]
        if stateString == nil {
            print("Could not find state from user location")
            print("user state", locationManager.userState)
            print("user city", locationManager.userCity)
            print("user longitide", locationManager.userLong)
            print("user latitude", locationManager.userLat)
            stateString = "NC"
        }
        let tempLocations = LocationService.shared.getLocationsInState(state: stateString!)
        
        self.renderingLocations = Array(tempLocations.sorted(by: {Utils.distanceLatLong(lat1: locationManager.userLat, lon1: locationManager.userLong, lat2: Double($0.latitude) ?? CHAPEL_HILL_LATITUDE , lon2: Double($0.longitude) ?? CHAPEL_HILL_LONGITUDE) < Utils.distanceLatLong(lat1: locationManager.userLat, lon1: locationManager.userLong, lat2: Double($1.latitude) ?? CHAPEL_HILL_LATITUDE , lon2: Double($1.longitude) ?? CHAPEL_HILL_LONGITUDE)}).prefix(30))
    }
    
    
    class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
        // this was from chatgpt D:
        private var locationManager = CLLocationManager()
        
        let CHAPEL_HILL_LATITUDE = 35.913200
        let CHAPEL_HILL_LONGITUDE = -79.0558

        @Published var userCity: String = ""
        @Published var userState: String = ""
        
        var userLat: Double {
            return locationManager.location?.coordinate.latitude ?? CHAPEL_HILL_LATITUDE
        }
        
        var userLong: Double {
            return locationManager.location?.coordinate.longitude ?? CHAPEL_HILL_LONGITUDE
        }

        override init() {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        print("Error reverse geocoding location: \(error.localizedDescription)")
                    } else if let placemark = placemarks?.first {
                        // Extract the city and state from the placemark
                        self.userCity = placemark.locality ?? ""
                        self.userState = placemark.administrativeArea ?? ""
                        print("user city", self.userCity)
                        print("user setate", self.userState)
                    }
                }
            }
        }
    }
    
    func updateRegion(with location: Location) -> MKMapRect {
        // Calculate the center between the specific coordinates and user's location
        print(location.latitude, ": location latitude")
        print(locationManager.userLat, ": user latitude")

            
        let locationMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: Double(location.latitude) ?? CHAPEL_HILL_LATITUDE, longitude: Double(location.longitude) ?? CHAPEL_HILL_LONGITUDE))
        
        
        
        let userMapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: locationManager.userLat, longitude: locationManager.userLong))

        // Calculate the union of the two points to create a bounding MKMapRect
        let boundingRect = MKMapRect(
            x: min(locationMapPoint.x, userMapPoint.x),
            y: min(locationMapPoint.y, userMapPoint.y),
            width: abs(locationMapPoint.x - userMapPoint.x) * 1.4,
            height: abs(locationMapPoint.y - userMapPoint.y) * 1.4
        )
        
        return boundingRect
    }

    
    func getNearbyUserLocations() -> [Location] {
        return renderingLocations
    }
    
    func getFormattedLocationDistanceFromUserLocation(lat: Double, long: Double) -> String {
        let km_distance = Utils.distanceLatLong(lat1: lat, lon1: long, lat2: locationManager.userLat, lon2: locationManager.userLong)
        return String(format: "%.2f", km_distance)
    }
    
    var stars: Int {
        StarAndMoneyService.shared.stars
    }

    var formattedCost: String {
        Utils.formatIntToDollars(number: cartService.costOfCart)
    }
    
    func getProductsInCart() -> [CustomProduct] {
        return CartService.shared.cart
    }
    var numProducts: Int {
        return CartService.shared.cart.count
    }
    var mostRecentProductImagePath: String {
        guard !CartService.shared.cart.isEmpty else {return ""}
        return CartService.shared.cart[CartService.shared.cart.count - 1].product.productName
    }
    var mostRecentProduct: Product {
        guard !CartService.shared.cart.isEmpty else {return Product.example}
        return CartService.shared.cart[CartService.shared.cart.count - 1].product
    }
    
    var cartRecentlyChanged: Bool {
        return CartService.shared.cartRecentlyChanged
    }
    
    func favoriteToggle(product: CustomProduct)  {
        FavoriteService.shared.toggleFavorite(product: product)
    }
    
    func isProductFavorited(product: CustomProduct) -> Bool {
        return FavoriteService.shared.isFavorite(product: product)
    }
    
    func removeProduct(product: CustomProduct) {
        CartService.shared.removeProduct(product: product)
        updated += 1
    }
    
    func addProduct(product: CustomProduct) {
        CartService.shared.addProductToOrder(product: product)
        updated += 1
    }
    
    func checkout() {
        HistoryService.shared.addToHistory(products: CartService.shared.cart)
        
        starAndMoneyService.buy_items(dollarAmount:CartService.shared.costOfCart)
        
        CartService.shared.cart = []
        updated += 1
    }
    
    func mostRecentOrder() -> [CustomProduct] {
        return HistoryService.shared.history.last?.products ?? []
    }
    
    var message: String? {
        if CartService.shared.messageAvailable {
            return CartService.shared.message
        } else if FavoriteService.shared.messageAvailable {
            return FavoriteService.shared.message
        }
        else {
            return nil
        }
    }
    
    
    
}
