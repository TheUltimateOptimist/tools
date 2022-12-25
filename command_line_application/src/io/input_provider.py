from rich.console import Console

class InputProvider:
    @staticmethod
    def get_continue_sign() -> str:
        text = "Enter anything to continue: "
        Console(highlight=False).print(text, style="green bold", end="")
        return input("")

    @staticmethod
    def should_start_new() -> bool:
        text = "Do you want to start a new session(y:Yes, rest: No): "
        Console(highlight=False).print(text, style="green bold", end="")
        user_input = input("")
        if user_input == "y":
            return True
        return False
