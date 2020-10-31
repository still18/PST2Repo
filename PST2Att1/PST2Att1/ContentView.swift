//
//  ContentView.swift
//  PST2Att1
//
//  Created by Sean on 9/24/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit
import AVKit
import MediaPlayer

var y : Int = 0
let musicP = MPMusicPlayerApplicationController.applicationQueuePlayer



struct ContentView: View {
    @State var yes = String(y)
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
    
    var body: some View {
        ScrollView {
       // VStack() {
            
         //   Spacer().frame(height: 50)
            
           // VStack() {
           // Text("What are you doing right now?")
           //     .font(.headline)
           //     Picker(selection: .constant(3), label: Text("")) {
          //  Text("Working out").tag(1)
          //  Text("Car ride").tag(2)
          //  Text("Studying").tag(3)
          //  Text("Small group").tag(4)
          //  Text("Large group").tag(5)
          //  }
            //.padding(-90.0)
          //  .frame(width: -200.0, height: 180)
          //  Spacer().frame(height: 0)
          //  }
 
            
            
           // VStack() {
           // Text("Select the genres you'd like to hear")
             //   .font(.headline)
                
           //    Toggle(isOn: $g1) {
            //   Text("Rock")
            //   }
             //  .padding(.horizontal)
             //  .frame(width: -250.0, height: 30)
                
           //    Toggle(isOn: $g2) {
            //    Text("Jazz")
            //    }
            //    .padding(.horizontal)
            //    .frame(width: -250.0, height: 30)
                
             //   Toggle(isOn: $g3) {
             //   Text("Techno")
              //  }
              //  .padding(.horizontal)
               // .frame(width: -250.0, height: 30)
           // }
            
        //    VStack() {
        //    Spacer().frame(height: 25)
          //  Text("What sort of mood are you in?").font(.headline)
       //         HStack() {
            //        Text("Aggressive")
              //      Toggle(isOn : $g4){ Text("a")
                        
                    //}.padding(.horizontal).frame(width: 50)
        //            Text("  Relaxed    ")
             //   }
          //      HStack() {
            //        Text("   Electronic")
              //      Toggle(isOn: $g5) { Text("b")
                        
                    //}.padding(.horizontal).frame(width: 50)
                   // Text("  Accoustic  ")
               // }
               // HStack() {
                //    Text("     Happy")
                 //   Toggle(isOn: $g6) { Text("c")
                        
                    //}.padding(.horizontal).frame(width: 50)
                   // Text("   Sad        ")
                //}
                //HStack() {
                  //  Text("      Big Party")
                    //Toggle(isOn: $g7) { Text("d")
                        
                    //}.padding(.horizontal).frame(width: 50)
                    //Text("  Small Group")
                //}
            //.padding(-90.0)
            //.frame(width: -200.0, height: 180)
           // Spacer().frame(height: 20)
              //  VStack(){
                //    Text("Select your speed/tempo").font(.headline)
                  //  Slider(value: $tempo, in: 40...200)
                    //    .frame(width: -300)
               //     Text("\(Int(tempo))")
                   // Spacer().frame(height: 20)
                //}
            //}
            
            
         //   VStack() {
           //     Text("Playback Controls").font(.headline)
             //   Spacer().frame(height: 10)
               // Button(action: {musicP.setQueue(with: .songs())
                //musicP.play()}) {
             //       Text("Start")
           // }
             //   Spacer().frame(height: 10)
               // Button(action: {
                //    musicP.pause()
               // }) {
                //    Text("Pause")
                //}
                //Spacer().frame(height: 10)
                //Button(action: {musicP.play()}) {
                  //  Text("Resume")
                //}
            //}
              //  Spacer().frame(height: 10)
               // Button(action: {musicP.skipToNextItem()
                 //   musicP.play()
                //}) {
                //Text("Next song")
           // }
             //   Spacer().frame(height: 10)
           // Button(action: {musicP.skipToPreviousItem()
               // musicP.play()
            //}
              //        ) {
                //Text("Previous Song")
            //}
            
            //Eli's recorder stuff goes in this object
            VStack() {
                
                                Button(action: {

                                    // Now going to record audio...
                                    
                                    // Intialization...
                                    
                                    // Were going to store audio in document directory...
                                    
                                    do{
                                        
                                        if self.record{
                                            
                                            // Already Started Recording means stopping and saving...
                                            
                                            self.recorder.stop()
                                            self.record.toggle()
                                            // updating data for every record...
                                            self.getAudios()
                                            return
                                        }
                                        
                                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                        
                                        // same file name...
                                        // it is updating based on audio count...
                                        let filName = url.appendingPathComponent("recording.m4a")
                                        
                                        let settings = [
                                        
                                            AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                                            AVSampleRateKey : 44100,
                                            AVNumberOfChannelsKey : 2,
                                            AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue
                                        
                                        ]
                                        
                                        self.recorder = try AVAudioRecorder(url: filName, settings: settings)
                                        self.recorder.record()
                                        self.record.toggle()
                                    }
                                    catch{
                                        
                                        print(error.localizedDescription)
                                    }
                                    
                                    
                                }) {
                                    
                                    ZStack{
                                        
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 70, height: 70)
                                        
                                        if self.record{
                                            
                                            Circle()
                                                .stroke(Color.white, lineWidth: 6)
                                                .frame(width: 85, height: 85)
                                        }
                                    }
                                }
                                .padding(.vertical, 25)
                            }
                            .navigationBarTitle("Record Audio")
                        }
                        .alert(isPresented: self.$alert, content: {
                            
                            Alert(title: Text("Error"), message: Text("Enable Acess"))
                        })
                        .onAppear {
                            
                            do{
                                
                                // Intializing...
                                
                                self.session = AVAudioSession.sharedInstance()
                                try self.session.setCategory(.playAndRecord)
                                
                                // requesting permission
                                // for this we require microphone usage description in info.plist...
                                self.session.requestRecordPermission { (status) in
                                    
                                    if !status{
                                        
                                        // error msg...
                                        self.alert.toggle()
                                    }
                                    else{
                                        
                                        // if permission granted means fetching all data...
                                        
                                        self.getAudios()
                                    }
                                }
                                
                                
                            }
                            catch{
                                
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    func getAudios(){
                        
                        do{
                            
                            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            
                            // fetch all data from document directory...
                            
                            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
                            
                            // updated means remove all old data..
                            
                            self.audios.removeAll()
                            
                            for i in result{
                                
                                self.audios.append(i)
                            }
                        }
                        catch{
                            
                            print(error.localizedDescription)
                        }
                    }
                }
            
            
            
            
            //This stuff below is just test stuff, it's not important to our intial project it's just for reference
            /*
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
        
             */
            /*
            
            Picker(selection: .constant(33), label: Text("")) {
        Text("Option 1").tag(11)
        Text("Option 2").tag(22)
        Text("Option 3").tag(33)
        Text("Option 4").tag(44)
        Text("Option 5").tag(55)
        }*/
            
       // }
        //}
    //}
    
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

