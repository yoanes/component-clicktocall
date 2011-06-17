######### Generic Features #########

First time??? read this first: http://wiki/display/WIRE/Whereis+Mobile+Cucumber


Those features are under the folder /features/generic and are ready for firefox. 
They also have the annotation @firefox at the feature or snecario level
You don't need to specify the device, as you will see for omniture tests bellow.

This will run all generic firefox: 

> bundle exec cucumber features/generic/ --tags @firefox --tags ~@wip

* Aways use ~@wip in order to skip or ignore (don't run) work in progress scenarios.


######## Omniture Features #########

All omniture tests under the folder /features/omniture.
You will have to specify the DEVICE as @iPhone-OS-4.0. Eg.:

> bundle exec cucumber features/omniture/omniture.feature DEVICE=@iPhone-OS-4.0 -r features

It is recomended to run omniture.feature by itself at the moment. This will generate the omniture_log.txt file

Click-to-call omniture tests have special treatment. At the moment run this way: 

> rake cucumber:click_to_call



You can always run specific scenarios:

> bundle exec cucumber features/generic/directions.feature 

> bundle exec cucumber features/generic/directions.feature:10 

> bundle exec cucumber features/omniture/omniture.feature:21 DEVICE=@iPhone-OS-4.0 


You can disable cookies, using DISABLE_COOKIES=true:

> bundle exec cucumber features/generic/directions.feature:18 --tags @firefox --tags ~@wip DISABLE_COOKIES=true

This is usefull for generic tests


##################################################
############### About this test strategy #################

About 85 to 90 percent of the bugs I have worked or hear about it, I was able to reproduce in Firefox.
Of course there are specific things enabled per device or carrier such as, locate button or telstra my places, click to call.


---> Why not to create coverage test for all 20 devices in the device list???

 Answer: you could end up with 20 different HTML's. The device list could change quickly. New devices could be added, others removed.

 Write tests for all 20 devices sounds cool but the maintenance cost is not worth because now you have 20 different implementations to take care.

 There are simple things that we can test in a generic way. Click-to-call is a good example.
 If the html link looks like <href="tel:0412567890" /> we DO know that this works in all high-end devices. So why try to simulate all 10 high-end devices in the list???
 We can easily find out the same approach for low-end devices.

 some devices don't accept cookies. We can disable and run the same tests.

 The intention of this strategy is find errors early - not to enable automatic deployment without human intervention.
 Mobile web sites is not the same as web sites - device verification will stick around for a long time.
 This strategy is focused in functionality issues.

Specific tests could be Maps for low-end devices. This case the map has got some navigation buttons that reload the page everytime you click in "move left/right/north/south"


 ---> Omniture logs testing

 Current test implementation verifies the omniture log AFTER the Event Capture transformation. 
 The test works out which server of the load balance the log has come though and grabs the modified lines for possible validation.

TODO: install Tibco and run the omniture tests locally. 







### GIT Tips ###

If you are a QA:

- only change .features file.
- never "git pull" with modified files. Commit or stath your changes.
- never use this command "git add ."
- always open Rubymine on the directory cucumber So that you never see any Java code.
- if you are building a new feature, use the work in progress annotation @wip so that you don't break the buil on the CI.
- Commit your changes and pull fequently to avoid big code merging. 
- Be carefull with "git reset --hard" - you will lose all non-committed changes.
- Before changing any file, "git pull"
- Set up some command alias. Eg.: gs="git status", gp="git pull"...




