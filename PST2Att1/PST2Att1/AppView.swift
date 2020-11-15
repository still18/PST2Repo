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
                Image(systemName: "list.bullet")
                Text("Presets")
            }
            
            PlaybackView().tabItem {
                Image(systemName: "music.note")
                Text("Playback")
            }
            
            AboutView().tabItem {
                Image(systemName: "info.circle")
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
