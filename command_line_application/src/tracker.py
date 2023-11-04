from src.session import Session
from src.data.tracking_config import TrackingConfig
from src.io.input_provider import InputProvider

class Tracker:
    def __init__(self, tracking_config: TrackingConfig) -> None:
        self.tracking_config = tracking_config

    def track(self):
        assert self.tracking_config.topic_name
        Session(self.tracking_config).execute()
        if InputProvider().should_start_new():
            self.track()


