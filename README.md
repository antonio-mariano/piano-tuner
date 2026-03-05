# 🎹 Piano Tuner – Real‑Time Detuning and Beating Analysis

A MATLAB tool for analyzing and tuning piano notes by detecting small frequency differences between strings of the same note. These differences create the characteristic *beating* effect heard when a note is slightly out of tune.

The system combines frequency‑domain and time‑domain analysis to estimate detuning in **Hz** and **cents**, and presents the results through clear, intuitive visualizations, that help you in the tuning process.

The code is modular and easy to extend. Contributions are welcome!

<p align="center">
  <img src="https://img.shields.io/badge/MATLAB-F58025?style=for-the-badge&logo=mathworks&logoColor=white">
  <img src="https://img.shields.io/badge/Signal%20Processing%20Toolbox-0076A8?style=for-the-badge">
</p>

---

## 📌 Project Overview

Most piano notes are produced by **three strings** tuned to the same frequency.  
When one string drifts slightly sharp or flat, the interference between them creates a slow amplitude modulation — the *beating effect*.

This tool analyzes a recorded piano note to:

- Identify the three strongest harmonic components  
- Measure the beating frequency using envelope analysis  
- Detect peak differences in the spectrum  
- Estimate detuning in **Hz** and **cents**  
- Provide clear visualizations to support tuning decisions  

The workflow is illustrated below:

![Workflow](/images/workflow.png)

---

## ✨ Features

- Automatic detection of the three dominant harmonic components  
- Envelope‑based estimation of beating frequency  
- Narrowband spectral analysis around each harmonic  
- Detuning measurement in **Hz** and **cents**  
- Clear plots designed to help with practical tuning  

---

## ▶️ Example Run

The figure below shows the analysis of the note `dataset/A4.ogg`.  
In the top‑right plot, only one of the three strings is correctly tuned to 440 Hz, while the other two are slightly lower.  
The left‑side plots show the amplitude oscillation that would be heard when playing the note — the *beating effect*.

![Example result of analysis](images/A4_example.png)

---

## 🚀 How to Use

1. **Record a piano note** (preferably one that is slightly out of tune) and place the audio file in the `dataset/` folder.  
   - Use `.wav` if you are working with an older MATLAB version.

2. **Edit the file name** in `Main.m`:
   ```matlab
   audioread('dataset/your_file.ogg');


---

## 📈 What the Program Analyzes
### Harmonic Estimation
The signal is transformed into the frequency domain, and the three strongest harmonic peaks are identified. These serve as reference points for the rest of the analysis.

### Envelope Analysis
Slightly detuned strings produce a slow amplitude modulation.
The tool extracts the envelope and estimates the beating frequency, which corresponds to the detuning between strings.

### Peak‑Difference Analysis
For each harmonic, two nearby spectral peaks are detected.
Their separation gives the detuning:

In Hz — absolute frequency difference

In cents — musical interval relative to the next semitone

This helps determine whether the note is stable or producing audible beating, and whether a string is sharp or flat.

---

## 💻 Requirements
Development environment
MATLAB R2019a

Signal Processing Toolbox 8.2

Minimum recommended version
MATLAB R2018a

Signal Processing Toolbox R2018a

All required functions (findpeaks, designfilt, lowpass, envelope, movmean) are available from R2018a onward.

