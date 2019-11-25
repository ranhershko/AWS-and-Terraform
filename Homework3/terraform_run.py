import json
from pprint import pprint
from pathlib import Path

path = Path(__file__).parent.absolute()
backend_tstate_file = path + "/" + "remote_state/terraform.tfstate"

data = json.load(backend_tstate_file)

for item in data.text.items:
    pprint(item)