import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/qoute_model.dart';
import 'widgets/qoute_card.dart';

class Qoutes extends StatefulWidget {
  const Qoutes({Key? key}) : super(key: key);

  @override
  _QoutesState createState() => _QoutesState();
}

class _QoutesState extends State<Qoutes> {
  late ScrollController _scrollController;
  late Stream<List<QuoteModel>> quotesStream;
  List<QuoteModel> quotes = [];
  bool isRefreshing = false;
  bool isLoadingMore = false; // Added flag for loading more data
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize the stream
    quotesStream = FirebaseFirestore.instance
        .collection('quotes')
        .orderBy('createdAt', descending: true)
        .limit(7)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => QuoteModel.fromMap(doc.data()))
            .toList());

    // Listen to scroll events and fetch more data when needed
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent -
              _scrollController.position.pixels <=
          200.0) {
        fetchMoreQuotes();
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMoreQuotes() async {
    try {
      if (!isLoadingMore && hasMoreData) {
        setState(() {
          isLoadingMore = true;
        });

        // Fetch the next 7 quotes based on the last quote in the current list
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('quotes')
                .orderBy('createdAt', descending: true)
                .startAfter([quotes.last.createdAt])
                .limit(7)
                .get();

        // Map the query result to a list of QuoteModel instances
        List<QuoteModel> newQuotes = querySnapshot.docs
            .map((doc) => QuoteModel.fromMap(doc.data()))
            .toList();

        if (newQuotes.isEmpty) {
          // No more data available
          hasMoreData = false;
        } else {
          quotes.addAll(newQuotes);
        }

        setState(() {
          isLoadingMore = false;
        });
      }
    } catch (e) {
      print('Error fetching more quotes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder<List<QuoteModel>>(
        stream: quotesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No quotes available.'));
          } else {
            // Set the quotes list initially with the stream data
            quotes = snapshot.data!;
            return ListView.builder(
              controller: _scrollController,
              itemCount: quotes.length + (hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == quotes.length) {
                  // Show loading indicator at the bottom while fetching more data
                  return isLoadingMore
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(child: Text('No more posts.'));
                } else {
                  // Build a regular quote card
                  return quoteCard(quotes[index]);
                }
              },
            );
          }
        },
      ),
    );
  }
}
