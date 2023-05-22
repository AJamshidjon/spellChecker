List<String> getList(String str) {
  str = str + ' ';
  List<String> result = [];
  int start = 0;
  for (int i = 0; i < str.length; i++) {
    if (str[i] == ' ') {
      result.add(str.substring(start, i));
      start = i + 1;
    }
  }
  return Endcode(result);
}

List<String> Endcode(List<String> lst) {
  int n = lst.length;
  List<String> numLst = [];
  for (int i = 1000; i < n + 1000; i++) {
    numLst.add('$i');
  }
  numLst.sort();
  List<String> result = [];
  for (int i = 0; i < n; i++) {
    result.add(numLst[i] + lst[i]);
  }
  return result;
}
