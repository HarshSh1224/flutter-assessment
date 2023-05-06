import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  void Function() toggleTheme;
  HomeScreen(this.toggleTheme, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Map<String, String>> usersData = [];
List<Map<String, String>> filteredUsersData = [];

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isInit = false;
  Future<void> _fetchData() async {
    final response = await FirebaseFirestore.instance.collection('users').get();
    // print(response.docs[0].data()['name']);
    usersData = [];
    for (int i = 0; i < response.docs.length; i++) {
      // print(response.docs[i].data());
      usersData.add({
        'name': '${response.docs[i].data()['name']}',
        'email': '${response.docs[i].data()['email']}',
        'source': '${response.docs[i].data()['source']}'
      });
    }
    filteredUsersData = usersData;
    _isInit = true;
    // print(usersData);
  }

  void search() {
    // print('object')
    filteredUsersData = usersData.where((element) {
      return element['name']!.contains(_searchController.text) ||
          element['email']!.contains(_searchController.text);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.filter_list_outlined),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: PopupMenuButton(
                      child: Row(
                        children: const [
                          Text(
                            'Show users only from',
                            style: TextStyle(fontSize: 17),
                          ),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                      onSelected: (value) {
                        filteredUsersData = [];
                        if (value == 'All') {
                          filteredUsersData = usersData;
                          setState(() {});
                          Navigator.of(context).pop();
                          return;
                        }
                        filteredUsersData = usersData
                            .where((element) => element['source'] == value)
                            .toList();
                        debugPrint(filteredUsersData.toString());
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              value: 'Facebook',
                              child: Text(
                                "Facebook",
                                style: TextStyle(fontSize: 17),
                              )),
                          const PopupMenuItem(
                              value: 'Instagram',
                              child: Text(
                                "Instagram",
                                style: TextStyle(fontSize: 17),
                              )),
                          const PopupMenuItem(
                              value: 'Organic',
                              child: Text(
                                "Organic",
                                style: TextStyle(fontSize: 17),
                              )),
                          const PopupMenuItem(
                              value: 'Friend',
                              child: Text(
                                "Friend",
                                style: TextStyle(fontSize: 17),
                              )),
                          const PopupMenuItem(
                              value: 'Google',
                              child: Text(
                                "Google",
                                style: TextStyle(fontSize: 17),
                              )),
                          const PopupMenuItem(
                              value: 'All',
                              child: Text(
                                "Show All",
                                style: TextStyle(fontSize: 17),
                              )),
                        ];
                      },
                    ),
                  )
                ];
              }),
          IconButton(
              onPressed: widget.toggleTheme, icon: const Icon(Icons.dark_mode)),
        ],
      ),
      body: FutureBuilder(
          future: _isInit ? null : _fetchData(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Fetching Users Data'),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23.0, vertical: 20),
                          child: Text(
                            'List of Users',
                            style: GoogleFonts.raleway(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(50)),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _searchController,
                                  onFieldSubmitted: (value) {
                                    search();
                                  },
                                  textInputAction: TextInputAction.search,
                                  style: GoogleFonts.raleway(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Search by name or email...',
                                      hintStyle: GoogleFonts.raleway(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(10, 0),
                                child: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: search,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                      filteredUsersData[index]['name']![0]),
                                ),
                                // trailing: const Icon(Icons.delete),
                                trailing:
                                    Text(filteredUsersData[index]['source']!),
                                title: Text(filteredUsersData[index]['name']!),
                                subtitle: Text(
                                    // 'via ${filteredUsersData[index]['source']!}'),
                                    filteredUsersData[index]['email']!),
                              );
                            },
                            itemCount: filteredUsersData.length,
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
