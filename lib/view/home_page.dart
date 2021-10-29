import 'package:flutter/material.dart';
import 'package:pagination/app_constant/common_fun.dart';
import 'package:pagination/model/model_pagintion.dart';
import 'package:pagination/view/card_widget.dart';
import 'package:pagination/vm/vm_pagination.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PaginationData> _list = [];
  int pageNo = 1;
  final ScrollController _scrollController = ScrollController();
  int _totalCount = 0;

  Future<void> _callApi({
    bool isRefresh = false,
  }) async {
    if (isRefresh) pageNo = 1;
    if (isRefresh) setState(() {});
    await Provider.of<VMPagination>(context, listen: false).getPaginatedList(
      pageNo: pageNo,
      isRefresh: isRefresh,
    );
  }

  @override
  void initState() {
    _callApi();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (_list.length >= _totalCount) {
            return;
          }
          pageNo += 1;

          _callApi();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: RefreshIndicator(
        color: Colors.transparent,
        backgroundColor: Colors.transparent,
        onRefresh: () {
          return _callApi(isRefresh: true);
        },
        child: Consumer<VMPagination>(builder: (context, vmPagination, ch) {
          if (vmPagination.responseState == requestResponseState.DataReceived) {
            _list = vmPagination.paginatedList;
            _totalCount = vmPagination.paginatedData.total;
          }
          return vmPagination.responseState == requestResponseState.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : vmPagination.responseState == requestResponseState.Error
                  ? Center(
                      child: InkWell(
                        onTap: () {
                          _callApi(isRefresh: true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Server error!!!"),
                            Icon(Icons.refresh)
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: vmPagination.paginatedList.length,
                      itemBuilder: (ctx, i) {
                        return ChangeNotifierProvider.value(
                          value: vmPagination.paginatedList[i],
                          child: CardWidget(),
                        );
                      });
        }),
      ),
    );
  }
}
