# **Switch** #
The Switch automator app is a multithreaded mac solution being able to process dualiso as well as non dualiso files coming from Magic Lantern generated CR2, DNG, RAW and MLV files. Different magic lantern related workflows are all being simplified through different self explanatory bash menus which all are started from within Main menu.  [Forum_thread](http://www.magiclantern.fm/forum/index.php?topic=15108.msg146822#msg146822)

**Following processing workflows are included:**

* Process dual iso generated files from multiple cameras
* Process CR2, DNG, dng, RAW and MLV files(both dualiso and non dualiso)
* Export to ProRes4444 and proxy(FFmpeg, dcraw)
* Process other files such as mov, mts, mpeg etc to ProRes(X to ProRes menu)
* HDR processing from MOV files. (ffmpeg tblend averaging filter. 48, 50, or 60fps recommended)
* 3D lut support(cube)
* White balance correction
* Darkframe averaging automation(mlv_dump)
* Flatframe automation(mlv_dump) 
* MLVFS workflow integration
* MlRawViewer integration(previewing)
* Multithreaded 
* Full auto mode

The program itself is depending on cr2hdr(a1ex), mlv_dump(g3gg0, a1ex), mlv_dump_on_steroids(Bouncyball) raw2dng(a1ex), [dcraw](https://www.cybercom.net/~dcoffin/dcraw/)(Dave Coffin) and [FFmpeg](https://www.ffmpeg.org/)(Fabrice Bellard) for processing the different dualiso generated files.
Processing includes white balance correction through [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/)(Phil Harvey), [exiv2](http://www.exiv2.org/)(Andreas Huggel) and [bwfmetaedit](http://bwfmetaedit.sourceforge.net/)(FADGI) audio metadata adding and if adobe dng converter is installed in applications folder Switch is able to include perfect correlation of white balance going from CR2 to dng files.
Included in code as well is dfort [focus pixel](https://bitbucket.org/daniel_fort/ml-focus-pixels) lists for cameras with focus pixels such as eos m, 650D etc.
Also incorporated is a MLVFS workflow menu. For this to work and take effect you need [MLVFS](Shttp://www.magiclantern.fm/forum/index.php?topic=13152.msg127218#msg127218)(dmilligan) installed onto your system. In conjunction with MLVFS I also put in very fine movie player [MlRawViewer](https://bitbucket.org/baldand/mlrawviewer)(baldand).
Switch works with different menus created in bash from where the user can select or deselect different settings inside Switch. 
The program is able to run all processes in a chain so just fill up the folder with various files and after selecting settings in the different menus simply run Switch and wait for it until it,s done.

*A very special thanks to **Bouncyball** for dedicated support and groundbreaking development(mlv_dump_on_steroids, fpmutil, RAW to MLV converter) in general.*

**Main menu**

![Screen_Shot_2017-07-26_at_10.05.56.png](https://s3.postimg.org/nepet7vjn/Screen_Shot_2017-07-26_at_10.05.56.png)

## HOWTO ##

1. Move Switch to applications folder
2. Double click Switch and select a folder with dual iso CR2, DNG, dng RAW or MLV files then navigate from the Main menu.
3. For dng compressing and matched white balanced Adobe dng converter needs to be installed into application folder. Switch works perfectly fine without ADC but white balance will be slightly off balance due to missing camera calibration information.
4. 3D luts can be added to both ProRes and proxy folders to further tweak the output.
5. Darkframe automation is possible by including darkframe footage(mlv) together with recorded mlv files. Put them all together in the root folder and select (A) from the main menu.
6. Drag and drop function added. Drop a folder/MLV/RAW/mov/dng/folder with dng files on Switch

**regarding gatekeeper**

To supress gatekeeper hold ctrl button down(macOS Sierrra) while opening the application the first time. You can also change permissions from within privacy/security settings.

**For coders**

Inside source_code folder there is a Build_dmg_package.command script. When double clicked it will copy and overwrite all .txt files over in source_code folder into the Switch one level up in source tree. After copying a mac dmg package will be created. Run chmod u=rwx on the script for full privilegies if needed.

**MAIN**
 
If you want to include changes done to Switch_MAIN.txt these have to be copied into Switch in automator. Automator is installed onto your system by default.


**Thanks to:** a1ex, g3gg0, bouncyball, Dave Coffin, Fabrice Bellard(FFmpeg community) Phil Harvey, Andreas Huggel, dmilligan, baldand, so-rose, Chmee, dfort, deafeyejedi.
