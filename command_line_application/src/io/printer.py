from rich.console import Console

class Printer:
    @staticmethod
    def error(text: str):
        Console().print(text, style="red bold")
