import Foundation

extension Sequence {
    /// Group a sequence into grouped sequences of `size`.
    /// For example:
    /// Self: [a, b, c, d]
    /// Grouped by 2: [[a, b], [c, d]]
    /// - Parameter size: Size of group
    func chunks(of size: Int) -> [[Iterator.Element]] {
        return self.reduce(into: [[Iterator.Element]]()) { (result, element) in
            guard var lastGroup = result.last,
                  lastGroup.count < size else {
                let group = [element]
                result.append(group)
                return
            }
            
            lastGroup.append(element)
            result[result.count - 1] = lastGroup
        }
    }
}
