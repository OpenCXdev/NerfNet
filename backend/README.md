### Overview
A prototype fastAPI backend for file upload and initiating NeRF training jobs. Supports: 
- User authentication (OAuth2 with JWT)
- Multi-threaded file upload to Firebase storage (easy to swap in other providers)
- Task creation and enqueueing

### Setup
- Install dependencies: `pip install -r requirements.txt`
- Add mock user to fake user db at `user_db.py`
- Download and add firebase service account credentials as `credentials.json`
- Start Uvicorn server for dev: `uvicorn main:app --reload` 
- Start without hot reload to allow multiple worker processes: `uvicorn main:app --workers <N_WORKERS>`
- View swagger docs and test at http://127.0.0.1:8000/docs/