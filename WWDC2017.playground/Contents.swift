
// Requires Xcode 8
import SpriteKit
import XCPlayground
import PlaygroundSupport

//set inital color array
//make sure each olor is only used once
let scene = UISetup.start()
//var colors = [Palette.Color.Purple, Palette.Color.Yellow, Palette.Color.Pink, Palette.Color.Blue, Palette.Color.Greez, Palette.Color.Purple]
var colors = [4,1,0,3,2]

//create the selectionsort palette
//var SSPalette = Palette(colors: colors, algorithm: Palette.Algorithm.SelectionSort)
var SSPalette = Palette(colors: colors, scene: scene, sort: 0)

//SS
if(SSPalette.colors.count > 1){
   for element in 0 ..< SSPalette.colors.count - 1 {
        SSPalette.setMin(min: element)
        for search in element + 1 ..< SSPalette.colors.count {
            if(SSPalette.compare(i1: search, i2: SSPalette.min()) == -1){
                SSPalette.changeMin(min: search)
            }
       }
        if element != SSPalette.min() {
            SSPalette.swap(e1: element, e2: SSPalette.min())
       }
   }
}

SSPalette.actions[0].append(SKAction.run { UISetup.initColorRow(row: 5, scene: scene, iColors: SSPalette.colors, sort: 0)})
//UISetup.animate(sort: 0, scene: scene, pal: palette)
UISetup.play(scene: scene, pal: SSPalette, sort: 0)



//IS
//func insertionSort(){
    //if( palette.colors().count > 1 ) {
      //  for i in 1..<palette.colors().count {
            //palette.setMin(min: i)
            //while palette.min() > 0 && palette.compare(i1: palette.min(), i2: palette.min()-1) < 0{
               // palette.swap(e1: palette.min(), e2:  palette.min()-1)
               // palette.changeMin(min: palette.min()-1)
           // }
       // }
    //}
//}

//insertionSort()
//palette.actions[0].append(SKAction.run { UISetup.initColorRow(row: 5, iColors: palette.colors(), sort: 0)})
//UISetup.animate(sort: 1, scene: scene, pal: palette)
//UISetup.reset(sort: 1, scene: scene, pal: palette)
//palette.reset(colors: colors, sort: 2)

//MS
func mergeSort(_ array: [Int], right: Bool) -> [Int] {
    guard array.count > 1 else { return array }    // 1
    
    let middle = array.count / 2
               // 2
    
    let leftArray = mergeSort(Array(array[0..<middle]), right: false)
    
    let rightArray = mergeSort(Array(array[middle..<array.count]), right: true)  // 4
    
    return merge(leftPile: leftArray, rightPile: rightArray, right: right)             // 5
}

func merge(leftPile: [Int], rightPile: [Int], right: Bool) -> [Int] {
    //palette.order.removeAll()
   
    var leftIndex = 0
    var rightIndex = 0
   
    
    if(right){
          //palette.middle = colors.count-(rightPile.count) - 1
    }
    else{
       // palette.middle = 0
    }
    //let start = palette.middle
    //let end = palette.middle + leftPile.count + rightPile.count - 1
 
   // palette.group(start: start, end: end + rightPile.count - 1)
    var orderedPile = [Int]()
    
  
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            //palette.order.append(leftPile[leftIndex])
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
          //  palette.order.append(rightPile[rightIndex])
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            //palette.order.append(leftPile[leftIndex])
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
           // palette.order.append(rightPile[rightIndex])
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
            
        }
    }
    
   
    while leftIndex < leftPile.count {
       // palette.order.append(leftPile[leftIndex])
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
       // palette.order.append(rightPile[rightIndex])
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    //palette.order = orderedPile
    
    return orderedPile
}

//print("init colors", colors)
//print("end colors", mergeSort(colors, right: false))
//UISetup.animate(sort: 2, scene: scene, pal: palette)
//UISetup.play(scene: scene, pal: palette)





      

