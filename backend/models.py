from pydantic import BaseModel
from dataclasses import dataclass
from pathlib import Path
from typing import Literal

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str | None = None


class User(BaseModel):
    username: str
    email: str | None = None
    full_name: str | None = None
    disabled: bool | None = None


class UserInDB(User):
    hashed_password: str

@dataclass
class Task:
    # username: str
    blobPath: Path
    method: Literal['nerfacto', 'instant-ngp', 'gaussian-splatting', 'neuralangelo']
    iters: int