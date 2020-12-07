//
//  ContentView.swift
//  record button
//
//  Created by Eli Ruckle on 10/18/20.
//  Copyright © 2020 Eli Ruckle. All rights reserved.
//
import SwiftUI
import AVKit
import UIKit

struct ContentView: View {
    var body: some View {
        
        Home()
            // always dark mode...
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var record = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    // Fetch Audios...
    @State var audios : [URL] = []
    
    var body: some View{
        
        NavigationView{
            
            VStack{
                
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
                            // updating data for every rcd...
                            self.getAudios()
                            return
                        }
                        
                        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        
                        // same file name...
                        // so were updating based on audio count...
                        let filName = url.appendingPathComponent("record\(self.audios.count + 1).m4a")
                        
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






