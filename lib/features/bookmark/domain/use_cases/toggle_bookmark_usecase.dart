import 'package:blog_app/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repository/bookmark_repository.dart';

class ToggleBookmarkUseCase {
  final BookmarkRepository repository;

  ToggleBookmarkUseCase(this.repository);

  Future<Either<Failure, void>> call(BookMarkEntity bookMarkEntity) async {
    final isBookmarked = repository.isBookmarked(bookMarkEntity.posterId).getOrElse((_) => false);
    return isBookmarked
        ? repository.removeBookmark(bookMarkEntity.posterId)
        : repository.addBookmark(bookMarkEntity);
  }
}