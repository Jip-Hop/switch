# **cr2hdr(.app)** #
The cr2hdr automator app is a multithreaded mac solution being able to process dualiso as well as non dualiso files coming from Magic Lantern generated CR2, DNG, RAW and MLV files. [Forum_thread](http://www.magiclantern.fm/forum/index.php?topic=15108.msg146822#msg146822)

**Following processing enhancements are included:**

* White balance correction
* Process dual iso generated files from multiple cameras
* Process CR2, DNG, dng, RAW and MLV files(both dualiso and non dualiso)
* Export to ProRes4444 and proxy(FFmpeg, dcraw)
* Multithreaded 

The application itself is depending on cr2hdr(a1ex), mlv_dump(g3gg0, a1ex), raw2dng(a1ex), [dcraw](https://www.cybercom.net/~dcoffin/dcraw/)(Dave Coffin) and [FFmpeg](https://www.ffmpeg.org/)(Fabrice Bellard) for processing the different dualiso generated files.
Processing includes white balance correction through [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/)(Phil Harvey), [exiv2](http://www.exiv2.org/)(Andreas Huggel) and [bwfmetaedit](http://bwfmetaedit.sourceforge.net/)(FADGI) audio metadata adding and if adobe dng converter is installed in applications folder(not included go fetch!) cr2hdr(.app)  is able to include perfect correlation of white balance going from CR2 to dng files.
cr2hdr(.app) also includes a menu selector created in bash from where the user can select or deselect different settings inside cr2hdr(.app).


**cr2hdr**

![menu.png](https://bitbucket.org/repo/Gkyeq9/images/615202290-menu.png)

**mlv_dump**

![Screen Shot 2016-10-23 at 08.23.54.png](https://bitbucket.org/repo/Gkyeq9/images/754466616-Screen%20Shot%202016-10-23%20at%2008.23.54.png)

**FFmpeg/dcraw**

![Screen Shot 2016-10-23 at 08.18.06.png](https://bitbucket.org/repo/Gkyeq9/images/13438127-Screen%20Shot%202016-10-23%20at%2008.18.06.png)

## HOWTO ##

1. Move cr2hdr(.app) to applications folder
2. Double click cr2hdr(.app) and select a folder with dual iso CR2, DNG, dng RAW or MLV files. 
3. For dng compressing and matched white balanced Adobe dng converter needs to be installed into application folder. cr2hdr(.app) works perfectly fine without ADC but white balance will be slightly off balance due to missing camera calibration information.

**regarding gatekeeper**

To supress gatekeeper hold ctrl button down(macOS Sierrra) while opening the application the first time. You can also change permissions from within privacy/security settings.

**For coders**

Inside source_code folder there is a Build_dmg_package.command script. When double clicked it will copy and overwrite all .txt files over in source_code folder into the cr2hdr(.app) one level up in source tree. After copying a mac dmg package will be created. Run chmod u=rwx on the script for full privilegies if needed.

**MAIN**
 
If you want to include changes done to cr2hdr_MAIN.txt these have to be copied by opening up cr2hdr(.app) in automator. Automator is installed in your system by default.



**Thanks to:** a1ex, g3gg0, Dave Coffin, Fabrice Bellard(FFmpeg community) Phil Harvey, Andreas Huggel, bouncyball, so-rose, dmilligan, Chmee, dfort, deafeyejedi