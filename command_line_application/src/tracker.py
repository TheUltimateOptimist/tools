from src.session import Session
from src.data.session_config import SessionConfig
from src.custom_timer import Timer
from src.data.tracking_config import TrackingConfig
from src.io.input_provider import InputProvider

class Tracker:
    def __init__(self, tracking_config: TrackingConfig) -> None:
        self.tracking_config = tracking_config

    def track(self):
        work_timer = Timer(self.tracking_config.duration, self.tracking_config.topic_name)
        pause_timer = Timer(self.tracking_config.pause, "Pause")
        session_config = SessionConfig(self.tracking_config.topic_id, work_timer, pause_timer)
        Session(session_config).execute()
        if InputProvider().should_start_new():
            self.track()


