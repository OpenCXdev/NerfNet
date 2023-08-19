import argparse
import time

import backoff
from firebase_admin import credentials, initialize_app, firestore

parser = argparse.ArgumentParser()
parser.add_argument("--cred", default="cred.json", help="Path to firebase credentials.")
parser.add_argument("--db", help="Firestore database ID.")
args = parser.parse_args()

cred = credentials.Certificate(args.cred)
initialize_app(cred, {"databaseURL": f"https://{args.db}.firebaseio.com"})
db = firestore.client()


@backoff.on_predicate(backoff.expo, max_time=60)
#@backoff.on_exception(backoff.expo, Exception, max_time=60)
def attempt_work():
    print("Attempting to do work")
    return False


def main():
    while True:
        attempt_work()
        time.sleep(1)


if __name__ == "__main__":
    main()
