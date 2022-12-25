import requests
import json

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

def get_hierarchy(parent_id: int):
    """
    returns a list of lists: [[name, parent, child]]
    """
    response = requests.get(f"{URL_PREFIX}/hierarchy/{parent_id}")
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

def get_past_sessions(steps_back: int = 1):
    assert steps_back > 0, "steps_back hast to be greater than 0"
    """
    steps_back has to be greater than 0
    steps_back = 1: last session will be retrieved
    steps_back = 2: the two last sessions will be retrieved...
    """
    response = requests.get(f"{URL_PREFIX}/sessions/last/{steps_back}")
    if not response.ok:
        raise Exception("API call to get past sessions did fail")
    return json.loads(response.text)

def get_todays_sessions():
    response = requests.get(f"{URL_PREFIX}/sessions/today")
    if not response.ok:
        raise Exception("API call to get today's sessions did fail")
    return json.loads(response.text)
