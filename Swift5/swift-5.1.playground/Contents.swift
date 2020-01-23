import UIKit

// MARK: - Novidades do Swift 5.1

func feature(named name: String, completion: () -> Void) {
    print("********************")
    print("\(name):")
    completion()
    print("")
}

/* -------------------- */
/* -------------------- */
// MARK: - Synthesized initializers
/*
    - SE-0242 [https://is.gd/fS0WYf]
    - Atributos de estruturas que tem um valor padrão não precisam mais
      ser incluídos no seu inicializador. O valor padrão é assumido.
 */

feature(named: "Synthesized initializers") {
    struct User {
        var name: String
        var loginCount: Int = 0
    }

    let dan = User(name: "Danilo")
    print(dan)
}

/* -------------------- */
/* -------------------- */
// MARK: - Implicit return from single-expression functions
/*
    - SE-0255 [https://is.gd/PgnK38]
    - A palavra return pode ser removida de funções com retorno em uma única linha.
 */

feature(named: "Implicit return from single-expression functions") {
    let doubledOld = [1, 2, 3].map { return $0 * 2 }
    let doubledNew = [1, 2, 3].map { $0 * 2 }
    
    print(doubledOld)
    print(doubledNew)
}

/* -------------------- */
/* -------------------- */
// MARK: - Universal Self
/*
    - SE-0068 [https://is.gd/xQxTiT]
    - Dentro de um escopo de classe, Self tem o mesmo significado de `self.dynamicType`.
 */

class LoginManager {
    class var maximumLoginAttempts: Int {
        3
    }

    func printDebugData() {
//        print("Maximum loggin attempts: \(LoginManager.maximumLoginAttempts)")
        print("Maximum loggin attempts: \(Self.maximumLoginAttempts)")
    }
}

class DirectorLoginManager: LoginManager {
    override class var maximumLoginAttempts: Int {
        5
    }
}

feature(named: "Universal Self") {
    let manager = DirectorLoginManager()
    manager.printDebugData()
}

/* -------------------- */
/* -------------------- */
// MARK: - Static and class subscripts
/*
   - SE-0254 [https://is.gd/yOpvgY]
   - Adiciona a possibilidade de criar `subscripts` como estáticos.
*/

public struct Settings {
    private static var values = [String: String]()

    public static subscript(_ name: String) -> String? {
        get {
            values[name]
        }
        set {
            print("Adjusting \(name) to \(newValue ?? "nil")")
            values[name] = newValue
        }
    }
}

feature(named: "Static and class subscripts") {
    Settings["Captain"] = "Gary"
    Settings["Friend"] = "Mooncake"
    print(Settings["Captain"] ?? "Unknown")
}

/* -------------------- */
/* -------------------- */
// MARK: - Opaque return types
/*
   - SE-0244 [https://is.gd/FqA43y]
   - Introduz a o conceito de tipos opacos em Swift. Um tipo opaco é um objeto cujo sabemos
     suas capacidades sem saber especificamente qual tipo de objeto ele é. Embora não sabemos
     qual o tipo do objeto, o compilador sabe exatamente qual é.
*/

func makeInt() -> some Equatable {
    Int.random(in: 1...10)
}
func makeString() -> some Equatable {
    "String"
}

feature(named: "Opaque return types") {
    let int1 = makeInt()
    let int2 = makeInt()
    let string1 = makeString()
    let string2 = makeString()

    print(int1 == int2)
    print(string1 == string2)
    // print(int1 == string1) - Produces error
}

/* -------------------- */
/* -------------------- */
// MARK: - Matching optionals enums agaisnt non-optionals
/*
    - Agora podemos usar o padrão switch/case para validar enums opcionais com não opcionais.
 */

enum Status {
    case on, off
}

feature(named: "Matching optionals enums agaisnt non-optionals") {
    var status: Status?
    status = nil

    switch status {
        case .on:
            print("On")
        case .off:
            print("Off")
        case .none:
            print("None")
    }
}

/* -------------------- */
/* -------------------- */
// MARK: - Ordered collection diffing
/*
    - SE-0240 [https://is.gd/LzeJwv]
    - Uma forma de representar diferenças entre `collections`.
 */

feature(named: "Ordered collection diffing") {
    var scores1 = [100, 91, 95, 98, 100]
    let scores2 = [100, 98, 95, 91, 100]

    let diff = scores2.difference(from: scores1)

    for change in diff {
        print("change: \(change)")
    }

    let result = scores1.applying(diff)
    print(result ?? [])
}

/* -------------------- */
/* -------------------- */
// MARK: - Creating unitialized arrays
/*
   - SE-0245 [https://is.gd/vNiHsR]
   - Um novo inicializador de arrays que permite a criação de um array sem valores pré definidos.
*/

feature(named: "Creating unitialized arrays") {
    let randomNumbers = Array<Int>(unsafeUninitializedCapacity: 10) { (buffer, count) in
        for index in 0..<7 {
            buffer[index] = Int.random(in: 0...10)
        }
        count = 10
    }

    print(randomNumbers)
}
