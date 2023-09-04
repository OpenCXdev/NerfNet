from app import app


@app.task
def process_request(request: dict):
    """
    Process a request.
    See `specs.md` for the request format.
    """
    print(f"Processing request {request}")
    return request
