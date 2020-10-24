//
//  ContentView.swift
//  PST2Att1
//
//  Created by Sean on 9/24/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI
import UIKit
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
    
    var body: some View {
        ScrollView {
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
            //.padding(-90.0)
            .frame(width: -200.0, height: 180)
            Spacer().frame(height: 0)
            }
 
            
            
            VStack() {
            Text("Select the genres you'd like to hear")
                .font(.headline)
                
               Toggle(isOn: $g1) {
               Text("Rock")
               }
               .padding(.horizontal)
               .frame(width: -250.0, height: 30)
                
               Toggle(isOn: $g2) {
                Text("Jazz")
                }
                .padding(.horizontal)
                .frame(width: -250.0, height: 30)
                
                Toggle(isOn: $g3) {
                Text("Techno")
                }
                .padding(.horizontal)
                .frame(width: -250.0, height: 30)
            }
            
            VStack() {
            Spacer().frame(height: 25)
            Text("What sort of mood are you in?").font(.headline)
                HStack() {
                    Text("Aggressive")
                    Toggle(isOn: $g4) {
                        
                    }.padding(.horizontal).frame(width: 50)
                    Text("  Relaxed    ")
                }
                HStack() {
                    Text("   Electronic")
                    Toggle(isOn: $g5) {
                        
                    }.padding(.horizontal).frame(width: 50)
                    Text("  Accoustic  ")
                }
                HStack() {
                    Text("     Happy")
                    Toggle(isOn: $g6) {
                        
                    }.padding(.horizontal).frame(width: 50)
                    Text("   Sad        ")
                }
                HStack() {
                    Text("      Big Party")
                    Toggle(isOn: $g7) {
                        
                    }.padding(.horizontal).frame(width: 50)
                    Text("  Small Group")
                }
            //.padding(-90.0)
            //.frame(width: -200.0, height: 180)
            Spacer().frame(height: 20)
                VStack(){
                    Text("Select your speed/tempo").font(.headline)
                    Slider(value: $tempo, in: 40...200)
                        .frame(width: -300)
                    Text("\(Int(tempo))")
                    Spacer().frame(height: 20)
                }
            }
            
            
            VStack() {
                Text("Playback Controls").font(.headline)
                Spacer().frame(height: 10)
                Button(action: {musicP.setQueue(with: .songs())
                musicP.play()}) {
                    Text("Start")
            }
                Spacer().frame(height: 10)
                Button(action: {
                    musicP.pause()
                }) {
                    Text("Pause")
                }
                Spacer().frame(height: 10)
                Button(action: {musicP.play()}) {
                    Text("Resume")
                }
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
            }
                      ) {
                Text("Previous Song")
            }
            
            
            //Eli's recorder stuff goes in this object
            VStack() {
               
                
                
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
            
        }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

