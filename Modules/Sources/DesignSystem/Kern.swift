import UIKit

public enum Kern {
    public static func fromFigmaToiOS(figmaLetterSpacing: Double) -> Double {
        let kernInPixels = figmaLetterSpacing
        let kernInPoints = kernInPixels * UIScreen.main.scale
        return kernInPoints
    }
}
