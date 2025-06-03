#!/bin/zsh

# Set the default version if not provided
PYTHON_VERSION=${1:-3.13}

# Directory where Homebrew installs Python
PYTHON_HOME=$(brew --prefix python@$PYTHON_VERSION)/bin

# Destination directory for the symbolic links
LINK_DIR="/usr/local/bin"

# Create unversioned symlinks for python, pip, etc.
ln -sf ${PYTHON_HOME}/python${PYTHON_VERSION} ${LINK_DIR}/python
ln -sf ${PYTHON_HOME}/pip${PYTHON_VERSION} ${LINK_DIR}/pip

# Add similar lines for other executables like pydoc3, etc., if needed
