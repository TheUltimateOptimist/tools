import typer

from src.io.printer import Printer
from src.io.error_message import ErrorMessage
from src.io.sessions_table import SessionsTable
from src.data.sdk import get_past_sessions, get_todays_sessions

app = typer.Typer()


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
    sessions = get_todays_sessions()
    SessionsTable("Today's sessions", sessions).print()