import json
import requests
import os
import acoustid

## Edit the following variable "path" to the path of your music library ##
base_path = "/Users/josephhackman/Desktop/PST2Repo Songs/"

files = os.listdir(base_path)

api_key = 'cSpUJKpD'

mbid_list = []

for i in files:
    try:
        results = acoustid.match(api_key, base_path+i)
        temp = []
        for score, recording_id, title, artist in results:
            temp.append(recording_id)
        mbid_list.append(temp)
    except:
        pass

mbid_dict = {}

def get_low_level(mbid):
    base_api_url = "https://acousticbrainz.org/api/v1/"
    url = base_api_url + mbid + "/low-level?n=0"
    data = requests.get(url)
    return data.json()

def get_high_level(mbid):
    base_api_url = "https://acousticbrainz.org/api/v1/"
    url = base_api_url + mbid + "/high-level?n=0"
    data = requests.get(url)
    return data.json()

def extract_API(a_list, a_dict):
    for i in a_list:
        app = False
        for mb in i:
            if app:
                break
            else:
                low_level = get_low_level(mb)
                high_level = get_high_level(mb)
                if low_level == {'message': 'Not found'} or high_level == {'message': 'Not found'}:
                    continue
                else:
                    app = True
                    a_dict[mb] = [low_level, high_level, i[0]]

mbid_dict = {}
extract_API(mbid_list, mbid_dict)

confirmed_mbid = []
for k, v in mbid_dict.items():
    confirmed_mbid.append(k)

def get_song_list():
    f = open("test2_song_info.txt", "r")
    data = f.readlines()
    f.close()
    return data

def update_song_list(l, now):
    f = open("test2_song_info.txt", "a")
    for i in range(len(l)):
        if l[i] not in now:
            f.write("\"" + str(l[i]) + "\"" + "\n")
    f.close()
    return f

mood_list = []
for i in range(0, len(mbid_dict)):
    a = confirmed_mbid[i]               #Load Individual Song Info
    song_info = mbid_dict[a][1]
    song_high = song_info["highlevel"]   #High-Level Data

    song_acoustic = song_high["mood_acoustic"]["probability"]  #song_mood is probability of a mood
    acoustic_value =song_high["mood_acoustic"]["value"]        #acoustic_value is value of mood: acoustic vs not_acoustic

    song_electronic = song_high["mood_electronic"]["probability"]
    electronic_value = song_high["mood_electronic"]["value"]

    song_happy = song_high["mood_happy"]["probability"]
    happy_value = song_high["mood_happy"]["value"]

    song_aggressive = song_high["mood_aggressive"]["probability"]
    aggressive_value = song_high["mood_aggressive"]["value"]

    song_party = song_high["mood_party"]["probability"]
    party_value = song_high["mood_party"]["value"]

    song_sad = song_high["mood_sad"]["probability"]
    sad_value = song_high["mood_sad"]["value"]

    song_relaxed = song_high["mood_relaxed"]["probability"]
    relaxed_value = song_high["mood_relaxed"]["value"]

    #Sort all song moods
    mood_info = [relaxed_value, song_relaxed*100, aggressive_value, song_aggressive*100, acoustic_value, song_acoustic*100, electronic_value, song_electronic*100, happy_value, song_happy*100, sad_value, song_sad*100, party_value, song_party*100]
    
    modified_mood_info = ""
    for i in mood_info:
        modified_mood_info += "<#" + str(i) + "#>"
    
    mood_list = mood_list + [modified_mood_info]

songIDs = confirmed_mbid

bpms = []
rmslist = []
titlelist = []
artistlist = []
albumlist = []
trackdate = []
tracknum = []
genre = []
for i in range(0,len(songIDs)):
    bpm = mbid_dict[songIDs[i]][0]["rhythm"]["bpm"]
    bpms = bpms + [bpm]
    rmsMean = mbid_dict[songIDs[i]][0]['lowlevel']['spectral_rms']['mean']
    rmslist = rmslist + [rmsMean]
    
    
    try:
        titlelist = titlelist + [mbid_dict[songIDs[i]][1]["metadata"]["tags"]["title"][0]]
    except:
        titlelist = titlelist + ["song_name"]
    try:
        artistlist = artistlist + [mbid_dict[songIDs[i]][1]["metadata"]["tags"]["artist"][0]]
    except:
        artistlist = artistlist + ["artist_name"]
    try:
        albumlist = albumlist + [mbid_dict[songIDs[i]][1]["metadata"]["tags"]["album"][0]]
    except:
        albumlist = albumlist + ["album_name"]
    try:
        trackdate = trackdate + [mbid_dict[songIDs[i]][1]["metadata"]["tags"]["date"][0]]
    except:
        trackdate = trackdate + ["date_name"]
    try:
        tracknum = tracknum + [mbid_dict[songIDs[i]][1]["metadata"]["tags"]["tracknumber"][0]]
    except:
        tracknum = tracknum + ["num_name"]
    try:
        genre = genre + [mbid_dict[songIDs[i]][1]["highlevel"]["genre_rosamerica"]["value"]]
    except:
        genre = genre + ["genre_name"]
        
    n_bpms = ""
    n_rmslist = ""
    n_titlelist = ""
    n_artistlist = ""
    n_albumlist = ""
    n_trackdate = ""
    n_tracknum = ""
    n_genre = ""
    
    for i in bpms:
        n_bpms += "<#" + str(i) + "#>"
    for i in rmslist:
        n_rmslist += "<#" + str(i) + "#>"
    for i in titlelist:
        n_titlelist += '<#' + str(i) + '#>'
    for i in artistlist:
        n_artistlist += "<#" + str(i) + "#>"    
    for i in albumlist:
        n_albumlist += "<#" + str(i) + "#>"
    for i in trackdate:
        n_trackdate += "<#" + str(i) + "#>"
    for i in tracknum:
        n_tracknum += "<#" + str(i) + "#>"
    for i in genre:
        n_genre += "<#" + str(i) + "#>"
valuelist = [mood_list, [n_bpms], [n_rmslist], [n_titlelist], [n_artistlist], [n_albumlist], [n_trackdate], [n_tracknum], [n_genre]]

current = get_song_list()
update_song_list(valuelist, current)
