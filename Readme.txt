DMML: Digital Mavica Markup Language

Markup language created to organize media created with Sony Digital Mavica FD-81.

The digital camera saves photos, audio comments and short movies to 1.44 MB floppy disks.

A stylesheet for Photo Album in XSL language allows to generate a HTML page.

Written by Stefano Cotta Ramusino.

__________________________________________________________________________________________

Minimum requirements:

- Windows 2000 Professional or later

- Java 1.3.0 or later

- Xalan Java 1.0.0 or later (the JAR files must be in the same directory)

__________________________________________________________________________________________

Insert a floppy with media in the drive and run "FloppyManager.js".

Click on "Copy all files" button and continue with next floppy disks.

Create an "Album.xml" with a content like the following one:

<ALBUM>

    <GOOD>

        <PHOTO
            comment="Good photo"
            floppy="1"

        >Photo title<LOCATION

            place="Photo place"
                >Photo location
            </LOCATION>

            <PHOTOINFO
                effect="negative"
                filter="polarizer"
                type="VOICE"
                file="Voice/MVC-001A.MPG"
            >MVC-001X.JPG</PHOTOINFO>

        </PHOTO>

    </GOOD>

    <BAD>

        <MOVIE
            comment="Bad movie"
            floppy="1"

        >Movie title<LOCATION

            place="Movie place"
                >Movie location
            </LOCATION>

            <MOVIEINFO
                effects="blackNwhite"
                duration='1m 03"'
                size="160x112"
        	>MVC-002V.MPG</MOVIEINFO>

        </MOVIE>

    </BAD>

</ALBUM>

Run "DMML2HTML.cmd" to generates the HTML file.
