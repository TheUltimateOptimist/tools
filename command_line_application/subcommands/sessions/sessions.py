import typer
import subcommands.sessions.subcommands.count as count_subcommand
import subcommands.sessions.subcommands.show as show_subcommand

app = typer.Typer()

app.add_typer(count_subcommand.app, name="count")
app.add_typer(show_subcommand.app, name="show")


