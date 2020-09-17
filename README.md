# Traffic-Light-Controller-on-FPGA-

This is the design for a Traffic Light Controller Using Real Digital Blackboard. 
It is a simple traffic light controller for Santa Clara Street and 7th Street.
Specifications:
1. Santa Clara St will have the priority. When there is no other request, the traffic light will be green until there is another event on the cross street (7th St.)  
On the cross street: Any event below will trigger a traffic light change.
2a. When there is a car waiting at the intersection, represented by a push-button switch, the light on the cross street will turn green within 1 minute, stay green for 2 minutes, and turn yellow for 30 seconds, then turn red. It will remain with red color until the next event happens. 
2b. When there is a pedestrian push-button request, the light on the cross street will turn green within 1 minute, stay green for 4 minutes, and turn yellow for 30 seconds, then turn red. It will remain with red color until the next event happens. 
2c. When there is an emergency vehicle sending a beacon signal to the controller, represented by another push-button switch, the light on the cross street will turn green within 1 second, stay green for 2 minutes, and turn yellow for 30 seconds, then turn red. It will remain with red color until the next event happens.
