Getting an addon to track hots the way I wanted when I first started healing as a resto druid was a major struggle. None of the available addons track hots properly. So I ended up making numerous modifications to some of the Grid extensions to add the functionality I needed. This is what the frame looks like:

[img]http://puu.sh/mrxaH/f2ecc2d2e2.png[/img]

[b][u][size=150]Grid[/size][/u][/b]
[b]Top Middle Text: [/b] Time left on lifebloom. Green -> Yellow -> Red colored as it runs out.
[b]Top Right Corner Icon: [/b] Represents number of stacks of lifebloom on the target. Green = 3 stacks, Yellow = 2 stacks, Purple = 1 stack
[b]Bottom Middle Text: [/b] Time left on Rejuvenation. Color coded just like lifebloom
[b]Bottom Right Corner Icon: [/b] Represents time life on Regrowth. Green = 5-21 seconds left, Yellow = 3-5 seconds left, Red = 1-3 seconds left
[b]Middle Text: [/b] Shows the name of the player. If any direct heal is currently being cast on a player, then the name will change to an estimation of how big the heal they are about to receive will be. 
[b]Bonus - Bottom Middle Icon:[/b] Not shown in this screenshot. But you will see a Mark of the Wild icon in the bottom middle of the frame if a target is missing Mark of the Wild and you are out of combat. 
[b]Bonus - Bottom Left Corner Icon:[/b] Not shown in this screenshot. The bottom left corner icon shows a purple square when a raid member is inflicted with a curse that you can remove with [b]Remove Curse[/b].
[b]Bonus - Top Left Corner Icon:[/b] Not shown in this screenshot. The top left corner icon shows a green square when a raid member is inflicted with a poison that you can remove with [b]Abolish Poison[/b].
[b]Bonus - Border:[/b] Not shown in this screenshot. When a raid member has aggro, their border turns red. When a raid member is your target, their border turns white.
[b]Bonus - Kalecgos:[/b] My setup also tracks Curse of Agony on the Kalecgos encounter in Sunwell. The border will light up green a raid member is inflicted with Curse of Agony. The border will then turn pink when the curse of agony has been on the target for 13 seconds, which means you need to decurse them. No more looking at the stupid curse duration bars from DBM and searching your grid for raid members that need a decurse!
[b]Border Priorities: [/b] Kalecgos Curse > Aggro > Your Target

[b][u][size=150]Hotcandy[/size][/u][/b]
[img]https://i.imgur.com/H3e3wEG.png[/img]

This addon shows bars that track hots on your current target. It also displays stacks of lifebloom, and bars are color coded based on their duration. For configuration, just type /hotcandy. [b]Important: Leave the scale at 1.0. There is a bug with the scale that will cause the position of the bars to be offset if you change the scale at all. You are free to change the width all you want.[/b]

The main reason I use this addon is because grid statuses bug when multiple resto druids are in the raid. Grid statuses will show lifeblooms/rejuvs of other resto druids, but they will be overwritten by yours. Example: I put up 1 lifebloom on Tank A. It ticks for 2 seconds, and my Grid shows 1 bloom and 5 seconds remaining. Then another resto druid puts a lifebloom and a rejuv on Tank A. My Grid will now show 1 lifebloom, with a 7 second duration, and a rejuv with a 12 second duration. 

This type of case makes it hard to distinguish between who has hots on who. Luckily, Hotcandy does not get confused like this, and will only display your hots. So when there are multiple resto druids, I use hotcandy so that I can see accurate hot counts on tanks and such.

While this is unfortunate, there is little we can do without a lot of code changes because this is a very old version of Grid. Still though, the functionality that I have created with my setup is as good as it gets, and problems only arise when there are multiple resto druids.

[b][u]All Together:[/u][/b]
[img]https://i.imgur.com/yPWVpLV.png[/img]

Before installing any of this [b][size=150][u]BACKUP YOUR ENTIRE WTF FOLDER AND YOUR ENTIRE INTERFACE/ADDONS FOLDER[/u][/size][/b]

[u]Download Here:[/u]
[b][url]https://github.com/Patchett/Burning-Crusade-Resto-Druid-Grid-And-HotCandy-Config[/url][/b]
(Press the [b]Download Zip[/b] button)

To install:
1. Extract the Zip. 
2. Put the contents of the [b]Grid Addons[/b] folder into WoW/Interface/Addons
3. Put the contents of the [b]Grid Config[/b] folder into WoW/WTF/Account/YOUR_ACCOUNT_NAME/SavedVariables
4. All of this is contained in the READMES that are in the download

Post here if you have problems/questions.
