# PST2Repo

## Project Studio Tech Group 2
This is our project repo. We are working 
on an app to automatically suggest and 
playback music based on the mood of the user and accelerometer data. 

## Members
* Sean Tillman, sean.tillman@gatech.edu
* Joe Hackman, hackman.joseph@gatech.edu
* Eli Ruckle, eliruckle@gatech.edu
* Will Smith, wsmith324@gatech.edu

## GitHub Files
* PST2Att1 (This is the Swift File, and where the majority of the code is for the app)
  Whithin this folder, there is the main project file PST2Att1.xcodeproj, this is the app. The file folder conatins all of the files needed to run the app.
* pyacoustid-1.2.0 (This allows for the metadata of a song to be sent to the app)

## Download Instructions

* To ensure that the metadata for the local library matches that hosted on MusicBrainz & AcousticBrainz, download Picard from MusicBrainz and follow the instructions within.  https://picard.musicbrainz.org/
* To create the txt file, download the pyacoustid folder, "my_song_info.txt", and AcousticBrainz_extraction.py.  Once downloaded, move the file titled "fpcalc" to the directory "/usr/local/bin" on your macOS device.  In the AcousticBrainz_extraction.py file, change the variable "base_path" to the directory of your music library.  Once this is complete, run the AcousticBrainz_extraction.py script.  This may take a while, but will populate the empty "my_song_info.txt" file with the information obtained from MusicBrainz and AcousticBrainz.
* Once you have your txt file, make sure you have the most recent version of XCode and a relativily up-to-date iPhone with the music already loaded on. If you
 haven't already done so, you will you need to set up your AppleID and phone using the below links:
 - https://help.apple.com/xcode/mac/current/#/devaf282080a
 - https://help.apple.com/xcode/mac/current/#/dev23aab79b4
 * After your XCode is linked with your AppleID, you can plug in your phone. The final step before running the app is to move the txt file you created to the
 directory. You can either drag it from Finder or use the plus (+) arrow at the bottom (make sure "copy items if needed" is selected). You will want to name
 your txt file "my_song_info.txt" (otherwise you'll have to change the code), and you may need to delete any existing files with the same name. You're then 
 finally ready to run the app by selecting the play button towards the top left (make sure your iPhone is selected as the target device). The first time it is
 run will take longer to download, and you may get one or two popups asking for permission to use your media library. Once you have run the app that one time 
 you should be able to easily unplug the phone and run the app from the home screen. For questions about specific questions about the app installation, consult
 some of Apple's websites, or contact the main developer, Sean, at his email above. 
