import typer

import subcommands.sessions as sessions
import subcommands.topics as topics

from src.data.tracking_config import TrackingConfig
from src.io.printer import Printer
from src.tracker import Tracker

app = typer.Typer()
app.add_typer(sessions.app, name="sessions")
app.add_typer(topics.app, name="topics")

def launch_lofi():
    import webbrowser
    webbrowser.open_new_tab("https://www.youtube.com/watch?v=jfKfPfyJRdk")

@app.command()
def lofi():
    launch_lofi()

@app.command()
def start():
    launch_lofi()
    import subprocess
    subprocess.call(["C:\\Users\\JDuec\\AppData\\Local\\Programs\\Microsoft VS Code\\bin\\code-tunnel.exe"])
    from subcommands.topics import show
    show()

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