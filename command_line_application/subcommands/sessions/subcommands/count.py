import typer

from src.io.printer import Printer
from src.io.error_message import ErrorMessage
from src.io.sessions_count import SessionsCount
from src.data.sdk import get_number_of_topics_sessions, get_topic_name, get_number_of_sessions
from src.util.time import today_start, yesterday_start, now

app = typer.Typer()


@app.command()
def root(topic_id: int):
    topic_name = get_topic_name(topic_id)
    if topic_name == "None":
        Printer.error(ErrorMessage.INVALID_ID)
        return
    number_of_sessions = get_number_of_topics_sessions(topic_id)
    SessionsCount(topic_name, number_of_sessions).print()

        
@app.command()
def today():
    number_of_sessions = get_number_of_sessions(today_start(), now())
    SessionsCount("Today", number_of_sessions).print()

@app.command()
def yesterday():
    number_of_sessions = get_number_of_sessions(yesterday_start(), today_start())
    SessionsCount("Yesterday", number_of_sessions).print()