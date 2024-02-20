import os

import dotenv

dotenv_file = dotenv.find_dotenv()
dotenv.load_dotenv(dotenv_file)

print(os.environ["token"])
os.environ["token"] = os.getenv('access_token')
print(os.environ["token"])

dotenv.set_key(dotenv_file, "token", os.environ["token"])
