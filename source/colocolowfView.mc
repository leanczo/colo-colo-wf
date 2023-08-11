import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class colocolowfView extends WatchUi.WatchFace {
	var logo;
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
        logo = WatchUi.loadResource(Rez.Drawables.Logo);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var widthScreen = dc.getWidth();
		var heightScreen = dc.getHeight();
  		var widthCenter = widthScreen / 2;
  		var heightCenter = heightScreen / 2;
		
		var radii = [widthScreen / 3, widthScreen / 4, widthScreen / 2.5, widthScreen / 2.8, widthScreen / 2.2, widthScreen / 3.5];

		// Generar los ángulos
		var angles = [];
		for (var a = 0; a < 360; a += 15) {
		    angles.add(a);
		}
		
		for (var i = 0; i < angles.size(); i++) {
		    var angle = angles[i];
		    var radiusIndex = i % radii.size();
		    var radius = radii[radiusIndex];
		
		    var endX = widthCenter + radius * Math.cos(angle * Math.PI / 180);
		    var endY = heightCenter + radius * Math.sin(angle * Math.PI / 180);
		    
		    // Definimos los colores según el índice de la línea
		    switch (i % 4) {
		        case 0:
		            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
		            break;
		        case 1:
		            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
		            break;
		        case 2:
		            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
		            break;
		        case 3:
		            dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
		            break;
		    }
		    
		    dc.drawLine(widthCenter, heightCenter, endX, endY);
		}
  		// Logo
        var positionLogoX = (widthScreen / 2) - 60;
        var positionLogoY = (heightScreen / 2) - 58.5;
        dc.drawBitmap(positionLogoX, positionLogoY, logo);
        
        // Time
        dc.setColor(getApp().getProperty("ForegroundColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(widthCenter, (heightScreen / 8) * 6, Graphics.FONT_LARGE, timeString, Graphics.TEXT_JUSTIFY_CENTER);
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
    }

}
