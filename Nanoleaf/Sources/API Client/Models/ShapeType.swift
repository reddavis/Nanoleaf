import Foundation

public enum ShapeType: Int {
    case triangle = 0
    case rhythm = 1
    case square = 2
    case controlSquareMaster = 3
    case controlSquarePassive = 4
    case shapesHexagon = 7
    case shapesTriangle = 8
    case shapesMiniTriangle = 9
    case shapesController = 12
    case elementsHexagons = 14
    case elementsHexagonsCorner = 15
    case linesConnector = 16
    case linesLight = 17
    case linesLightSingleZone = 18
    case controllerCap = 19
    case powerConnected = 20
}

extension ShapeType: Codable {}
