CMake AVR
=========

Note: this project extends the orginal by acristoffers with some tweaks to make this work with Windows, and now supports programming using dfu-programmer. Be sure to set the directories for the binaries!

This project sets up a CMake project to compile AVR C/C++ source code.

It was made to be used with ATMega328P, but can be configured to others (easily, I think, just change some variables in the file).

It can:

- compile the code
- upload (flash) using avrdude (or other if changed a bit)
- reset the microcontroller
- change fuses (1mhz/8mhz/16mhz/uno-like)
- set/clear eeprom fuse (enable/disable eeprom persistence)

For a list of functionalities, look at the end of file for the bunch of `add_custom_target`.

Blink
-----

Contains a basic standalone example. It's folder structure is:

- src: put the project source files here. Meant only to C/C++/ASM files (supported extensions: .c .cpp .cc .cxx .S .sx .asm).
- include: put the project header files here.
- lib: create folders for each added libraries inside this folder. Add C/C++ and header files all together inside the library folder.

Arduino
-------

The Arduino folder contains a project that compiles a blink sample.

Open the CMakeLists.txt and uncomment on the beginning to use standard libraries. They are all disabled by default because they get in the final code, even if not used, making the code bigger. Because of that, only activate what you need.

Four libraries are missing in the Arduino subfolder. See the MISSING file for more info. The other folders follow the Blink convention.
