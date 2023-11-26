//
//  ScanView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct ScanView: View {
    var body: some View {
        VStack{
            HStack {
                Text("69")
                    .padding(.trailing, -4)
                    .bold()
                Image(systemName: "star.fill")
                    .font(.caption)
                Spacer()
                Text("John D.")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "plus.circle")
                    .opacity(0.5)
                    .font(.title3)
            }.padding()
            TopTabView(labels: ["Scan & pay", "Scan only"], views: [ScanView1(), ScanView2()])
        }.background(Color.scrollbackground)

    }
}

struct ScanView1: View {
    var body: some View {
        BaseCardView(cornerRadius: 25.0) {
            Text("$69.99")
                .font(.title)
                .bold()
                .padding(.top)
            ZStack {
                Text("Earns 2    per $1")
                    .bold()
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 5.0).strokeBorder(style: StrokeStyle()).foregroundStyle(Color("gold")))
                Image(systemName: "star.fill")
                    .foregroundStyle(.black)
                    .font(.caption)
                    .offset(x:3)
            }.padding(.top, -12)
            Spacer()
            Image("barcode")
                .resizable()
                .frame(height: 40)
                .padding(.horizontal, 70)
            Text("1234 5678 9012 3456")
                .font(.caption)
            Spacer()
            HStack {
                VStack {
                    Image(systemName: "gearshape")
                    Text("Manage")
                        .font(.caption)
                }
                VStack {
                    Image(systemName: "dollarsign.arrow.circlepath")
                    Text("Add funds")
                        .font(.caption)
                }
                
            }.padding()
                .padding(.horizontal)
            
        } image: {
            Image("card1")
        }
        .frame(maxHeight: 600)
        .padding()
        Spacer()
    }
}

struct ScanView2: View {
    var body: some View {
        BaseCardView(cornerRadius: 25.0) {
            Text("Scan to earn Stars")
                .font(.title)
                .bold()
                .padding(.top)
            ZStack {
                Text("Earns 1    per $1")
                    .bold()
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 5.0).strokeBorder(style: StrokeStyle()).foregroundStyle(Color("gold")))
                Image(systemName: "star.fill")
                    .foregroundStyle(.black)
                    .font(.caption)
                    .offset(x:3)
            }.padding(.top, -12)
            Spacer()
            Image("qrcode")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .padding(.horizontal, 70)
            Spacer()
            HStack {
                VStack {
                    Image(systemName: "checkmark.circle")
                    Text("Make default")
                        .font(.caption)
                }
                
            }.padding()
                .padding(.horizontal)
            
        } image: {
            Image("card2")
        }
        .frame(maxHeight: 600)
        .padding()
        Spacer()
    }
}

#Preview {
    ScanView()
}
