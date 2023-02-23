class GetListRequest{

  int? skipCount;
  int? maxResultCount;
  String? sorting;
  String? keyword;
  Map<String, dynamic>?  extraParams;

  GetListRequest(
      {this.skipCount,
        this.maxResultCount,
        this.sorting,
        this.keyword,
        this.extraParams}
        );


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   if(skipCount !=null) data['SkipCount'] = skipCount;
   if(maxResultCount !=null) data['MaxResultCount'] = maxResultCount;
    if(sorting !=null) data['Sorting'] = sorting;
    if(keyword !=null) data['Keyword'] = keyword;
    if(extraParams != null) {
      data.addAll(extraParams ?? {});
    }
    return data;
  }
}