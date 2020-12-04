//
//  ValueAccess.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI
import Foundation
//import UIKit
//import AVFoundation
//import Accelerate
//import AVKit
import MediaPlayer
import CoreMotion

//Permanent/Changing vars go here or at top of other classes
let musicP = MPMusicPlayerApplicationController.applicationQueuePlayer
class MyData: ObservableObject {
    @Published var tempo : Double = 120
}
var motion = CMMotionManager()
var motion3 = CMDeviceMotion()


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
    
    func assignActivity() -> String {
        return happenActions[xSelection]
    }
    
    func assignGenres() -> [String] {
        
        var chosen = [String]()
        if (xBool[0]) {chosen.append("cla")}
        if (xBool[1]) {chosen.append("dan")}
        if (xBool[2]) {chosen.append("hip")}
        if (xBool[3]) {chosen.append("jaz")}
        if (xBool[4]) {chosen.append("pop")}
        if (xBool[5]) {chosen.append("rhy")}
        if (xBool[6]) {chosen.append("roc")}
        if (xBool[7]) {chosen.append("spe")}
        return chosen
    }
    
    func assignMoods() -> [String] {
        var choice1 = ""
        if (!xBool[8]) {
            choice1 = "Aggressive"
        } else {
            choice1 = "Relaxed"
        }
        
        var choice2 = ""
        if (!xBool[9]) {
            choice2 = "Electronic"
        } else {
            choice2 = "Accoustic"
        }
        
        var choice3 = ""
        if (!xBool[10]) {
            choice3 = "Happy"
        } else {
            choice3 = "Sad"
        }
        
        var choice4 = ""
        if (!xBool[11]) {
            choice4 = "Party"
        } else {
            choice4 = "Chill"
        }
        
        return [choice1, choice2, choice3, choice4]
    }
    
    func sortMoodAggressive(array: [Any]) -> [Any] {
        var out: [Any] = []
        for num in array.indices {
            if "\(array[num])" == "relaxed" {
                if "\(array[num+2])" == "aggressive" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["relaxed", array[num+1]]
                    } else {
                        out = out + ["aggressive", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "relaxed" {
                if "\(array[num+2])" == "not_aggressive" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["relaxed", array[num+1]]
                    } else {
                        out = out + ["relaxed", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_relaxed" {
                if "\(array[num+2])" == "aggressive" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["aggressive", array[num+1]]
                    } else {
                        out = out + ["aggressive", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_relaxed" {
                if "\(array[num+2])" == "not_aggressive" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["aggressive", array[num+1]]
                    } else {
                        out = out + ["relaxed", array[num+3]]
                    }
                }
            }
        }
        for i in out.indices {
            if "\(out[i])" == "relaxed" {
                out[i] = "aggressive"
                let b = out[i+1] as! Double
                out[i+1] = 100.0 - b
            }
        }
        var num: [Double] = []
        var new1: [Double] = []
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                num = num + [out[i] as! Double]
            }
        }
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                let b = out[i] as! Double
                new1 = new1+[(b-num.min()!)/(num.max()!-num.min()!)]
            }
        }
        let Aggressive = new1
        return Aggressive
    }
    
    func sortMoodElectronic(array: [Any]) -> [Any] {
        var out: [Any] = []
        for num in array.indices {
            if "\(array[num])" == "acoustic" {
                if "\(array[num+2])" == "electronic" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["acoustic", array[num+1]]
                    } else {
                        out = out + ["electronic", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "acoustic" {
                if "\(array[num+2])" == "not_electronic" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["acoustic", array[num+1]]
                    } else {
                        out = out + ["acoustic", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_acoustic" {
                if "\(array[num+2])" == "electronic" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["electronic", array[num+1]]
                    } else {
                        out = out + ["electronic", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_acoustic" {
                if "\(array[num+2])" == "not_electronic" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["electronic", array[num+1]]
                    } else {
                        out = out + ["acoustic", array[num+3]]
                    }
                }
            }
        }
        for i in out.indices {
            if "\(out[i])" == "acoustic" {
                out[i] = "electronic"
                let b = out[i+1] as! Double
                out[i+1] = 100.0 - b
            }
        }
        var num: [Double] = []
        var new1: [Double] = []
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                num = num + [out[i] as! Double]
            }
        }
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                let b = out[i] as! Double
                new1 = new1+[(b-num.min()!)/(num.max()!-num.min()!)]
            }
        }
        let Electronic = new1
        return Electronic
    }
    
    func sortMoodHappy(array: [Any]) -> [Any] {
        var out: [Any] = []
        for num in array.indices {
            if "\(array[num])" == "happy" {
                if "\(array[num+2])" == "sad" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["happy", array[num+1]]
                    } else {
                        out = out + ["sad", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "happy" {
                if "\(array[num+2])" == "not_sad" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["happy", array[num+1]]
                    } else {
                        out = out + ["happy", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_happy" {
                if "\(array[num+2])" == "sad" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["sad", array[num+1]]
                    } else {
                        out = out + ["sad", array[num+3]]
                    }
                }
            }
            if "\(array[num])" == "not_happy" {
                if "\(array[num+2])" == "not_sad" {
                    if array[num+1] as! Double > array[num+3] as! Double {
                        out = out + ["sad", array[num+1]]
                    } else {
                        out = out + ["happy", array[num+3]]
                    }
                }
            }
        }
        for i in out.indices {
            if "\(out[i])" == "happy" {
                out[i] = "sad"
                let b = out[i+1] as! Double
                out[i+1] = 100.0 - b
            }
        }
        var num: [Double] = []
        var new1: [Double] = []
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                num = num + [out[i] as! Double]
            }
        }
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                let b = out[i] as! Double
                new1 = new1+[(b-num.min()!)/(num.max()!-num.min()!)]
            }
        }
        let Happy = new1
        return Happy
    }
    
    
    func sortMoodParty(array: [Any]) -> [Any] {
        var out: [Any] = array
        for i in out.indices {
            if "\(out[i])" == "not_party" {
                out[i] = "party"
                let b = out[i+1] as! Double
                out[i+1] = 100.0 - b
            }
        }
        var num: [Double] = []
        var new1: [Double] = []
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                num = num + [out[i] as! Double]
            }
        }
        for i in out.indices {
            if "\(type(of: out[i]))" != "String" {
                let b = out[i] as! Double
                new1 = new1+[(b-num.min()!)/(num.max()!-num.min()!)]
            }
        }
        let Party = new1
        return Party
    }
    
    
    
    func calculate() -> [[Any]] {
        
        var moodSettings = assignMoods()
        var inputTempo = xTempo
        var rmsInput = xAcd
        var inputGenre = assignGenres()
        var activity = assignActivity()
        
        //Temporary test values
        moodSettings = ["Aggressive", "Electronic", "Sad", "Chill"]
        inputTempo = 140.0
        rmsInput = 0.25
        inputGenre = ["jaz", "pop"]
        activity = "Studying"
        
        // Determine the file name
        let filename = "songs.txt"

        // Read the contents of the specified file
        let contents = try! String(contentsOfFile: filename)

        // Split the file into separate lines
        let lines = contents.components(separatedBy: "\n")

        //variable was "line" before but didnt seem to be used
        let _: [Any] = Array(String(lines[0]))
        
        var mbid_array: [Any] = []
        for i in lines.indices {
            let stringArray = lines[i]
            let stringArrayCleaned = stringArray.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "")
            //let stringArrayCleaned1: [Any] = stringArrayCleaned
            let b = Array(stringArrayCleaned)
            var h: String = ""
            for i in b.indices {
                h = h + String(b[i])
            }
            var sarray = h.components(separatedBy: CharacterSet(charactersIn: ",]"))
            for i in sarray.indices {
                sarray[i] = sarray[i].replacingOccurrences(of: "\'", with: "").replacingOccurrences(of: " ", with: "")
            }
            //print(sarray)
            var news: [Any] = []
            for i in sarray.indices {
                if sarray[i] != "" {
                    news = news + [sarray[i]]
                }
            }
            mbid_array = mbid_array + [news]
        }
        
        let f = mbid_array[1] as! [Any]
        let num_songs: Int = f.count

        let moods = mbid_array[0] as! [Any]
        let tempo = mbid_array[1] as! [Any]
        let rms = mbid_array[2] as! [String]
        let titles = mbid_array[3] as! [Any]
        let artists = mbid_array[4] as! [Any]
        //let albums = mbid_array[5] as! [Any]
        //let dates = mbid_array[6] as! [Any]
        //let tracknum = mbid_array[7] as! [Any]
        let genre = mbid_array[8] as! [String]
        
        var mood_array: [Any] = []
        for i in 0...num_songs-1 {
            mood_array = mood_array + [Array(moods[(i*14)..<(i*14+14)])]
        }

        var songsAggressive: [Any] = []
        var songsElectronic: [Any] = []
        var songsHappy: [Any] = []
        var songsParty: [Any] = []
        for i in mood_array.indices {
            songsAggressive = songsAggressive + (mood_array[i] as! [Any])[0..<4]
            songsElectronic = songsElectronic + (mood_array[i] as! [Any])[4..<8]
            songsHappy = songsHappy + (mood_array[i] as! [Any])[8..<12]
            songsParty = songsParty + (mood_array[i] as! [Any])[12..<14]
        }
        
        for i in songsAggressive.indices {
            if i % 2 != 0 {
                let b: Any = songsAggressive[i]
                songsAggressive[i] = (b as! NSString).doubleValue
            }
        }
        for i in songsElectronic.indices {
            if i % 2 != 0 {
                let b: Any = songsElectronic[i]
                songsElectronic[i] = (b as! NSString).doubleValue
            }
        }
        for i in songsHappy.indices {
            if i % 2 != 0 {
                let b: Any = songsHappy[i]
                songsHappy[i] = (b as! NSString).doubleValue
            }
        }
        for i in songsParty.indices {
            if i % 2 != 0 {
                let b: Any = songsParty[i]
                songsParty[i] = (b as! NSString).doubleValue
            }
        }
        
        let A = sortMoodAggressive(array: songsAggressive)
        let E = sortMoodElectronic(array: songsElectronic)
        let H = sortMoodHappy(array: songsHappy)
        let P = sortMoodParty(array: songsParty)
        var allMoods: [Any] = []
        for i in A.indices {
            var moods: [Any] = []
            if A[i] as! Double >= 0.5 {
                moods = moods + ["Aggressive"]
            } else {
                moods = moods + ["Relaxed"]
            }
            if E[i] as! Double >= 0.5 {
                moods = moods + ["Electronic"]
            } else {
                moods = moods + ["Acoustic"]
            }
            if H[i] as! Double >= 0.5 {
                moods = moods + ["Happy"]
            } else {
                moods = moods + ["Sad"]
            }
            if P[i] as! Double >= 0.5 {
                moods = moods + ["Party"]
            } else {
                moods = moods + ["Chill"]
            }
            allMoods = allMoods + [moods]
        }
        
        let songMoodValues = allMoods
        var songChoice: [String] = []
        for i in songMoodValues.indices {
            if songMoodValues[i] as! [String] == moodSettings {
                songChoice = songChoice + [titles[i] as! String]
            }
        }
        
        var temposort: [String] = []
        for i in titles.indices {
            if songChoice.contains(titles[i] as! String) {
                if ((tempo[i] as! NSString).doubleValue) >= (inputTempo - 20.0) && ((tempo[i] as! NSString).doubleValue) <= (inputTempo + 20.0) {
                    temposort = temposort + [titles[i] as! String]
                }
            }
        }
        
        let drms = rms.compactMap { (value) -> Double? in
            return Double(value)!
        }
        var nrms: [Double] = []
        for i in drms.indices {
            let b = drms[i] //as! Double
            nrms = nrms+[(b-drms.min()!)/(drms.max()!-drms.min()!)]
        }
        
        let inputstart: Double = 0.0    //Maps RMS Calculation based on activity
        let inputend: Double = 1.0
        var outputstart: Double = 0.0
        var outputend: Double = 1.0
        if activity == "Working Out" {
            outputstart = 0.8
            outputend = 1.0
        } else if activity == "Large Group" {
            outputstart = 0.6
            outputend = 0.8
        } else if activity == "Car Ride" {
            outputstart = 0.4
            outputend = 0.6
        } else if activity == "Small Group" {
            outputstart = 0.2
            outputend = 0.4
        } else if activity == "Studying" {
            outputstart = 0.0
            outputend = 0.2
        }
        
        
        var rmsValue: Double = outputstart + ((outputend - outputstart) / (inputend - inputstart)) * (rmsInput - inputstart)
        var rmssort: [String] = []
        for i in titles.indices {
            if temposort.contains(titles[i] as! String) {
                if (nrms[i]) >= (rmsValue - 0.25) && (nrms[i]) <= (rmsValue + 0.25) {
                    rmssort = rmssort + [titles[i] as! String]
                }
            }
        }
        
        var genresort: [String] = []  //Picks songs based on genre input
        for i in titles.indices {
            if rmssort.contains(titles[i] as! String) {
                if inputGenre.contains(genre[i]) {
                    genresort = genresort + [titles[i] as! String]
                }
            }
        }
        
        var finalsongs: [[Any]] = []
        for i in titles.indices {
            if rmssort.contains(titles[i] as! String) {
                finalsongs = finalsongs + [[titles[i], artists[i]]]
            }
        }
        finalsongs.shuffle()
        //print(finalsongs)
        //return finalsongs
        return [["Test"],["Array"]]
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



