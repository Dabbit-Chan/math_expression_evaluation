void main() {
  String str = '13+2*3-(47+580)*6';
  RegExp regExp = RegExp(r'\d+');

  str = '$str#';

  List<String> list = [];

  List<double> numberStack = [];
  List<String> signStack = [];

  str.splitMapJoin(
    regExp,
    onMatch: (match) {
      list.add(match[0]!);
      return match[0]!;
    },
    onNonMatch: (match) {
      for (String i in match.split('')) {
        list.add(i);
      }
      return match;
    },
  );

  int i = 0;
  signStack.add('#');

  while (list[i] != '#' || signStack.last != '#') {
    try {
      String current = list[i];
      double? currentValue = double.tryParse(current);
      if (currentValue != null) {
        numberStack.add(currentValue);
        i++;
      } else {
        switch (compareTo(signStack.last, current)) {
          case -1:
            {
              signStack.add(current);
              i++;
              break;
            }
          case 0:
            {
              signStack.removeLast();
              i++;
              break;
            }
          case 1:
            {
              double value1 = numberStack.removeLast();
              double value2 = numberStack.removeLast();
              String sign = signStack.removeLast();
              switch (sign) {
                case '+':
                  numberStack.add(value2 + value1);
                  break;
                case '-':
                  numberStack.add(value2 - value1);
                  break;
                case '*':
                  numberStack.add(value2 * value1);
                  break;
                case '/':
                  numberStack.add(value2 / value1);
                  break;
              }
            }
        }
      }
      print(numberStack);
      print(signStack);
      print('*' * 10);
    } catch(_) {}
  }

  print(numberStack.last);
}

int? compareTo(String sign1, String sign2) {
  switch (sign1) {
    case '+':
      switch (sign2) {
        case '+':
        case '-':
        case ')':
        case '#':
          return 1;
        case '*':
        case '/':
        case '(':
          return -1;
      }
    case '-':
      switch (sign2) {
        case '+':
        case '-':
        case ')':
        case '#':
          return 1;
        case '*':
        case '/':
        case '(':
          return -1;
      }
    case '*':
      switch (sign2) {
        case '+':
        case '-':
        case ')':
        case '#':
        case '*':
        case '/':
          return 1;
        case '(':
          return -1;
      }
    case '/':
      switch (sign2) {
        case '+':
        case '-':
        case ')':
        case '#':
        case '*':
        case '/':
          return 1;
        case '(':
          return -1;
      }
    case '(':
      switch (sign2) {
        case '+':
        case '-':
        case '*':
        case '/':
        case '(':
          return -1;
        case ')':
          return 0;
      }
    case ')':
      switch (sign2) {
        case '+':
        case '-':
        case '*':
        case '/':
        case ')':
        case '#':
          return 1;
      }
    case '#':
      switch (sign2) {
        case '+':
        case '-':
        case '*':
        case '/':
        case '(':
          return -1;
        case '#':
          return 0;
      }
  }
  return null;
}
