//
//  ContentView.swift
//  PST2Att1
//
//  Created by Sean on 9/24/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello other teammates")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.yellow)
            Text("Here is some test UI")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Color.purple)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
