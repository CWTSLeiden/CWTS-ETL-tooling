# ReadJsonTags.exe

Python version: 3.9

## Packages

Dependencies are listed in requirements.in

## Tooling

- [pyenv](https://github.com/pyenv/pyenv)
    - install python: `pyenv install 3.9:latest`
- [pip-tools](https://github.com/jazzband/pip-tools) (install in venv):
    - add dependencies to requirements.in
    - lock requirements: `pip-compile`
    - install requirements: `pip-sync`
- [pyinstaller](https://pyinstaller.org/en/stable/):
    - create windows executable from code: `pyinstaller --onefile ReadJsonTags.py --icon NONE --version-file=version.rc`
    - or run `build.bat`
