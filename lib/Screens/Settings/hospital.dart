import 'package:allobaby/API/Requests/HospitalAPI.dart';
import 'package:allobaby/Config/Color.dart';
import 'package:allobaby/Screens/Settings/ViewHospital.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHospital extends StatefulWidget {
  const MyHospital({Key? key}) : super(key: key);

  @override
  _MyHospitalState createState() => _MyHospitalState();
}

class _MyHospitalState extends State<MyHospital> {
  List<dynamic> _hospitals = [];
  bool _isLoading = true;
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchHospitals();
  }

  Future<void> _fetchHospitals() async {
    try {
      final hospitals = await Hospitalapi.getHospitalList();
      setState(() {
        _hospitals = hospitals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching hospitals: $e");
    }
  }

  Future<void> _searchHospitals(String query) async {
    if (query.isEmpty) {
      _fetchHospitals();
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final searchResults = await Hospitalapi.searchHospital(query);
      setState(() {
        _hospitals = searchResults;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      print("Error searching hospitals: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Hospital",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: darkGrey2,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Black800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.local_hospital, color: Black800),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search hospitals...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _searchHospitals(value);
              },
            ),
          ),
          Expanded(
            child: _isLoading || _isSearching
                ? Center(child: CircularProgressIndicator())
                : _hospitals.isEmpty
                    ? Center(child: Text("No hospitals found"))
                    : ListView.builder(
                        itemCount: _hospitals.length,
                        itemBuilder: (context, index) {
                          final hospital = _hospitals[index];
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: 2,
                            child: ListTile(
                              title: Text(
                                hospital['name'],
                                style: TextStyle(fontWeight: FontWeight.bold, color: PrimaryColor),
                              ),
                              subtitle: Text("District: ${hospital['district']}"),
                              trailing: Icon(Icons.arrow_forward_ios, color: PrimaryColor),
                              onTap: () => Get.to(() => Viewhospital(hospital: hospital)),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}