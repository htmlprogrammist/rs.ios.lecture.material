
//: ## Swift: Generics

//: [WWDC 2016: Getting started with Swift](https://developer.apple.com/videos/play/wwdc2016/404/)
//:
//: [Swift docs: Generics](https://docs.swift.org/swift-book/LanguageGuide/Generics.html)

//: ### Generic Function
//:
//: Измените функцию так, чтобы она возвращала наименьшее значение из массива `items`.

func lowest<T: Comparable>(_ items: [T]) -> T? { items.min() }

let items: [Int] = (0...10).compactMap { (-200...($0 * 100)).randomElement() }

print(items.sorted())

if let value = lowest(items) {
    print(value)
}

//: ### Generic Type
//:
//: Определите реализацию типа `OrderedQueue`, используя знания о Generic, таким образом, чтобы:
//: 1. Элементы хранились в контейнере типа `Set`
//: 2. Метод `dequeue` извлекал минимальный элемент

struct OrderedQueue<T: Hashable & Comparable> {
    var items: Set<T> = []
    mutating func dequeue() -> T? {
//        var tmp: [T] = items.sorted(by: {$0 < $1})
//        return tmp[0]
        items.min()
    }
}

var orderedQueue = OrderedQueue<Int>(items: [5, 1, 2, 3, 4])
orderedQueue.items
orderedQueue.dequeue()
orderedQueue.items

//: ### `associatedtype`
//:
//: Произведите рефакторинг кода, применяя знания об `associatedtype`, для классов, описанных ниже.
//:
protocol Types {
    associatedtype ItemType
    var id: ItemType { get set }
}

class Passenger: Types {
    typealias ItemType = String
    var id: String = ""
}

class Container: Types {
    // а тут не пишу тайпэлиас, всё равно всё норм
    var id: String = ""
}

class Van: Types {
    var id: String = ""
}

class Airbus {
    var items: [Passenger] = []
}

class Train {
    var items: [Van] = []
}

class Seaship {
    var items: [Container] = []
}

/* orig
class Passenger {
    var id: String = ""
}

class Container {
    var id: String = ""
}

class Van {
    var id: String = ""
}

class Airbus {
    var items: [Passenger] = []
}

class Train {
    var items: [Van] = []
}

class Seaship {
    var items: [Container] = []
}
*/
//: ### `where`
//:
//: Для типа `OrderedQueue`, описанного выше, добавьте расширения с условиями:
//:
//: 1. Если тип `T` представлен числовым типом, в интерфейсе доступно свойство `count`, возвращающее количество элементов
//: 2. Если тип `T` представлен строковым типом, в интерфейсе доступен метод `prefix`, возвращающий наибольший общий префикс у всех элементов

extension OrderedQueue {
    where T == Int {
    var count: Int = 0
    }
}

extension OrderedQueue {
    
}
