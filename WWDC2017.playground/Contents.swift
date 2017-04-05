// Requires Xcode 8
import SpriteKit
import XCPlayground
import PlaygroundSupport

let scene = UISetup.start()
/*:
 # Hi there! Ready to doodle?
 
In this playground, we will and explore and experiment with the sorting algorithms found on the AP Computer Science A exam(selection sort, insertion sort, and merge sort). To show this, we will be sorting some paint for a few doodles. As the computer sorts the paint, the paints' colors will appear in the doodle depending on each paint's distance to its final sorted position. **Make sure to watch out for each doodle's fun suprise at the end.**
_ _ _
 
 
 
 ## First, lets grab the paint.
 
 This is the inital position our paint will be before we sort their colors.
 
 *Feel free to change around the colors' order if you'd like as long as you* ***use one bottle of each paint(Pink, Yellow, Green, Blue, & Purple).***
*/
let doodle = Doodle(colors: [Doodle.Paint.Purple, Doodle.Paint.Yellow, Doodle.Paint.Pink, Doodle.Paint.Blue, Doodle.Paint.Green], scene: scene)

/*:
 ## We've got some sorting business to do.
Now, lets write our sorting algorithms for selection sort, insertion sort, and merge sort.

 ### Selection Sort
***a short summary***
 
 It works by finding the smallest element in the array and putting it at the beginning of the list and then repeating that process on the unsorted remainder of the data.
 
*-via Sparknotes (http://www.sparknotes.com/cs/sorting/select/summary.html)*
 */
func selectionSort(palette: Palette)->[Doodle.Paint]{
/*:
 1. If the array is empty or only contains a single element, then there's not much point to sorting it.
*/
if(palette.colors.count > 1){
/*:
 2. There are two loops inside this function. The outer loop looks at each of the elements in the array in turn; this is what narrows the range of elements being checked.
*/
    for element in 0 ..< palette.colors.count - 1 {
/*:
 3. Sets the minimum as the first element in the range. 
*/
        palette.initMin(min: element)
/*:
 4. This is the inner loop. It finds the lowest number in the rest of the array.
*/
        for search in element + 1 ..< palette.colors.count {
            if(palette.compare(i1: search, i2: palette.min) == -1){
                palette.min = search
            }
        }
/*:
 5. Swap the lowest number with the current array index.*/
        if element != palette.min {
            palette.swap(e1: element, e2: palette.min)
        }
    }
}
/*:
 6. Returns the sorted array.
 */
   return palette.sortedColors()
}
/*:
*-algorithm instructions via ***Swift Algorithm Club***(https://github.com/raywenderlich/swift-algorithm-club/tree/master/Selection%20Sort)*
 */

/*:
 ### Insertion Sort
 ***a short summary***

It sorts a data set by identifying an element that is out of order relative to the elements around it, removing it from the list, shifting elements up one place and then placing the removed element in its correct location.
 
*-via Sparknotes (http://www.sparknotes.com/cs/sorting/insert/summary.html)*
 */
func insertionSort(palette: Palette)->[Doodle.Paint]{
/*:
 1. If the array is empty or only contains a single element, then there's not much point to sorting it.
*/
    if( palette.colors.count > 1 ) {
/*:
 2. There are two loops inside this function. The outer loop looks at each of the elements in the array in turn; this is what picks the top-most number from the pile. The variable x is the index of where the sorted portion ends and the pile begins (the position of the | bar). Remember, at any given moment the beginning of the array -- from index 0 up to x -- is always sorted. The rest, from index x until the last element, is the unsorted pile.
*/
        for i in 1..<palette.colors.count {
/*:
 3. Sets the minimum as the element being inserted.
*/
            palette.initMin(min: i)
/*:
 4. The inner loop looks at the element at position x. This is the number at the top of the pile, and it may be smaller than any of the previous elements. The inner loop steps backwards through the sorted array; every time it finds a previous number that is larger, it swaps them. When the inner loop completes, the beginning of the array is sorted again, and the sorted portion has grown by one element.
*/
            while palette.min > 0 && palette.compare(i1: palette.min, i2: palette.min-1) < 0{
                palette.swap(e1: palette.min, e2:  palette.min-1)
                palette.min =  palette.min-1
            }
        }
    }
/*:
 5. Returns the sorted array.
*/
    return palette.sortedColors()
}
/*:
 **Note:** The outer loop starts at index 1, not 0. Moving the very first element from the pile to the sorted portion doesn't actually change anything, so we might as well skip it.
 */
/*:
 *-algorithm instructions via ***Swift Algorithm Club***(https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort)*
 */

/*:
 ### Merge Sort
 ***a short summary***
 
Merge Sort breaks the data into small data sets, sorts those small sets, and then merges the resulting sorted lists together.
 
 *-via Sparknotes (http://www.sparknotes.com/cs/sorting/merge/summary.html)*
 */

func mergeSort(_ array: [Int], right: Bool, palette: Palette) -> [Int] {
/*:
 1. If the array is empty or contains a single element, there is no way to split it into smaller pieces. You must just return the array.
*/
    guard array.count > 1 else {
        
        return array }
/*:
 2. Find the middle index.
*/
    let middle = array.count / 2
   
/*:
 3. Using the middle index from the previous step, recursively split the left side of the array.
*/
    let leftArray = mergeSort(Array(array[0..<middle]), right: false, palette: palette)
/*:
 4. Also, recursively split the right side of the array.
*/
    let rightArray = mergeSort(Array(array[middle..<array.count]), right: true, palette: palette)  // 4
/*:
 5. Finally, merge all the values together, making sure that it is always sorted.
*/
    return merge(leftPile: leftArray, rightPile: rightArray, right: right, palette: palette)             // 5
}

func merge(leftPile: [Int], rightPile: [Int], right: Bool, palette: Palette) -> [Int] {
/*:
 1. This is the merged array. It is empty right now, but you will build it up in subsequent steps by appending elements from the other arrays.
*/
    palette.order.removeAll()
    palette.setMiddle(c: rightPile.count)

    palette.initOrderedPile(start: palette.middle, end: palette.middle + leftPile.count + rightPile.count - 1 + rightPile.count - 1)
    
/*:
2. You need two indexes to keep track of your progress for the two arrays while merging.
*/
    var leftIndex = 0
    var rightIndex = 0
    //UI Boolean - no need to pay attention to 
    palette.right = right
/*:
 3. This while-loop will compare the elements from the left and right sides and append them into the orderedPile while making sure that the result stays in order.
*/
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            palette.order.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            palette.order.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            palette.order.append(leftPile[leftIndex])
            leftIndex += 1
            palette.order.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
/*:
 4. If control exits from the previous while-loop, it means that either the leftPile or the rightPile has its contents completely merged into the orderedPile. At this point, you no longer need to do comparisons. Just append the rest of the contents of the other array until there is no more to append.
*/
    while leftIndex < leftPile.count {
        palette.order.append(leftPile[leftIndex])
        leftIndex += 1
    }
    while rightIndex < rightPile.count {
        palette.order.append(rightPile[rightIndex])
        rightIndex += 1
    }
/*:
 5. Returns ordered array.
*/
    return palette.order
}
/*:
 *-algorithm instructions via ***Swift Algorithm Club***(https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort)*
 _ _ _
 
## Time for some action.
 1. Initalize one palette to test for each sort
*/
var SSPalette = doodle.createPalette(algorithm: Doodle.Algorithm.SelectionSort)
let ISPalette = doodle.createPalette(algorithm: Doodle.Algorithm.InsertionSort)
let MSPalette = doodle.createPalette(algorithm: Doodle.Algorithm.MergeSort)
/*:
 2. Test out the algorithms!
 */
let sortedSSArr = selectionSort(palette: SSPalette)
let sortedISArr = insertionSort(palette: ISPalette)
/*:
***The song for this algorithm is the actual sound of insertion sort.***
 */
let sortedMSArr = MSPalette.sortedColors(arr: mergeSort(MSPalette.colors, right: false, palette: MSPalette))











