from rich.live import Console, Live
from rich.text import Text
from time import sleep
from src.io.input_provider import InputProvider
from sound import play_sound

def format_seconds(seconds: int) -> str:
    from datetime import timedelta
    return f"{'-' if seconds < 0 else ''}{timedelta(seconds=abs(seconds))}"

def play(text: str, seconds: int) -> int:
    try:
        with Live(console=Console(highlight=False)) as live:
            while True:
                styled_text = Text()
                styled_text.append(text)
                styled_text.append(" ")
                styled_text.append(format_seconds(seconds), style="grey37 bold")
                live.update(styled_text, refresh=True)
                if seconds == 0:
                    play_sound()
                sleep(1)
                seconds-=1
    except KeyboardInterrupt:
        return seconds


def work(text: str, seconds: int) -> None:
    remaining_seconds = play(text, seconds)
    if remaining_seconds <= 0:
        return
    try:
        InputProvider.get_continue_sign()
    except KeyboardInterrupt:
        return
    work(text, remaining_seconds)

def pause(seconds: int) -> None:
    play("Pause", seconds)