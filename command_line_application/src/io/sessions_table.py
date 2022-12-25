from rich.table import Table
from rich.console import Console
from datetime import datetime

class SessionsTable:
    def __init__(self, title: str, sessions: list[list]) -> None:
        self.title = title
        self.sessions = sessions

    def print(self):
        table = Table("topic id", "topic name", "start", "end", title=self.title)
        for session in self.sessions:
            start = self.__get_date_string(session[2])
            end = self.__get_date_string(session[3])
            table.add_row(str(session[0]), session[1], start, end)
        console = Console(highlight=False)
        if len(self.sessions) == 0:
            console.print("No sessions")
        else:
            console.print(table)

    def __get_date_string(self, secondsSinceEpoch: float):
        return datetime.fromtimestamp(secondsSinceEpoch).strftime('%d.%m.%Y %H:%M:%S')