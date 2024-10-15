import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repository/bookmark_repository.dart';

class GetBookmarksUseCase {
  final BookmarkRepository repository;

  GetBookmarksUseCase(this.repository);

  Future<Either<Failure, List<BookMarkEntity>>> call() async {
    return repository.getBookmarks();
  }
}