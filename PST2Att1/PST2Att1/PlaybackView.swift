//
//  PlaybackView.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct PlaybackView: View {
    
    @State var playerPaused = true
    
    var body: some View {
            VStack() {
                Text("Playback Controls").font(.headline)
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.startDefaultQueue()
                    self.playerPaused.toggle()
                }) {
                    Text("Start")
                }
                }
                HStack() {
                    VStack {
                    Spacer().frame(height: 10)
                    Button(action: {VA.skipToPrevSong()}) {
                        Image(systemName: "backward.end.fill").resizable().frame(width: 50, height: 50)
                    }
                    }
                    Spacer().frame(width: 40)
                    VStack {
                    Spacer().frame(height: 10)
                    Button(action: {
                        self.playerPaused.toggle()
                        if self.playerPaused {
                            VA.pauseMusic()
                        } else {
                            VA.playMusic()
                        }
                    }) {
                        Image(systemName: playerPaused ? "play.fill" : "pause.fill").resizable().frame(width: 50, height: 50)
                    }
                    }
                    Spacer().frame(width: 40)
                    VStack {
                    Spacer().frame(height: 10)
                    Button(action: {VA.skipToNextSong()}) {
                        Image(systemName: "forward.end.fill").resizable().frame(width: 50, height: 50)
                    }
                    }
                    
                }.frame(minWidth: 100)
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView()
    }
}
