# Working with Nibs

## How to create nib and associated with View Controller

Create a nib `View`.

Optionally turn off Safe Area Layout Guide

![](images/1.png)

Make size Freeform.

![](images/2.png)

Draw and layout controls.

![](images/3.png)

Create a backing View (i.e. LoginView).

![](images/3a.png)

Associated the view with the nib.

![](images/4.png)

Add the `IBOutlets` by getting both the view and the nib on screen at the same time and control drag `IBOutlets` from the nib to the view (make them strong references).

![](images/5.png)

Set the File’s owner to be the View Controller.

![](images/5a.png)

Set the nib view outlet. Click File’s Owner. 

In the right-hand sidebar, click on the last tab--the one that looks like a circle with an arrow in it
You should see "outlets" with "view" under it. Drag the circle next to it over to the "view" icon on the left bar (bottom one, looks like a white square with a thick gray outline.

![](images/6.png)

Can now run and display app.


### Links that help
* [Apple Docs Nib Files](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html)
