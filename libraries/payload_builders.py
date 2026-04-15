import json

from faker import Faker

_fake = Faker()


def generate_random_id() -> int:
    return _fake.random_int(min=100000, max=999999)

def generate_random_dog_name(prefix: str = "Dog") -> str:
    return f"{prefix}_{_fake.first_name()}"

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

def serialize_to_json(payload: dict) -> str:
    return json.dumps(payload)