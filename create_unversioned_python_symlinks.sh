#!/bin/zsh

# Directory where Homebrew installs Python
PYTHON_HOME=$(brew --prefix python@3.12)/bin

# Destination directory for the symbolic links
LINK_DIR="/usr/local/bin"

# Create unversioned symlinks for python, pip, etc.
ln -sf ${PYTHON_HOME}/python3.12 ${LINK_DIR}/python
ln -sf ${PYTHON_HOME}/pip3.12 ${LINK_DIR}/pip

# Add similar lines for other executables like pydoc3, etc., if needed
