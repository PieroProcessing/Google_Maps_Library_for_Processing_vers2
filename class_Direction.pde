class Direction extends Client {
  // **********************************************
  //      json and basic settings
  // **********************************************
  JSONObject jsonTwoPointDirection;
  String origin, stateOrigin, destination, stateDestination;
  // **********************************************
  //      var for waypoint extraction
  // **********************************************
  List<LatLng> list;
  List<LatLng> counter;
  //int number;
  ArrayList <String> path = new ArrayList<String>();
  String [] allPoint;
  String joinPath;
  int increment=90;
  // **********************************************
  //     constructor
  // **********************************************
  Direction (String origin_, String stateOrigin_, String destination_, String stateDestination_) {
    origin = origin_; 
    stateOrigin = stateOrigin_;
    destination = destination_;
    stateDestination = stateDestination_;
  }
  // **********************************************
  //      specific functions
  // **********************************************
  void calculateTwoPointDirection ( ) {
    setOptionalParameter();
    //println(avaibleOption);
    String twoPointDir = direction_URL+"key="+api+"&origin="+origin+","+ stateOrigin+"&destination="+destination+","+stateDestination+avaibleOption;
    jsonTwoPointDirection = loadJSONObject (twoPointDir);
    println(twoPointDir);
  }
  JSONObject getJSONObjectData() {
    return jsonTwoPointDirection;
  };
  void printJSONObjectData() {
    println(jsonTwoPointDirection);
  }
  String getWayPointForURL () {
    JSONArray jRoutes = null;
    JSONArray jLegs = null;
    JSONArray jSteps = null;
    jRoutes = jsonTwoPointDirection.getJSONArray("routes");
    for (int i=0; i<jRoutes.size(); i++) {
      jLegs = ( (JSONObject)jRoutes.get(i)).getJSONArray("legs");
      /** Traversing all legs */
      for (int j=0; j<jLegs.size(); j++) {
        jSteps = ( (JSONObject)jLegs.get(j)).getJSONArray("steps");
        /** Traversing all steps */
        for (int k=0; k<jSteps.size(); k++) {
          String polyline = "";
          polyline = (String)((JSONObject)((JSONObject)jSteps.get(k)).get("polyline")).get("points");
          list = decodePoly(polyline);
          counter = decodePoly(polyline);
          //for (int l=0; l<counter.size(); l++) {
          //  number++;
          //}
          /** Traversing all points */
          for (int l=0; l<list.size(); l+=increment) {
            path.add(Double.toString(((LatLng)list.get(l)).lat)+","+Double.toString(((LatLng)list.get(l)).lng));
          }
        }
      }
    }
    allPoint = new String [path.size()];
    for (int i=0; i<allPoint.length; i++) {
      allPoint[i] = path.get(i);
    }
    joinPath = join(allPoint, "|"); 
    return joinPath;
  }
}