# CSGOTV

## Description
Challenge app for Moises.io iOS Developer position
For this challenge you have to implement an app to display all CS:GO matches in a time period range using PandaScore API as backend api source.
[Figma design]() for reference

## Installation
### System Requirements
This implementation was made on a M1 Mac and tested on a Intel based mac, so ~~I guess~~ it is working fine in both platforms ~~it runs fine in both of my macs~~ 
I used XCode 13.4.1 running on MacOS Monterey 12.5

To be able properly open 'CSGOTV.xcworkspace', you have to first:
```
pod install
```

If something gets wrong just do a 'pod deintegrate' and then 'pod install' again.
~~Hope it works~~

## About Implementation
### CSTVGONetworking
This is the Networking API module, it was designed to be detached from the main CSTVGO app, and can be used as framework for any other app that needs these api calls/models. Nothing much to say about it, you can read the methods documentation in the code, It's not the most beautiful peace of code you ever saw in your life, but it's working.

### Architecture
Basically, I don't have much to say about the architecture, because one of the requirements was to do it using MVVM. 

#### Coordinators and Factory
So I decided to use Coordinators to do flow management, and factory pattern to instantiate the section classes. Basically one Coordinator is responsible for communicate with others coordinators and push the view using the viewController returned by the factory. The coordinator will not have access to viewModels, services and other stuffs, it can only see the factory. BUT, we still need to call other views/coordinators, so for that, the viewModel can have a instance of a coordinatorDelegate to delegate some external view/coordinator call to the section coordinator.

#### ViewControllers
Talking about ViewControllers, it does have a ViewModel reference to directly call methods and get data from. ViewModels doesn't have direct references to ViewControllers, so to pass any kind of information to ViewControllers I used state 'Publishers', were I listen to it in the ViewController.

#### ViewModel
The ViewModel is responsible to fetch the data from the service, sort and format to send it beautifully for the ViewController to display. Many people love "pure" ViewModels and like to manipulate the data in managers. I not a big fan of this approach ~~but I'm using a manager to format tournament data indeed~~ 

#### Service
Well, service is a service. It calls the CSGOTVNetworking session implementation to get the data from PandaScoreAPI. I wrote a little documentation in the code, if you have any question, feel free to contact me.

### External Dependencies
I'm only using Kingfisher to download images using the url directly into imageViews. Although I could use Alamofire for backend calls, and SnapKit for programmatically create constraints, In this project scope (not a huge app, not that hard to maintain) I decided to do all by hand.

## Problems Found
### PandaScore API
God, never heard about before. But I think it works fine to create IA models and manipulate the data. If you need LOADS of data, this is what you are looking for. But, to do a simple app to show matches, it is not that good. One of the problems that I found was that I would have to pay a big amount of money ~~IN EUROS~~ to get a specific match information. To workaround that, I saw that I was able to get the tournaments list with all the matches. Cool, problem solved, right? right? Not at all. Some tournaments have a TON of matches. Thats why I get only 5 tournaments and end up with 35-40 matches. The solution is get only one tournament per page, right? ~~Buzz sound~~ Wrong again. Even asking for sorted tournaments with begin_at attribute, some matches start in different days, which causes a big mess when doing pagination and updating the matches table view. Yep, the best solution I found was to get 5 tournaments, parse the data, display and scroll a lot to see the pagination. You will see that the data still gets messed up ~~not a bug, more like a feature~~. If this was a real world scenario, I would definitely have a conversation with the backend team!

### UITests Failing
Sometimes UITests fails. Not completely sure why, but it does. ~~looks like a feature, or a xcode bug, not really sure~~


Basically:
Coordinator -> Factory -> Coordinator
ViewController -> ViewModel -> Service
ViewController -> ViewModel -> Coordinator
