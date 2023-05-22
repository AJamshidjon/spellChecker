List<String> Decode(List<String> lst) {
  int n = lst.length;
  List<String> numLst = [];
  for (int i = 1; i < n + 1; i++) {
    numLst.add('$i');
  }
  numLst.sort();
  List<String> result = [];
  for (int i = 0; i < n; i++) {
    result.add(lst[i].substring(numLst[i].length));
  }
  return result;
}
