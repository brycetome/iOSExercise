### Summary: Include screen shots or a video of your app highlighting its features

https://github.com/user-attachments/assets/06b8c82e-f569-4ec1-a3f1-7b630b5a4299

In this short video (GitHub limits to 10MB) is the Recipe Showcase app.

Highlighted features:
- Navigation links to recipe details
- Recipe details include the large image, cuisine type, and external links.
- Recipe list has a search to filter by the recipe name.
- There is a tool bar selection to choose between the different end points.
- Empty state and error message.
- Image caching to the phone's cache directory.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I chose to focus on code quality because getting something to work is just the first step, but creating readable, maintainable, and reusable code is vital for longevity and reducing bugs.
While code quality could be ignored for a small, one-time project like this, thinking in terms of code quality helps develop the app and enhance the user experience.

For example, by breaking out the `getImage()` function's `retrieveImage()` and `cacheImage()` functions, this can be reused while setting up tests.

I also used the MVVM pattern for the main content view. The view handled displaying and responding to the `ViewModel`.

Additionally, I leveraged Swift's powerful `enum` features to create the `RecipeEndpoint` selection. The `enum` defines each case's title string, image, and endpoint function to call.
I could have created different instances of a struct but that opens the possibility to create malformed `RecipeEndpoints` from other callers.
This way, the definition of each case is encapsulated to the `enum`.

Besides those highlighted examples, I focused on general clean coding such as error handling, keeping units of code separate from each other, and closely following Apple and community syntax standards.

Another focus of mine on making sure the image caching worked.
Initially, I was not sure how to tackle this problem.
Storing the image bytes in a Core Data model would work, but after doing some research I saw that this was bad practice and could cause performance hits from storing large files.
I saw that using the cache directory for the app would provide the performance I needed.
I designed the method to return the image despite any cache failures.

I wanted to make sure this worked, so in my tests, I isolated instances where the cache should be hit or not and compared the data to a static image I put in the project.
Admittedly, there is probably a better way to code this, image data was difficult to work with.
While running the tests, I was observing the simulator's cache directory. Despite clearing the cache before each test, I noticed images were popping up from previous tests.
I realized that the tests were running in parallel, so I adjusted it to run in serial since the cache persists beyond each test.

I also tried different methods of calling the `getImage()` function once to prevent subsequent calls when the UI refreshes.

My attempts included calling it when getting all the recipes from the endpoint, storing it on the class, and using a DTO (Data Transfer Object). These alternative methods, despite only calling it once, caused long delays. I stuck with loading it as a `.task` on the UI.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent 10 hours on this project. Which is a considerable amount of time relative to the suggested amount of time (explained in the next question).

I allocated my time by setting aside a full day to work on this, and then some additional time the next day to clean up some things and write this report.
I made sure to skip a "cool" idea if it was going to block making a complete app.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

My focus on writing clean code and following best practices added the additional time.
There were things I wanted to add that I ended up scraping because I did not find a solution, I was happy with (rather than submit a lot of features with poor code).

For example, I wanted to section off the list, grouping by each recipe's cuisine type, but this proved to be unwieldy to work with.
To my surprise Swift does have a good grouping feature for lists, or at least one that I came across.

### Weakest Part of the Project: What do you think is the weakest part of your project?

I think the weakest part of my app is the details view for each recipe.
I wasn't sure the best way to present this, so I kept it simple and spent time on other parts of the app.

I also think some of the technical pieces were a bit weak. I don't have senior experience with Swift and there are probably some better ways to load in the images (which I did attempt to find).

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I had a lot of fun with this project! I used to be an iOS developer and switched to C# .NET but always saw myself coming back to iOS/Swift.
There is something truly "magical" (as Apple would put it) about programming in Swift.
Alongside with the powerful Apple provided frameworks, I love the struct-focused paradigm (don't get me started on ‘enums’ 🤤) and ease of keeping single sources of truth.
