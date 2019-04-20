
import UIKit

class GameViewController: UIViewController {

    let gameModel = GameModel()
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var eventLogLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var eventText: UILabel!
    
    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
    }
    
    
    @IBAction func moveNorth(_ sender: UIButton) {
        eventLogLabel.text = "Event Log: Moved North"
        gameModel.move(direction: GameDirection.north)
        setLocation()
        updateDirections()
    }
    
    @IBAction func moveEast(_ sender: UIButton) {
        eventLogLabel.text = "Event Log: Moved East"
        gameModel.move(direction: GameDirection.east)
        setLocation()
        updateDirections()
    }
    
    @IBAction func moveSouth(_ sender: UIButton) {
        eventLogLabel.text = "Event Log: Moved South"
        gameModel.move(direction: GameDirection.south)
        setLocation()
        updateDirections()
    }
    
    @IBAction func moveWest(_ sender: UIButton) {
        eventLogLabel.text = "Event Log: Moved West"
        gameModel.move(direction: GameDirection.west)
        setLocation()
        updateDirections()
    }
    
    
    @IBAction func resetToOrigin(_ sender: Any) {
        gameModel.restart()
        setLocation()
        eventLogLabel.text = "Event Log: Reset"
        updateDirections()
    }
    
    func updateCoordinates() {
        coordinates.text = "(x:\(gameModel.currentLocation.x), y:\(gameModel.currentLocation.y))"
    }
    
    func updateDirections() {
        var directions = [GameDirection.north,
                          GameDirection.east,
                          GameDirection.south,
                          GameDirection.west]
        
        let buttons = [northButton,
                       eastButton,
                       southButton,
                       westButton]
        for index in 0...3 {
            if gameModel.currentLocation.allowedDirections.contains(directions[index]){
                buttons[index]?.isEnabled = true
            }
            else{
                buttons[index]?.isEnabled = false
            }
        }
        
        
    }
    
    func setLocation() {
        let x = gameModel.currentLocation.x
        let y = gameModel.currentLocation.y
        
        updateCoordinates()
        
        if gameModel.currentLocation.event != nil {
            switch(x,y) {
            case (1,1): icon.image = #imageLiteral(resourceName: "gandalf")
                eventText.text = gameModel.currentLocation.event
            case (-1,-1): icon.image = #imageLiteral(resourceName: "TomAndJerry")
                eventText.text = gameModel.currentLocation.event
            case (-1,1):  icon.image = #imageLiteral(resourceName: "Hammond")
                eventText.text = gameModel.currentLocation.event
            case (x,-2):
                if x == 2 {
                    icon.image = #imageLiteral(resourceName: "cliffFence")
                    eventText.text = gameModel.currentLocation.event
                }
                else if x == -2 {
                    icon.image = #imageLiteral(resourceName: "cliffRadioactive")
                    eventText.text = gameModel.currentLocation.event
                }
                else {
                    icon.image = #imageLiteral(resourceName: "cliff")
                    eventText.text = gameModel.currentLocation.event
                }
            case (x,2):
                if x == 2 {
                    icon.image = #imageLiteral(resourceName: "landMineAndFence")
                    eventText.text = gameModel.currentLocation.event
                }
                else if x == -2 {
                    icon.image = #imageLiteral(resourceName: "landMineAndRadioactive")
                    eventText.text = gameModel.currentLocation.event
                }
                else {
                    icon.image = #imageLiteral(resourceName: "landMine")
                    eventText.text = gameModel.currentLocation.event
                }
            case (-2,y):
                if y == 2 {
                    icon.image = #imageLiteral(resourceName: "landMineAndRadioactive")
                    eventText.text = gameModel.currentLocation.event
                }
                else if y == -2 {
                    icon.image = #imageLiteral(resourceName: "cliffRadioactive")
                    eventText.text = gameModel.currentLocation.event
                }
                else {
                    icon.image = #imageLiteral(resourceName: "radioactive")
                    eventText.text = gameModel.currentLocation.event
                }
            case (2,y):
                if y == 2 {
                    icon.image = #imageLiteral(resourceName: "landMineAndFence")
                    eventText.text = gameModel.currentLocation.event
                }
                else if y == -2 {
                    icon.image = #imageLiteral(resourceName: "cliffFence")
                    eventText.text = gameModel.currentLocation.event
                }
                else {
                    icon.image = #imageLiteral(resourceName: "electricFence")
                    eventText.text = gameModel.currentLocation.event
                }
            default: break
            }
        }
        else {
            icon.image = nil
            eventText.text = ""
        }
    }
}

