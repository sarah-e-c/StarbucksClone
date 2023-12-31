//
//  ContentView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/12/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var selection = 0
    @StateObject private var storeAndCartVM = StoreAndCartViewModel()
    

    var body: some View {
        TabView(selection: $selection) {
            HomeView(selectedTab: $selection, vm: UserDataViewModel())
                    .tabItem { TabLabel(image: Image(systemName: "house.fill"), name: "Home") }
                    .tag(0)
            ScanView(vm: UserDataViewModel())
                    .tabItem { TabLabel(image: Image(systemName: "qrcode"), name: "Scan") }
                    .tag(1)
                
                //order view
                NavigationStack {
                    OrderView(storeAndCartVM: storeAndCartVM)
                }.tabItem { TabLabel(image: Image(systemName: "cup.and.saucer"), name: "Order") }
                .tag(2)
            NavigationStack {
                GiftView(vm: GiftViewModel())
            }
                
            .tabItem { TabLabel(image: Image(systemName: "gift"), name: "Gift") }
            .tag(3)
                
                // offers view
                NavigationStack {
                    OffersView()
                }
                    .tabItem { TabLabel(image: Image(systemName: "star"), name: "Offers") }
                    .tag(4)
            
            }.accentColor(Color("green"))
            .onAppear(perform: {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
            })
    }
}

struct TabLabel: View  {
    let image: Image
    let name: String
    
    var body: some View {
        VStack {
            image
                .renderingMode(.template)
            Text(name)
                .font(.caption2)
        }
    }
}

#Preview {
    ContentView()
}
