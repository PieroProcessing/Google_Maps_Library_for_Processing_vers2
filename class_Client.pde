class Client {
  // **********************************************
  //      specific url
  // **********************************************
  String api="AIzaSyAOFVs_fLIeh36yGFTiKGAGx2wDIH1fiJg"; 
  String distance_Matrix_URL ="https://maps.googleapis.com/maps/api/distancematrix/json?";
  String direction_URL = "https://maps.googleapis.com/maps/api/directions/json?";
  // **********************************************
  //      generic variable
  // **********************************************
  // travel mode
  String [] Travel_Mode_OPT = {null, "driving", "walking", "bicycling", "transit"};
  String travelMode ="";
  // time request
  String timeRequest="";
  GregorianCalendar calendar = new GregorianCalendar();
  // avoid opt
  String [] Avoid_OPT = {null, "tolls", "highways", "ferries", "indoor"};
  String avoidMode="";
  // language
  String language ="";
  // unit opt
  String unit="";
  // traffic model
  String [] Traffic_Model_OPT = {null, "best_guess", "pessimistic", "optimistic"};
  String trafficModel="";
  // transit mode
  String [] Transit_Mode_OPT = {null, "bus", "subway", "train", "tram", "rail"};
  String transitMode="";
  //transit_routing_preference
  String transitRoutingPreference="";
  // final url option var
  String avaibleOption="";
  // **********************************************
  //      generic functions
  // **********************************************
  void setOptionalParameter() {
    avaibleOption= language + unit + travelMode + transitMode + trafficModel + avoidMode + transitRoutingPreference + timeRequest;
  }
  void setTravelMode(int driving, int walking, int bicycling, int transit) {
    String temp = select(driving*1, walking*2, bicycling*3, transit*4, Travel_Mode_OPT);
    travelMode = verify(temp, "&mode=");
    //if (index == 4) {
    //}
  }
  void setTransitMode( int bus, int subway, int train, int tram, int rail) {
    String [] temp = {Transit_Mode_OPT[bus*1], Transit_Mode_OPT[subway*2], Transit_Mode_OPT[train*3], Transit_Mode_OPT[tram*4], Transit_Mode_OPT[rail*5]};
    String transitModeString = join(multipleSelect(temp), "|");
    transitMode=verify(transitModeString, "&transit_mode=");
  }
  void setTrafficModel (int best_guess, int pessimistic, int optimistic) {
    String [] temp = {Traffic_Model_OPT[best_guess*1], Traffic_Model_OPT[pessimistic*2], Traffic_Model_OPT[optimistic*3]};
    String trafficModelString = join(multipleSelect(temp), "|");
    trafficModel=verify(trafficModelString, "&traffic_model=");
  }
  void setTransitRoutingPreference (int t) {
    String temp;
    switch (t) {
    case 0:
      temp = "less_walking";
      break;
    case 1:
      temp = "fewer_transfers";
      break;
    default:
      temp="";
      break;
    }
    transitRoutingPreference = verify(temp, "&transit_routing_preference=");
  }
  void setTransitRequest (int type, int year_, int month_, int date_, int hourOfDay_, int minute_) {
    long dataTime = setTime( year_, month_, date_, hourOfDay_, minute_);
    switch (type) {
    case 0:
      timeRequest="&departure_time="+ dataTime;
      break;
    case 1:
      timeRequest="&arrival_time="+ dataTime;
      break;
    default:
      timeRequest="";
      break;
    }
  }
  long setTime(int year_, int month_, int date_, int hourOfDay_, int minute_) {
    calendar.set( year_, month_, date_, hourOfDay_, minute_);
    long time = calendar.getTimeInMillis()/1000;
    return time;
  }
  void setAvoidOption (int tolls, int highways, int ferries, int indoor ) {
    String [] temp ={Avoid_OPT[tolls*1], Avoid_OPT[highways*2], Avoid_OPT[ferries*3], Avoid_OPT[indoor*4]};
    String  avoidString =  join(multipleSelect( temp), "|");
    avoidMode= verify(avoidString, "&avoid=");
  }

  void setLanguage(String l) {
    language = verify(l, "&language=");
  }
  void setUnits (String m) {
    unit= verify(m, "&units=");
  }
  String verify (String v, String url) {
    if (v.equals("")) {
      return "";
    } else {
      return url+ v;
    }
  }
  String select(int a, int b, int c, int d, String []k) {
    String compare= new String();
    String [] temp ={k[a], k[b], k[c], k[d]};
    for (int i=0; i<temp.length; i++) {
      if (temp[i] != null) {
        compare = temp[i];
      }
    }
    return compare;
  }
  String [] multipleSelect(String [] in) {
    ArrayList <String> compare= new ArrayList <String>();
    String [] def;
    for (int i=0; i<in.length; i++) {
      if (in[i] != null) compare.add(in[i]);
    }
    def = new String[compare.size()];
    for (int i=0; i<compare.size(); i++) {
      def[i]= compare.get(i);
    }
    return def;
  }
  List<LatLng> decodePoly(String encoded) {

    List<LatLng> poly = new ArrayList<LatLng>();
    int index = 0, len = encoded.length();
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.charAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.charAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = new LatLng((((double) lat / 1E5)), 
        (((double) lng / 1E5)));
      poly.add(p);
    }

    return poly;
  }
}