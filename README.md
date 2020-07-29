# Energy Bar🍫

Energy Bar is very simple message bar that get to user's response.

## Installation
> pod 'EnergyBar'

## Usage
### Initialization
```
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let energyBar = EnergyBar(delegate: self)
        
        return true
    }
}

extension AppDelegate: EnergyBarDelegate {
    func buttonTap(eventID: String, tag: Int) {
        //handle your event
    }
}
```

### show EnergyBar
```
try? energyBar.show(eventID:messageLabel:buttons:size:)
```

### Bring top level window
```
energyBar.bringEnergyBarToFront()
```

## Better Usage
- Make `energyBar` singleton like `App.energyBar`
- `AppDelegate` class must have `EnergyBarDelegate`
- Make custom events use `enum` like...
    ```
    enum EnergyBarEvents: String {
        case doSomething = "doSomethingEvent"
    }
    ```
    and... pass enum's rawValue to `show` method like...
    ```
    eventID: EnergyBarEvents.doSomething.rawValue
    ```
    then `EnergyBarDelegate` returns eventID. and handle event like...
    ```
    if let event = EnergyBarEvents(rawValue: eventID) {
        switch event {
        case .doSomething:
            //handle event
        }
    }
    ```
