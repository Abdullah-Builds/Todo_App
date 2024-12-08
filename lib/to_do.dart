import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';
import 'display/display_tasks.dart';
import 'package:todo_app/theme/wave_clipper.dart';

class TodoUI extends StatefulWidget {
  const TodoUI({super.key});

  @override
  TodoUIState createState() => TodoUIState();
}

class TodoUIState extends State<TodoUI> {
  final TextEditingController toSearch = TextEditingController();
  final List<String> list = [];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    toSearch.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    toSearch.removeListener(_onSearchChanged);
    toSearch.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      filteredItems = list
          .where((item) =>
          item.toLowerCase().contains(toSearch.text.toLowerCase()))
          .toList();
    });
  }

  void _showAddTaskDialog() {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  setState(() {
                    list.add(taskController.text);
                    filteredItems = list;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomBackgroundTheme(
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.white,
                  child:  Stack(
                   children: [

                   Padding(
                     padding: const EdgeInsets.only(top : 8.0,left: 8.0,right: 4.0),
                     child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                       child: Image.asset('assets/Images/todo.png',),),),
                   ),

                   Align(
                    alignment: Alignment.topCenter,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 40.0,left : 15),
                       child: SizedBox(
                         width: MediaQuery.of(context).size.height*0.25,
                         height: MediaQuery.of(context).size.height*0.25,
                       child: SearchBar(toSearch: toSearch, suggestions: filteredItems),
                             ),
                     ),
                         ),
                       ],
                    )
                  ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.40,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: DisplayTasks(list),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 11.0, left: 11.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: _showAddTaskDialog,
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.toSearch,
    required this.suggestions,
  });

  final TextEditingController toSearch;
  final List<String> suggestions;

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocusedOrNotEmpty = false;

  @override
  void initState() {
    super.initState();
    widget.toSearch.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.toSearch.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isFocusedOrNotEmpty = widget.toSearch.text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _isFocusedOrNotEmpty =
          _focusNode.hasFocus || widget.toSearch.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 300,
          child: Center(
            child: TextField(
              focusNode: _focusNode,
              controller: widget.toSearch,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search_sharp, color: Colors.black87),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
        if (_isFocusedOrNotEmpty && widget.suggestions.isNotEmpty)
          SizedBox(
            height: 100,
            width: 300,
            child: ListView.builder(
              itemCount: widget.suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.suggestions[index]),
                  onTap: () {
                    widget.toSearch.text = widget.suggestions[index];
                    _focusNode.unfocus(); // Dismiss the keyboard
                    setState(() {
                      _isFocusedOrNotEmpty = false; // Hide suggestions after selection
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
