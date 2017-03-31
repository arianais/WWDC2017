
// Requires Xcode 8
import SpriteKit
import XCPlayground
import PlaygroundSupport

//Setup View
let scene = UISetup.start()

//hide this
let doodle = Doodle(colors: [Doodle.Paint.Purple, Doodle.Paint.Yellow, Doodle.Paint.Pink, Doodle.Paint.Blue, Doodle.Paint.Green], scene: scene)
var colors = doodle.colors //change numbers to colors
var SSPalette = doodle.createPalette(algorithm: Doodle.Algorithm.SelectionSort)


//SS
func selectionSort(palette: Palette){
if(palette.colors().count > 1){
    for element in 0 ..< palette.colors().count - 1 {
        palette.setMin(min: element)
        for search in element + 1 ..< palette.colors().count {
            if(palette.compare(i1: search, i2: palette.min()) == -1){
                palette.changeMin(min: search)
            }
        }
        if element != palette.min() {
            palette.swap(e1: element, e2: palette.min())
        }
    }
}
    palette.sorted = true
}
selectionSort(palette: SSPalette)

let ISPalette = doodle.createPalette(algorithm: Doodle.Algorithm.InsertionSort)

func insertionSort(palette: Palette){
    if( palette.colors().count > 1 ) {
        for i in 1..<palette.colors().count {
            palette.setMin(min: i)
            while palette.min() > 0 && palette.compare(i1: palette.min(), i2: palette.min()-1) < 0{
                palette.swap(e1: palette.min(), e2:  palette.min()-1)
                palette.changeMin(min: palette.min()-1)
            }
        }
    }
    palette.sorted = true

}
insertionSort(palette: ISPalette)

//MS
func mergeSort(_ array: [Int], right: Bool, palette: Palette) -> [Int] {
    guard array.count > 1 else {
        return array }    // 1
    
    let middle = array.count / 2
    // 2
    
    let leftArray = mergeSort(Array(array[0..<middle]), right: false, palette: palette)
    
    let rightArray = mergeSort(Array(array[middle..<array.count]), right: true, palette: palette)  // 4
    
    return merge(leftPile: leftArray, rightPile: rightArray, right: right, palette: palette)             // 5
}

func merge(leftPile: [Int], rightPile: [Int], right: Bool, palette: Palette) -> [Int] {
    palette.order.removeAll()
    
    var leftIndex = 0
    var rightIndex = 0
    
    
    if(right){
        palette.middle = colors.count-(rightPile.count) - 1
    }
    else{
        palette.middle = 0
    }
    let start = palette.middle
    let end = palette.middle + leftPile.count + rightPile.count - 1
    
    palette.group(start: start, end: end + rightPile.count - 1)
    var orderedPile = [Int]()
    
    
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            palette.order.append(leftPile[leftIndex])
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            palette.order.append(rightPile[rightIndex])
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            palette.order.append(leftPile[leftIndex])
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            palette.order.append(rightPile[rightIndex])
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
            
        }
    }
    
    
    while leftIndex < leftPile.count {
        palette.order.append(leftPile[leftIndex])
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        palette.order.append(rightPile[rightIndex])
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    palette.order = orderedPile
    
    return orderedPile
}

print("init colors", colors)
let MSPalette = doodle.createPalette(algorithm: Doodle.Algorithm.MergeSort)
print(mergeSort(MSPalette.colors(), right: false, palette: MSPalette))
MSPalette.sorted = true








