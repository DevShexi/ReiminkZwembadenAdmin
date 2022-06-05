import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/requests/new_requests.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/requests/rejected_clients.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 1.0,
              child: Container(
                color: AppColors.white,
                child: TabBar(
                  controller: _tabController!,
                  indicatorColor: AppColors.primary,
                  unselectedLabelColor: AppColors.black,
                  labelColor: AppColors.primary,
                  tabs: const <Tab>[
                    Tab(
                      text: Strings.requests,
                    ),
                    Tab(
                      text: Strings.rejectedClients,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TabBarView(
                  controller: _tabController!,
                  children: const <Widget>[
                    NewRequests(type: Strings.requestClientType),
                    RegectedClients(type: Strings.rejectedClientType),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
