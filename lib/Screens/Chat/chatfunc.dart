

String getChatID(String p1, String p2) {

          String smaller = int.parse(p1) >int.parse(p2) ? p2:p1;
        String greater = int.parse(p1) >int.parse(p2) ? p1:p2;


        return "$smaller-$greater";
}