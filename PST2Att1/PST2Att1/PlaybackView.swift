//
//  PlaybackView.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

var xPP: Bool = true

struct PlaybackView: View {
    
    @State var playerPaused: Bool = true
    @State var playbackAlert: Bool = false
    @State var firstTimePlaying: Bool = true
    
    @State var playText : String = "-"
    @State var playArt : String = "-"
    
    func getCurrentSong() {
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            let current = musicP.nowPlayingItem
            self.playText = current?.title as! String
            self.playArt = current?.artist as! String
            if (self.playText == endSong) {
                VA.makeQueue(songArtistList: VA.calculate(firstTime: false))
            }
        }
    }
    
    var body: some View {
            VStack() {
                Text("Move-it Music!").font(.custom("Marker Felt Thin", size: 42))
                    .foregroundColor(.blue)
                VStack() {
                    Spacer().frame(height: 160)
                    Text("Now playing:").font(.custom("Marker Felt", size: 30))
                    Spacer().frame(height: 15)
                    Text("\(String(playText))").frame(width: 300)
                    Spacer().frame(height: 35)
                    Text("By:").font(.custom("Marker Felt", size: 22))
                    Spacer().frame(height: 15)
                    Text("\(String(playArt))").frame(width: 300)
                }
                Spacer().frame(height: 180)
                Text("Playback Controls").font(.headline)
                VStack {
                     Spacer().frame(height: 10)
                }
                HStack() {
                    VStack {
                    Spacer().frame(height: 10)
                    Button(action: {
                        if (!initialSet) {
                            playbackAlert.toggle()
                        } else {
                            if (playerPaused) {
                                self.playerPaused.toggle()
                                VA.skipToPrevSong()
                            } else {
                                VA.skipToPrevSong()
                            }
                        }
                    }) {
                        Image(systemName: "backward.end.fill").resizable().frame(width: 50, height: 50)
                    }
                    }
                    Spacer().frame(width: 40)
                    VStack {
                    Spacer().frame(height: 10)
                    Button(action: {
                        if (!initialSet) {
                            playbackAlert.toggle()
                        } else {
                            self.playerPaused.toggle()
                            if self.playerPaused {
                                VA.pauseMusic()
                                xPP = playerPaused
                            } else {
                                VA.playMusic()
                                if (firstTimePlaying) {
                                    firstTimePlaying = false
                                    getCurrentSong()
                                }
                                xPP = playerPaused
                            }
                        }
                    }) {
                        Image(systemName: playerPaused ? "play.circle.fill" : "pause.circle.fill").resizable().frame(width: 60, height: 60)
                    }
                    }
                    Spacer().frame(width: 40)
                    VStack {
                        Spacer().frame(height: 10)
                        Button(action: {
                            if (!initialSet) {
                                playbackAlert.toggle()
                            } else {
                                if (playerPaused) {
                                    self.playerPaused.toggle()
                                    VA.skipToNextSong()
                                    getCurrentSong()
                                } else {
                                    VA.skipToNextSong()
                                    getCurrentSong()
                                }
                            }
                        }) {
                        Image(systemName: "forward.end.fill").resizable().frame(width: 50, height: 50)
                        }
                    }
                    
                }.frame(minWidth: 100)
                Spacer().frame(height: 17)
                
        }.alert(isPresented: $playbackAlert) {
            Alert(title: Text("Attention!"), message: Text("Please set your choices on the first page."), dismissButton: .default(Text("OK!"))) }
    }
}

struct PlaybackView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView()
    }
}

