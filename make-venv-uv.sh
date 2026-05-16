uv venv .venv
source .venv/bin/activate
pip install uv
uv pip install --upgrade pip
uv pip install -r requirements.txt
uv pip install -e packages
uv pip list
deactivate
