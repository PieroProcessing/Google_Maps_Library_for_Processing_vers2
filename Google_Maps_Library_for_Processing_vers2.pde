import java.util.GregorianCalendar;
import java.util.List;


Direction dm;

public void setup() 
{
  size(300, 50, P2D);
  background(0);
  smooth();

  dm = new Direction("ROMA", "IT", "MILANO", "IT");
  dm.setTransitRequest(0, 2017, 04, 21, 12, 54);
  dm.setTravelMode(1, 0, 0, 0);
  dm.setTransitMode(0, 0, 0, 0, 0);
  dm.setAvoidOption(0, 0, 0, 0);
  dm.setTrafficModel(0, 1, 0);
  dm.setLanguage("italiano");
  dm.setUnits("metric");
  dm.setTransitRoutingPreference(1);
  //textMode(CENTER);
  dm.calculateTwoPointDirection();
  dm.printJSONObjectData();
}