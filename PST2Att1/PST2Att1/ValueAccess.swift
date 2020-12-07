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
var motion = CMMotionManager()
//var motion3 = CMDeviceMotion()

var tempAcc: Double = 0.0
var postAcc: Double = 0.0
var playbackFirst: Bool = true
var endSong: String = "~~~~~"

var ilist: [Int] = []
var moods: [String] = []
var tempo : [String] = []
var rms : [String] = []
var titles : [String] = []
var artists : [String] = []
var albums : [String] = []
var dates : [String] = []
var tracknum : [String] = []
var genre : [String] = []

var maxAmount: Int = -1


extension Array where Element: Hashable {     //NEW STUFF    COMPARES LIST SIMILARITY
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
extension Array {
    mutating func remove(at indexs: [Int]) {
        guard !isEmpty else { return }
        let newIndexs = Set(indexs).sorted(by: >)
        newIndexs.forEach {
            guard $0 < count, $0 >= 0 else { return }
            remove(at: $0)
        }
    }
}


//Functions and temporary vars go here
class ValueAccess {
    
    //@ObservedObject var yeet = SongPlaying()
    
    
    func startDefaultQueue() {
        musicP.setQueue(with: .songs())
        musicP.prepareToPlay()
        //musicP.play()
    }
    
    func pauseMusic() {
        musicP.pause()
        //yeet.songName = "bet?"
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
    
    func makeQueue(songArtistList: [Any]) {
        
        if (!playbackFirst) {
            pauseMusic()
        }
        var mutableThing = songArtistList
        //first time through
        let firstSong = mutableThing[0] as! [String]
        let t1 = MPMediaPropertyPredicate(value: firstSong[0], forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
        //let a1 = MPMediaPropertyPredicate(value: firstSong[1], forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
        let ffls = Set([t1])
        let iniQuery = MPMediaQuery(filterPredicates: ffls)
        print(iniQuery)
        musicP.setQueue(with: iniQuery)
        musicP.prepareToPlay()
        let maxCount = mutableThing.count
        mutableThing.removeFirst()
        var count = 1
        for others in mutableThing {
            let otherSong = others as! [String]
            let ti = MPMediaPropertyPredicate(value: otherSong[0], forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
            //let ai = MPMediaPropertyPredicate(value: otherSong[1], forProperty: MPMediaItemPropertyArtist, comparisonType: .contains)
            let ofls = Set([ti])
            let othQuery = MPMediaQuery(filterPredicates: ofls)
            print(othQuery)
            let plz = MPMusicPlayerMediaItemQueueDescriptor.init(query: othQuery)
            musicP.append(plz)
            musicP.prepareToPlay()
            count = count + 1
            if (count == maxCount) {
                endSong = otherSong[0]
            }
        }
        if (!playbackFirst || !xPP) {
            musicP.play()
        }
        
    }
    
    func monitorMotion() {
        print("\nStarting monitoring process...")
        let _ = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.accelAfter()
            let _ = Timer.scheduledTimer(withTimeInterval: 10.2, repeats: false) { timer in
                print("Recorded interval:", postAcc)
                if ((abs(xAcd - postAcc) > 2) && !buttonStatus) {
                    print("Starting auto update!")
                    xAcd = postAcc
                    let result = self.calculate(firstTime: false)
                    print("UPDATED RESULTS:")
                    print(result)
                    self.makeQueue(songArtistList: result)
                } else {
                    print("No updates necessary")
                }
            }
        }
    }
    
    func accelAfter(){
        motion.deviceMotionUpdateInterval = 0.5
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            if let mD = data {
                let x = mD.userAcceleration.x
                let y = mD.userAcceleration.y
                let z = mD.userAcceleration.z
                let mag = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
                tempAcc = mag
            }
        }
        var poss = [-99.9]
        let bruh2 = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            poss.append(tempAcc)
            //print(getMag())
        }
        let _ = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { timer in
            let idk = poss.max()!
            print("\nMax value in last 10 seconds:", idk)
            postAcc = idk
            motion.stopDeviceMotionUpdates()
            bruh2.invalidate()
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
    
    func reloadSongs() {
        moods = loadFile()[0] as! [String]
        tempo = loadFile()[1] as! [String]
        rms = loadFile()[2] as! [String]
        titles = loadFile()[3] as! [String]
        artists = loadFile()[4] as! [String]
        albums = loadFile()[5] as! [String]
        dates = loadFile()[6] as! [String]
        tracknum = loadFile()[7] as! [String]
        genre = loadFile()[8] as! [String]
    }
    
    func removeUnec() {
        moods.removeAll { $0 == ", " }
        tempo.removeAll { $0 == ", " }
        rms.removeAll { $0 == ", " }
        titles.removeAll { $0 == ", " }
        artists.removeAll { $0 == ", " }
        albums.removeAll { $0 == ", " }
        dates.removeAll { $0 == ", " }
        tracknum.removeAll { $0 == ", " }
        genre.removeAll { $0 == ", " }
    }
    
    func loadFile() -> [Any] {
        var lines:[String] = []
        let filename = "my_song_info"
        if let path = Bundle.main.path(forResource: filename, ofType: "txt"){
            do {
                let contents = try String(contentsOfFile: path, encoding: .utf8)
                lines = contents.components(separatedBy: "\n")
                //print("\"lines\" var:")
                //print(lines)//remove later
            } catch {
                print(error)
            }
        } else {
            print("ERROR OCCURED")
        }
        
        //Reads lines of file into array with necessary format adjustments
        var mbid_array: [Any] = []
        for i in lines.indices {
            let stringArray = lines[i]
                                                                                                  
            let stringArrayCleaned = stringArray.description.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        
            let b = Array(stringArrayCleaned)
        
            var h: String = ""
        
            for i in b.indices {
                h = h + String(b[i])
            }
        
            var sarray = h.components(separatedBy: CharacterSet(charactersIn: "<#"))
            for i in sarray.indices {
                sarray[i] = sarray[i].replacingOccurrences(of: "\'", with: "")
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
        return mbid_array
    }
    
    func calculate(firstTime: Bool) -> [Any] {
        

        if (firstTime) {
            reloadSongs()
        }

        removeUnec()

        let num_songs: Int = titles.count
        if (firstTime) {
            maxAmount = num_songs
            print("Max amount of songs: ", maxAmount)
        }
        print("Songs to select from: ", num_songs)
        
        if (num_songs < ((3 * maxAmount) / 10)) {
            reloadSongs()
            removeUnec()
        }
        
        //Sorts mood values by song (array for each song)
        var mood_array: [Any] = []
        for i in 0...num_songs-1 {
            mood_array = mood_array + [Array(moods[(i*14)..<(i*14+14)])]
        }
        //print(mood_array)

        

        func Mappings(moodSettings: [String], inputTempo: Double, rmsInput: Double, inputGenre: [String], activity: String) -> [Any]{
            
            //Sorts each songs mood values into each mood type
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

            //Converts numerical values from string to double for each mood type
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
            
            //Determines new mood value based on normalized range to best fit the song library
            var allMoods: [Any] = []
            for i in A.indices {     //If all moods are determined by AcousticBrainz to be happy, then the least happy of the songs will be relabled as sad based on the normalized range
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
            
            //Picks songs based on mood inputs
            let songMoodValues = allMoods
            
            var songChoice: [String] = []
            for i in songMoodValues.indices {
                if songMoodValues[i] as! [String] == moodSettings {
                    songChoice = songChoice + [titles[i]]
                }
            }
            
            
            
            //Makes songchoices at least 15 songs
            while songChoice.count < 15 {
                for i in songMoodValues.indices {
                    if songChoice.count < 15 {
                        if (songMoodValues[i] as! [String]).difference(from: moodSettings).count == 2 {
                            songChoice = songChoice + [titles[i]]
                        }
                    }
                }
            }
            
            //Picks songs based on tempo input
            var temposort: [String] = []
            for i in titles.indices {
                if songChoice.contains(titles[i]) {
                    if ((tempo[i] as! NSString).doubleValue) >= (inputTempo - 30.0) && ((tempo[i] as! NSString).doubleValue) <= (inputTempo + 30.0) {
                        temposort = temposort + [titles[i]]
                    }
                }
            }
            
            
            let drms = rms.compactMap { (value) -> Double? in
                return Double(value)!
            }
            
            //Normalizes RMS values
            var nrms: [Double] = []
            for i in drms.indices {
                let b = drms[i]
                nrms = nrms+[(b-drms.min()!)/(drms.max()!-drms.min()!)]
            }
            
            
            
            let inputstart: Double = 0.0
            let inputend: Double = 7.0
            var outputstart: Double = 0.0
            var outputend: Double = 1.0
            if activity == "Working Out" {
                outputstart = 0.8
                outputend = 1.0
            } else if activity == "In a Crowd" {
                outputstart = 0.6
                outputend = 0.8
            } else if activity == "Car Ride" {
                outputstart = 0.4
                outputend = 0.6
            } else if activity == "With Friends" {
                outputstart = 0.2
                outputend = 0.4
            } else if activity == "Studying" {
                outputstart = 0.0
                outputend = 0.2
            }
            
            let rmsValue: Double = outputstart + ((outputend - outputstart) / (inputend - inputstart)) * (rmsInput - inputstart)
            
            //Picks songs based on accelerometer data via songs' RMS values
            var rmssort: [String] = []
            for i in titles.indices {
                if temposort.contains(titles[i]) {
                    if (nrms[i]) >= (rmsValue - 0.35) && (nrms[i]) <= (rmsValue + 0.35) {
                        rmssort = rmssort + [titles[i]]
                    }
                }
            }
            
            //Picks songs based on genre input
            var genresort: [String] = []
            for i in titles.indices {
                if rmssort.contains(titles[i]) {
                    if inputGenre.contains(genre[i]) {
                        genresort = genresort + [titles[i]]
                    }
                }
            }
            
            //Makes minimum of 5 song output
            var out1: [String] = []
            if genresort.count < 5 {
                if rmssort.count < 5 {
                    if temposort.count < 5 {
                        out1 = songChoice
                    } else {
                        out1 = temposort
                    }
                } else {
                    out1 = rmssort
                }
            } else {
                out1 = genresort
            }
            
            //Formats output with correct song info (title and artist name)
            var finalsongs: [[Any]] = []
            for i in titles.indices {
                if out1.contains(titles[i]) {
                    finalsongs = finalsongs + [[titles[i], artists[i]]]
                    ilist = ilist + [i]
                    
                }
            }
            
            //Removes songs at indices to prevent replay
            artists.remove(at: ilist)
            titles.remove(at: ilist)
            mood_array.remove(at: ilist)
            tempo.remove(at: ilist)
            rms.remove(at: ilist)
            albums.remove(at: ilist)
            tracknum.remove(at: ilist)
            dates.remove(at: ilist)
            genre.remove(at: ilist)
            
            if finalsongs.count < 5 {
                reloadSongs()
            }
            
            finalsongs.shuffle()
            return finalsongs
        }


        let moodSettings = assignMoods()
        let inputTempo = xTempo
        let rmsInput = xAcd
        let inputGenre = assignGenres()
        let activity = assignActivity()
        print("\nInputed values:")
        print(moodSettings)
        print(inputTempo)
        print(rmsInput)
        print(inputGenre)
        print(activity, "\n")
        
        //print(titles.count)
        return Mappings(moodSettings: moodSettings, inputTempo: inputTempo, rmsInput: rmsInput, inputGenre: inputGenre, activity: activity)
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
   
 
 /*
 var tester = songArtistList[0] as! [String]
 var idkman = type(of: tester)
 print(tester[0])
 print(type(of: tester))
 print(type(of: tester[0]))
 let albTF = MPMediaPropertyPredicate(value: "One Click Headshot", forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
 let albTF2 = MPMediaPropertyPredicate(value: "Come as You Are", forProperty: MPMediaItemPropertyTitle, comparisonType: .contains)
 //let filterSet = Set(allTitleFilters)
 let filterSet = Set([albTF])
 let query = MPMediaQuery(filterPredicates: filterSet)
 let filterSet2 = Set([albTF2])
 let query2 = MPMediaQuery(filterPredicates: filterSet2)
 print(query)
 print(query2)
 musicP.repeatMode = MPMusicRepeatMode.none
 musicP.setQueue(with: query)
 let plzzz = MPMusicPlayerMediaItemQueueDescriptor.init(query: query2)
 musicP.prepareToPlay()
 musicP.append(plzzz)*/
     
     
 }
 */



