Getting an addon to track hots the way I wanted when I first started healing as a resto druid in TBC was a major struggle. None of the available addons track hots properly. So I ended up making numerous modifications to some of the Grid extensions to add the functionality I needed. This is what the frame looks like:

![](http://puu.sh/mrxaH/f2ecc2d2e2.png)

##**Grid**
**Top Middle Text:** Time left on lifebloom. Green -> Yellow -> Red colored as it runs out.  
**Top Right Corner Icon:** Represents number of stacks of lifebloom on the target. Green = 3 stacks, Yellow = 2 stacks, Purple = 1 stack  
**Bottom Middle Text:** Time left on Rejuvenation. Color coded just like lifebloom  
**Bottom Right Corner Icon:** Represents time life on Regrowth. Green = 5-21 seconds left, Yellow = 3-5 seconds left, Red = 1-3 seconds left  
**Middle Text:** Shows the name of the player. If any direct heal is currently being cast on a player, then the name will change to an estimation of how big the heal they are about to receive will be.  
**Bonus - Middle Icon:** Not shown in this screenshot. But you will see a Mark of the Wild icon in the bottom middle of the frame if a target is missing Mark of the Wild and you are out of combat. The middle icon will also show numerous important debuffs such as Encapsulate on Felmyst, Firebloom on KJ, etc.
**Bonus - Bottom Left Corner Icon:** Not shown in this screenshot. The bottom left corner icon shows a purple square when a raid member is inflicted with a curse that you can remove with **Remove Curse**.  
**Bonus - Top Left Corner Icon:** Not shown in this screenshot. The top left corner icon shows a green square when a raid member is inflicted with a poison that you can remove with **Abolish Poison**.  
**Bonus - Border:** Not shown in this screenshot. When a raid member has aggro, their border turns red. When a raid member is your target, their border turns white. The border will also show buffs like Ice Block, paladin bubble, and BoP. There are some others too, just look under Frame->Border in grid config.
**Bonus - Kalecgos:** My setup also tracks Curse of Agony on the Kalecgos encounter in Sunwell. The border will light up green a when raid member is inflicted with Curse of Agony. The border will then turn pink when the curse of agony has been on the target for 13 seconds, which means you need to decurse them. No more looking at the stupid curse duration bars from DBM and searching your grid for raid members that need a decurse!  
**Bonus - Brutallus Burn:** On Brutallus, the center text will show burn duration and color code the text based on how much damage a burn target will take. This is extremely useful for burn healing. More information about this specific addon can be found [here](http://www.wowinterface.com/downloads/info10006-GridStatusBurn.html). My setup already includes it.  
**Border Priorities:** Kalecgos Curse > Aggro > Your Target  

##**Hotcandy**  
![](https://i.imgur.com/H3e3wEG.png)  

This addon shows bars that track all of your hots. It also displays stacks of lifebloom, and bars are color coded based on their duration. For configuration, just type /hotcandy. **Important: Leave the scale at 1.0. There is a bug with the scale that will cause the position of the bars to be offset if you change the scale at all. You are free to change the width all you want.**  

The main reason I use this addon is because grid statuses bug when multiple resto druids are in the raid. Hots from other druids will overwrite your hots. Example: I put up 1 lifebloom on Tank A. It ticks for 2 seconds, and my Grid shows 1 bloom and 5 seconds remaining. Then another resto druid puts a lifebloom and a rejuv on Tank A. My Grid will now show 1 lifebloom, with a 7 second duration, and a rejuv with a 12 second duration.  

This type of case makes it hard to distinguish between who has hots on who. Luckily, Hotcandy does not get confused like this, and will only display your hots. So when there are multiple resto druids, I use hotcandy so that I can see accurate hot counts on tanks and such.  

While this is unfortunate, there is little we can do without a lot of code changes because this is a very old version of Grid. Still though, the functionality that I have created with my setup is as good as it gets, and problems only arise when there are multiple resto druids.  

##**All Together:**  
![](https://i.imgur.com/yPWVpLV.png)

Before installing any of this **BACKUP YOUR ENTIRE WTF FOLDER AND YOUR ENTIRE INTERFACE/ADDONS FOLDER**  

##To install:  
1. Extract the Zip.  
2. Put the contents of the **Grid Addons** folder into WoW/Interface/Addons  
3. Put the contents of the **Grid Config** folder into WoW/WTF/Account/YOUR_ACCOUNT_NAME/SavedVariables  
4. All of this is contained in the READMES that are in the download  
  
Post here if you have problems/questions.  
