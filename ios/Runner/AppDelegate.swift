import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let flutterView : FlutterViewController = window?.rootViewController as! FlutterViewController
      let channel = FlutterMethodChannel(
        name: "todosChannel", binaryMessenger: flutterView.binaryMessenger)
    
      channel.setMethodCallHandler {
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        switch (call.method) {
        case "print": result("Hello, \(call.arguments as! String)")
        case "printNewTodo": result(printNewTodo(todo: call.arguments as! String))
        case "sortTodos": result(sortTodos(todos: call.arguments as! String))
        default: result(FlutterMethodNotImplemented)
        }
      }
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

struct Todo: Codable {
    var userId: Int;
    var id: Int;
    var title: String;
    var completed: Bool;
}

func printNewTodo(todo: String) -> String {
    do {
        let decoder = JSONDecoder();
        let encoder = JSONEncoder();
        
        var decodedTodo = try decoder.decode(Todo.self, from: todo.data(using: .utf8)!)
        decodedTodo.title = "New Todo"
        
        let encodedTodo = try encoder.encode(decodedTodo)
        let json = String(data: encodedTodo, encoding: String.Encoding.utf8)!
        
        return(json)
    } catch let err {
        print(err)
    }
    
    return(todo)
}

func sortTodos(todos: String) -> String {
    do {
        let decoder = JSONDecoder();
        let encoder = JSONEncoder();
        
        var decodedTodos = try decoder.decode([Todo].self, from: todos.data(using: .utf8)!)
        let completedTodos = decodedTodos.filter {todo in return todo.completed == true}
        let uncompletedTodos = decodedTodos.filter {todo in return todo.completed == false}
        
        decodedTodos = uncompletedTodos + completedTodos
        
        let encodedTodo = try encoder.encode(decodedTodos)
        let json = String(data: encodedTodo, encoding: String.Encoding.utf8)!
        
        return(json)
    } catch let err {
        print(err)
    }
    
    return(todos)
}
