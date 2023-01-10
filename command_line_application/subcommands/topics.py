import typer
from src.data.sdk import get_topic_name, add_topic, get_hierarchy
from src.io.printer import Printer
from src.io.error_message import ErrorMessage
from src.io.topics_tree import TopicsTree

app = typer.Typer()


@app.command()
def add(name: str, parent: int):
    if len(name) == 0: #propably unnecessary as name can not be empty at this point
        Printer.error(ErrorMessage.EMPTY_NAME)
        return
    if parent < 0:
        Printer.error(ErrorMessage.NEGATIVE_PARENT)
        return
    if get_topic_name(parent) == "None":
        Printer.error(ErrorMessage.INVALID_PARENT)
        return
    add_topic(name, parent)


@app.command()
def show(parent: int = 0):
    if parent < 0:
        Printer.error(ErrorMessage.NEGATIVE_PARENT)
        return
    parent_name = get_topic_name(parent)
    if parent_name == "None":
        Printer.error(ErrorMessage.INVALID_PARENT)
        return
    tree_nodes = get_hierarchy(parent)
    tree = TopicsTree(parent, parent_name, tree_nodes)
    tree.print()
