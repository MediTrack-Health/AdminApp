import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../records/add_record_screen.dart';
import 'bloc/relation_bloc.dart';
import 'bloc/relation_event.dart';
import 'bloc/relation_state.dart';

class RelationDetailsScreen extends StatefulWidget {
  const RelationDetailsScreen({super.key});

  @override
  RelationDetailsScreenState createState() => RelationDetailsScreenState();
}

class RelationDetailsScreenState extends State<RelationDetailsScreen> {
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relation Details')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final mobileNumber = _mobileController.text;
              if (mobileNumber.isNotEmpty) {
                context.read<RelationBloc>().add(FetchRelationDetails(mobileNumber));
              }
            },
            child: Text('Get Relations'),
          ),
          Expanded(
            child: BlocBuilder<RelationBloc, RelationState>(
              builder: (context, state) {
                if (state is RelationLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RelationLoaded) {
                  return ListView.builder(
                    itemCount: state.relations.length,
                    itemBuilder: (context, index) {
                      final relation = state.relations[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(relation.profileImagePath),
                        ),
                        title: Text(relation.profileName),
                        subtitle: Text(relation.relation),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                             // builder: (context) => AddRecordScreen(),
                              builder: (context) => AddRecordScreen(relationDetail: relation),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is RelationError) {
                  return Center(child: Text(state.message));
                }
                return Center(child: Text('Enter a mobile number to fetch relations.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}