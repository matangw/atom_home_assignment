Matan Gabso ATOM home assignment
Missions:
    Home page with a 1 button in the center that should stay there for many as screen as possible.
    Data migration from the json file.
    Execute the correct action from the 3 actions list (make it possible for easy actions update and action addition).
    
actions:
    Animation - make the button rotate 360.
    Toast - show a toast to the user.
    Notification - send a local notification that if the app initiated by pressing on the notification it execute the animation action

Work flow:
    I started by creating the homepage with the button in the center of the screen.
    Migrate the data from the .json file.
    Created objects for the action and a factory fromJson builder.
    Started building the mvp for the home page: 
        component - the screen itself
        model - the data migration and the functions class for the screen
        view - the connection between the model and component, an abstract class implemented in the component to make it
                possible for the model to execute context command on the component screen.
    Created the actions functions in the view and implemented them in the component.
    Build function that recognize the right action to use when pressing the button and calling the  view."action"
        to execute it in the component.

folders:
    screens- contains the home page folder the has the 3 classes of the home screen.
    models - contains the models of custom used objects in the app.
    utils - several utils that need to be access form the app(like the notificationServices that used to execute local notifications command)
            
    
    