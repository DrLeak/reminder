# reminder
Do not collect your thoughts with your brain, but with this script, which will then remind you of what you need when you want it.

`use /remindme [hour:minute] [remindtext] to add a reminder!` 
`use /removereminders to remove all reminders!` 
`use /remindplayer [serverid] [hour:minute] [remindtext] to add a reminder to an different person!`

the reminder goes through the list of remindings all 10 seconds. This means that if you create a message at 5:00 p.m., it may only arrive 10 seconds later. 
This can be changed by setting the number to 0 in line 111 at Citizen.Wait. However, this will increase the load on the server.

The remindings follow through the chat and a Notification sound, in case that the player tabbed out. (sound can be turned off through configuration)
