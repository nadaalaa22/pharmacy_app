import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user/presentation/bloc/user_data_bloc/user_data_bloc.dart';
import '../bloc/medicine/medicine_bloc.dart';
import '../widgets/product_grid_tile.dart';

class KitsPage extends StatefulWidget {
  const KitsPage({Key? key}) : super(key: key);

  @override
  State<KitsPage> createState() => _KitsPageState();
}

class _KitsPageState extends State<KitsPage> {
  late String userId = '';
 // Initialize with an empty string
  @override
  void initState() {
    super.initState();
    _initializeData();
    context.read<MedicineBloc>().add(GetMedicines());
  }
  Future<void> _initializeData() async {
    context.read<UserDataBloc>().add(GetUserEvent());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
    }
    setState(() {});
    print(userId);
    print('nadaa'); // Trigger a rebuild after initialization.
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = 5;

    return Scaffold(
      backgroundColor: Color(0xfff2e9e2),
      appBar: AppBar(
        backgroundColor: Color(0xffe4d4c5),
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        title: Text(
          'M\'s Remedies',
          style: TextStyle(fontSize: 24, fontFamily: 'MyFont'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              // Handle search action
            },
          ),
          SizedBox(width: 15),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                onPressed: () {
                  // Handle shopping cart action
                },
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 8,
                child: Text(
                  cartItemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
        ],
      ),
      drawer: BlocBuilder<UserDataBloc, UserDataState>(
          builder: (context, state) {
            print(state);
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            print(state);
            if (state is UserLoadedState) {
              var listOfNames = state.usersModel.where((element) =>
              element.id == userId).toList();
              print(listOfNames);
              String name = listOfNames[0].name;
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xffe4d4c5),
                      ),
                      child: Center(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Handle the first button tap
                            Navigator.pop(
                                context); // Close the drawer if needed
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => FirstPage()),
                            // );
                          },
                          child: Text(
                            'Ongoing',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'MyFont',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            // Handle the second button tap
                            Navigator.pop(
                                context); // Close the drawer if needed
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SecondPage()),
                            // );
                          },
                          child: Text(
                            'History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'MyFont',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add more ListTile widgets for additional menu items
                  ],
                ),
              );
            }
            return SizedBox();
          }
      ),
      body: BlocBuilder<MedicineBloc, MedicineState>(
        builder: (context, state) {
          if (state is MedicineLoading)
          {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MedicineLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
              ),

              itemBuilder: (BuildContext context, int index) =>
                  ProductGridTile(medicineData: state.medicines[index],),
              itemCount: state.medicines.length,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
