import typer

import subcommands.sessions as sessions
import subcommands.topics as topics

from src.data.tracking_config import TrackingConfig
from src.io.printer import Printer
from src.tracker import Tracker

app = typer.Typer()
app.add_typer(sessions.app, name="sessions")
app.add_typer(topics.app, name="topics")

@app.command()
def track(id: int = 0, duration: int = 1620, pause: int = 180, last: bool = False, secondlast: bool = False, thirdlast: bool = False):
    tracking_config = TrackingConfig(id, duration, pause, last, secondlast, thirdlast)
    error_message = tracking_config.validate()
    if error_message:
        Printer.error(error_message)
        return
    error_message = tracking_config.initialize()
    if error_message:
        Printer.error(error_message)
        return
    tracker = Tracker(tracking_config)
    tracker.track()

if __name__ == "__main__":
    app()