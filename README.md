# EC551_Final_Project -- FPGA Synthesizer + Musix Box

### I/O:
1. Keyboard Input
2. Mode Switch
3. Speaker output
4. VGA display

### Functions:
1. Input music notes C3~C6 from the keyboard, which supports square waves and sine waves.
2. Allow up to three notes entered at the same time to form a chord.
3. Play four songs stored in the memory.
4. VGA that shows music sheets and displays the input notes in real time.

### Final_Project Folder
This folder contains the code for testing and generating sine waves. The "Sine_Gen" module uses previously calculated values for the sine wave values and the "Sine_TaylorSeries" module generates the sine waves using a Taylor Series. The sine wave outputs get fed into the "Duty_Cycler" module to adjust the duty cycle of the input to the PWM output. The shorter the duty cycle, the lower the output and vice versa, thus the sine wave output stretches the range of the duty cycle.

### Demo Link:
