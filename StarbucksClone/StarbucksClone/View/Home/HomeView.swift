//
//  HomeView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int
    @ObservedObject var vm: UserDataViewModel
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HomeToolbar().background(Color.white)
                HeaderEdgeDivider()
                    .padding(.bottom, -20)
                CustomScrollView {
                    Group {
                        StarsView(vm: vm)
                        VStack {
                            Offer1View()
                                .padding(.bottom, -30)
                            
                            Offer2View()
                                .padding(.bottom, -30)
                            PromotionView(image: "promotion1", titleLabel: "Praline party", bodyText: "Celebrate with a Chestnut Praline Latte, sprinkled with spiced praline crumbs.", buttonText: "Order now")
                                .padding(.bottom, -30)
                            PromotionView(image: "promotion2", titleLabel: "Sugar cookie goodness", bodyText: "Here for a few more days: our Iced Sugar Cookie Almondmilk Latte, topped with red and green sprinkled.", buttonText: "Order now")
                                .padding(.bottom, -30)
                            PromotionView(image: "promotion3", titleLabel: "Mocha merriment", bodyText: "Our Peppermint Mocha is all dressed up with whipped cream and dark-chocolate curls.", buttonText: "Order now")
                                .padding(.bottom, -30)
                            PromotionView(image: "promotion4", titleLabel: "Cranberry delight", bodyText: "Topped with cream-cheese icing, our Cranberry Bliss Bar is the perfect holiday treat.", buttonText: "Order now")
                                .padding(.bottom, -30)
                            PromotionView(image: "podcast", titleLabel: "Celebs share their memories", bodyText: "Conan O'Brien, Gayle King and others share fond memories and lessons learned from the heart of their childhood homes -- the kitchen. From Your Momma's Kitchen.", buttonText: "Listen on Hark")
                        }
                        
                    }
                    
                } onScroll: { position in
                    
                }.background(Color.scrollbackground).padding(.top, -8)
                    
            }
            ScanInStoreButton(selection: $selectedTab)
            
        }.onAppear(perform: {vm.objectWillChange.send()})


    }
}


#Preview {
    Text("Hello World!")
}

private struct HomeToolbar: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Merrier with you, John")
                .font(.largeTitle)
                .padding(.top)
                .bold()
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "envelope")
                    Text("Inbox")
                }
                Button {
                    
                } label: {
                    Image("locationicon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                    Text("Stores")
                }
                Spacer()
                Image(systemName: "printer.filled.and.paper")
                    .padding(.horizontal)
                Image(systemName: "person.crop.circle")
                
            }.foregroundStyle(.black)
                .opacity(0.5)
        }.padding(.horizontal)
    }
}

private struct StarsView: View {
    @ObservedObject var vm: UserDataViewModel
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("\(vm.stars)")
                            .font(.title)
                            .bold()
                        Image(systemName: "star.fill")
                            .padding(.leading, -8)
                    }
                    Text("Star balance")
                        .font(.caption)
                        .opacity(0.5)
                }
                Spacer()
                Text("Rewards options")
                    .font(.caption)
                    .opacity(0.5)
                Image(systemName: "chevron.down")
                    .opacity(0.5)
                
            }.padding([.horizontal, .top])
            
           
            Image(systemName: "arrowtriangle.down.fill")
                .offset(x:((CGFloat(UIScreen.screenWidth) * (CGFloat(vm.stars) - (UIScreen.screenWidth / 2)) / 400) + 9), y: 15)
                .foregroundStyle(Color("green"))
            

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .opacity(0.2)
                    .frame(height: 4)
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color("lightgreen"))
                        .frame(width: CGFloat(UIScreen.screenWidth) * CGFloat(vm.stars) / 400, height: 4 )
                    Spacer()
                }
                HStack {
                    StarCheckpointView(numStars: vm.stars, starCheckpoint: 25)
                    Spacer()
                    StarCheckpointView(numStars: vm.stars, starCheckpoint: 100)
                    Spacer()
                    StarCheckpointView(numStars: vm.stars, starCheckpoint: 200)
                    Spacer()
                    StarCheckpointView(numStars: vm.stars, starCheckpoint: 300)
                    Spacer()
                    StarCheckpointView(numStars: vm.stars, starCheckpoint: 400)
                }.padding(.horizontal)
                                

            }.padding()
            HStack {
                Button {
                    
                } label: {
                    Text("Details")
                        .foregroundStyle(.black)
                        .bold()
                        .padding(8)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 25.0).strokeBorder().opacity(0.5).foregroundStyle(.black))
                }
                Button {
                    
                } label: {
                    Text("Redeem")
                        .foregroundStyle(.white)
                        .bold()
                        .padding(8)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(.black))
                    
                }


                Spacer()
            }.padding(.horizontal)
        }
    }
}

private struct StarCheckpointView: View {
    let numStars: Int
    let starCheckpoint: Int
    var body: some View {
        VStack {
            Circle()
                .strokeBorder(lineWidth: numStars >= starCheckpoint ? 5.0 : 2.0)
                .opacity(numStars >= starCheckpoint ? 1.0 : 0.2)
                .foregroundStyle(numStars >= starCheckpoint ? Color.lightgreen : Color.black)
                .frame(width: 10)
                .background(Color.scrollbackground)
            Text(String(starCheckpoint))
                .font(.caption)
                .bold()
                .opacity(numStars >= starCheckpoint ? 0.9 : 0.6)
        }.offset(x:0, y: 10)

            
    }
}

private struct ScanInStoreButton: View {
    @Binding var selection: Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Button {
                    selection = 1
                } label: {
                    GreenButton("Scan in Store")
                }
            }
        }
    }
}
