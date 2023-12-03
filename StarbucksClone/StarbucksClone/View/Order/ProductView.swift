//
//  ProductView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var vm: ProductViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isHeartShowing = false
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    let isAlternate: Bool
    init(vm: ProductViewModel, storeAndCartVm: StoreAndCartViewModel) {
        self.vm = vm
        isAlternate = false
        self.storeAndCartVm = storeAndCartVm
    }
    
    init(vm: ProductViewModel, storeAndCartVm: StoreAndCartViewModel, isAlternate: Bool) {
        self.vm = vm
        self.isAlternate = isAlternate
        self.storeAndCartVm = storeAndCartVm
    }
    
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Button {
                        vm.toggleFavorite()
                        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(_) in isHeartShowing.toggle()})
                    } label: {
                        Image(systemName: vm.isFavorited ? "heart.fill" :"heart")
                            .foregroundStyle(vm.isFavorited ? Color("green") : .black)
                            .padding(.trailing)
                            .opacity(isHeartShowing ? 1.0 : 0.99)
                            
                    }
                    ShareLink(item: "Check out this \(vm.product.productName) from Starbucks! \n\n https://www.starbucks.com", preview: SharePreview("Check out this \(vm.product.productName) from Starbucks!", image: Image(vm.product.productName))) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(Color.black)
                    }
                    
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }.padding()
                    .font(.title3)
                    .frame(height: 50)
                    .opacity(0.6)
                    
                ScrollView {
                    VStack {
                        ProductImageView(product: vm.product, size: .singleFocusSize)
                        Text(vm.product.productName)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                        Group {
                            if let calories = vm.product.productCalories {
                                Text("\(calories) calories").opacity(0.8)
                                    .padding(.bottom)
                            }
                        }
                        VStack(alignment: .leading) {
                            SizeView(vm: vm)
                                .padding(.bottom)
                            OptionView(vm: vm)
                                .padding(.bottom)
                            
                            NavigationLink {
                                Text("LOL I did not implement this :)")
                            } label: {
                                CustomizationButtonView()
                            }.padding(.bottom)
                            
                            Group {
                                if vm.isModified {
                                    Button {
                                        vm.resetCustomizations()
                                    } label: {
                                        ResetRecipeButtonView()
                                    }
                                }
                            }
                            ZStack {
                                Color("darkgreen")
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(
                                            "\(vm.product.productStars ?? "")")
                                        .padding(.trailing, -6)
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 6)
                                        Text(" item")
                                            .padding(.leading, -6)
                                    }.font(.caption).padding(5)
                                        .background(RoundedRectangle(cornerSize: CGSize(width: 3, height: 3)).strokeBorder())
                                        .foregroundColor(Color("gold"))
                                    Text(vm.product.productDescription ?? "")
                                        .font(.subheadline)
                                        .opacity(0.6)
                                        .padding(.vertical)
                                    Text(vm.product.productNutritionSummary ?? "")
                                }.foregroundStyle(.white)
                                    .padding()
                                Spacer()
                            }
                            
                        }
                        
                        
                    }.background(Color.white)
                }
                if !isAlternate {
                    StoreAndCartView(vm: storeAndCartVm)
                }
            }
            AddToOrderButton(vm: vm)
            
        }
    }
}


private struct SizeView: View {
    @ObservedObject var vm: ProductViewModel
    var body: some View {
        VStack {
            if vm.areSizes {
                HStack {
                    Text("Size options")
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                LightGreenDivider()
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    ForEach(vm.availableSizes ?? [], id:\.self) { size in
                        VStack {
                            ZStack {
                                Button {
                                    vm.selectedSize = size
                                } label: {
                                    ZStack {
                                        Circle()
                                            .scaledToFit()
                                            .frame(width: Constants.IconSizes.mini.rawValue)
                                            .foregroundStyle(Color("green").opacity(vm.selectedSize == size ? 0.3 : 0.0))
                                        Circle()
                                            .strokeBorder(Color("green"), lineWidth: vm.selectedSize == size ? 2.0 : 0.0)
                                            .scaledToFit()
                                            .frame(width: Constants.IconSizes.mini.rawValue)
                                    }
                                }
                                Image(vm.getImageNameFromSize(size: size))
                            }
                            Text(size.rawValue)
                                .bold()
                            Text(sizeOptionToSize[size] ?? "")
                                .font(.caption)
                            
                        }.padding(.horizontal, 4.0)
                        
                    }
                    Spacer()
                }
                
            }
        }
    }
}

private struct OptionView: View {
    @ObservedObject var vm: ProductViewModel
    var body: some View {
        VStack {
            if vm.areOptions {
                HStack {
                    Text("What's included")
                        .bold()
                        .padding(.horizontal)
                    Spacer()
                }
                LightGreenDivider()
                    .padding(.bottom, 3)
                    .padding(.horizontal)
            }
            ForEach(vm.customizationOptions, id:\.id) {option in
                Group {
                    if option.isDropdown {
                        DropdownOptionView(vm: vm, option: option as! ProductCustomizationDropdown)
                    } else {
                        StepperOptionView(vm: vm, option: option as! ProductCustomizationStepper)
                    }
                }
                
            }
            
        }
    }
}

private struct DropdownOptionView: View {
    @ObservedObject var vm: ProductViewModel
    @ObservedObject var sheetManager = SheetManager.shared
    @State private var isAdditionalOptionsPresented = false
    
    var option: ProductCustomizationDropdown
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                .strokeBorder(option.isModified ? Color("green") : .black , lineWidth: option.isModified ?  2.0 : 1.0)
                .opacity(option.isModified ? 1.0 : 0.6)
            
            Button {
                isAdditionalOptionsPresented.toggle()
            } label: {
                HStack {
                    Text(option.selectedOption)
                        .foregroundStyle(.black)
                        
                    Spacer()
                    Image(systemName: option.isModified ? "chevron.down.circle.fill" : "chevron.down.circle")
                    .foregroundStyle(Color("green"))
                    .font(.title3)
                }
            }.padding(.horizontal)
        }.frame(height: 50)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .sheet(isPresented: $isAdditionalOptionsPresented, content: {
                VStack {
                    Text("Additional Options")
                        .font(.headline)
                        .padding(3)
                    LightGreenDivider()
                    VStack {
                        ForEach(option.options, id: \.self) {option_ in
                        Button {
                            vm.changeDropdownOption(option: option, selection: option_)
                            vm.objectWillChange.send()
                            isAdditionalOptionsPresented = false
                        }
                        label: {
                                HStack {
                                    Text(option_)
                                        .bold()
                                        .padding(.vertical, 6)
                                        .foregroundStyle(.black)
                                    Group {
                                        if option_ == option.defaultOption {
                                            ZStack {
                                                RoundedRectangle(cornerSize: CGSize(width: 3, height: 3))
                                                    .strokeBorder(Color("green"))
                                                    .frame(width: 90, height: 20)
                                                Text("STANDARD")
                                                    .font(.caption)
                                                    .foregroundStyle(Color("green"))
                                                    .bold()
                                            }
                                        
                                        }
                                        Spacer()
                                    }
                                }
                                
                            }
                            Divider()
                        }
                        
                    }.padding(.horizontal)
                }.presentationDetents([.height(CGFloat(option.options.count) * 50.0 + 60.0)])
                    .presentationDragIndicator(.visible)
            })
        
    }
}


private struct StepperOptionView: View {
    @ObservedObject var vm: ProductViewModel
    
    var option: ProductCustomizationStepper
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))
                .strokeBorder(option.isModified ? Color("green") : .black , lineWidth: option.isModified ?  2.0 : 1.0)
                .opacity(option.isModified ? 1.0 : 0.6)
            HStack {
                Text("\(option.value) Placeholder(s)")
                Spacer()
                Button {
                    vm.decrementStepper(option: option)
                    vm.objectWillChange.send()
                } label: {
                    Image(systemName: option.isModified ? "minus.circle.fill" : "minus.circle")
                    .foregroundStyle(Color("green"))
                    .font(.title3)
                }
                Text("\(option.value)")
                    .bold()
                    .foregroundStyle(.black)
                Button {
                    vm.incrementStepper(option: option)
                    vm.objectWillChange.send()
                } label: {
                    Image(systemName: option.isModified ? "plus.circle.fill" : "plus.circle")
                    .foregroundStyle(Color("green"))
                    .font(.title3)
                }
            }.padding(.horizontal)
        }.frame(height: 50)
            .padding(.horizontal)
            .padding(.vertical, 5)
        
    }
}



#Preview {
    ProductView(vm: ProductViewModel(product: Product.example), storeAndCartVm: StoreAndCartViewModel())
}


private struct CustomizationButtonView: View {
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .foregroundStyle(Color("darkgreen"))
                    .frame(width: 160, height: 50)
                HStack {
                    Image(systemName: "wand.and.stars")
                        .foregroundStyle(Color("gold"))
                        .font(.title2)
                    Text("Customize")
                        .foregroundStyle(.white)
                        .bold()
                }
            }
            Spacer()
        }
    }
}

private struct ResetRecipeButtonView: View {
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 40, height: 40))
                    .strokeBorder(lineWidth: 0.5)
                    .frame(width: 240, height: 30)
                Text("Reset to standard recipe")
                    .bold()
            }.foregroundStyle(Color("green"))
            Spacer()
        }
    }
}

private struct BackgroundView: View {
    var body: some View {
        VStack {
            Color.white
            Color("darkgreen").ignoresSafeArea()
        }
    }
}

private struct AddToOrderButton: View {
    @ObservedObject var vm: ProductViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    vm.addToOrder()
                } label: {
                    GreenButton("Add to order")
                }.padding(.vertical, 60)
            }
            
        }
    }
}

