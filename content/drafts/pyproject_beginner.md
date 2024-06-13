# Pyproject

Venvs are fine for development, but I wanted something that I could easily
install globally. I found `pipx` and realized that I could use this to install
python projects everywhere. 

## Sample Project with Dependencies

- TODO: create a sample project
- TODO: have required dependencies
- TODO: have dev dependencies

## Using pyproject toml

Ref: https://packaging.python.org/en/latest/guides/writing-pyproject-toml/


```
python -m venv .env
source .env/bin/activate
# allows development changes to reflect immediately
python -m pip install --editable ".[dev]"
pipx install --force . # --force to make sure already installed versions are overwritten
```
