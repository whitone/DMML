var answer, activeX, isThisOne, Floppy, A;

var shell = WScript.CreateObject("Wscript.Shell");

var images = new Array(50);
var movies = new Array(50);
var thumbnails = new Array(50);
var bitmap;

var A_Exists = false;
var newline = "\r\n";

// ------------KEYS-----------
var RetryCancel = 5;

// ------------ICONS----------
var Stop = 16;

// ---------PRESSED KEYS-------
var sCancel = 2;


function theFloppyExists(drive) {

	var Removable = 1;
	
 	with (drive) {

	     A = DriveLetter.toString().toUpperCase();

	     if (DriveType == Removable) {

	         while (IsReady == false) {

	             Ask("Floppy not ready in the drive "+A+"!", "I/O error", RetryCancel, Stop);

	             if (answer==sCancel) {
	                 WScript.Quit();
	             }

	         } A_Exists = true;
	     }
	}
}


function identify(Floppy) {

	var file, files, text, comparetext;

	files = new Enumerator(Floppy.Files);

	text = ''; isThisOne = false;

	for (; !files.atEnd(); files.moveNext()) {
  		
		file = files.item();

		if (file.Name.toLowerCase() == "mavica.htm") { 

			filename = file.Path;
			readFile = activeX.OpenTextFile(filename, 1, false);
  			while (readFile.Line < 5) {
				with(readFile) {
	   				text = text + ReadLine();
					if (Line != 5) { text = text + newline; }
				}
			}
			comparetext = '<HTML>' +
				   newline +
				  '<HEAD><TITLE>Digital Mavica image viewer</TITLE></HEAD>'+
				   newline +
				  '<META NAME="GENERATOR" CONTENT="Digital Mavica MVC-FD81    ">'+
				   newline +
				  '<BODY>';
			if (text == comparetext) { 
				isThisOne = true;
			} 
  			readFile.Close();
  		} 

		if (text != '') {
			break;
		}

	}
}


function count(Floppy, type, inNumber) {

        var sing = "";
	var count = 0;
	var iFiles = Floppy.Files;
	
	if (type=='FILE') {

		count = iFiles.Count;
		sing = "file";
        
	} else {

		var counter, file, withDot;

		sing = "file";
	
		counter = new Enumerator(iFiles);

                for (;!counter.atEnd();counter.moveNext()) {
		
			file = counter.item().Name;
			withDot = file.lastIndexOf(".");
			
			if (withDot!=-1) {

                extension = file.substr(withDot);
                if (extension == type) {
                    count = count + 1;
                }

            }
				
				 switch (type) {
				
				   case ".JPG": 
						sing = "image";
						if (count>0) images[count-1]=file;
						break;
				   case ".MPG":
                        sing = "movie";
						if (count>0) movies[count-1]=file;
						break;
				   case ".411": 
						sing = "thumbnail";
						if (count>0) thumbnails[count-1]=file;
						break;
				   case ".BMP":
						sing = "bitmap image";
						if (count>0) bitmap=file;
						break;
				   default:
						sing = "file";
				
				 }
                    
		}
	
	}

	if (inNumber) { return count; }

	else { 
		if (count==0) { return count = "non ci sono " + sing + "s"; }
                else if (count!=1) { return count.toString() + " " + sing + "s"; }
                else { return count + " " + sing; }
	}

}


function MakeHTML(Floppy) {
	
	var page, head, style, script, body, foot;

	script = "<SCRIPT>"+
		 newline+
		 "var p='';"+
		 newline+
		 "function copy(what) {"+
		 newline+
		 '	if (!p) { p = window.prompt("Number of the floppy?","1") }'+
		 newline+
		 '	var fso = new ActiveXObject("Scripting.FileSystemObject");'+
		 newline+
         '	if (!(fso.FolderExists("Floppy"))) fso.CreateFolder("Floppy");'+
         newline+
		 '	if (!(fso.FolderExists("Floppy\\\\"+p))) fso.CreateFolder("Floppy\\\\"+p);'+
		 newline+
		 '	fso.CopyFile("'+A+':\\\\*."+what, "Floppy\\\\"+p+"\\\\");'+
		 newline+
		 '	//fso.DeleteFolder("'+A+':\\\\");'+
		 newline+
		 "	window.close;"+
		 newline+
		 "}"+
		 newline+
		 "function copyallfiles() {"+
		 newline+
		 '	p = window.prompt("Number of the floppy?","1");'+
		 newline+
		 '	var fso = new ActiveXObject("Scripting.FileSystemObject");'+
		 newline+
         '	if (!(fso.FolderExists("Floppy"))) fso.CreateFolder("Floppy");'+
         newline+
         '	if (!(fso.FolderExists("Floppy\\\\"+p))) fso.CreateFolder("Floppy\\\\"+p);'+
		 newline+
		 '	fso.CopyFile("'+A+':\\\\mavica.htm", "Floppy\\\\"+p+"\\\\");'+
		 newline+
		 '	//fso.DeleteFolder("'+A+':\\\\");'+
		 newline+
		 '	if ('+count(Floppy,".JPG",1)+'>0) { copy("jpg") }'+
		 newline+
		 '	if ('+count(Floppy,".MPG",1)+'>0) { copy("mpg") }'+
		 newline+
		 '	if ('+count(Floppy,".BMP",1)+'>0) { copy("bmp") }'+
		 newline+
		 "	window.close;"+
		 newline+
		 "}"+
		 newline+
		 "</SCRIPT>";

	style = "<STYLE> </STYLE>";

	head = "<HTA:APPLICATION WINDOWSTATE='maximize'>"+
		newline+
		"<HTML>"+
		newline+
		"<HEAD>"+
		newline+
		'<META NAME="Author" VALUE="Stefano Cotta Ramusino">'+
		newline+
		"<TITLE>Floppy Viewer</TITLE>"+
		newline+
		script+
		newline+
		style+
		"</HEAD>";

	body = "<BODY>"+
		newline+
		"<CENTER><H1>View the content of the Floppy</H1><BR>"+
		newline+
		'</CENTER><A HREF="file://'+A+':/mavica.htm">INDEX</A><BR>'+
		newline;

	message = "The floppy contains " + count(Floppy,'FILE',0) + ":"
		    +"<BR>"+newline
		    +"<UL>"+newline
		    +"<LI>"+
		    count(Floppy,'.JPG')+";"
		    +newline+"<LI>"+
		    count(Floppy,'.BMP')+";"
		    +newline+"<LI>"+
		    count(Floppy,'.MPG')+";"
		    +newline+"<LI>"+
		    count(Floppy,'.411')+";"
		    +newline+"<LI>1 index.</UL>";
	
	body = body + message + "<BR>" + newline;

	ThereAreJPG = count(Floppy,'.JPG',1);
	ThereAreMPG = count(Floppy,'.MPG',1);
	ThereAreBMP = count(Floppy,'.BMP',1);

	if (ThereAreJPG>0) {

		for (var i=0; i < ThereAreJPG; i++) {

			body = body+
				'<A HREF="file://'+A+':/'+images[i]+'">'+
				'<IMG STYLE="height:150;width=200;"'+
				' SRC="file://'+A+':/'+images[i]+'">'+
				'</A>'+
				newline;

		}
	}


	if (ThereAreMPG>0) {

		for (var i=0; i < ThereAreMPG; i++) {

			body = body+
				'<A HREF="file://'+A+':/'+movies[i]+'">'+
				movies[i]+
				'</A>'+
				newline;

		}
	}


	if (ThereAreBMP>0) {

		for (var i=0; i < ThereAreBMP; i++) {

			body = body+
				'<A HREF="file://'+A+':/'+bitmap+'">'+
				'<IMG STYLE="height:150;width=200;"'+
				' SRC="file://'+A+':/'+bitmap+'">'+
				'</A>'+
				newline;

		}
	}

	foot = "<BR><HR><BR><BUTTON onClick='copy("+'"jpg"'+")'>Copy JPEG images</BUTTON>"+
		newline+
		"  <BUTTON onClick='copy("+'"mpg"'+")'>Copy movies</BUTTON>"+
		newline+
		"  <BUTTON onClick='copy("+'"htm"'+")'>Copy index</BUTTON>"+
		newline+
		"  <BUTTON onClick='copyallfiles()'>Copy all files</BUTTON>"+
		"</BODY></HTML>";

	page = head + newline + body + foot;

	HTMLfile = shell.ExpandEnvironmentStrings("%temp%\\index.hta");
	writeFile = activeX.CreateTextFile(HTMLfile, true);

	writeFile.Write(page);

	writeFile.close();

	shell.Run(HTMLfile,1,true);

	writeFile = activeX.GetFile(HTMLfile);
	writeFile.Delete();
	
}


function Start() {

	var drive, drives, message;

	activeX = new ActiveXObject("Scripting.FileSystemObject");
	
	drives = new Enumerator(activeX.Drives);	
	
	for (;!drives.atEnd();drives.moveNext()) {

		drive = drives.item();
		theFloppyExists(drive);
		if (A_Exists) {
			Floppy = drive.RootFolder;
			identify(Floppy);
			if (isThisOne == false) { Write("This one is not a floppy created with the MAVICA FD-81!"); }
                        if (isThisOne) {
				MakeHTML(Floppy);
                        }
		 	A_Exists = false;
		}
	}

}


function Write(x) {
	WScript.Echo(x);
}


function Ask(text,title,keys,icons,seconds) {

	answer = shell.PopUp(text,seconds,title,keys+icons);
	return answer;

}


//Command of launch of the script

Start();
