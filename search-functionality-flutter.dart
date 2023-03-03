// search functionality in firebase flutter


// 1. Import the necessary Firebase libraries and initialize Firebase in your Flutter application.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//2. Create a text field widget to capture user input for the search query.

TextField(
  decoration: InputDecoration(
    hintText: 'Search for data...',
  ),
  onChanged: (value) {
    // Implement search functionality here
  },
)

//3. Implement the search functionality in the onChanged callback of the text field. You can use the where method of the CollectionReference class to filter the documents based on a condition.
Stream<QuerySnapshot> searchQuery(String searchText) {
  return FirebaseFirestore.instance
    .collection('collection_name')
    .where('field_name', isGreaterThanOrEqualTo: searchText)
    .snapshots();
}

TextField(
  decoration: InputDecoration(
    hintText: 'Search for data...',
  ),
  onChanged: (value) {
    setState(() {
      searchStream = searchQuery(value);
    });
  },
),

//4. Finally, use a StreamBuilder widget to display the search results in real-time.
StreamBuilder<QuerySnapshot>(
  stream: searchStream,
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }
    final documents = snapshot.data!.docs;
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (context, index) {
        final document = documents[index];
        return ListTile(
          title: Text(document['title']),
          subtitle: Text(document['description']),
        );
      },
    );
  },
),
