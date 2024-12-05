**Identify which of the course topics you applied (e.g. secure data persistence) and describe how you applied them.**  
- *Stateless & Stateful widgets:* We used stateless and stateful widgets throughout the app. Stateful widgets were used for the main pages of the app since they have a lot of components that are consistently being modified. Stateless widgets are used to make up the components of each of the pages such as text, icons, lists, etc.

- *Accessing sensors (GPS):* We get the user's current GPS location to display their position on a map and show them which second hand stores/recycling centers are close to them. We used the geolocator package for this.

- *Querying web services:* We used the Climatiq API to calculate the user's carbon emissions based on the activities they input. We also used geolocator and flutter maps to display the user's current position on a map. 

- *Data Persistence:* We used Isar to implement data persistence into our app. This allows the user's data to be saved when they close/exit the app. 


**Discuss how doing this project challenged and/or deepened your understanding of these topics.**  
We got hands-on experience with topics/tool we weren't totallt familirized with, such as generating g.dart files for Isar and 
designing and integrating data structures and flows for our app. Since we are having a lot of categories and subcategories for
estimating emissions, handeling dataflows was complex and required extra debug skills. Deploying the API for emission estimtion was also challenging since we provide very diversified and detailed options for users to track their emissions. Finally the UI design challenged our
depth in knowledge of flutter widgets, such as using dropdownmenus and editing their background colors. Overall, we overcomed all these
with patience and recourses from internet. It was fun!

**Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?**  
The primary change in our design was shifting from a user goal-based system to tracking the cumulative amount of CO₂ saved.

**Original Concept:**  
We initially planned for users to set specific goals related to their recycling activities (e.g., recycling X number of items or achieving a certain CO₂ savings target).

**Final Implementation:**  
The final design focuses exclusively on tracking and displaying the amount of CO₂ saved through recycling. Goals are no longer part of the user experience.

**Reason for the Change:**  
This adjustment simplifies the user experience by focusing on the most impactful metric: CO₂ savings. It also aligns better with our primary aim—raising awareness of environmental impact—without requiring users to set and manage goals, which could feel cumbersome or unnecessary.

**Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app**  
Currently, the "Click Here" button on some screens is not immediately intuitive for users to find, as it requires scrolling. To enhance accessibility:
- We plan to redesign the layout to ensure all critical actions are visible without scrolling, such as repositioning or resizing the button to make it prominent.

A major enhancement for usability involves integrating a feature where users can input items they need to dispose of, and the app will provide tailored disposal or recycling instructions. This would include:
- A search bar where users can type the name of an item (e.g., "batteries" or "electronics").
- Leveraging an AI-powered database to provide precise recycling instructions based on the item and the user's location. This feature would empower users with actionable information, making recycling more accessible and personalized to their needs.

**Citations**
For our Animation: 
https://app.lottiefiles.com/animation/147d75d9-d107-4c17-8385-94eb5f1c2cd3?channel=web&source=public-animation&panel=embed

TAs:
Dhruv Bansal

More: 
https://docs.flutter.dev/ui/widgets
https://flutterstuff.com/how-to-fix-widget-at-top-bottom-in-flutter/#:~:text=If%20you%20set%20%60bottom%60%20to,the%20bottom%20of%20the%20screen.&text=If%20you%20want%20to%20fix,in%20the%20%60Positioned%60%20widget.
https://docs.fleaflet.dev
https://docs.fleaflet.dev/layers/tile-layer/tile-providers
https://docs.mapbox.com
https://github.com/flutter/flutter/issues/133742
https://api.flutter.dev/flutter/material/DropdownMenu-class.html
https://isar.dev/schema.html
https://forums.developer.apple.com/forums/thread/758642

Climatiq API: 
- API docs: https://www.climatiq.io/docs/api-reference
- Data (Emission Factor IDs come from here): https://www.climatiq.io/data

API calls via flutter: 
- Fetch data: https://docs.flutter.dev/cookbook/networking/fetch-data
- Using API key: https://docs.flutter.dev/cookbook/networking/authenticated-requests
- Sending data: https://docs.flutter.dev/cookbook/networking/send-data
- Retrieve data (used Ben's code as a reference): https://gitlab.cs.washington.edu/rbs/seattle-busses

Entry & Activity History: Reworked code from Journal



**What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?**  
Avni: Working with Flutter was a game-changer for me. It’s an intuitive framework that made learning app development far more enjoyable compared to other frameworks like React. Its versatility for cross-platform development and amazing set of widgets made creating applications straightforward and efficient. Beyond the technical skills, I also learned about the importance of UI design, usability, and accessibility.

Another critical takeaway was learning how to problem-solve independently. Early on, I leaned heavily on office hours, but I grew to understand the value of going online to research and troubleshoot issues first. Developing this problem-solving mindset has been empowering and will serve me well in future technical challenges.

Mason: I learned a lot about how the structure of implementing an app. The model-view-controller structure was very helpful for figuring out both where different pieces of the app should go, and it also made it a lot easier to figure out where things were going wrong while I was debugging. Even if this structure looks a bit different in other programming languages and frameworks, I think the concept of it will help me with figuring out how to make the piece of my future projects fit together.

Michael: For me the most valueable thing I learned is basically how to develope a whole complete app with flutter. It's suprisingly powerful
compared to swift, offering immense flexibility for building cross-platform applications. However, it’s also complex and challenging to use because of its intricacy in managing widgets and states and dealing with dependencies. After got in touch with flutter for a quarter I'm now confident in designing my own app's data flow and debugging specifically.

**If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why?)**

**Advice to My Past Self**  
Avni: 
- Don’t hesitate to ask for help or input from peers, instructors, or TAs. Receiving feedback is crucial, whether it’s for improving your code, refining your designs, or brainstorming new ideas. Collaboration is one of the best ways to grow.
  
- Starting early allows you to experiment with new ideas and features, rather than rushing to meet deadlines. This extra time leads to more creative and polished applications.
  
- While researching solutions online is a critical skill, don’t be afraid to reach out when you're stuck. Finding the right balance between independent problem-solving and seeking help can save time and deepen your understanding.

Mason:
- Test your apps on your physical phone early, especially on Android. I ran into a lot of issues with Android and had to change gradle settings for almost every project which either required going to office hours or doing research to figure out how to solve those bugs. This is a lot more stressful when you put it off until the last day a project is due.

- Try to add extra features to your apps/do the extension problems when you can, because it will make the future assignments easier. However, also be aware that you only have a week for most of these assignments. I made my journal app way too complicated and was unable to even start working on Isar before the initial deadline because of that.

Michael:
- Also be patient with bugs even they are everywhere. You have them because you are using a very robust tool. You will be grateful if
you make it in the end!

- Never hesitate to ask questions. It will ***always help!

- Be like water while using different widgets, you will find out that you can always get the widget in the way you wanted.