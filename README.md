**Make sure to check [esx_adminplus on Fivem forum](https://forum.cfx.re/t/esx-v1-exm-esx-adminplus/1202550)**

**ESX AdminPlus**

My first public resource , created mainly for ESX V1.2 _(AKA. V Final)_ (but also works with V1.1)

all commands available in this script:

>**server console commands:**
*  **players** | will return ID/name/group of online players
*  **reviveall** | will revive all dead players
*  **say [message]** | send announcement to all online players

>**ingame Admin commands**
* **/admin** | your exact rank on server
* **/tpm** | teleport you to selected waypoint on map [thanks to [qalle](https://github.com/qalle-fivem/esx_marker) for his code]
* **/coords** | print ped coords in serverconsole and F8

* **/report [message]** | send `message` to all online admins [configurable cooldown]
* **/announce [message]** | send announcement to all online players
* **/bring [ID]** | bring a player to your location
* **/bringback [ID]** | teleport player back to where he was before `/bring`
* **/goto [ID]** | teleport you to player with given ID
* **/goback** | teleport you back where you was before `/goto`
* **/kill [ID]** | instantly kill player with given ID
* **/freeze [ID]** | freezing and making player invincible
* **/unfreeze [ID]** | opposite of what `/freeze` do
* **/reviveall** | revive all dead player on server (completely serversided, so no exploit can be done)
* **/a [message]** | admin only chat with ranks and names
* **/warn [ID]** | warn a player and kick if execeed max warns [configurable]
* **/noclip** | Noclip [thanks to [riftwebdev](https://github.com/riftwebdev)] for his code

special thanks to `Cold Cat!!!#8585` for helping me on debugging and testing

>**INSTALLATION**
1. **download from [github](https://github.com/ali-exacute/esx_adminplus)**

2. extract esx_adminplus-master to your `resources` folder and remove `-master` from folder name
3. add **start esx_adminplus**  AFTER es_extended(or ExtendedMode) and esx_ambulancejob in your server config
4. open up config.lua in esx_adminplus folder and config it as you want [note: default ranking system as i know was : **superadmin > admin > moderator** [it could be different for you, check your server cfg and see what is yours]

**dependencies :**  
>[ESX V1 final](https://github.com/esx-framework/es_extended/tree/v1-final) || alternative :  [ExtendedMode](https://github.com/extendedmode/extendedmode)
>
>[esx_ambulancejob](https://github.com/ESX-Org/esx_ambulancejob) [can be optional] _(only for reviveall command)_
>
>Onesync [can be optional] _(read below for more information)_

**notes:**

>there is no UI like [es_admin](https://github.com/kanersps/es_admin) , all commands are easy to use already

>ESX version 1.1 and 1.2 both supported

>Onesync needed for teleport / bring / goto / coords commands ( TLDR : anything that need coordination )

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


**my other scripts :**

[second hand vehicle](https://forum.cfx.re/t/esx-exm-second-hand-vehicle-v1-2-2-sell-your-used-cars-to-other-players)

[Advanced Job System](https://forum.cfx.re/t/esx-advanced-job-system/2616104)

[Advanced Kit System](https://forum.cfx.re/t/standalone-esx-advanced-kit-system)


hope you like it!

if you need help about this script you can contact me @ https://discord.com/invite/Mgyg2nVRhC

_I am gonna work on a new administrator menu (yes, MENU!) soon,
but its gonna be a lot of work_

_Stay tuned!_
