<!--

 window.onerror=null;


 function hide() {

	divLoadCont.style.visibility="hidden";

 }


 function load(n,type) {

	text = ""; textt = ""; no = "";

	n = n+1;

	if (type == "photo") {

		no=document.images.length+1;

		if (no==1) {text = "Loaded <B>" + no + "</B> photo"}
		
		else {text = "Loaded <B>" + no + "</B> photos"}

		document.all.loaded_photos.innerHTML = text;


	} else if (type == "movie") {

		if (n==1) {textt = "Loaded <B>" + n + "</B> movie"}

		else {textt = "Loaded <B>" + n + "</B> movies"}

		document.all.loaded_movies.innerHTML = textt;

	}
	
 }


 function disappear() {

	document.all.loaded_photos.style.display="none";

	document.all.loaded_movies.style.display="none";

 }


 function TextHTML(URLImg, bool) {
	
	head = '<HTML ONKEYPRESS="window.close()" ONCLICK="window.close()">\n' +
	      	 '<LINK REL="stylesheet" HREF="Album-files/Style.css">\n';

	body  = '<BODY CLASS="backgroundIMG">\n<CENTER>\n';

	img    = '<IMG SRC="' + URLImg + '" CLASS="Image"/>';

	email = '<IMG ONMOUSEDOWN="show()" ID="email" SRC="' + URLImg + '" CLASS="eMail"/>';

	end   = '</CENTER></BODY></HTML>';

	hTmL = head + body + img + end;

	if (bool==1) {

		hTmL = head +
		       '<SCRIPT SRC="Album-files/script.js"></SCRIPT>' +
		       body + email + end;

	} else if (bool=="positive") {

		img2 = '<IMG SRC="' + URLImg + '" CLASS="Image" STYLE="filter:Invert()"/>';

		hTmL = head + body + img2 + end;

	}

	return hTmL;
 }


 function FullScreen(imgg) {

	FullScreen(imgg, 0);

 }


 function FullScreen(Image, Email) {

	if (Email=="voice") {
		window.location = Image;
	}
	
	else {	

	var pS = window.open("","",[
		"toolbar=no", "location=no", "directories=no", "status=no",
		"menubar=no", "scrollbars=no", "resizable=no","fullscreen=yes"
	]);
	pS.focus();
	pS.document.write(TextHTML(Image,Email));
	pS.document.close();

	}

 }


 function date(file) {

 	var creationDate = "";

 	var date = floppy[file][0];

	days = new Array("Su","Mo","Tu","We","Th","Fr","Sa");
	nameDay = days[date.getDay()];

	months = new   Array("Jan","Feb","Mar","Apr","May","Jun");
	months = months.concat("Jul","Aug","Sep","Oct","Nov","Dec");
	month = months[date.getMonth()];

	divider = "</TD></TR><TR><TD CLASS=\'attribute\'>Hour</TD><TD class=\'value1\'>";

	creationDate = nameDay+" "+date.getDate()+"-"+month+"-"+date.getFullYear();
	creationDate = creationDate+divider;
	creationDate = creationDate+(date.getHours()<10?"0":"")+date.getHours();
	creationDate = creationDate+":"+(date.getMinutes()<10?"0":"")+date.getMinutes();
	creationDate = creationDate+"."+(date.getSeconds()<10?"0":"")+date.getSeconds();

	return creationDate;
 }


 function file_size_Format(file) {

    var size = "";
    var format = "";
    var size_format = "";

    size = floppy[file][1] / 1024;

    size = size.toString();
    dec = size.indexOf(".");

    if (dec!=-1) {

        size = size.substring(0,dec+3);

    }

    size = size+" KB";

    filename = file.substr(file.lastIndexOf("/")+1);
    withDot = filename.lastIndexOf(".");

    if (withDot!=-1) {

        extension = filename.substr(withDot+1).toUpperCase();

        switch(extension) {

            case "JPG":
                format = "JPEG";
                break;

            case "MPG":
                format = "MPEG";
                break;

            case "BMP":
                format = "Bitmap";
                break;

            default:
                format = "Generic";
        }
    }

    div = "</TD></TR><TR><TD CLASS=\'info\'>Format</TD><TD class=\'value\'>";

    size_format = size+div+format;

    return size_format;

}

 function fps(dur) {

	FramesPerSecond = 26.4;
 	var sec, frames;
	moreThanMin = dur.indexOf("m");

	if (moreThanMin == -1) {

		sec = parseInt(dur);

	} else {
		
		parzSec = 0;
		if (dur.length > moreThanMin) parzSec = parseInt(dur.substr(moreThanMin+1));
		min = parseInt(dur.substring(0,moreThanMin));
		sec = parzSec + (60 * min);
	}

	frames = Math.round(sec * FramesPerSecond);
	if (frames==0) frames=1;
	return frames;

 }


 function positive(nPhoto) {

	FullScreen(document.all.photo[nPhoto].src, "positive");

 }


 function showInfo(table) {
	
	with (document.all.hidden[table].style) {
		
		if (display == "none") {
			display = "block";
		} else if (display == "block") {
			display = "none";
		} else { 
			 display ="block";
		}
	}
 }

// --------------------------------------------------------


 function show() {

		with (document.all.email.style) {
		
			var width  = "document.body.clientWidth"  ;
			var height = "document.body.clientHeight" ;
			top="0";
			left="0";
			setExpression("width" , width) ;
			setExpression("height", height);
			
		}	
 }

// -->
