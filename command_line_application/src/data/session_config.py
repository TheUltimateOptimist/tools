class SessionConfig:
    def __init__(self, topic_id: int, duration: int, pause: int) -> None:
        self.topic_id = topic_id
        self.duration = duration
        self.pause = pause