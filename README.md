# EC551_Final_Project -- FPGA Synthesizer + Musix Box

## Full Demo Link:
https://drive.google.com/file/d/1S3SE2koBkpDHM0XWziQEpQ2eJBbI3GJV/view?usp=share_link

### I/O:
1. Keyboard input
2. Mode toggle switch
3. Speaker output
4. VGA display

### Functions:
1. Input music notes C3~C6 from the keyboard, which supports square waves and sine waves.
2. Allow up to three notes entered at the same time to form a chord.
3. Play four songs stored in the memory.
4. VGA that shows several music sheets and displays the input note and system mode in real time.

### Final_Project Folder
This folder contains the code for testing and generating sine waves. The "Sine_Gen" module uses previously calculated values for the sine wave values and the "Sine_TaylorSeries" module generates the sine waves using a Taylor Series. The sine wave outputs get fed into the "Duty_Cycler" module to adjust the duty cycle of the input to the PWM output. The shorter the duty cycle, the lower the output and vice versa, thus the sine wave output stretches the range of the duty cycle.

### VGA_Notes Folder
This folder contains modules for VGA display. It has a VGA controller provided by the EC551 lab, which generates horizontal and vertical timing signals. The VGA module is connected to a font_terminal, which gets the horizontal and vertical location of the pixel and the encoded character which will be displayed. The address bus is driven into the character memory and the corresponding data is fetched. In the end, the VGA module will output the RGB value based on the desired pixel location. The VGA module is clocked with mode switch input and user keyboard input to refresh the information on the screen in real time.

### KeyboardMusicBox Folders
#### V1:
One Octave and two songs (Twinkle Twinkle Little Star and Ode To Joy)

#### V2:
Three Octaves and four songs (Twinkle Twinkle Little Star, Ode To Joy, Jasmine, Old MacDonald)

#### V3:
V2 + VGA Integration which displays current note being played, Keyboard/MusicBox Mode, and keys to play the four music box songs

### SynthesizerMusicBox_Final Use Instructions
#### Keyboard Mode:
The FPGA will start in Square Wave Keyboard Mode. Press Keys Q-O for C3-C4, A-K for C4 to C5, and Z-, for C5-C6

To switch to Sine Wave Keyboard Mode for chords flip the SW switch (default L16). In Sine Wave Keyboard Mode, any keys in the C4-C5 range can be pressed seperatly or together to form chords

#### Music Box Mode:
To enter Music Box Mode, flip the musicBox switch (default J15). In Music Box Mode, you can press any of the four outer buttons on the FPGA to play a select song in memory

**Top**: Twinkle Twinkle Little Star

**Right**: Ode To Joy

**Bottom**: Jasmine

**Left**: Old MacDonald

To stop a song, press the center button
