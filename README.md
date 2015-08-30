# frijmags
## A silly project to make custom-font alphanumeric refrigerator magnets from your own handwriting.

---
I made a set of fridge-mags for my daughter for Christmas using my wife's (beautiful) handwriting, which led to this project. I also made a set out of my (poor) handwriting.

If I'm not too lazy to do so when she starts writing herself, I will some day make a new set from my daughter's handwriting every few months to immortalize (assuming I use ABS and not PLA) the progression of her penmanship. We're hoping she gets her mother's calligraphy skills, not her father's.

If you have a 3d printer and some basic tools and supplies, this repo should be enough info to get you from zero to frijmag in around 6 hours. However, if this all sounds neat to you, but you don't really want to do all the stuff below, then fear not! I sell these, custom made from your font template, on Etsy: <http://farrisfair.etsy.com>.

### Recursive cross-posty links:
* Evil, nasty Thingiverse: <http://www.thingiverse.com/thing:991549>
* Rad, awesome Github: <https://github.com/JustinFarris/frijmags>
* Yarny, stay-at-home-mommy Etsy: <http://farrisfair.etsy.com>

## Create your font
### <http://www.myscriptfont.com>
* Download and print this template: <http://www.myscriptfont.com/res/ScriptTemplate.pdf>
* Fill out the template in your own handwriting using dark lines, but stay within the guides.
* You can pick up and relocate your hand for crossed letters and such, but each finished letter should be one single, contiguous object. The magnets will be made using only the upper-case letters to avoid floating objects such as in dotted letters.

### Cleanup the images

* Remove errant pixels, move writing within template guidelines line, etc.
* Make sure gaps inside letters aren't too small, such as the whole inside the capital "A". Tiny gaps will be auto-filled and disappear when the file is converted to a vector image.
* Dilate or Erode in gimp as needed to thicken or thin the lines. I also posterized mine since I have an old scanner that doesn't provide very good non-grayscale images. (find a command-line way to do this)

### Convert font to TTF: <http://www.myscriptfont.com/>
* It would be awesome if we could get the source code for this tool or find an alternative. I have contacted the developer, but no response so far.


## Install your font

This is the part that's a little hairy, and you're on your own for parts of it. Below is what worked for me.
*** YOUR MILEAGE MAY VARY. This is likely to be slightly different on your system than on mine. If this stuff confuses you, perhaps you should find a different DIY project and consider letting me do all of this for you for a reasonable fee via my Etsy shop: <http://farrisfair.etsy.com> ***

### Put the new TTF font file somewhere safe, such as in ~/fonts/YourFontName.ttf

### Add this to /usr/local/etc/ImageMagick-6/type.xml:
* This can totally be scripted, I just haven't done it yet.

```
  <type
     format="ttf"
     name="YourFontName"
     fullname="YourFontName"
     family="YourFontName"
     glyphs="/path/to/your/font/file/YourFontNamt.ttf"
     />
```

###Create text images and SVGs with ImageMagick "convert" and <online-convert.com> using my mkmags.sh bash script

This is a QAD bash script that uses ImageMagick and a call to API. You can actually use it to make any set of characters, grouped into whatever size batches you want. I'll assume if you've gotten this far that you're comfortable with shell scripts. If not, I'll leave it as an exercise for the maker to either learn or find someone to help out.

Here's what the script does in a nutshell:

* Takes no arguments, but has several configurable variables up top. You should look a those. It probably won't work if you don't.
* Allows you to choose what characters to create and how many characters are used per image.
* Creates a directory to put stuff in.
* Iterates over the list of characters to create 2d images of $N characters.
* When all of the 2d images are created, it makes an api call to online-convert.com for each one to convert it to an SVG file. More info at <http://image.online-convert.com/convert-to-svg>.

I'd rather find an offline script or library to do this. That site/service seems to use potrace on the backend. However, for some reason if I use potrace myself the generated SVGs, while perfectly functional vector graphics files, are not recognized by Tinkercad or a few other offline CAD tools I've tried.

Supposedly autotrace is cleaner and better than potrace, but I had trouble getting it built and installed on my system. I might come back and retry that later.

The free version of the online-convert API only allows 30 conversion jobs per day, so be careful. Do some math to set your variables in mkmags.sh and test. Then test some more. Then test again.

You can also do manual conversions through the website using your browser, and I don't think there's any limitation on that.

It's a pretty useful service, so if you have a legit need for it and can afford it, consider a premium subscription.

### Import SVGs to CAD, create STLs
* Manually add holes the size of your magnets (mine are 1/4" x 1/16" nickel/neodymium discs) to the bottom side of each character.
* I'm using TinkerCad for this right now, but I'd like to possibly automate it later using OpenSCAD or some other process that finds the largest contiguous area and carves out a hole in the center for the magnet.
* If you're using all of my defaults, you should import the SVGs to Tinkercad at 20% Scale and 5mm Height.

## Time & dimension estimations **~6 hours total**:

#### Writing & scanning template: **5-15min**

#### Edting & cleanup: **5-15 min** (maybe more if source image is rough)

#### Creating images (jpg, convert to svg): **1-5 min**
* (mkmags.sh and/or manual website)
* **Font Size 240**

#### Creating STLs with holes: **20min**
* **5mm thick, 50mm tall, 210mm wide**
* Tinkercad import 5mm tall, 20% scale ***FIND A WAY TO SCRIPT SVG->STL WITH THESE SETTINGS!***
* Move magnet holes underneath (Cylinder d=6.6mm, h=1.6mm)
* Export to STL

#### Printing: **~4-5hrs per set**
* Rotate Y-180deg so no support is needed for the holes
* I skew it a about 2cm left, because my printer is not well-centered. You should probably calibrate your bot rather than do what I do.
* Experiment with print settings & speed to bring down time. Let me know what settings you use. I used 20% infill, 3 shells, and 0.3mm layers. Anything higher was better seemed like overkill, and anything worse didn't seem to have the weight you'd want in a fridge magnet.

#### Assembly: **5-10min per set**
I used two methods to affix the magnets (how to they work? IT'S A MIRACLE!), both of which seem to work equally well:

* Hammer (quicker method): Put a dab of liquid superglue in the hole, and gently place the magnet on top of the hole, then firmly but gently hammer it in with one motion, swiping the hammer to the side before pulling it off the piece to prevent bringing the magnet back up stuck to the hammer.
* Crimper (less accident-prone method): I have an old Scotchlok crimper that came over on the Mayflower with my dad that worked perfectly for this. Just put a dab of glue in the hole, magnetize the magnet to the inside top of the crimper, and then firmly crimp it into the hole. Again, slide the tool off to the side before pulling it away in case the magnet wants to stay stuck to it.


## Current Etsy Pricing (preliminary, might change)
I know it's kinda gauche to talk about money on Github & Thingiverse, but I'm trying to be transparent. I'd also like input on what seems fair. I'm not a lawyer, and I can't afford one, so if I'm violating some TOSes (TsOS?), please politely let me know rather than being a jerk and reporting me to somebody who can.

### Needs more research:
* Common distributions for writing words?
* Scrabble sets?
* Fair-but-profitable pricing? Check etsy & amazon for similar products

### (1) Alphanumeric set, single color, single font: **$60**
### (1) Alphanumeric set, 2-color, single font: **$80**
### (2) Alphanumeric sets, single color, single font: **$90**
### (2) Alphanumeric sets, 2-color, single font: **$110**
### (2) Alphanumeric sets, 3-color, single font: **$120**

## Notes & TODOs
* Automate/script the GIMP filters
* online-convert.com API key: ~/.online-convert
* Would be better to find a library to replace the API call to online-convert.com to remove the dependency (API only allows 30 conversions per day)
* online-convert.com uses potrace, so why doesn't potrace work offline for me? It generates a valid SVG, but the format is not recognized by Tinkercad
* Use autotrace rather than potrace?
* Find a way to programmatically find the largest spot for the magnet. OpenSCAD?
