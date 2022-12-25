#!/usr/bin/env python3

import os
import shutil
from git import Repo
import math
import yaml

REPO_URL = f"https://github.com/apple/device-management"
REPO_DIR = "device-management"
PROFILES_DIR = f"{REPO_DIR}/mdm/profiles"
PAYLOADS_FILE = "Low Profile/Payloads.yaml"

if os.path.exists(REPO_DIR):
    shutil.rmtree(REPO_DIR)

Repo.clone_from(REPO_URL, REPO_DIR)

payloads = {}

for filename in os.listdir(PROFILES_DIR):
    filepath = os.path.join(PROFILES_DIR, filename)

    with open(filepath) as file:
        payload = yaml.load(file, Loader=yaml.FullLoader)
        key = filename.replace(".yaml", "")
        payloads[key] = payload

with open(PAYLOADS_FILE, "w") as file:
    yaml.dump(payloads, file, width=math.inf)

exit(0)
