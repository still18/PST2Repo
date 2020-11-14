//
//  AppView.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        
        TabView {
            
            ContentView().tabItem {
                Image(systemName: "list.dash")
                Text("Presets")
            }
            
            PlaybackView().tabItem {
                Image(systemName: "square.and.pencil")
                Text("Playback")
            }
            
            AboutView().tabItem {
                Image(systemName: "list.dash")
                Text("About")
            }
            
        }
        
    }
}



struct AppView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppView()
    }
    
}
