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
import AVFoundation
import Accelerate
import AVKit
import MediaPlayer

let VA = ValueAccess()

var xTempo: Double = -1
var xBool: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false]
var happenActions = ["Working Out", "Car Ride", "Studying", "Small Group", "Large Group"]
var xSelection: Int = -1
var xAcd: Double = 0.0

struct ContentView: View {
    //@ObservedObject var data = MyData()
    @State var tempo2 : Double = 120
    
    @State var g1: Bool = false
    @State var g2: Bool = false
    @State var g3: Bool = false
    @State var g4: Bool = false
    @State var g5: Bool = true
    @State var g6: Bool = false
    @State var g7: Bool = false
    @State var g8: Bool = false
    
    @State var g9: Bool = true
    @State var g10: Bool = false
    @State var g11: Bool = true
    @State var g12: Bool = false
    
    @State var accelx : Double = 0.0
    @State var accely : Double = 0.0
    @State var accelz : Double = 0.0
    @State var accelmag : Double = 0.0
    
    @State var selectedAction = 2
    @State var showingAlert = false
    
    func exportTempo() {
        xTempo = tempo2
    }
    func exportBools() {
        xBool = [g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, g12]
    }
    func exportSelection() {
        //This is only the index, not the actual choice
        //To get actual choice (String), acess happenActions at index xSelection
        xSelection = selectedAction
    }
    
    func getMag() -> Double {
        return self.accelmag
    }
    
    func exportAccelMag() {
        motion.deviceMotionUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            if let mD = data {
                self.accelx = mD.userAcceleration.x
                self.accely = mD.userAcceleration.y
                self.accelz = mD.userAcceleration.z
                self.accelmag = sqrt(pow(self.accelx, 2) + pow(self.accely, 2) + pow(self.accelz, 2))
                xAcd = self.accelmag
            }
        }
        var poss = [-99.9]
        let bruh = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            poss.append(getMag())
            print(getMag())
        }
        let _ = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: false) { timer in
            xAcd = poss.max()!
            print("Max value in last 5 seconds:")//delete this and following 2 lines as well
            print(xAcd)
            accelmag = xAcd
            motion.stopDeviceMotionUpdates()
            bruh.invalidate()
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack() {
                
               Spacer().frame(height: 50)

                //Actions
                VStack() {
                Text("What are you doing right now?")
                    .font(.headline)
                Picker(selection: $selectedAction, label: Text("")) {
                    ForEach(0 ..< happenActions.count) {
                        Text(happenActions[$0])
                    }
                }
                .padding(90.0)
                .frame(width: 200.0, height: 180)
                Spacer().frame(height: 0)
                }
                
                //Genres
                VStack() {
                Text("Select the genres you'd like to hear")
                    .font(.headline)
                    
                   Toggle(isOn: $g1) {
                   Text("Classical")
                   }
                   .padding(.horizontal)
                   .frame(width: 200, height: 30)
                    
                   Toggle(isOn: $g2) {
                    Text("Dance")
                    }
                    .padding(.horizontal)
                    .frame(width: 200, height: 30)
                    
                    Toggle(isOn: $g3) {
                    Text("Hip-Hop")
                    }
                    .padding(.horizontal)
                    .frame(width: 200, height: 30)
                    VStack() {
                        Toggle(isOn: $g4) {
                        Text("Jazz")
                        }
                        .padding(.horizontal)
                        .frame(width: 200, height: 30)
                         
                        Toggle(isOn: $g5) {
                         Text("Pop")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                         
                         Toggle(isOn: $g6) {
                         Text("RnB")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                    }
                    VStack() {
                        Toggle(isOn: $g7) {
                        Text("Rock")
                        }
                        .padding(.horizontal)
                        .frame(width: 200, height: 30)
                         
                        Toggle(isOn: $g8) {
                         Text("Speech")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                    }
                }
                }
                
                //Moods
                VStack() {
                    Spacer().frame(height: 25)
                    Text("What sort of mood are you in?").font(.headline)
                        HStack() {
                            Text("Aggressive")
                            Toggle(isOn : $g9){ Text("a")
                            
                            }.padding(.horizontal).frame(width: 50)
                            Text("  Relaxed    ")
                        }
                        HStack() {
                            Text("   Electronic")
                            Toggle(isOn: $g10) { Text("b")
                            
                            }.padding(.horizontal).frame(width: 50)
                            Text("  Accoustic  ")
                        }
                        HStack() {
                            Text("     Happy")
                            Toggle(isOn: $g11) { Text("c")
                            
                            }.padding(.horizontal).frame(width: 50)
                            Text("   Sad        ")
                        }
                        HStack() {
                            Text("      Big Party")
                            Toggle(isOn: $g12) { Text("d")
                            
                            }.padding(.horizontal).frame(width: 50)
                            Text("  Small Group")
                        }
                    
                //Tempo
                Spacer().frame(height: 30)
                VStack(){
                        
                        Text("Select your speed/tempo").font(.headline)
                        Slider(value: $tempo2, in: 40...200).frame(width: 300)
                        Text("\(Int(tempo2))")
                        Spacer().frame(height: 20)
                        
                }
                
                //Update
                VStack() {
                    
                    Text("Press here to update your choices").font(.headline)
                    Spacer().frame(height: 15)
                    HStack() {
                        
                        Button(action: {
                            if ((!g1 && !g2 && !g3 && !g4 && !g5 && !g6 && !g7 && !g8)) {
                                showingAlert.toggle()
                            } else {
                                //"Export" values to global variables
                                self.exportTempo()
                                self.exportBools()
                                self.exportSelection()
                                //self.startAccel()
                                self.exportAccelMag()
                                //self.stopAccel()
                                
                                //Below prints out all current values
                                //Just for the console, no affect on the app
                                print("\n\nValues of current measureable elements:")
                                
                                //Selector value
                                print("\nCurrent seleceted action...")
                                let cac = happenActions[xSelection]
                                //cac uses global index with the possible options
                                print(cac)
                                
                                //Booleans
                                print("\nBoolean values...")
                                print(xBool)
                                
                                //Tempo
                                print("\nSelected tempo...")
                                print(xTempo)
                                
                                //Songs
                                VA.musicPrinter()
                                
                                //Test stuff again
                            }

                        }) {
                            Text("Update!")
                        }
                     
                    }
                    Spacer().frame(height: 20)
                    Text("\(Double(accelx))")
                    Text("\(Double(accely))")
                    Text("\(Double(accelz))")
                    Text("\(Double(accelmag))").font(.headline)
                }
              
                
            }
    
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Attention!"), message: Text("Please select at least one genre"), dismissButton: .default(Text("OK")))
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


    







//This stuff below is just test stuff, it's not important to our intial project it's just for reference
/*
//Above:
 var y : Int = 0
 @State var yes = String(y)

 
 
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







/*
    //Eli's recorder stuff goes in this object
    VStack() {
        List(self.audios,id: \.self){i in
        
        // printing only file name...
        
        Text(i.relativeString)
        }
    
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
                                        .stroke(Color.black, lineWidth: 6)
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
                    print("url:")
                    print(url)
                    // fetch all data from document directory...
                    let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
                    print("result:")
                    print(result)
                    
                    let urlString = try String(contentsOf: url)
                    let testThing = try FileManager.default.contentsOfDirectory(atPath: urlString)
                    print("test result: ")
                    print(testThing)
                    
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
        }*/



/*
 func startAccel() {
     motion.deviceMotionUpdateInterval = 0.5
     motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
         if let mD = data {
             self.accelx = mD.userAcceleration.x
             self.accely = mD.userAcceleration.y
             self.accelz = mD.userAcceleration.z
             self.accelmag = sqrt(pow(self.accelx, 2) + pow(self.accely, 2) + pow(self.accelz, 2))
             xAcd = self.accelmag
         }
     }
 }
 
 func stopAccel() {
     motion.stopDeviceMotionUpdates()
 }
 */
