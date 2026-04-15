import json

from faker import Faker

_fake = Faker()


def generate_random_id() -> int:
    return _fake.random_int(min=100000, max=999999)

def generate_random_dog_name(prefix: str = "Dog") -> str:
    return f"{prefix}_{_fake.first_name()}"

def generate_random_username(prefix: str = "student") -> str:
    return f"{prefix}_{_fake.user_name()}"

def generate_random_first_name() -> str:
    return _fake.first_name()

def generate_random_last_name() -> str:
    return _fake.last_name()

def generate_random_phone() -> str:
    return _fake.phone_number()

def build_pet_payload(
    pet_id: int | None = None,
    name: str | None = None,
    status: str = "available",
    category_id: int = 1,
    category_name: str = "dog",
    photo_urls: list[str] | None = None,
    tag_id: int = 1,
    tag_name: str = "friendly",
) -> dict:
    resolved_photo_urls = photo_urls if photo_urls is not None else ["https://example.com/reksio-test.jpg"]

    resolved_pet_id = pet_id if pet_id is not None else generate_random_id()
    resolved_name = name if name is not None else generate_random_dog_name(prefix="Pet")
    return {
        "id": resolved_pet_id,
        "category": {"id": category_id, "name": category_name},
        "name": resolved_name,
        "photoUrls": resolved_photo_urls,
        "tags": [{"id": tag_id, "name": tag_name}],
        "status": status,
    }

def build_user_payload(
    user_id: int | None = None,
    username: str | None = None,
    first_name: str | None = None,
    last_name: str | None = None,
    email: str | None = None,
    password: str = "Test1234",
    phone: str | None = None,
    user_status: int = 1,
) -> dict:
    resolved_user_id = user_id if user_id is not None else generate_random_id()
    resolved_username = username if username is not None else generate_random_username()
    resolved_first_name = first_name if first_name is not None else generate_random_first_name()
    resolved_last_name = last_name if last_name is not None else generate_random_last_name()
    resolved_email = email if email is not None else f"{resolved_username}@example.com"
    resolved_phone = phone if phone is not None else _fake.phone_number()

    return {
        "id": resolved_user_id,
        "username": resolved_username,
        "firstName": resolved_first_name,
        "lastName": resolved_last_name,
        "email": resolved_email,
        "password": password,
        "phone": resolved_phone,
        "userStatus": user_status,
    }

def serialize_to_json(payload: dict) -> str:
    return json.dumps(payload)