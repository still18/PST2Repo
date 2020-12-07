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
var happenActions = ["Studying", "Car Ride", "Working Out", "With Friends", "In a Crowd"]
var xSelection: Int = -1
var xAcd: Double = 0.0
var initialSet: Bool = false
var buttonStatus: Bool = false

struct ContentView: View {
    @State var tempo2 : Double = 120
    
    @State var buttonText : String = "Set my choices!"
    
    @State var g1: Bool = false
    @State var g2: Bool = false
    @State var g3: Bool = false
    @State var g4: Bool = false
    @State var g5: Bool = true
    @State var g6: Bool = false
    @State var g7: Bool = false
    @State var g8: Bool = false
    
    @State var g9: Bool = false
    @State var g10: Bool = false
    @State var g11: Bool = false
    @State var g12: Bool = true
    
    @State var accelx : Double = 0.0
    @State var accely : Double = 0.0
    @State var accelz : Double = 0.0
    @State var accelmag : Double = 0.0
    
    @State var selectedAction = 2
    @State var showingAlert = false
    @State var firstTimeAlg = true
    
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
        }
        let _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
            xAcd = poss.max()!
            //print("Max value in last 4 seconds:")
            //print(xAcd)
            accelmag = xAcd
            motion.stopDeviceMotionUpdates()
            bruh.invalidate()
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack() {
                
                //Header
                VStack() {
                    Spacer().frame(height: 10)
                    Text("Move-it Music!").font(.custom("Marker Felt Thin", size: 42))
                        .foregroundColor(.blue)
                    Spacer().frame(height: 20)
                }

                //Actions
                VStack() {
                Text("What are you doing right now?")
                    .font(.custom("Big Caslon", size: 22)).fontWeight(.bold)
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
                    .font(.custom("Big Caslon", size: 22)).fontWeight(.bold)
                    
                   Toggle(isOn: $g1) {
                   Text("Classical")
                   }
                   .padding(.horizontal)
                   .frame(width: 200, height: 30)
                   .toggleStyle(SwitchToggleStyle(tint: .purple))
                    
                   Toggle(isOn: $g2) {
                    Text("Dance")
                    }
                    .padding(.horizontal)
                    .frame(width: 200, height: 30)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    
                    Toggle(isOn: $g3) {
                    Text("Hip-Hop")
                    }
                    .padding(.horizontal)
                    .frame(width: 200, height: 30)
                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                    VStack() {
                        Toggle(isOn: $g4) {
                        Text("Jazz")
                        }
                        .padding(.horizontal)
                        .frame(width: 200, height: 30)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                         
                        Toggle(isOn: $g5) {
                         Text("Pop")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                         .toggleStyle(SwitchToggleStyle(tint: .purple))
                         
                         Toggle(isOn: $g6) {
                         Text("RnB")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                         .toggleStyle(SwitchToggleStyle(tint: .purple))
                    }
                    VStack() {
                        Toggle(isOn: $g7) {
                        Text("Rock")
                        }
                        .padding(.horizontal)
                        .frame(width: 200, height: 30)
                        .toggleStyle(SwitchToggleStyle(tint: .purple))
                         
                        Toggle(isOn: $g8) {
                         Text("Speech")
                         }
                         .padding(.horizontal)
                         .frame(width: 200, height: 30)
                         .toggleStyle(SwitchToggleStyle(tint: .purple))
                    }
                }
                }
                
                //Moods
                VStack() {
                    Spacer().frame(height: 25)
                    Text("What sort of mood are you in?").font(.custom("Big Caslon", size: 22)).fontWeight(.bold)
                        HStack() {
                            Text("Aggressive")
                            Toggle(isOn : $g9){ Text("a")
                            
                            }.padding(.horizontal).frame(width: 50)
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            Text("  Relaxed    ")
                        }
                        HStack() {
                            Text("   Electronic")
                            Toggle(isOn: $g10) { Text("b")
                            
                            }.padding(.horizontal).frame(width: 50)
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            Text("  Accoustic  ")
                        }
                        HStack() {
                            Text("     Happy")
                            Toggle(isOn: $g11) { Text("c")
                            
                            }.padding(.horizontal).frame(width: 50)
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            Text("   Sad        ")
                        }
                        HStack() {
                            Text("      Big Party")
                            Toggle(isOn: $g12) { Text("d")
                            
                            }.padding(.horizontal).frame(width: 50)
                            .toggleStyle(SwitchToggleStyle(tint: .green))
                            Text("  Small Group")
                        }
                    
                //Tempo
                Spacer().frame(height: 30)
                VStack(){
                        
                        Text("Select your speed/tempo").font(.custom("Big Caslon", size: 22)).fontWeight(.bold)
                        Slider(value: $tempo2, in: 40...200).frame(width: 300)
                        Text("\(Int(tempo2))")
                        Spacer().frame(height: 10)
                        
                }
                
                //Update
                VStack() {
                    
                    Spacer().frame(height: 10)
                    HStack() {
                        
                        Button(action: {
                            
                            //Make sure genre is selected
                            if ((!g1 && !g2 && !g3 && !g4 && !g5 && !g6 && !g7 && !g8)) {
                                showingAlert.toggle()
                            } else {
                                buttonStatus = true
                                buttonText = "Processing..."
                                
                                //Start external accel timer and button timer
                                self.exportAccelMag()
                                let _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                                    
                                    initialSet = true
                                    
                                    //"Export" values to global variables
                                    self.exportTempo()
                                    self.exportBools()
                                    self.exportSelection()
                                    
                                    /*
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
                                    print(VA.musicNameComp())
                                    */
                                    
                                    //VA Stuff: runs actual mapping and sets songs
                                    let butRes = VA.calculate(firstTime: firstTimeAlg)
                                    //print(butRes)
                                    VA.makeQueue(songArtistList: butRes)
                                    
                                    //Starts monitoring accelerometer for large changes, waits extra minute the first time
                                    if (firstTimeAlg) {
                                        let _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { timer in
                                            VA.monitorMotion()
                                        }
                                    }
                                    self.firstTimeAlg = false
                                    buttonText = "Done!"
                                    buttonStatus = false
                                    
                                }
                                //revert button text
                                let _ = Timer.scheduledTimer(withTimeInterval: 6.5, repeats: false) { timer in
                                    buttonText = "Update my choices!"
                                }
                            }

                        }) {
                            Text("\(String(buttonText))").font(.custom("Marker Felt Thin", size: 26))
                                .foregroundColor(.white)
                        }.buttonStyle(NeumorphicButtonStyle(bgColor: .blue))
                     
                    }
                    Spacer().frame(height: 20)
                }
              
                
            }
    
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Attention!"), message: Text("Please select at least one genre."), dismissButton: .default(Text("OK!")))
        }

    }
}

//Button styling
struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


