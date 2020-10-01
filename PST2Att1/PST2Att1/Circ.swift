//
//  Circ.swift
//  PST2Att1
//
//  Created by Sean on 9/24/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct Circ: View {
    var body: some View {
        VStack() {
        Image("stock1")
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).overlay(
            Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 5)
        Image("stock1")
        
    }
    }
}

struct Circ_Previews: PreviewProvider {
    static var previews: some View {
        Circ()
    }
}
