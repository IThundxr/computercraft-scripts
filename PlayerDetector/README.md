# Player detector with discord webhook support

copy the code from basedefence.lua into a pastebin then make a file called `startup.lua` and add this code

```lua
shell.run("delete", "playerDetector")
shell.run("pastebin", "get", "z4bNPJ7r", "playerDetector")
shell.run("playerDetector", "webhookurl")
```

replace z4bNPJ7r with your pastebin code and webhookurl with your discord webhook and it will work!