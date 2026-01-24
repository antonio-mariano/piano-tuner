# Piano Tuner (MATLAB)

This project implements an helper tool for piano tuning.  
Its purpose is to detect small frequency differences between strings of the same note, which create the characteristic “beating” effect. The analysis is performed both in the frequency domain—by inspecting the spectral content—and in the time domain, by examining the envelope of the signal.

The tool estimates detuning in both Hz and cents (1 cent = 1% of the distance to the next semitone) and presents the results in clear visual form.

The code is modular, easy to read, and suitable for experimentation or further development.

---

## Project Structure

```
│
├── Main.m                     % Main script
├── filtro_mm.m                % Moving‑mean low‑pass filter
├── filtro_narrowband.m        % Narrowband IIR band‑pass filter
├── harmonics.m                % Estimates harmonic frequencies
├── plot_envelope_freq.m       % Computes and plots envelope frequency
├── plot_difference_freq.m     % Computes and plots peak‑difference
├── reliable_mean.m            % Robust mean estimator
├── spectrum.m                 % Helper for spectrum visualization
│
├── dataset/                   % Audio files
└── img/                       % Output example plots
```

---

## How to Use

1. Record an out‑of‑tune piano note and place the audio file inside the `dataset/` folder  
   (use `.wav` if your MATLAB version is older than 2018).
2. Edit the file name in `Main.m`, for example:  
   ```matlab
   audioread('dataset/your_file.ogg');
   ```
3. Run the script:
   ```matlab
   Main
   ```

---

## What the Program Does

### Harmonic estimation
The signal is analyzed in the frequency domain to identify the strongest three harmonic components of the note.

### Envelope analysis
The tuner measures the slow amplitude modulation caused by slightly detuned strings, which produces the audible beating.

### Peak‑difference analysis
The script finds the two most separated peaks around each harmonic and reports the difference in Hz and cents.

The plots make it easy to see whether a note is stable or producing noticeable beating.  
When beating is present, the tool indicates which string is flat or sharp, helping determine the direction to move the tuning hammer.

---

## Requirements

This project was developed and tested using:

- MATLAB R2019a  
- Signal Processing Toolbox 8.2  

### Minimum recommended version

- MATLAB R2018a  
- Signal Processing Toolbox R2018a  

All functions used (`findpeaks`, `designfilt`, `lowpass`, `envelope`, `movmean`) are available from R2018a onward.

---


