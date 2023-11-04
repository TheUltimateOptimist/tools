from rich.console import Console

class InputProvider:
    @staticmethod
    def get_continue_sign() -> str:
        text = "Enter anything to continue: "
        Console(highlight=False).print(text, style="green bold", end="")
        return input("")

    @staticmethod
    def should_start_new() -> bool:
        text = "Do you want to start a new session"
        return InputProvider.yes_or_no(text, style="green bold") 

    @staticmethod
    def yes_or_no(text: str, style: str = "white bold") -> bool:
        Console(highlight=False).print(f"{text}(y: Yes, Rest: No): ", style=style, end="")
        user_input = input("")
        if user_input == "y":
            return True
        return False