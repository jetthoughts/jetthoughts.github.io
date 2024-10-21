---
dev_to_id: 1853475
title: "React Native Testing Options Overview"
description: "After investigating 100 articles about testing React Native applications I detected 2 main methods of..."
created_at: "2024-05-15T06:05:38Z"
edited_at: "2024-10-21T17:08:06Z"
draft: false
tags: ["testing", "react", "jest", "detox"]
canonical_url: "https://jetthoughts.com/blog/react-native-testing-options-overview/"
cover_image: "https://media.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fraw.githubusercontent.com%2Fjetthoughts%2Fjetthoughts.github.io%2Fmaster%2Fstatic%2Fassets%2Fimg%2Fblog%2Freact-native-testing-options-overview%2Ffile_0.jpeg"
slug: "react-native-testing-options-overview"
metatags:
  image: cover.jpeg
---
After investigating 100 articles about testing React Native applications I detected 2 main methods of testing which helped me succeed and can definitely help you.

![Photo by [Austin Neill](https://unsplash.com/@arstyy?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com?utm_source=medium&utm_medium=referral)](file_0.jpeg)

## Unit testing

A lot of people use [Jest](https://jestjs.io/docs/en/tutorial-react-native) with [Enzyme](https://airbnb.io/enzyme/docs/guides/react-native.html) to make unit testing more confident and more easygoing. You can do snapshot testing, test components, and assert functional staff.

There is another option called [React Native Testing Library](https://github.com/callstack/react-native-testing-library) is a lightweight React Native testing utilities helping you write better tests with less effort.

## Jest overview

More than 500 companies use Jest in their tech stacks, including Airbnb**, **Facebook**, **and Instagram.

### Reasons why companies use Jest:

* Open-source

* Mock by default makes testing much simpler

* Out of the box code coverage

### Common Approach

Built on top of the Jasmine test framework, using natural *expect(value).toBe(other)* assertions.

### Mock by Default

Automatically mocks CommonJS modules returned by *require()* as a result most existing code testable.

### Short Feedback Loop

DOM APIs are mocked. Tests run in parallel via a Node.js command-line utility.

### Russel Werner, Lead Engineer at StackShare:
>  Jest is fast and convenient and it has plenty of community support behind it. It lets us run our unit tests with Enzyme and snapshot tests.

## Enzyme overview

The Enzyme is a JavaScript Testing utility for React that makes it easier to assert, manipulate, and traverse your Components’ output. Enzyme’s API is meant to be intuitive by simulating jQuery’s API for DOM manipulation and traversal.

Companies like Airbnb**, **BlaBlaCar**, **and Redox Engine use Enzyme in their tech stacks.

```js
import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';

import MyComponent from './MyComponent';

describe('<MyComponent />', () => {
  it('renders an `.icon-star`', () => {
    const wrapper = shallow(<MyComponent />);
                            
    expect(wrapper.find('.icon-star')).to.have.lengthOf(1);
  });
});
```

## react-native-testing-library overview

It is a lightweight solution for testing your React Native components which provides small utility functions on top of *react-test-renderer*. Thus, always up to date with the latest React features. It prevents you from testing implementation details.

```js
import { render } from 'react-native-testing-library';
import { QuestionsBoard } from '../QuestionsBoard';

test('should verify two questions', () => {
  const { queryAllByA11yRole } = render(<QuestionsBoard {...props} />);
  const allQuestions = queryAllByA11yRole('header');

  expect(allQuestions).toHaveLength(2);
});
```

## Integration testing

The most difficult part of automated testing on mobile is the tip of the testing pyramid — E2E. The core problem with E2E tests is flakiness — tests are usually not deterministic.

There are two well-supported solutions on the market for mobile apps testing. Gray box end-to-end testing and automation library called [Detox](https://github.com/wix/Detox), and open source, a cross-platform test automation tool for native, hybrid and mobile apps called [Appium](https://github.com/appium/appium).

## Detox overview

The high speed of native mobile development requires us to adopt continuous integration workflows. It means our reliance on manual QA has to drop significantly. Detox tests your mobile app while it’s running in a real device/simulator, interacting with it just like a real user.

Companies reportedly use Detox in their tech stacks, including Glorgo, Dropboy, and Jumpn.

### Core features:

* Automatically Synchronized. Stops flakiness at the core by monitoring asynchronous operations in your app

* Debuggable. Modern async-await API allows breakpoints in asynchronous tests to work as expected

* Independent Test Runner. Use Mocha, AVA, or any other JavaScript test runner you like

```js
describe('Login flow', () => {
  it('should login successfully', async () => {
    await device.reloadReactNative();
    await expect(element(by.id('email'))).toBeVisible();
      
    await element(by.id('email')).typeText('john@example.com');
    await element(by.id('password')).typeText('123456');
    await element(by.text('Login')).tap();
      
    await expect(element(by.text('Welcome'))).toBeVisible();
    await expect(element(by.id('email'))).toNotExist();
  });
});
```

## Appium overview

Appium is an open-source test automation framework. You can use it with native, hybrid, and mobile web apps. It drives iOS and Android apps using the WebDriver protocol. Appium is sponsored by [Sauce Labs](https://saucelabs.com/) and a community of open source developers.

![From the official site [http://appium.io/](http://appium.io/)](file_1.jpeg)

More than 50 companies constantly use Appium in their tech stacks, including N26, Intuit, and PedidosYa.

### Why developers like Appium:

* Open-source

* You don’t have to recompile your app or modify it in any way, due to the use of standard automation APIs on all platforms

* You can write tests with your favorite dev tools using any WebDriver-compatible language such as Java, Objective-C, JavaScript (Node), PHP, Python, Ruby, C#, Clojure, or Perl with the Selenium WebDriver API and language-specific client libraries

* You can use any testing framework

* Within the same script, you can switch seamlessly between native app automation and WebView automation, all using the WebDriver model that’s already the standard for web automation

### Kevin Roulleau, QA Engineer Freelance at happn:
>  *I chose WebdriverIO and Appium to implement E2E tests solution on a native mobile app. WebdriverIO goes well beyond just implementing the Selenium / Appium protocol and allows us to run tests in parallel out of the box. Appium has the big advantage of supporting iOS and Android platforms, so the test codebase and tools are exactly the same, which greatly reduces the learning curve and implementation time.*

## Summary

Testing mobile applications is a big problem in modern software development. I analyzed the most popular testing methods in 2020. As a result, I didn’t find a perfect solution that covers all needs.

Using Jest in pair with Enzyme will give you coverage of the individual components of the application. As a replacement for Enzyme, you can consider react-native-testing-library which has a smaller API, and enough for small projects hence takes up less memory and resources.

For integration tests, you can use already discovered solutions, as well as new ones that are more convenient to use but for which you need to do additional configuration. Detox is built from the ground up to support React Native projects as well as pure native ones. Appium supports app automation across a variety of platforms, like iOS, Android, Windows, and Mac.

**Ilya Novohatskyi **is a Software Engineer at [JetThoughts](https://www.jetthoughts.com/). Follow him on [LinkedIn](https://www.linkedin.com/in/ilya-novohatskyi-a61644114/) or [GitHub](https://github.com/sweatC).
>  If you enjoyed this story, we recommend reading our [latest tech stories](https://jtway.co/latest) and [trending tech stories](https://jtway.co/trending).
