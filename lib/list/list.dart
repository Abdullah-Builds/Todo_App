class TodoList {
  List<String> todo;

  TodoList() : todo = [];

  void add(String task) {
    todo.add(task);
  }
  List<String> getTasks() {
    return todo;
  }
}
