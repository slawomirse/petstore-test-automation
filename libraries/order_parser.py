import re


def parse_order_id_from_toast(toast_text: str) -> str:
    match = re.search(r"Order #(\d+) placed", toast_text)
    if not match:
        raise ValueError(f"Could not parse order ID from toast text: {toast_text!r}")
    return match.group(1)
