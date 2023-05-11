import time
from typing import  Union
from src.data.session_config import SessionConfig
from src.data.sdk import add_session

class Session:
    def __init__(self, session_config: SessionConfig) -> None:
        self.__session_config = session_config
        self.__start: Union[float, None] = None
        self.__end: Union[float, None] = None

    def execute(self):
        self.__start = time.time()
        self.__session_config.work_timer.execute()
        self.__end = time.time()
        self.__beep()
        self.__save()
        self.__session_config.pause_timer.execute()
        self.__beep()

    def __save(self):
        assert self.__start
        assert self.__end
        add_session(self.__start, self.__end, self.__session_config.topic_id)

    def __beep(self):
        from sound import play_sound
        play_sound()
    



    

    
