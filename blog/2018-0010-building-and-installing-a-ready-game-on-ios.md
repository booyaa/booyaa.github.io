---
permalink: "/2018/building-and-installing-a-ready-game-on-ios"
title: "Building and installing a Ready game on iOS"
categories:
  - "videogames,ios,unity,ready,xcode"
published_date: "2018-09-15 13:37:00 +0000"
layout: post.liquid
is_draft: false
data:
  tags: "videogames,ios,unity,ready,xcode"
  route: blog
---

I’ve been playing around with [Ready](https://www.getready.io/) which is a lovely and easy to use tool that allows you to create video games. Ready is aimed at the class room to teach kids about the basics of programming in a fun way, if you’ve seen [Scratch](https://scratch.mit.edu/), you’ll know what I’m talking about.

Ready is made using [Unity](https://unity3d.com/) and also has the ability to export your creations and build them on Unity. Naturally once you can build them in Unity, why not go all the way and deploy them to an iOS device?

I should point out that you can play your own creation on an iOS device if you have the Ready app installed. So this is only if you’re interested in customising the behaviour of your Ready game, or perhaps you’ve wanted to know how to build your Unity game for iOS.

This blog post assumes you have Ready, Unity and Xcode installed on the same computer.

I’ll be using the personal/private use iPhone developer license (free), but the instructions are the same if you’ve got a paid iPhone developer license. I’ve used Xcode 9.4.1 (9F2000)

Unity has a free tier, so long as your new game doesn’t exceed 10,000 US dollars in profit you won’t need to buy a  license 😉! I’ve used Unity 2018.1.0f2. I’ve also installed [‎Unity Remote 5](https://itunes.apple.com/us/app/unity-remote-5/id871767552) on m iOS device to allow for testing before we export the game to Xcode.

## Make a game in Ready and export it

[Video of Ready Game](https://youtu.be/GoFUHUvkFnM)

As you can see I’ve gone for a really basic animated Sprite with drag behaviour. The game was created for landscape mode. This will be important to know later on.

In Ready, click the Gear icon (game settings), then click the  `Export to Unity3D` button.

- Create a new folder and select it as export target.

## Playable in Unity

1. Open Unity > click on `Open`  button (next to `My Account` link) and click into your newly exported Ready game folder, then click `Open` button. You want to open the project where you can see `Assets` and `ProjectSettings` folders.
2. In the [Project](https://docs.unity3d.com/Manual/ProjectView.html) window.
    1. Select the `Assets` folder.
    2. Double click on `ReadyPackage`  asset to decompress the data.
3. In the [Import Unity Package](https://docs.unity3d.com/Manual/AssetPackages.html#ImportingPackages) dialogue, click the `Import` button. This may take a while.
4. Back in the Project window.
    1. Select the `Scenes` folder.
    2. Double click on the  `PlayerScene` asset to load it.
5. In the Unity menu bar, click on  `Ready` > `Recreate Project`.
6. Click the `Play` icon to test the build.
7. Click the `Play` icon to stop playing.

## Playable in Unity Remote

1. In the Unity menu bar click on  `File`  >  `Build Settings…`.
2. Click on the  `Add Open Scenes` buttons.
3. Select `iOS` as your platform.
4. Click `Switch Platform`. This may take a while.
5. Close pop up window
6. Connect your iOS device to your Mac.
7. In the Unity menu bar click on  `Edit` > `Project Settings` > `Editor`
8. In the  `Unity Remote` section, select your connected `Device` from the drop down list
9. Start up the **Unity Remote 5** on your iOS device
10. Click the `Play` icon to test the build on your iOS device.
11. Click the `Play` icon to stop playing.

You will notice that the game looks skewed in portrait mode, if you tilt your iOS device into landscape mode you’ll see the game correct it’s scaling.

## Playable on iOS

1. In the Unity menubar click  `File`  >  `Build Settings…`.
2. Select the  `iOS`  platform.
3. Click the  `Player Settings`  button.
    1. Set your Company name.
    2. Set your icon (pick from assets).
    3. Set `Default Orientation` to either `Landscape Right` or `Landscape Left`.
4. Click the `Build` button.
5. Pick target folder and click `Save`. This will take a while
6. In `Finder` go to the target folder and open `Unity-iPhone.xcodeproj`, this will launch Xcode.
7. In `Project navigator` (left most icon [folder]) in picker, select `Unity-iPhone`

![Xcode Project Navigator](/img/ready-001-xcode-project-navigator.png)

8. In the `Identity` section, update the `Bundle Identifier` field. Important: this must be a unique.
9. In the `Signing` section
	1. check `Automatically manage signing`
	2. Select your `Team` from drop down list
10. Click on this icon to fix any warnings

![Xcode warnings icon](/img/ready-002-warnings.png)

11. Make sure your device is connect and has been selected from the drop down list

![Xcode device selector](/img/ready-003-device.png)

12. Unlock your iOS device and click `Play`  icon. This will take a while, you may also see warnings during compilation.

Marvel at your new iOS game! 

[Video Game Running on iOS](https://youtu.be/9STnboHARQA)

You may need to trust your personal certificate (they’re renewed every six days) if you see this pop up window whilst deploying the app to your iOS device.

In iOS 11 this setting can be found in `Settings` > `General` > `Profile & Device Management` . Select the `DEVELOPER APP` profile and trust the certificate.

![Xcode trust certificate on device dialogue](/img/ready-004-trust.png)

## References

- [Space Chicken - Extra Credit: Exporting the Game to Desktop](https://unity3d.com/learn/tutorials/projects/space-chicken/extra-credit-exporting-game-desktop?playlist=51293)
- [Unity - Building your Unity game to an iOS device for testing](https://unity3d.com/learn/tutorials/topics/mobile-touch/building-your-unity-game-ios-device-testing)