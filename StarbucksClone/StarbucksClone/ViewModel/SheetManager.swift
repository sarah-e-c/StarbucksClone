//
//  SheetManager.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/24/23.
//

import Foundation
import SwiftUI

class SheetManager: ObservableObject {
    @Published var productSheetShowing = false
    @Published var alternateProductSheetShowing = false
    @Published var confirmOrderSheetShowing = false
    @Published var thankYouSheetShowing  = false
    
    static var shared = SheetManager()
    
    func showProductSheet() {
        thankYouSheetShowing = false
        productSheetShowing = true
        alternateProductSheetShowing = false
    }
    
    func showConfirmOrderSheet() {
        print("showing confirm order sheet now...")
        if productSheetShowing {
            withAnimation {
                productSheetShowing = false
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
                self.confirmOrderSheetShowing = true
                self.thankYouSheetShowing = false
                self.alternateProductSheetShowing = false
            })
        } else {
            self.productSheetShowing = false
            self.confirmOrderSheetShowing = true
            self.thankYouSheetShowing = false
            self.alternateProductSheetShowing = false
            
        }

    }
    
    func showThankYouSheet() {
        productSheetShowing = false
        thankYouSheetShowing = true
    }
    
    func closeThankYouSheet() {
        productSheetShowing = false
        thankYouSheetShowing = false
        confirmOrderSheetShowing = false
        alternateProductSheetShowing = false
    }
    
    func showAdditionalOptionsSheet() {
        withAnimation {
            thankYouSheetShowing = false
        }
    }
    
    func showAlternateProductSheet() {
        print("showing the alternate product sheet...")
        withAnimation {
            productSheetShowing = false
            thankYouSheetShowing = false
            alternateProductSheetShowing = true
        }
    }
    

}
