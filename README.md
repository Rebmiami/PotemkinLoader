PotemkinLoader is a Lua script for The Powder Toy meant for testing scripts on platforms such as Android where there is currently no easy way for developers to debug or test compatibility in a timely manner.

To use PotemkinLoader, upload your script using pastebin, 0x0.st, github gists, or any other server that your testing device can access. Then, load the script in The Powder Toy and open the console. PotemkinLoader provides the following functions:
- `Potemkin.SetURL(string url)` - Saves the specified URL and attempts to execute the script at that location on every subsequent reload. Currently, only one URL can be saved.
- `Potemkin.RunScriptFromURL(string url)` - Attempts to execute the script at the specified URL once.

PotemkinLoader is NOT meant for use by non-developers. It contains no safeguards against malicious scripts and is only meant for use in cases where the user created the remote file.
