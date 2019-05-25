import Foundation
//sort(stk.item){ $0 > $1}
struct  ArrayList<T>{
    var item=[T]()
    mutating func add(item_:T){
        item.append(item_)
    }
    mutating func removeLast(){
        item.removeLast()
    }
    mutating func size()->Int{
        return  item.count
    }
    mutating func removeAll(){
        item.removeAll()
    }
    mutating func removeAtIndex(index:Int){
        if item.count>index{
            item.remove(at: index)
        }
    }
    mutating func get(index:Int)->T{
        
        return item[index]
    }
    mutating func insert(newElement: T, atIndex: Int){
        item.insert(newElement,at:atIndex)
    }    
}
extension ArrayList{
    func descption()->String{
        return "\(self.item)"
    }
}
