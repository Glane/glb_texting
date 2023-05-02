# README

Hi there! 
Thanks for visiting Laney's Texting Service!  I hope you enjoy your stay.
Here are the steps to get the Service runnning.

- Open a terminal window and run the following commands to clone the app locally.
 
 `git clone https://github.com/Glane/glb_texting.git`
 
 `cd glb_texting`
 
 `bundle install`
 
 `rails db:migrate`
 
 `rails server`
 


- Download ngrok at https://ngrok.com/download (if you do not have it already)

- Open a second terminal window and run the following:

`./ngrok http 3000`

You should see an ngrok session pop up. To the right of the word 'forwarding' you will see a 'ngrok-url' -> http://localhost:3000
You will need this 'ngrok-url' to create your callback_url for your text messages as follows:
**YOUR CALLBACK URL: 'ngrok-url' + '/text_message_responses'**

for example, if your 'ngrok-url' is https://a23f-104-12-203-65.ngrok-free.app, 

your callback_url will be https://a23f-104-12-203-65.ngrok-free.app/text_message_responses



Open a browser and proceed to http://localhost:3000, Voila! (hopefully you see something)

Before you start sending messages you need to set up your Providers.  Click the 'Manage Providers' button.  Then the 'New Provider' button.  Please enter the following info to add two Providers.  Don't worry, you can edit them if you make a mistake.

1 - name: 'Provider 1' url: 'https://mock-text-provider.parentsquare.com/provider1' allocation: 0.3 active: checked, count: 0
2 - name: 'Provider 2' url: 'https://mock-text-provider.parentsquare.com/provider2' allocation: 0.7 active: checked, count: 0


Go back to 'See Messages' and hit the 'Send A New Message' button.  Go ahead, send a message!  Enter a phone number, a message, and the callback_url you created a few minutes ago, and hit send.  Of course, it won't really go anywhere, but you will hopefully get an ID and a Status in return.  Go to 'See Messages" to find out.  Hopefully you are off and running to send messages and follow their status.  Here is a list of what each Status indicates.


**requested** - The Message has been requested to send (has a number, message, and callback_url).

**retrying** - The first Provider was down(500 responce).  It will try the other Providers that are Active until either one works or they all fail.

**failed** - Either all Active Providers were tried and none of them responded (all down indicated by lack of message_id) or the callback status was 'failed"

**pending** - The message was sent and a message_id was returned.  This message is waiting for a callback status.

**delivered** - This message received a callback with a status of 'delivered'.

**number_invalid** - This message either received a callback wiht a status of 'invalid' or the same number received a callback status of 'invalid" from a previous message.  note: Rails objected to a state named 'invalid' so I renamed it 'number_invalid' after it came in.




Other things



Open a third terminal window and cd into the project directory again.
`cd glb_texting`


* ...
