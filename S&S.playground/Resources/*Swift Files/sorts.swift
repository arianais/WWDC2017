class SelectionSort {
    func SelectionSort(arr: [Int])-> [Int]  {
            guard arr.count > 1 else { return arr }
        
            var a = array
            for x in 0 ..< a.count - 1 {
                var min = x
                for y in x + 1 ..< a.count {
                    if a[y] < a[min] {
                        min = y
                    }
                }
                if x != min {
                    print("Swap", x, min)
                    swap(&a[x], &a[min])
                }
            }
            print("new row", x)
            return a
        }
}
class InsertionSort {
    
}
class MergeSort {
    
}
class Sort {
    func swap(a:Int,  b:Int)  {
        
    }
}
