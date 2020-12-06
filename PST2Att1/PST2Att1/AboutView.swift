//
//  AboutView.swift
//  PST2Att1
//
//  Created by Sean on 11/13/20.
//  Copyright © 2020 SeanTillman. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Spacer().frame(height: 10)
            Text("Move-it Music!").font(.custom("Marker Felt Thin", size: 42))
                .foregroundColor(.blue)
            VStack() {
                Spacer().frame(height: 35)
                Text("Move-it Music is designed to take the already great music on your phone and play back songs according to whatever you happen to be doing! You simply fill our the first page, press a button, and listen!")
                Spacer().frame(height: 10)
                Text("What it does:").fontWeight(.bold)
                Text("Our application uses your deisred choices as well as motion data to select songs from your device to play while you are doing something else. Rather than being purely randomized, or drawing from a set playlist, Move-it Music uses the given inputs to narrow down and select the most fitting songs for your given activity and mood. Additionally, your motion data will be lightly monitored so that if there is a big change in your movement, the music will adjust accordingly. For more information on exactly how this is accomplished, please consult our GitHub page (link below).")
                Spacer().frame(height: 17)
                Text("How to use:").fontWeight(.bold)
                Text("First of all, make sure you've followed all of the insructions on our GitHub page. On the presets page, start by chosing your activity or whatever matches best. \"Move-it\" music works even if you're not moving, so if you're just sitting with friends it will work just fine. Then, flip on the switches for all of the genres you'd like Move-it Music to choose from. Our algorithms will try to select songs of the selected genres first, though you may here other related songs if you don't have many on your device. Next, look at the following 4 switches and move it to the side that best describes your mood. Right below that you can change the speed of your music (which is indicated in BPM below) using the slider. Finally, hit \"Set my choices!\" and after a couple seconds your music will start to play! If at any time you'd like to change your selections, just go back to the back page and hit the button again after changing the desired options. [PLAYBACK INFORMATION HERE]")
                
            }.frame(width: 320)
            
            VStack() {
                Spacer().frame(height: 17)
                Text("Future possibilities:").fontWeight(.bold)
                Text("-Full support with Apple Music")
                Text("-Using input audio to increase accuracy")
                Text("-Online music meta data collection")
            }.frame(width: 320)
            
            VStack() {
                Image("david_is_here").resizable().scaledToFit()
                Spacer().frame(height: 17)
                Text("Our GitHub: ").fontWeight(.bold)
                Spacer().frame(height: 12)
                //Text("[put tinyurl or button here]")
                Link("MAKE PUBLIC SEAN", destination: URL(string: "https://github.com/still18/PST2Repo")!)
                    .font(.custom("Big Caslon", size: 24))
            }.frame(width: 320)
            
            VStack() {
                Spacer().frame(height: 35)
                Text("This app was made for educational purposes by students from the Georgia Institute of Technology. It is not meant for any commerical use. All images and fonts used are free use. The developers of this application are not responsible for the music played and the rating of said music. Please do not use this application while operating a motor vehicle.").font(.custom("Helvetica Neue", size: 8)).multilineTextAlignment(.center)
                Image("copyright").resizable().frame(width: 20, height: 15)
                Text("pre_release-1.0")
                Spacer().frame(height: 8)
            }.frame(width: 200).font(.custom("Helvetica Neue", size: 6))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
