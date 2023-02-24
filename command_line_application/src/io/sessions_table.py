from rich.table import Table
from rich.console import Console
from datetime import datetime
from ..data.session_metadata import SessionMetadata

class SessionsTable:
    def __init__(self, title: str, sessions: list[SessionMetadata]) -> None:
        self.title = title
        self.sessions = sessions

    def print(self):
        table = Table("topic id", "topic name", "start", "end", title=self.title, title_justify="left")
        for session in self.sessions:
            start = self.__get_date_string(session.start)
            end = self.__get_date_string(session.end)
            table.add_row(str(session.topic_id), session.name, start, end)
        console = Console(highlight=False)
        if len(self.sessions) == 0:
            console.print("No sessions")
        else:
            console.print(table)

    def __get_date_string(self, secondsSinceEpoch: float):
        return datetime.fromtimestamp(secondsSinceEpoch).strftime('%d.%m.%Y %H:%M:%S')