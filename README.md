##StoryboardTest  

###Summary
The purpose of this StoryboardTest is to find a solution for complete replacement of UINavigationController transition methods  

Some methods of achieving this are:

 1. manually adding viewcontroller views as subviews and animating them  

 2. manually adding viewcontroller views, animating and then replacing with uinavigationcontroller calls without animation  

 3. using pure uiview containment and animating them  

 4. using storyboard segue in combination with uinavigationcontroller and updating  uinavigationcontroller view state at the end of the segue  

 5. using storyboard segue in combination with uiview containment  

The solution arrived at is the 5th one, because it provides the most flexible control over the animation appearance, and leaves the uiview hierarchy in a consistent state. It is also easy to create new instances of view controllers to transition to, without having to modify the container code.  

--

http://twitter.com/dilliontan