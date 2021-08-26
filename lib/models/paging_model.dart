class Paging {
  late int currentPage;
  late int totalCount;
  late int totalPage;

  Paging.fromJson(Map<String, dynamic> json)
  : currentPage = json['currentPage'],
    totalCount = json['totalCount'],
    totalPage = json['totalPage'];
}