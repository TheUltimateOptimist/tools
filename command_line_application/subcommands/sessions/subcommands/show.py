import typer

from src.io.printer import Printer
from src.io.error_message import ErrorMessage
from src.io.sessions_table import SessionsTable
from src.data.sdk import get_past_sessions, get_sessions, get_topic_name, get_sessions_of_topic
from src.util.time import now, yesterday_start, today_start

app = typer.Typer()

@app.command()
def root(topic_id: int):
    topic_name = get_topic_name(topic_id)
    if topic_name == "None":
        Printer.error(ErrorMessage.INVALID_ID)
        return
    sessions = get_sessions_of_topic(topic_id)
    SessionsTable(f"Sessions for {topic_name}", sessions).print()

@app.command()
def last(count: int = 1):
    if count <= 0:
        Printer.error(ErrorMessage.INVALID_COUNT)
        return
    title = f"Last {count} sessions"
    if count == 1:
        title = "Last session"
    sessions = get_past_sessions(count)
    SessionsTable(title, sessions).print()
        
@app.command()
def today():
    sessions = get_sessions(today_start(), now())
    SessionsTable("Today's sessions", sessions).print()

@app.command()
def yesterday():
    sessions = get_sessions(yesterday_start(), today_start())
    SessionsTable("Yesterday's sessions", sessions).print()