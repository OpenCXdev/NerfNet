import firebase_admin
from firebase_admin import credentials, storage
from fastapi import UploadFile
from pathlib import Path
import asyncio

creds = credentials.Certificate("credentials.json")
firebase_admin.initialize_app(creds)
db = storage.bucket(f'{creds.project_id}.appspot.com')

async def upload_file_to_firebase_storage(file: UploadFile, dir: Path):
    content = await file.read()
    blob = db.blob(str(Path(dir,file.filename)))
    await asyncio.to_thread(blob.upload_from_string, content, content_type=file.content_type)
    return {'blobPath': blob.path, 'message': 'Uploaded successfully'}

async def upload_files_to_firebase_storage(files: list[UploadFile], dir: Path):
    # create a new directory in the storage bucket with the user's username
    tasks = [asyncio.create_task(upload_file_to_firebase_storage(file, dir)) for file in files]
    res = await asyncio.gather(*tasks)
    return {'blobPath': dir, 'nfiles': len(res), 'message': 'Job queued successfully'}