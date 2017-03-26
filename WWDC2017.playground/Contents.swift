
// Requires Xcode 8
import SpriteKit
import XCPlayground
import PlaygroundSupport

//Setup View
let scene = UISetup.start()
var colors = [4,1,0,3,2] //change numbers to colors
var palette = Palette(colors: colors, scene: scene, sort: 0)


//SS
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
UISetup.setRow(scene: scene, colors: palette.colors(), row: 5, pal:palette, sort: 0)
UISetup.animate(sort: 0, scene: scene, pal: palette)
UISetup.reset(sort:0,  scene: scene, pal: palette)
palette.reset(colors: colors, sort: 1)


//IS

if( palette.colors().count > 1 ) {
    for i in 1..<palette.colors().count {
        palette.setMin(min: i)
        while palette.min() > 0 && palette.compare(i1: palette.min(), i2: palette.min()-1) < 0{
            palette.swap(e1: palette.min(), e2:  palette.min()-1)
            palette.changeMin(min: palette.min()-1)
        }
    }
}
UISetup.setRow(scene: scene, colors: palette.colors(), row: 5, pal:palette, sort: 1)
UISetup.reset(sort: 1, scene: scene, pal: palette)
palette.reset(colors: colors, sort: 2)

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
print("end colors", mergeSort(colors, right: false))
UISetup.play(scene: scene, pal: palette)





      

