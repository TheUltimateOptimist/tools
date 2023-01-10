import time
from src.data.session_config import SessionConfig
from src.data.sdk import add_session

class Session:
    def __init__(self, session_config: SessionConfig) -> None:
        self.__session_config = session_config
        self.__start: float = None
        self.__end: float = None

    def execute(self):
        self.__start = time.time()
        self.__session_config.work_timer.execute()
        self.__end = time.time()
        self.__beep()
        self.__save()
        self.__session_config.pause_timer.execute()
        self.__beep()

    def __save(self):
        add_session(self.__start, self.__end, self.__session_config.topic_id)

    def __beep(self):
        from winsound import Beep
        Beep(frequency=2500, duration=3000)
    



    

    