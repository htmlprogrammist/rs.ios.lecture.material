
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

extension OrderedQueue where T == Int {
    var k: Int { items.count }
}

extension OrderedQueue where T == String {
    func prefix() -> String {
        let k = self.items.map{ $0.count }.min() ?? 0
        for index in stride(from: k, to: 0, by: -1) {
            var tmp: Set<String> = []
            for element in self.items {
                tmp.insert(String(element.prefix(index)))
            }
            if tmp.count == 1 {
                return tmp.first!
            }
        }
        return ""
    }
}

var a = OrderedQueue(items: ["123", "123", "1234"])
a.prefix()
var b = OrderedQueue(items: [1, 2, 3, 4, 5])
b.k
