(function(){
    document.addEventListener("DOMContentLoaded", function(){
        //Finding the radius:
        var getRadius = function( orgX, orgY){
            if(orgX > orgY){
                return orgY;
            }
            return orgX;
        };

        //Converting Radians to Cartesian for drawing circles
        var radToCart = function( radiusLength, radians){
            var coords = {};
            coords.x = radiusLength/2 * Math.cos(radians/2);
            coords.y = radiusLength/2 * Math.sin(radians/2);
            return coords;
        };

        var canvas = document.querySelector("#cvs");
        var context = canvas.getContext("2d");
        var x = canvas.width/2;
        var y = canvas.height/2;
        var radius = getRadius(x, y);

        var newEl = document.querySelector("#new");
        var totalEl = document.querySelector("#total");
        var retEl = document.querySelector("#return")
        var newV = parseInt(newEl.innerHTML, 10);
        var totalV = parseInt(totalEl.innerHTML, 10);
        var retV = parseInt(retEl.innerHTML, 10);

        var newP = Math.round((newV/totalV) * 100);
        var totalP = 100 - newP;

        var newInRad = (newV/totalV) * 2 * Math.PI;
        var retInRad = (retV/totalV) * 2 * Math.PI;
        //Define Drawing (NEW)
        var startDeg = 0;
        var endDeg = newInRad;
        var counterClockwise = false;

        context.beginPath();
        context.moveTo(x, y);
        context.arc(x, y, radius, startDeg, endDeg, counterClockwise);
        context.closePath();
        //Render Image
        context.fillStyle = "aqua";
        context.fill();

        //Define Drawing (RETURN)
        var startDeg = endDeg;
        var endDeg = 0;
        context.beginPath();
        context.moveTo(x, y);

        context.arc(x, y, radius, startDeg, endDeg, counterClockwise);
        context.closePath();
        context.fillStyle = "pink";
        context.fill();
    })
})();