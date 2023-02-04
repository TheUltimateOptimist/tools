from rich.console import Console

class SessionsCount:
    def __init__(self, description: str, count: int) -> None:
        self.description = description
        self.count = count

    def print(self):
        console = Console(highlight=False)
        hours = self.count / 2
        session_text = "session" if self.count == 1 else "sessions"
        console.print(f"{self.description}: {self.count} {session_text} -> {hours}h")
