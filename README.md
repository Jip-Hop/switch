****# cr2hdr(.app) #
The cr2hdr automator app is a multithreaded mac solution being able to process dual iso files coming from magic lantern generated CR2, DNG, and MLV files. 

**Following postprocessing enhancements are included:**
-	White balance correction
-	Process dual iso generated files from multiple cameras
-	Process CR2, DNG, dng, and MLV files
-	Multithreaded 

The application itself is depending on cr2hdr(a1ex) and mlv_dump(g3gg0, a1ex) for processing the different dualiso generated files.
Processing includes white balance correction through exiftool(Phil Harvey) and exiv2(Andreas Huggel) and if adobe dng converter is installed in applications folder(not included go fetch!) cr2hdr(.app)  is able to include perfect correlation of white balance going from CR2 to dng files.
cr2hdr(.app) also includes a menu selector created in bash from where the user can select or deselect different settings inside cr2hdr(.app).


**Bash menu**

![menu.png](https://bitbucket.org/repo/Gkyeq9/images/615202290-menu.png)


****## HOWTO ##
1 - Move cr2hdr(.app) to applications folder
2 - Double click cr2hdr(.app) and select a folder with dual iso cr2 files. 
3 - For compressing and matched white balanced Adobe dng converter needs to be installed into application folder. cr2hdr works perfectly fine without but white balance will be slightly off balance due to missing camera calibration information.

**NOTE 1**
To supress gatekeeper hold ctrl button down while opening the application the first time. You can also change permissions from within privacy/security settings.

**For coders**
Inside source_code folder there is a Build_dmg_package(.app) application. When double clicked it will copy and overwrite all .txt files over in source_code folder into the cr2hdr(.app) located one level up in source tree. 

**NOTE 2** 
If you want to include changes done to cr2hdr_MAIN.txt these have to be copied by opening up cr2hdr(.app) in automator.