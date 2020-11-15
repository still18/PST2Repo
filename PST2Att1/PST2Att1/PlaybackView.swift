//
//  PlaybackView.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct PlaybackView: View {
    var body: some View {
            VStack() {
                Text("Playback Controls").font(.headline)
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.startDefaultQueue()}) {
                    Text("Start")
                }
                }
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.pauseMusic()}) {
                    Text("Pause")
                }
                }
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.playMusic()}) {
                    Text("Resume")
                }
                }
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.skipToNextSong()}) {
                    Text("Next song")
                }
                }
                VStack {
                Spacer().frame(height: 10)
                Button(action: {VA.skipToPrevSong()}) {
                    Text("Previous Song")
                    }
                }
        }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView()
    }
}
