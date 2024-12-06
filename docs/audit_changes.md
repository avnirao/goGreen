# Audit Changes

## Changes we made
For the suggestion, "semantic label for home animation can be more detailed," we updated the semantic label to describe it as the "Globe Animation of the Earth" to clarify what the animation looks like.

The main suggestion we received from our SUS testing was that while it was easy to figure out what each of the widgets on the Entry View Page did, when you first opened the page the number of interactable widgets (buttons, dropdown menus, text inputs) on the screen was confusing/overwhelming. To fix this, we added text labels above each of those widgets to better display its purpose.

## Changes we didn't make
We tried to accomodate the suggestion, "tapping the icons on the map is a bit difficult," but we think that this is an issue with flutter maps rather than our code. It seems to work fine sometimes and become unresponsive at other times.

## Changes we made following poster presentations
Automated Emission Calculations:
After receiving feedback during the poster presentations (especially from Ben), we introduced an automatic emissions calculation feature. Now, once a user enters their data, the total emission is instantly calculated, eliminating the need for a separate "Estimate Emission" button. This makes the process more seamless and user-friendly.
Dynamic Emission Color Coding & Info Button:
To help users better understand their emissions, we added a color-coded system that changes the emission total's color based on the user's daily emissions compared to the average American. This visual cue provides a quick and clear interpretation of their environmental impact. Additionally, we added an Info Button at the top right of the screen that explains the meaning behind the color changes, helping users understand whether their emissions are high or low in context.