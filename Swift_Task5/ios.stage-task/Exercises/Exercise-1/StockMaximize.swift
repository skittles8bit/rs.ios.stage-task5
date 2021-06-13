import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        if prices.count < 2 {
            return 0
        }
        
        var profit = 0
        guard var maxValueOfPrices = prices.max() else { return 0 }
        
        for (index, elem ) in prices.enumerated() {
            if index < prices.endIndex - 1 {
                guard let firstIndex = prices.firstIndex(of: maxValueOfPrices) else { return 0 }
            
                if ( elem < maxValueOfPrices && index < firstIndex) {
                    profit += maxValueOfPrices - elem
                }
            
                if (elem < maxValueOfPrices && index > firstIndex) {
                    
                    guard let temp = prices[(firstIndex + 1)...].max() else { return 0 }
                    maxValueOfPrices = temp
                    
                    if (elem < maxValueOfPrices) {
                        profit += maxValueOfPrices - elem
                    }
                }
            }
        }

        return profit
    }
}
