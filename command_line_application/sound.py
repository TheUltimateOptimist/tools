import os

def play_sound():
    import playsound
    playsound.playsound(os.path.join(os.path.dirname(os.path.abspath(__file__)), "sound.mp3"))
