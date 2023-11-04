import time
from typing import  Union
from src.data.tracking_config import TrackingConfig
from src.data.sdk import add_session
from src.timer import work, pause

class Session:
    def __init__(self, tracking_config: TrackingConfig) -> None:
        self.__tracking_config = tracking_config
        self.__start: Union[float, None] = None
        self.__end: Union[float, None] = None

    def execute(self):
        self.__start = time.time()
        work(self.__tracking_config.topic_name, self.__tracking_config.duration)
        self.__end = time.time()
        self.__save()
        pause(self.__tracking_config.pause)

    def __save(self):
        assert self.__start
        assert self.__end
        add_session(self.__start, self.__end, self.__tracking_config.topic_id)