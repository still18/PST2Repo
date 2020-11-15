//
//  ValueAccess.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit
import AVFoundation
import Accelerate
import AVKit
import MediaPlayer

//Permanent/Changing vars go here or at top of other classes
let musicP = MPMusicPlayerApplicationController.applicationQueuePlayer
class MyData: ObservableObject {
    @Published var tempo : Double = 120
}


//Functions and temporary vars go here
class ValueAccess {
    
    @ObservedObject var testData = MyData()
    
    func startDefaultQueue() {
        musicP.setQueue(with: .songs())
        musicP.prepareToPlay()
        musicP.play()
    }
    
    func pauseMusic() {
        musicP.pause()
    }
    
    func playMusic() {
        musicP.play()
    }
    
    func skipToPrevSong() {
        musicP.skipToPreviousItem()
        musicP.play()
    }
    
    func skipToNextSong() {
        musicP.skipToNextItem()
        musicP.play()
    }
    
    func expirPlay() {
        let mediaItems = MPMediaQuery.songs().items
        let oneItem = mediaItems![2]
        print("\nThe selected song is:", oneItem.title!)
        let twoItem = mediaItems![6]
        print("The next selected song is:", twoItem.title!)
        let tempSongs = MPMediaItemCollection.init(items: [oneItem, twoItem])
        musicP.setQueue(with: tempSongs)
        musicP.prepareToPlay()
    }
    
    func musicPrinter() {
        //Song names
        let mediaItems = MPMediaQuery.songs().items
        //print(mediaItems)
        print("\nSong info...")
        for case let unit in mediaItems! {
            let song = unit.title
            let artist = unit.artist
            //let album = unit.albumTitle
            //let pID = unit.persistentID
            print("The song is -", song!, "- by:", artist!)
        }
    }
    
}











/*
func getAudioSamples(forResource: String,
                            withExtension: String) -> (naturalTimeScale: CMTimeScale,
                                                       data: [Float])? {
    
    guard let path = Bundle.main.url(forResource: forResource,
                                     withExtension: withExtension) else {
                                        return nil
    }
    
    let asset = AVAsset(url: path.absoluteURL)
    
    guard
        let reader = try? AVAssetReader(asset: asset),
        let track = asset.tracks.first else {
            return nil
    }
    
    let outputSettings: [String: Int] = [
        AVFormatIDKey: Int(kAudioFormatLinearPCM),
        AVNumberOfChannelsKey: 1,
        AVLinearPCMIsBigEndianKey: 0,
        AVLinearPCMIsFloatKey: 1,
        AVLinearPCMBitDepthKey: 32,
        AVLinearPCMIsNonInterleaved: 1
    ]
    
    let output = AVAssetReaderTrackOutput(track: track,
                                          outputSettings: outputSettings)

    reader.add(output)
    reader.startReading()
    
    var samplesData = [Float]()
    
    while reader.status == .reading {
        if
            let sampleBuffer = output.copyNextSampleBuffer(),
            let dataBuffer = CMSampleBufferGetDataBuffer(sampleBuffer) {
            
                let bufferLength = CMBlockBufferGetDataLength(dataBuffer)
            
                var data = [Float](repeating: 0,
                                   count: bufferLength / 4)
                CMBlockBufferCopyDataBytes(dataBuffer,
                                           atOffset: 0,
                                           dataLength: bufferLength,
                                           destination: &data)
            
                samplesData.append(contentsOf: data)
        }
    }

    return (naturalTimeScale: track.naturalTimeScale,
            data: samplesData)
}

let samples: (naturalTimeScale: Int32, data: [Float]) = {
    guard let samples = getAudioSamples(
            forResource: "recording",
            withExtension: "m4a") else {
            fatalError("Unable to parse the audio resource.")
    }

    return samples
}()*/


//State vars before UI
/*
 @State var tempo: Double =  120
 @State var g1: Bool = false
 @State var g2: Bool = true
 @State var g3: Bool = false
 @State var g4: Bool = true
 @State var g5: Bool = false
 @State var g6: Bool = true
 @State var g7: Bool = false

 @State var record = false
 // creating instance for recroding...
 @State var session : AVAudioSession!
 @State var recorder : AVAudioRecorder!
 @State var alert = false
 // Fetch Audios...
 @State var audios : [URL] = []
 */


//UI STUFF
/*
 VStack() {
     
    Spacer().frame(height: 50)
     

     VStack() {
     Text("What are you doing right now?")
         .font(.headline)
         Picker(selection: .constant(3), label: Text("")) {
     Text("Working out").tag(1)
     Text("Car ride").tag(2)
     Text("Studying").tag(3)
     Text("Small group").tag(4)
     Text("Large group").tag(5)
     }
     .padding(90.0)
     .frame(width: 200.0, height: 180)
     Spacer().frame(height: 0)
     }

     
     
     VStack() {
     Text("Select the genres you'd like to hear")
         .font(.headline)
         

        Toggle(isOn: $g1) {
        Text("Rock")
        }
        .padding(.horizontal)
        .frame(width: 250, height: 30)
         
        Toggle(isOn: $g2) {
         Text("Jazz")
         }
         .padding(.horizontal)
         .frame(width: 250, height: 30)
         
         Toggle(isOn: $g3) {
         Text("Techno")
         }
         .padding(.horizontal)
         .frame(width: 250, height: 30)
     }
 }
     
 VStack() {
     Spacer().frame(height: 25)
     Text("What sort of mood are you in?").font(.headline)
         HStack() {
             Text("Aggressive")
             Toggle(isOn : $g4){ Text("a")
                 
         }.padding(.horizontal).frame(width: 50)
             Text("  Relaxed    ")
         }
         HStack() {
             Text("   Electronic")
             Toggle(isOn: $g5) { Text("b")
                 
             }.padding(.horizontal).frame(width: 50)
             Text("  Accoustic  ")
         }
         HStack() {
             Text("     Happy")
             Toggle(isOn: $g6) { Text("c")
                 
             }.padding(.horizontal).frame(width: 50)
             Text("   Sad        ")
         }
         HStack() {
             Text("      Big Party")
             Toggle(isOn: $g7) { Text("d")
                 
             }.padding(.horizontal).frame(width: 50)
             Text("  Small Group")
         }
     //.padding(-90.0)
     //.frame(width: 200.0, height: 180)
         Spacer().frame(height: 30)
         VStack(){
             
             Text("Select your speed/tempo").font(.headline)
             
             Slider(value: $tempo, in: 40...200).frame(width: 300)
             Text("\(Int(tempo))")
             Spacer().frame(height: 20)
             
         }
     }
 
     
 VStack() {
     VStack() {
         Text("Playback Controls").font(.headline)
         Spacer().frame(height: 10)
         Button(action: {musicP.setQueue(with: .songs())
                     musicP.play()}) {
             Text("Start")
     }
         VStack() {
         Spacer().frame(height: 10)
         Button(action: {
             musicP.pause()
             let mediaItems = MPMediaQuery.songs().items
             print("Songs:")
             //print(mediaItems)
             for case let unit in mediaItems! {
                 let saved = unit.title
                 print(saved)
             }
         }) {
             Text("Pause")
         }
         Spacer().frame(height: 10)
         Button(action: {musicP.play()}) {
             Text("Resume")
         }
     
         Spacer().frame(height: 10)
         Button(action: {musicP.skipToNextItem()
             musicP.play()
         }) {
         Text("Next song")
     }
         Spacer().frame(height: 10)
             Button(action: {musicP.skipToPreviousItem()
                 musicP.play()
             }){
                 Text("Previous Song")
             }
     }
     }
     
     VStack() {
         Text("Accelerometer values: ")
         //Put live updating values here
         HStack() {
             
          
         }
     }
   
     
     
 }
 */



