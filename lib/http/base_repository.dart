part of 'http.dart';

abstract class BaseRepository<T extends DataModel, TFilter extends DataFilter>
    extends HttpRepository {
  @override
  bool get useInterceptors => true;

  @override
  InterceptorsWrapper get interceptorsWrapper => globalInterceptorsWrapper;

  Future<List<T>> list(TFilter filter) async {
    return _dio
        .post(url("list"), data: filter.toJSON())
        .then((response) => response.bodyAsList<T>());
  }

  Future<int> count(TFilter filter) async {
    return _dio
        .post(url("count"), data: filter.toJSON())
        .then((response) => (response.data as num).toInt());
  }

  Future<T> getById(num id) async {
    return _dio.post(url("get"), data: {
      'id': id,
    }).then((response) => response.body<T>());
  }

  Future<T> create(T entity) async {
    return _dio
        .post(url("create"), data: entity.toJSON())
        .then((response) => response.body<T>());
  }

  Future<T> update(T entity) async {
    return _dio
        .post(url("update"), data: entity.toJSON())
        .then((response) => response.body<T>());
  }

  Future<T> deleteByEntity(T entity) async {
    return _dio
        .post(url("delete"), data: entity.toJSON())
        .then((response) => response.body<T>());
  }

  Future<T> deleteById(num id) async {
    return _dio.post(url("delete"), data: {
      'id': id,
    }).then((response) => response.body<T>());
  }

  Future<T> approve(T entity) async {
    return _dio
        .post(url("approve"), data: entity.toJSON())
        .then((response) => response.body<T>());
  }

  Future<T> reject(T entity) async {
    return _dio
        .post(url("reject"), data: entity.toJSON())
        .then((response) => response.body<T>());
  }
}
