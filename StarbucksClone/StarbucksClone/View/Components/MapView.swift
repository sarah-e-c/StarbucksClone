//
//  MapView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/30/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) var dismiss
    @State private var mapCameraPosition = MapCameraPosition.userLocation(fallback: MapCameraPosition.automatic)
    
    @ObservedObject var vm: StoreAndCartViewModel
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "magnifyingglass")
                    .opacity(0.5)
                Spacer()
                Text("Choose a store")
                    .bold()
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .opacity(0.5)
                        .foregroundStyle(Color.black)
                }

            }.padding()
            HeaderEdgeDivider()
            Map(position: $mapCameraPosition) {
                UserAnnotation()
                ForEach(vm.getNearbyUserLocations()) {location in
                    Annotation(location.name, coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)) {
                        LocationAnnotation(location: location, mapCameraPosition: $mapCameraPosition, vm: vm)
                    }
                }
            }
              .edgesIgnoringSafeArea(.all)
              .padding(.top, -10)
            TopTabView(labels: ["Nearby", "Previous", "Favorites"], views: [ViewLocationsView(locations: vm.getNearbyUserLocations(), mapCameraPosition: $mapCameraPosition, vm: vm), PreviousLocationsView(), FavoriteLocationsView()])
                .padding(.top, 4)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ViewLocationsView: View {
    let locations: [Location]
    @Binding var mapCameraPosition: MapCameraPosition
    @ObservedObject var vm: StoreAndCartViewModel
    var body: some View {
        ScrollView {
            ForEach(locations, id:\.name) { location in
                LocationView(location: location, mapCameraPosition: $mapCameraPosition, vm: vm)
                Divider()
            }
        }.ignoresSafeArea()
    }
}

struct PreviousLocationsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("No previous locations")
                .font(.title2)
                .padding(.bottom, 3)
            Text("Make your first order to access previous locations.                                    ")
                .font(.caption)
        }.padding()
    }
}

struct FavoriteLocationsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("No favorite stores")
                .font(.title2)
                .padding(.bottom, 3)
            
            Text("Tap on the heart to favorite a store. It will be here for you to choose.")
                .font(.caption)
        }.padding()
    }
}


struct LocationAnnotation: View {
    let location: Location
    @Binding var mapCameraPosition: MapCameraPosition
    @ObservedObject var vm: StoreAndCartViewModel
    var body: some View {
        Button {
            withAnimation {
                vm.selectedLocation = location
                mapCameraPosition = MapCameraPosition.rect(vm.updateRegion(with: location))
            }
        } label: {
            ZStack{
                if vm.selectedLocation?.id == location.id && vm.selectedLocation != nil {
                        Image("grandefill")
                        .padding()
                            .background(Circle().foregroundStyle(Color("green")))
                } else {
                    ZStack {
                        Circle()
                            .frame(width: 20)
                            .foregroundStyle(Color("green"))
                        Circle()
                            .strokeBorder()
                            .foregroundStyle(Color.white)
                        }

                        
                }
                
                
            }
        }

        
    }
}

struct LocationView: View {
    let location: Location
    @Binding var mapCameraPosition: MapCameraPosition
    @ObservedObject var vm: StoreAndCartViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            withAnimation {
                vm.selectedLocation = location
                mapCameraPosition = MapCameraPosition.rect(vm.updateRegion(with: location))
            }

        } label: {
            VStack(alignment: .leading) {
                HStack {
                    Text(location.name)
                        .bold()
                    Spacer()
                    Image(systemName: "heart")
                        .opacity(0.5)
                        .padding(.trailing)
                    Image(systemName: "info.circle")
                        .opacity(0.5)
                }
                Text(location.street1)
                    .font(.caption)
                Text("\(vm.getFormattedLocationDistanceFromUserLocation(lat: Double(location.latitude) ?? 0.0, long: Double(location.longitude) ?? 0.0)) km • Open until 8:00 PM")
                    .font(.caption)
                    .padding(.bottom)
                HStack {
                    VStack(alignment: .center) {
                        Image(systemName: "door.left.hand.open")
                        Text("In store")
                            .font(.caption)
                    }
                    Spacer()
                    if vm.selectedLocation?.id == location.id {
                        Button {
                            dismiss()
                        } label: {
                            Text("Order Here")
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(RoundedRectangle(cornerRadius: 40)
                                    .foregroundStyle(Color("green")))
                        }
                    }
                }
            }.padding()
                .foregroundStyle(Color.black)
                .background(RoundedRectangle(cornerRadius: 10)
                    .strokeBorder()
                    .foregroundStyle(Color("green"))
                    .opacity(vm.selectedLocation?.id == location.id ? 1.0 : 0.0)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.lightgreen).opacity(vm.selectedLocation?.id == location.id ? 0.2 : 0.0)))
        }

    }
}

#Preview {
    MapView(vm: StoreAndCartViewModel())
}
