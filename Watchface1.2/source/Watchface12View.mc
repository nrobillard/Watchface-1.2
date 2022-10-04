import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Time;
import Toybox.Time.Gregorian;

class Watchface12View extends WatchUi.WatchFace {

	var battFont = null;
	var timeFont = null;
	var dateFont = null;
	var color = null;
	
	
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
    	
    	battFont = WatchUi.loadResource(Rez.Fonts.customFont1);
    	timeFont = WatchUi.loadResource(Rez.Fonts.customFont2);
    	dateFont = WatchUi.loadResource(Rez.Fonts.customFont3);
    	
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        
		dc.clear();
		
		
		var clockTime = System.getClockTime();
		
       	var timeStr = timeFunc(clockTime);
       	var batStr = battFunc();
       	var dateStr = dateFunc();
       	var view = View.findDrawableById("TimeLabel") as Text;

       	
       	
       	
       	
       	if (clockTime.hour >= 0 && clockTime.hour < 6){
        	color = Graphics.COLOR_DK_RED;
        }
       	else if (clockTime.hour >= 6 && clockTime.hour < 12){
        	color = Graphics.COLOR_YELLOW;
        }
        else if (clockTime.hour >= 12 && clockTime.hour < 21){
        	color = Graphics.COLOR_BLUE;
        }
        else {
        	color = Graphics.COLOR_DK_RED;
        }
        
        
       	
        
        dc.setColor(Graphics.COLOR_WHITE,color);
        dc.drawText(dc.getWidth()/2, 85 ,timeFont,timeStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(dc.getWidth()/2, 10 ,battFont,batStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(dc.getWidth()/2, 200 ,dateFont,dateStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(color,color);
        
       
        
    }
    
    
    
    }
  
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    	WatchUi.requestUpdate();
    }
    
    
    function timeFunc(clockTime){
    
	    var timeString = null;
	    
	    if (System.getDeviceSettings().is24Hour) {
	    	timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min]);
	    	
	    }
	    else{
	    	var hour = (clockTime.hour + 11) % 12 + 1;
	    	var min = clockTime.min.format("%.02d");
	    	timeString = Lang.format("$1$:$2$", [hour, min]);
	    
	    }
	    
   	return timeString;
    }
    
    
    
    function dateFunc(){
	    var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
	    var dateString = Lang.format("$1$/$2$/$3$",[today.month,today.day,today.year]);
    	
    	
   	return dateString;
    }
    
    
    
    function battFunc(){
    
	    var stats = System.getSystemStats(); 
	    var pwr = stats.battery; 
	    var batStr = 0;
	    
	    if(pwr < 10){
	    	
	    	batStr = Lang.format( "$1$%", [ pwr.format( "%02d" ) ] );
	    		    	
	    }
	    else{
	    	batStr = Lang.format( "$1$%", [ pwr.format( "%2d" ) ] ); 
	    
	    }
	    
	    
 
    return batStr;
    }
    
 
    
 
