//
//  ContentView.swift
//  PST2Att1
//
//  Created by Sean on 9/24/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

   var y : Int = 0

struct ContentView: View {
    @State var yes = String(y)
    var body: some View {
        ScrollView {
        VStack() {
            
            Spacer().frame(height: 50)
            
            Text("What are you doing right now?")
                .font(.headline)
            
            Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("")) {
            Text("Option 1").tag(1)
            Text("Option 2").tag(2)
            Text("Option 3").tag(3)
            Text("Option 3").tag(4)
            }
            .padding(-80.0)
            .frame(width: -1.0)
            
            Spacer().frame(height: 85)
            
            VStack(/*alignment: .leading*/) {
            Text("Hello other teammates")
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(Color.yellow)
            HStack {
                Text("Here is some test UI")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.purple)
                Text("And more here")
                    .font(.subheadline)
                    .foregroundColor(Color.blue)
            }
        }
            
            
            Text(yes).padding()
            
            Button(action: {y = y + 1
                self.yes = String(y)
            }) {
            Text("Press 4 fun")
            }
            
        }
        }}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

