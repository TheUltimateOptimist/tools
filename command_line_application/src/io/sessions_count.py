from rich.console import Console

class SessionsCount:
    def __init__(self, description: str, count: int) -> None:
        self.description = description
        self.count = count

    def print(self):
        console = Console(highlight=False)
        hours = self.count / 2
        console.print(f"{self.description}: {self.count} sessions -> {hours}h")
