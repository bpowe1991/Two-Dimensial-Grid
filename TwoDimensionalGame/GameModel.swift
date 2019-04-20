
enum GameDirection {
    case north, east, west, south
}

struct GameLocation {
    let x: Int
    let y: Int
    let allowedDirections: [GameDirection]
    var event: String?
}

struct GameRow {
    let locations: [GameLocation]
}

class GameModel {
    
    private var currentRowIndex = 2          // start at (x: 0, y: 0)
    private var currentLocationIndex = 2    // which translates to index 2 in our arrays
    
    private var gameGrid: [GameRow] = []
    
    init() {
        self.gameGrid = createGameGrid()
    }
    
    func restart() {
        currentRowIndex = 2
        currentLocationIndex = 2
    }
    
    func move(direction: GameDirection) {
        switch direction {
        case .north:    currentRowIndex += 1
        case .south:    currentRowIndex -= 1
        case .east:     currentLocationIndex += 1
        case .west:     currentLocationIndex -= 1
        }
    }
    
    var currentLocation: GameLocation {
        /*
         TODO: Implement this method. It should return the *correct* GameLocation struct
         in the gameGrid for the player's current location.
         */
        return self.gameGrid[currentRowIndex].locations[currentLocationIndex]
    }
    
    // MARK: Helper methods for creating the game grid
    
    private func eventForCoordinate(x: Int, y: Int) -> String? {
        /*
         TODO: Implement at least 2 special events for specific coordinates
         in this method.
         */
        var event:String? = nil
        switch(x,y){
        case (1,1): event = """
            In front of you is a wizard in grey robes fighting a towering demon of hellish flame.
            The wizard yells \"You shall not pass!\". It's best you not interfere.
            """
        case (-1,-1): event = """
            Ahead is a grey tomcat chasing a brown field mouse with a mallet.
            Diagetic music plays from an unknown source.
            """
        case (-1,1): event = """
            An elderly man in white, holding a amber tipped staff is working on a broken down jeep.
            Two kids sit in the back seat, looking bored. You hear him mutter \"Pff, Spare no expense\".
            """
        case (x,-2):
            if x == 2 {
                event = """
                A sharp cliff impedes your path to the south and an electrified fence blocks the way to the east.
                """
            }
            else if x == -2 {
                event = """
                A sharp cliff impedes your path to the south and a radioactive swamp blocks the way to the west.
                """
            }
            else {
                event = """
                A sharp cliff impedes your path to the south.
                """
            }
        case (x,2):
            if x == 2 {
                event = """
                A mine field ends your path to the north and an electrified fence blocks the way to the east.
                """
            }
            else if x == -2 {
                event = """
                A mine field ends your path to the north and a radioactive swamp blocks the way to the west.
                """
            }
            else {
                event = """
                A mine field ends your path to the north.
                """
            }
        case (-2,y):
            if y == 2 {
                event = """
                A mine field ends your path to the north and a radioactive swamp blocks the way to the west.
                """
            }
            else if y == -2 {
                event = """
                A sharp cliff impedes your path to the south and a radioactive swamp blocks the way to the west.
                """
            }
            else {
                event = """
                A radioactive swamp blocks the way to the west.
                """
            }
        case (2,y):
            if y == 2 {
                event = """
                A mine field ends your path to the north and an electrified fence blocks the way to the east.
                """
            }
            else if y == -2 {
                event = """
                A sharp cliff impedes your path to the south and an electrified fence blocks the way to the east.
                """
            }
            else {
                event = """
                An electrified fence blocks the way to the east.
                """
            }
        default: event = nil
        }
        
        return event
    }
    
    private func createGameGrid() -> [GameRow] {
        var gameGrid = [GameRow]()
        for yValue in -2...2 {
            var locations = [GameLocation]()
            for xValue in -2...2 {
                let directions = allowedDirectionsForCoordinate(x: xValue, y: yValue)
                let event = eventForCoordinate(x: xValue, y: yValue)
                let location = GameLocation(x: xValue, y: yValue, allowedDirections: directions, event: event)
                locations.append(location)
            }
            let gameRow = GameRow(locations: locations)
            gameGrid.append(gameRow)
        }
        return gameGrid
    }
    
    private func allowedDirectionsForCoordinate(x: Int, y: Int) -> [GameDirection] {
        var directions = [GameDirection]()
        
        switch y {
        case -2:    directions += [.north]
        case 2:     directions += [.south]
        default:    directions += [.north, .south]
        }
        
        switch x {
        case -2:    directions += [.east]
        case 2:     directions += [.west]
        default:    directions += [.east, .west]
        }
        
        return directions
    }
    
}

