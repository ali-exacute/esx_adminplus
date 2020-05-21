Hello everyone!
First of all , this my first time releasing something on [forum](https://forum.cfx.re/t/esx-1-2-esx-adminplus/1202550?u=ali_exacute) , so take it easy on me!

I just made this script for [newest ESX version [1.2]](https://github.com/ESX-Org/es_extended)

All commands available in this script:

>**server console commands:**
*  **players** | will return ID/name/group of online players
*  **reviveall** | will revive all dead players
*  **say [message]** | send announcement to all online players

>**ingame Admin commands**
* **/admin** | Your exact rank on server
* **/tpm** | Teleports you to a selected waypoint on the map [thanks to [qalle](https://github.com/qalle-fivem/esx_marker)] for his code
* **/noclip** | Noclip [thanks to [riftwebdev](https://github.com/riftwebdev)] for his code
* **/coords** | Prints PED coordinates in serverconsole and F8
* **/report [message]** | Sends `message` to all online admins [configurable cooldown]
* **/announce [message]** | Sends announcements to all online players
* **/bring [ID]** | Brings a target to your location
* **/bringback [ID]** | Teleports target back to where he was before `/bring`
* **/goto [ID]** | Teleports you to target with given ID
* **/goback** | Teleport you back where you was before `/goto`
* **/kill [ID]** | Instantly kill player
* **/freeze [ID]** | Freezes and makes target godmode
* **/unfreeze [ID]** | Opposite of what `/freeze` do
* **/reviveall** | Revives all dead player on the server (completely serversided)
* **/a [message]** | Admin only chat with ranks and names
* **/warn [ID]** | Warns a player and kicks if exceeds max warnings [configurable]

Special thanks to `Cold Cat!!!#8585` for helping me on debugging and testing

>**INSTALLATION**
1. Download from [github](https://github.com/ali-exacute/esx_adminplus)
2. Extract esx_adminplus-master to your `resources` folder and remove `-master` from folder name
3. Add **start esx_adminplus**  AFTER es_extended and esx_ambulancejob in your server config
4. Open up config.lua in esx_adminplus folder and config it as you want [note: default ranking system is : **superadmin > admin > moderator**

**dependencies :**  
>[ESX latest version](https://github.com/ESX-Org/es_extended)
[esx_ambulancejob](https://github.com/ESX-Org/esx_ambulancejob)

**Notes:**
>There is no UI like [es_admin](https://github.com/kanersps/es_admin) , all commands are easy to use already

> You can exclude rank(s) from accessing to a command by passing a table of ranks as second argument to `havePermission()`
>
>If you don't know what that means , lets do an example :
You want to exclude `moderator` from sending announcements , so :
First , find
```RegisterCommand("announce", function(source, args, rawCommand)```
Then find
```if havePermission(xPlayer) then```
And add second argument to `havePermission` like below:
```if havePermission(xPlayer, {'moderator'}) then```
Thats it! 

Hope you like it!
Have a good day :snail: 
