from src.data.api import get_topic_name, get_past_topic_id
from src.io.error_message import ErrorMessage

class TrackingConfig:
    def __init__(self, topic_id: int, duration: int, pause: int, last: bool, secondlast: bool, thirdlast: bool) -> None:
        self.topic_id = topic_id
        self.duration = duration
        self.pause = pause
        self.last = last
        self.secondlast = secondlast
        self.thirdlast = thirdlast
        self.topic_name = None

    def validate(self):
        if (self.last or self.secondlast) and (self.last or self.thirdlast) and (self.secondlast or self.thirdlast):
            return ErrorMessage.DUPLICATE_FLAG
        if self.topic_id < 0:
            return ErrorMessage.NEGATIVE_ID
        if self.duration < 0:
            return ErrorMessage.NEGATIVE_DURATION
        if self.pause < 0:
            return ErrorMessage.NEGATIVE_PAUSE
        

    def initialize(self):
        if self.last:
            self.topic_id = get_past_topic_id()
        elif self.secondlast:
            self.topic_id = get_past_topic_id(steps_back=2)
        elif self.thirdlast:
            self.topic_id = get_past_topic_id(steps_back=3)
        self.topic_name = get_topic_name(self.topic_id)
        if self.topic_name == "None":
            return ErrorMessage.INVALID_ID