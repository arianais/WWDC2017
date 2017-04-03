//Probally not the best place to be rn. Check out the rad strucutre for the doodle class though while you are here though.
import SceneKit
import SpriteKit
import Foundation
public class Doodle{
    public enum Paint: Int {
        case Pink = 0
        case Yellow = 1
        case Green = 2
        case Blue = 3
        case Purple = 4
    }
    public enum Algorithm:Int {
        case SelectionSort = 0
        case InsertionSort = 1
        case MergeSort = 2
    }
    public var palettes:[Palette] = []
    public static let titleX = [269.697, 269.667, 269.636]
    public static let titles = ["selection sort", "insertion sort", "merge sort"]
    public static let titleY = [183.745, 117.811, 65.131]
    public var colors: [Int] = []
    private var scene: SKScene
    
    public init(colors:[Paint], scene: SKScene){
        self.scene = scene
        for  color in colors {
            self.colors.append(color.rawValue)
        }
    }
    public func createPalette(algorithm: Algorithm) -> Palette{
        palettes.append(Palette(colors: colors, scene: scene, sort: algorithm.rawValue, doodle: self))
        return palettes.last!
    }
}

