class DistanceMatrix extends Client {

  // **********************************************
  //      json and basic settings
  // **********************************************
  JSONObject jsonTwoPointDistance;
  String origin, stateOrigin, destination, stateDestination;
  // **********************************************
  //      data from json
  // **********************************************
  String durationString, distanceString, trafficString;
  int durationValueInSecond, distanceValueInMeter, trafficValueInSecond;
  // **********************************************
  //     constructor
  // **********************************************
  DistanceMatrix ( String origin_, String stateOrigin_, String destination_, String stateDestination_) {
    origin = origin_; 
    stateOrigin = stateOrigin_;
    destination = destination_;
    stateDestination = stateDestination_;
  }
  // **********************************************
  //      specific functions
  // **********************************************
  void calculateTwoPointDistance ( ) {
    setOptionalParameter();
    //println(avaibleOption);
    String twoPointDist = distance_Matrix_URL+"key="+api+"&origins="+origin+","+ stateOrigin+"&destinations="+destination+","+stateDestination+avaibleOption;
    jsonTwoPointDistance = loadJSONObject (twoPointDist);
    println(twoPointDist);
  }
  void extractDataString() {
    JSONObject jRows = null;
    JSONObject jElement = null;
    jRows = jsonTwoPointDistance.getJSONArray("rows").getJSONObject(0);
    jElement = jRows.getJSONArray("elements").getJSONObject(0);
    if (jElement.getString("status").equals("OK")) {
      durationString = jElement.getJSONObject("duration").getString("text");
      distanceString = jElement.getJSONObject("distance").getString("text");
      if (jElement.getJSONObject("duration_in_traffic") != null)
        trafficString = jElement.getJSONObject("duration_in_traffic").getString("text");
    }
    //println(durationString);
    //println(distanceString);
    //println(trafficString);
  }
  String getDurationString() {
    return durationString;
  }
  String getDistanceString() {
    return distanceString;
  }
  void extractDataValue() {
    JSONObject jRows = null;
    JSONObject jElement = null;
    jRows = jsonTwoPointDistance.getJSONArray("rows").getJSONObject(0);
    jElement = jRows.getJSONArray("elements").getJSONObject(0);
    if (jElement.getString("status").equals("OK")) {
      durationValueInSecond = jElement.getJSONObject("duration").getInt("value");
      distanceValueInMeter = jElement.getJSONObject("distance").getInt("value");
      if (jElement.getJSONObject("duration_in_traffic") != null)
        trafficValueInSecond = jElement.getJSONObject("duration_in_traffic").getInt("value");
    }
    //println(distanceValueInMeter);
    //println(durationValueInSecond);
    //println(trafficValueInSecond);
  }
  int getDurationValueInSecond() {
    return durationValueInSecond;
  }
  int getDistanceValueInMeter() {
    return distanceValueInMeter;
  }
  // **********************************************
  //      json and basic functions
  // **********************************************
  JSONObject getJSONObjectData() {
    return jsonTwoPointDistance;
  };
  void printJSONObjectData() {
    println(jsonTwoPointDistance);
  }
  void saveJSONObjectData(String title) {
    saveJSONObject(jsonTwoPointDistance, "data/"+ title +".json");
  }
}