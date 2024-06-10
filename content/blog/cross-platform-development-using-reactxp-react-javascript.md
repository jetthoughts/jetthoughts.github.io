---
dev_to_id: 1853624
title: "Cross-platform development using ReactXP"
description: "Cross-platform development using ReactXP   Startups with limited resources trying to reduce..."
created_at: "2024-05-15T07:48:27Z"
edited_at: "2024-06-10T15:46:02Z"
draft: false
tags: ["react", "javascript", "startup", "typescript"]
canonical_url: "https://jetthoughts.com/blog/cross-platform-development-using-reactxp-react-javascript"
slug: "cross-platform-development-using-reactxp-react-javascript"
---

## Cross-platform development using ReactXP

Startups with limited resources trying to reduce cost on delivering their apps to both web and mobile platforms. For now, it’s common to use [React Native](https://facebook.github.io/react-native/) for mobile and [React.js](https://reactjs.org/) for the Web. Even though these are two different frameworks, there are some solutions which reduce maintenance and at least prevent duplication in the code.

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cross-platform-development-using-reactxp-react-javascript/file_0.png)

Using it, you will still need to build several infrastructures to deliver the app to different platforms, but at least you would not need to duplicate your code, which requires more time on development.

In this post, we want to build a cross-platform mobile and web app. Our technology stack of exploration consists of [ReactXP](https://microsoft.github.io/reactxp/) and [TypeScript](https://www.typescriptlang.org/). Source code should be universal for two platforms.

## About ReactXP

ReactXP is a new library by Microsoft for building cross-platform apps that run on iOS, Android, Windows, and can also be used for the web.

ReactXP allows building the cross-platform solutions using React and React Native, where the lifecycle methods remain the same throughout both platforms. The main difference between React Native and ReactXP is that ReactXP works out of the box with not only iOS and Android but also with the Web.

## Develop

Here we are going to go through the process of building an app from scratch. The process is divided into steps. Each step results in a fully functional app that you can run.

## Setup

 1. Install the tools
`npm i -g create-xp-app`

 2. Create your project
`create-xp-app new YourAppName`

 3. Move to the created app template
`cd YourAppName`

## How to run

### For Web:
```
npm run web-watch
```
This compiles the TypeScript code and recompiles it whenever any files are changed.

Open index.html in your browser to view the result.

### For React Native:
```
run npm run rn-watch
```
This compiles the TypeScript code and recompiles it whenever any files are changed.
```
run npm start
```
This starts the React Native Packager.

## Create the main screen

Let’s start with creating the main screen. Here, we will display a list of videos, by clicking on which will go to the next screen.

Add fake data file for the list of videos.

Here, we add the Home screen with [VideoThumbnail component](https://gist.github.com/andriyParashchuk/6468dbde43cb2cb989b22fe93c779e2b) that is an essential part of our Home screen.

Now our app should look similar to the image below. It shows the list of video from fake API.

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cross-platform-development-using-reactxp-react-javascript/file_1.jpeg)

## Create the Playback screen component

As a video player, we will use the extension calledRXVideo. More extensions and components could be found [here](https://microsoft.github.io/reactxp/docs/extensions/video.html). This version of the app allows to choose a video, watch and use standard controls for the player.

![](https://raw.githubusercontent.com/jetthoughts/jetthoughts.github.io/master/static/assets/img/blog/cross-platform-development-using-reactxp-react-javascript/file_2.jpeg)

## Finally, the last step needed for routes our screens

Connect Home screen, and Playback screen to ****App.tsx

We initialized the state with video value where we will store the chosen video which will be sent to the Playback screen.

## Conclusion

ReactXP is a powerful solution with a set of various useful components and best practices implemented into it. It will let you deal with both ReactJS (web) and React Native (iOS, Android) having a single codebase. ReactXP is a good choice for your first JavaScript app. You won’t have an informational glut, as you will only see the TypeScript code and no iOS/Android internals.

**Andriy Parashchuk **is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/andriy-parashchuk-3aa56468/) or [GitHub](https://github.com/andriyParashchuk).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
