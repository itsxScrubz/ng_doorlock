**-----------------------------------**  
**-- Information --**  
**-----------------------------------**  
-- //©_Scrubz#0001_© ^_^// --  
-- //NextGen Framework Public Release// --  
You may rename this resource to whatever you wish for personal use on your server as long as you leave my credit bit thats written above^^ and inside cl_doors.lua. If you make edits to it and/or share it on ANY platform for public use, YOU MUST provide credit and link back to [this repo](https://github.com/itsxScrubz/ng_doorlock).  
I did make some small changes that work on my framework and I made the same changes to the ESX version. I do not have esx files to test, so if something is broken please make a pull request. As of right now, everything works as intended for me. (Should be working for esx or at least it does for a server currently using this [before the minor changes I made].)  

#### **-- Features --**  
Swing Checks  
AutoLocking at Night  
Lockpickable Doors  
AutoRelocking after being lockpicked  
Supports single doors, double doors, and double doors with different models  

#### **-- IMPORTANT --**  
I left notes inside cfg_doorlist.lua. But here are the important bits:  
- Gates MUST HAVE `isGate = true` otherwise it will break.   
- Double doors MUST HAVE `doubleDoor = true` otherwise it will break.  
- When putting the heading for double doors, heading1 needs to match doorPos key 1, and heading2 needs to match doorPos key 2.  
- Double doors with different door models MUST HAVE `multiModel = true` otherwise it will break.  
- The keys need for double doors with different models. 
If you have the left door as key 1, then you need to have that doors pos as key 1.  

#### **-- Current Bugs --**   
- For some reason the swing check doesn't work with the side doors at pdm. Idk if it's just those doors, all multimodel double doors, or if it's my code. I'll come back to it eventually... :shrug:  

#### **-- FAQ --**  
> Idk why it's broken, can you help me??  

No.

> The esx version no work!?!?  

This may be due to the version of esx your running. I don't use esx, nor do I have any files to test with therefor I will NOT help you get it working.  

> I found a bug!!  

Please for the love of god submit a pull request!! Don't just horde all the fixes to yourself.  

> I have a better way of doing -xxx-!!  

Either make a pull request, or send me the code. ^_^  

> Could you add -xxx-??  

Maybe. If you give headpats I might be inclinded to do so.  

