import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

class SimpleInfiniteList<T extends DataModel, TFilter extends DataFilter,
    TRepo extends BaseRepository<T, TFilter>> extends StatefulWidget {
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final TFilter Function() filterInitializer;

  final TRepo repository;

  const SimpleInfiniteList({
    super.key,
    required this.itemBuilder,
    required this.repository,
    required this.filterInitializer,
  });

  @override
  State<StatefulWidget> createState() {
    return _SimpleInfiniteListState<T, TFilter, TRepo>();
  }
}

class _SimpleInfiniteListState<T extends DataModel, TFilter extends DataFilter,
        TRepo extends BaseRepository<T, TFilter>>
    extends State<SimpleInfiniteList<T, TFilter, TRepo>> {
  static const _pageSize = 20;

  final PagingController<int, T> _pagingController =
      PagingController<int, T>(firstPageKey: 0);

  late TFilter filter;

  @override
  void initState() {
    super.initState();
    filter = widget.filterInitializer();
    _pagingController.addPageRequestListener((pageKey) {
      _handleFetchNewData(pageKey: pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  _handleFetchNewData({int pageKey = 0}) async {
    filter.skip = pageKey;
    try {
      Future.wait([
        widget.repository.list(filter),
        widget.repository.count(filter),
      ]).then((values) {
        if (mounted) {
          final List<T> list = values[0] as List<T>;
          final int count = values[1] as int;
          final isLastPage =
              list.length < _pageSize || list.length + (filter.skip!) == count;

          if (isLastPage) {
            _pagingController.appendLastPage(list);
          } else {
            final nextPageKey = pageKey + list.length;
            _pagingController.appendPage(list, nextPageKey);
          }
        }
      });
    } catch (error) {
      if (mounted) {
        _pagingController.error = error;
      }
    }
  }

  Future<void> _onRefresh() async {
    return _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: PagedListView<int, T>(
        padding: const EdgeInsets.symmetric(vertical: 8),
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
          itemBuilder: widget.itemBuilder,
        ),
      ),
    );
  }
}
