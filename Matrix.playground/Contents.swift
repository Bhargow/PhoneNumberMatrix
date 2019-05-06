import UIKit

var str = "Phone number pad demo"

// Declare a 3*4 matrix to form a phone dial pad grid
var firstRow = ["1","2","3"]
var secondRow = ["4","5","6"]
var thirdRow = ["7","8","9"]
var fourthRow = ["","0",""]

var phoneMatrix = [firstRow,secondRow,thirdRow,fourthRow]

func getNumberCombitationsFor(_ startingNumber: Int ,_ length: Int) {
    var resultArray = ["\(startingNumber)"]
    if length > 1 {
        //Iterate till the given length
        for _ in 0...length - (resultArray.count + 1) {
            // Have a temporary result array so that the actuall array is not disturbed
            var tempResultsArray: [String] = []
            // Iterate with the previous results to append the neighbouring numbers
            for i in resultArray {
            // Get neighbour number array for the last character
                let neighbourNumberArray = getNeighboursForCurrentNumber(i.stringToNumber())
                // With the neighbour number append with the previous results
                for neighbourNumber in neighbourNumberArray {
                    let updatedString = i.appending("\(neighbourNumber)")
                    tempResultsArray.append(updatedString)
                }
            }
            //Update the result array with the temporary array
            resultArray = tempResultsArray
        }
    }
    print(resultArray)
}

func getNeighboursForCurrentNumber(_ startingNumber: Int) -> [String] {
    var rowNumber = 0
    var coloumnNumber = 0
    var currentArray:[String] = []
    for (i, phoneArray) in phoneMatrix.enumerated() {
        if phoneArray.contains("\(startingNumber)") {
            rowNumber = i
            coloumnNumber = phoneArray.index(of: "\(startingNumber)") ?? 0
            currentArray = phoneArray
            break
        }
    }
    
    let previousRow = rowNumber - 1
    let nextRow = rowNumber + 1
    let previousColoumn = coloumnNumber - 1
    let nextColoumn = coloumnNumber + 1
    
    var neighbours: [String] = []

//    get number top of the current number
    if previousRow >= 0 {
        let topNumber = phoneMatrix[previousRow][coloumnNumber]
        if topNumber.isValidNumberString() {
            neighbours.append(topNumber)
        }
    }
    
//    get number bottom of the current number
    if nextRow <= phoneMatrix.count - 1 {
        let bottomNumber = phoneMatrix[nextRow][coloumnNumber]
        if bottomNumber.isValidNumberString() {
            neighbours.append(bottomNumber)
        }
    }
    
//    get number left of the current number
    if previousColoumn >= 0 {
        let leftNumber = currentArray[previousColoumn]
        if leftNumber.isValidNumberString() {
            neighbours.append(leftNumber)
        }
    }
    
//    get number right of the current number
    if nextColoumn <= currentArray.count - 1 {
        let rightNumber = currentArray[nextColoumn]
        if rightNumber.isValidNumberString() {
            neighbours.append(rightNumber)
        }
    }
    return neighbours
}

extension String {
    
    //Check if string is a valid number
    func isValidNumberString() -> Bool {
        if let _ = Int(self) {
            return true
        }
        return false
    }
    
    //To convert last character of a resule number to Int to get the neighbouring numbers
    func stringToNumber() -> Int {
        if let number = Int(String(self.last!)) {
            return number
        }
        return 0
    }
}

getNumberCombitationsFor(1, 3)


