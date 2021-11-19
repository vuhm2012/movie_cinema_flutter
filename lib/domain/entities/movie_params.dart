import 'package:equatable/equatable.dart';

class MovieParams extends Equatable {
  final int id;

  const MovieParams(this.id);

  @override
  List<Object> get props => [id];
}

class MoviePageParams extends Equatable {
  final int page;

  const MoviePageParams(this.page);

  @override
  List<Object?> get props => [page];
}
