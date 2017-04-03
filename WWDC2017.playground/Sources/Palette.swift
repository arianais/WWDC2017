//I see you in this file O.o. Please don't edit anything in this file(unless you want the program to crash and burn). This file pretty much just connects the sorting states to the UI. But, if you have any questions about what each reference to Palette object is in the sorting algorithms, you are in the right place.

import SpriteKit
import SceneKit
import XCPlayground
import PlaygroundSupport

open class Palette {
    //fix setters & getters to be private vars
    public var doodle: Doodle
    public var colors:[Int] = []
    public var sorted = false{
        didSet{
            if(sorted == true){
                UISetup.animate(sort: self.sort, scene: self.scene, pal: self, doodle: self.doodle)
                if(sort == 0){
                    UISetup.play(scene: scene, pal: self)
                }
            }
        }
    }
    public var sort: Int
    public var msArr:[Int] = []
    public var middle: Int = 0
    public var right:Bool = false{
        didSet{
            if(right == true){
                self.middle = doodle.colors.count-(rightPileCt) - 1
            }
            else{
                self.middle = 0
            }
        }
    }
    public var order:[Int]{
        didSet{
            if(order.count > 0){
                self.push(i: order.count - 1  + middle, e: order[order.count-1])
            }
            else if (order.count == self.colors.count){
                self.sorted = true
            }
        }
    }
    public var min: Int
    private var scene:SKScene
    private var actionSet:[SKAction] = []
    private var rowCount = 0
    private var rightPileCt = 0
    public init(colors: [Int], scene: SKScene, sort: Int, doodle: Doodle) {
        self.sort = sort
        self.colors = colors
        self.scene = scene
        actionSet = []
        self.doodle = doodle
        self.min = colors[0]
        order = []
        UISetup.setRow(scene: scene, colors: colors, row: 0, pal: self, sort: sort)
  
        if(sort != 0){
            UISetup.reset(sort: sort, scene: scene, pal: self)
    
        }
    }
    public func addAction(action: SKAction){
        actionSet.append(action)
        
    }
    public func getActions()->[SKAction]{
        return actionSet
        
    }
    public func setMiddle(c: Int){
        self.rightPileCt = c
        
    }
    public func compare(i1: Int, i2: Int)->Int{
        if(sort == 2){
            UISetup.select(scene: scene, row: rowCount+1, col1: i1, col2: i2, color1: colors[i1], color2: colors[i2], pal: self)
        }
        else{
            UISetup.select(scene: scene, row: rowCount, col1: i1, col2: i2, color1: colors[i1], color2: colors[i2], pal: self)
        }
        if (colors[i1] > colors[i2]){
            return 1
        }
        else if (colors[i1] < colors[i2]){
            return -1
        }
        else{
            return 0
        }
    }
    public func color(i:Int)->Int{
        return colors[i]
    }
    public func initMin(min: Int){
        rowCount += 1
        UISetup.setRow(scene: scene, colors: colors, row: rowCount, pal:self, sort: sort)
        self.min = min
    }
  
    public func sortedColors()->[Doodle.Paint]{
        self.sorted = true
        var sortedArr: [Doodle.Paint] = []
        for a in colors{
            switch a {
            case 0:
                sortedArr.append(Doodle.Paint.Pink)
            case 1:
                sortedArr.append(Doodle.Paint.Yellow)
            case 2:
                sortedArr.append(Doodle.Paint.Green)
            case 3:
                sortedArr.append(Doodle.Paint.Blue)
            case 4:
                sortedArr.append(Doodle.Paint.Purple)
            default:
                print("Not paint!")
            }
        }
        return sortedArr
    }
    public func sortedColors(arr: [Int])->[Doodle.Paint]{
        self.sorted = true
        var sortedArr: [Doodle.Paint] = []
        for a in arr{
            switch a {
            case 0:
                sortedArr.append(Doodle.Paint.Pink)
            case 1:
                sortedArr.append(Doodle.Paint.Yellow)
            case 2:
                sortedArr.append(Doodle.Paint.Green)
            case 3:
                sortedArr.append(Doodle.Paint.Blue)
            case 4:
                sortedArr.append(Doodle.Paint.Purple)
            default:
                print("Not paint!")
            }
        }
        return sortedArr
    }
    public func swap(e1: Int, e2: Int){
        UISetup.swap(scene: scene, row: rowCount, col1: e1, col2: e2, color1: colors[e1], color2: colors[e2],  pal: self)
        let temp = self.colors[e1]
        self.colors[e1] = self.colors[e2]
        self.colors[e2] = temp
        if (rowCount == 4) {
            let palette = scene.childNode(withName: "palette")
            let initPalette = SKAction.run { UISetup.initColorRow(palette: palette!, row: 5, scene: self.scene, iColors: self.colors, sort: self.sort) }
            self.addAction(action: initPalette)
        }
    }
    public func endCheck(){
  
        if(colors == [0, 1, 2, 3, 4]){
            UISetup.setRow(scene: scene, colors: colors, row: 5, pal: self, sort: sort)
            UISetup.animate(sort: sort, scene: scene, pal: self, doodle: doodle)
        }
    }
    public func initOrderedPile(start: Int, end: Int){
        let remainder = colors[order.count...colors.count-1]
        colors = order + remainder
        rowCount += 1
        UISetup.select50(scene: scene, row: rowCount, start: start, end: end, data: colors, pal: self)
    }
    public func push (i: Int, e: Int){
        UISetup.select(scene: scene, row: rowCount+1, col: i, color: e, pal: self)
    }
    public func reset(colors: [Int], sort: Int){
        self.sort = sort
        rowCount = 0
        self.colors = colors
        UISetup.setRow(scene: scene, colors: colors, row: 1, pal:self, sort: sort)
    }
}
