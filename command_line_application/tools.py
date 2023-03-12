import typer

import subcommands.sessions.sessions as sessions_subcommand
import subcommands.topics as topics_subcommand

from src.data.tracking_config import TrackingConfig
from src.io.printer import Printer
from src.tracker import Tracker

app = typer.Typer()
app.add_typer(sessions_subcommand.app, name="sessions")
app.add_typer(topics_subcommand.app, name="topics")

def launch_lofi():
    import webbrowser
    webbrowser.open_new_tab("https://www.youtube.com/watch?v=jfKfPfyJRdk")

def enter_command(command: str, post_delay: int):
    import keyboard
    import time
    keyboard.write(command)
    time.sleep(1)
    keyboard.send("enter")
    time.sleep(post_delay)


@app.command()
def popularize(name: str, count: int = 10):
    import time
    time.sleep(5)
    for i in range(count):
        print(f"{i + 1}/{count}")
        enter_command("flutter create popular", 3)
        enter_command("cd popular", 1)
        enter_command(f"flutter pub add {name}", 5)
        enter_command('cd "C:\\Users\\JDuec"', 1)
        enter_command("rmdir popular", 3)
        enter_command(f"J", 3)

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

@app.command()
def send(email_path: str, destination_address: str, subject: str):
    with open(email_path, "r", encoding="utf8") as file:
        markdown_email = file.read()
    import markdown
    html_email = markdown.markdown(markdown_email)
    from src.mailing.email_bot import EmailBot
    EmailBot(destination_address=destination_address, subject=subject, message=html_email).send()

if __name__ == "__main__":
    app()