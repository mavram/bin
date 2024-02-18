## create_unversioned_homebrew_python.zsh ##

### Using the Script ###
* **Save the Script:** Copy the script into a text file, for example, create_unversioned_homebrew_python.zsh.
* **Make It Executable:** Before running the script, you need to make it executable. You can do this using the chmod command in the terminal:
```
chmod +x create_unversioned_python_symlinks.zsh
```
* **Run the Script:** Now, you can run the script by typing `./create_unversioned_homebrew_python.zsh` in the terminal from the directory where the script is located.
### Additional Notes ##
* Ensure `/usr/local/bin` is in your `PATH` environment variable for the symlinks to be effective.
* Running the script might require sudo if your user does not have write permissions to `/usr/local/bin`.
* This script assumes that Homebrew's Python package installs its binaries with names like python3 and pip3, which is the standard naming convention. However, this could potentially change with future Homebrew or Python releases, so if you encounter issues, it may be worth checking the current naming convention.
* Since you are creating symlinks to the Homebrew-managed versions of Python and pip, any updates to Homebrew's Python package should be reflected automatically in your symlinks, making it a convenient way to stay up to date.

### Enhancements ###
* Add support for version as input parameter
