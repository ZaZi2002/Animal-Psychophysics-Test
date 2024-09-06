# Psychophysical Test: Animal or Not
![IMG_E3659](https://github.com/user-attachments/assets/403d203e-c8e1-4476-8d48-f3c88dc0a4ea)

## Overview

This MATLAB script conducts a psychophysical test using Psychtoolbox in MATLAB where participants are shown images and must determine whether the image contains an animal. The script is designed to run a series of trials and collect data on participant responses.

## Features

- Loads images from multiple directories, categorized by type and condition.
- Presents images to the participant with noise and inter-stimulus intervals.
- Collects and records participant responses, accuracy, and response times.
- Provides feedback to the participant based on their responses.
- Saves results and calculates accuracy and response times for each category.

## Requirements

- MATLAB with Psychtoolbox
- Image files in specific directories (H_a, H_d, C_a, C_d, M_a, M_d, F_a, F_d)

## Files

- `AnimalOrnot.m`: Main script for running the experiment.
- `measurements.m`: Function for saving results and calculating accuracy and response times.

## Setup

1. **Prepare Directories**: Ensure the following directories exist in your working directory and contain images:
    - `H_a`: Images of Head with Animal
    - `H_d`: Images of Head without Animal
    - `C_a`: Images of Close Body with Animal
    - `C_d`: Images of Close Body without Animal
    - `M_a`: Images of Medium Body with Animal
    - `M_d`: Images of Medium Body without Animal
    - `F_a`: Images of Far Body with Animal
    - `F_d`: Images of Far Body without Animal

2. **Install Psychtoolbox**: Ensure Psychtoolbox is installed and properly configured in MATLAB.

## Function Descriptions

### `AnimalOrnot`

This is the main function that conducts the experiment. It performs the following tasks:

- **Data Reading**: Loads images from directories corresponding to different conditions (e.g., Head with Animal, Close Body without Animal).
- **Trial Making**: Creates arrays of trials by categorizing images into different trial sets.
- **Trial Defining**: Selects a specific trial set based on the provided trial number.
- **Screen Setup**: Initializes the Psychtoolbox screen for displaying stimuli.
- **Keyboard Input**: Defines keys for participant responses (e.g., LeftArrow for "Animal", RightArrow for "Not Animal").
- **Epoch Durations**: Sets durations for image presentation and inter-stimulus intervals.
- **Noise Filter**: Creates and displays a procedural noise texture.
- **Text Features**: Configures text display for instructions and feedback.
- **Main Loop**: Runs the experiment loop where images are shown, responses are collected, and feedback is provided.
- **Measurements**: Calls the `measurements` function to save results and calculate accuracy and response times.
- **Quit Message**: Displays a message prompting the participant to quit the experiment.

#### Parameters

- `subject_name` (string): Name of the participant.
- `n` (integer): Trial number (1, 2, or 3) specifying which set of trials to use.
- `image_counts` (integer): Number of images to use in the trial.

#### Example Usage

```matlab
AnimalOrnot("Participant1", 2, 4);
