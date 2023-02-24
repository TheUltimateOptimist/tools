from dataclasses import dataclass

@dataclass
class SessionMetadata:
    topic_id: int
    name: str  
    start: float 
    end: float

    @staticmethod
    def from_list(data: list):
        return SessionMetadata(data[0], data[1], data[2], data[3])
