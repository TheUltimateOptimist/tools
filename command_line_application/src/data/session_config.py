from src.custom_timer import Timer

class SessionConfig:
    def __init__(self, topic_id: int, work_timer: Timer, pause_timer: Timer) -> None:
        self.topic_id = topic_id
        self.work_timer = work_timer
        self.pause_timer = pause_timer