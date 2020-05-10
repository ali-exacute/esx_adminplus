hello everyone!
first of all , this my first time releasing something on [forum](https://forum.cfx.re/t/esx-1-2-esx-adminplus/1202550?u=ali_exacute) , so take it easy on me!

i just make this script for [newest ESX version [1.2]](https://github.com/ESX-Org/es_extended)

all commands available in this script:

>**server console commands:**
*  **players** | will return ID/name/group of online players
*  **reviveall** | will revive all dead players
*  **say [message]** | send announcement to all online players

>**ingame Admin commands**
* **/admin** | your exact rank on server
* **/tpm** | teleport you to selected waypoint on map [thanks to [qalle](https://github.com/qalle-fivem/esx_marker) for his code
* **/coords** | print ped coords in serverconsole and F8
* **/report [message]** | send `message` to all online admins [configurable cooldown]
* **/announce [message]** | send announcement to all online players
* **/bring [ID]** | bring a player to your location
* **/bringback [ID]** | teleport player back to where he was before `/bring`
* **/goto [ID]** | teleport you to player with given ID
* **/goback** | teleport you back where you was before `/goto`
* **/kill [ID]** | instantly kill player
* **/freeze [ID]** | freezing and making player invincible
* **/unfreeze [ID]** | opposite of what `/freeze` do
* **/reviveall** | revive all dead player on server (completely serversided)
* **/a [message]** | admin only chat with ranks and names
* **/warn [ID]** | warn a player and kick if execeed max warns [configurable]

special thanks to `Cold Cat!!!#8585` for helping me on debugging and testing

>**INSTALLATION**
1. download from [github](https://github.com/ali-exacute/esx_adminplus)
2. extract esx_adminplus-master to your `resources` folder and remove `-master` from folder name
3. add **start esx_adminplus**  AFTER es_extended and esx_ambulancejob in your server config
4. open up config.lua in esx_adminplus folder and config it as you want [note: default ranking system is : **superadmin > admin > moderator**

**dependencies :**  
>[ESX latest version](https://github.com/ESX-Org/es_extended)
[esx_ambulancejob](https://github.com/ESX-Org/esx_ambulancejob)

**notes:**
>there is no UI like [es_admin](https://github.com/kanersps/es_admin) , all commands are easy to use already

> you can exclude rank(s) from accessing to a command by passing a table of ranks as second argument to `havePermission()`
>
>if you don't know what that means , lets do an example :
you want to exclude `moderator` from sending announcements , so :
first , find
```RegisterCommand("announce", function(source, args, rawCommand)```
then find
```if havePermission(xPlayer) then```
and add second argument to `havePermission` like below:
```if havePermission(xPlayer, {'moderator'}) then```
thats it! 

hope you like it!
have a good day :snail: 
