# 14 AAG Mission Template

This repository holds all the logic we require to run our missions, everything from custom Zeus modules & compositions to the respawn system and whitelist.

<img src="https://www.14aag.com/assets/img/logo-512.png" alt="14aag logo" width=100>

## Loading the template

***This guide will go over creating a simple mission using this template.***

- Before you do anything, load into the arma editor and load the map you want to create a mission on. save this as a new mission. 

- Go to where this mission was saved. In most cases it will be saved here:

```
C:\Users\%USERPROFILE%\Documents\Arma 3 - Other Profiles\SGT%20B%2e%20Wayne\missions\mission_name.map_name
```

- Download this repo and copy the contents of the `mission_dir` folder into your own mission save folder.

Your mission will now have all the required scripts and modules that a 14AAG mission needs.

## Loading the basic composition

Unless you are creating a completely custom mission you will need the basic unit composition.

- Locate your profile compositions folder, most likely here: 

```
C:\Users\%USERPROFILE%\Documents\Arma 3 - Other Profiles\SGT%20B%2e%20Wayne\compositions
```

- Copy the contents of `compositions` into that folder, if you're already in the editor then you'll need to exit and enter again.

You should have `14AAG Base` under the custom compositions tab.

## Creating a limited arsenal

- Copy the contents of [whitelists/standard.txt](whitelists/standard.txt) to your clipboard

- In the arma3 editor, spawn an empty object like a box.

- Bring up the object attributes `right-click > attributes`

- In the `Object: ACE Arsenal` dropdown, click on the import button. (make sure the whitelist is still in your clipboard)

The arsenal is now limited 🎉🎉