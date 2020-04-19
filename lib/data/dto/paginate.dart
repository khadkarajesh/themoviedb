class Paginate<T> {
  int page;
  int totalResults;
  int totalPages;
  List<T> results;

  Paginate({this.page, this.totalResults, this.totalPages, this.results});
}
