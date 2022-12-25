from rich.live import Live
from time import sleep
from src.io.input_provider import InputProvider

class Timer:
    def __init__(self, seconds: int, description: str) -> None:
        self.__seconds = seconds
        self.__description = description

    def execute(self):
        try:
            with Live() as live:
                for _ in range(self.__seconds):
                    live.update(self.__get_text(), refresh=True)
                    sleep(1)
                    self.__seconds-=1
                live.update(self.__get_text(), refresh=True)
        except KeyboardInterrupt:
            InputProvider.get_continue_sign()
            self.execute()

    def __get_text(self):
        from datetime import timedelta
        return f"{self.__description} {timedelta(seconds = self.__seconds)}"