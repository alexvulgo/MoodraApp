# Moodra: Meditate with Mudras
An app that uses ARKit’s human body-tracking feature
to guide users through dynamic meditation,
displaying mudras and postures for them to follow.

**BARKit Team:**

Alessandro Esposito Vulgo Gigante,

Luigi Fiorentino,

Matteo Perotta,

Alexia Merolla,

Francesca Pia De Rosa,

Matthew Andrea D'Alessio

<img src="https://github.com/alexvulgo/MoodraApp/assets/120048791/d0cfe46d-70b5-461a-b75c-6a7924af0a87" width=70% height=70%>

## Description: 
We used RealityKit to create fully immersive spaces, and Reality Composer Pro to customize them, then in order to understand if a mudra was performed correctly, we had to ensure a method that worked on any kind of human hand. We created an algorithm that is capable of detecting if a finger is “closed” or “extended”, using just the relative distances between its fingertips and knuckles.

The goal of Moodra is to teach different hand positions to allow users to do dynamic meditation sessions. The app has two sections: “Learn Mudra” and “Meditate”.

Tapping on “Learn mudra” the app lets you choose three positions among the ones available and practice them.

Using ARKit's hand tracking, Moodra recognizes when a user has done a mudra correctly, considering it successful only if held for at least five seconds.

Also the meditate section lets you choose three mudras and meditation time, organizing the environment for a perfect session.

The app lets the users decide whether to use the immersive space by tapping a button and choosing their preferred environment.

Users can choose any moment to stay in the immersive environment or return to their original space.

We've also added white noise selection to improve meditation quality. We plan to expand features by adding new spaces, sounds, and the option to create custom environments by unlocking various objects. We also aim to offer new animations and artwork for mudras.


## Features: 

• SwiftUI

• ARKit

• RealityKit

• Reality Composer Pro

## Screens: 

![moodra1](https://github.com/alexvulgo/MoodraApp/assets/120048791/df8236de-eb19-4ca3-b0ec-4e40ac9076fd)


![moodra2](https://github.com/alexvulgo/MoodraApp/assets/120048791/06360d98-8bc6-43a7-9af0-8ff9a26b3e33)



