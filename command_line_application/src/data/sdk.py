import requests
import json
from .session_metadata import SessionMetadata

URL_PREFIX = "http://theultimateoptimist.pythonanywhere.com/worktracker"

def add_topic(topic_name: str, parent_id: int) -> int:
    response = requests.post(f"{URL_PREFIX}/topic/add", {"topic": topic_name, "parent_id": parent_id})
    if not response.ok:
        raise Exception("API call to add topic did not work")
    return int(response.text)

def add_session(start: float, end: float, topic_id: int):
    response = requests.post(f"{URL_PREFIX}/session/add", {"start": start, "end": end, "topic_id": topic_id})
    if not response.ok:
        raise Exception("API call to add session did not work")

def get_hierarchy(parent_id: int, verbose: bool):
    """
    returns a list of lists: [[name, parent, child]]
    """
    response = requests.get(f"{URL_PREFIX}/hierarchy/{parent_id}/{int(verbose)}")
    if not response.ok:
        raise Exception("API call to get hierarchy did not work")
    return json.loads(response.text)

def get_topic_name(topic_id: int) -> str:
    """
    if the given topic id does not exist, 'None' will be returned
    """
    response = requests.get(f"{URL_PREFIX}/topic/name/{topic_id}")
    if not response.ok:
        raise Exception("API call to get topic name did not work")
    return response.text

def get_past_topic_id(steps_back: int = 1):
    """
    steps_back has to be greater than 0
    steps_back = 1: last topic id will be retrieved
    steps_back = 2: second last topic id will be retrieved...
    """
    assert steps_back > 0, "steps_back hast to be greater than 0"
    response = requests.get(f"{URL_PREFIX}/topic/last/{steps_back}")
    if not response.ok:
        raise Exception("API call to get past topic id did fail")
    return int(response.text)

def get_past_sessions(steps_back: int = 1) -> list[SessionMetadata]:
    assert steps_back > 0, "steps_back hast to be greater than 0"
    """
    steps_back has to be greater than 0
    steps_back = 1: last session will be retrieved
    steps_back = 2: the two last sessions will be retrieved...
    """
    response = requests.get(f"{URL_PREFIX}/sessions/last/{steps_back}")
    if not response.ok:
        raise Exception("API call to get past sessions did fail")
    raw_data: list[list] = json.loads(response.text)
    return list(map(lambda row: SessionMetadata.from_list(row), raw_data))

def get_sessions(fr: float, to: float) -> list[SessionMetadata]:
    assert to >= fr
    assert fr >= 0
    response = requests.get(f"{URL_PREFIX}/sessions/{fr}/{to}")
    if not response.ok:
        raise Exception("API call to get sessions did fail")
    raw_data: list[list] = json.loads(response.text)
    return list(map(lambda row: SessionMetadata.from_list(row), raw_data))

def get_number_of_sessions(fr: float, to: float):
    assert to >= fr
    assert fr >= 0
    response = requests.get(f"{URL_PREFIX}/sessions/count/{fr}/{to}")
    if not response.ok:
        raise Exception("API call to count sessions did fail")
    return json.loads(response.text)

def get_number_of_topics_sessions(topic_id: int) -> int:
    response = requests.get(f"{URL_PREFIX}/sessions/count/{topic_id}")
    if not response.ok:
        raise Exception(f"API call to get number of  sessions for the topic id {topic_id} did fail")
    return int(response.text)

def get_sessions_of_topic(topic_id: int) -> list[SessionMetadata]:
    response = requests.get(f"{URL_PREFIX}/sessions/{topic_id}")
    if not response.ok:
        raise Exception("API call to get sessions did fail")
    raw_data: list[list] = json.loads(response.text)
    return list(map(lambda row: SessionMetadata.from_list(row), raw_data))
