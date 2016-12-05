# PROYECTOMIR UNIAJC

## Table of Contents

* [Description](README.md#description)
* [Requirements](README.md#requirements)
* [Installation](README.md#installation)
* [Maintainers](README.md#maintainers)
* [Credits](README.md#credits)

## Description

A set of tools to analyze and visualize Music Information Retrieval algorithms over Pop-Music Audio signals.

This Source is organized as follows:

1) The principal Graphic user interface (GUI), GUI_UNIAJC_MIR.m/fig, has four buttons addressing to four MIR modules: Tonal, Beat Tracking, Chord Recognition, and Melody Recognition. 

2) Each module resides in its own folder, however resources are shared from the same folders such as Resources folder and MIRLib folder.

3) Resource folder contains icons and images for all the GUI's.

4) MIRLib folder has basic functions for MIR algorithm implementations. General [Audio Content Analysis] (http://www.audiocontentanalysis.org/), [Chroma Calculations] (http://www.ee.columbia.edu/ln/rosa/matlab/chroma-ansyn/) and [Beat tracking] (http://labrosa.ee.columbia.edu/projects/coversongs/) libraries has been downloaded and adapted for this project. 

If you are using PROECTOMIR UNIAJC in an academic context, please cite our work. 

## Requirements

### Hardware requirements

* PC with 4 GB RAM (or higher). 
* Intel Core i5 Processor or later. 
* 5 GB of free disk space.

### Software requirements

* Windows 8 or later.
* Matlab 2012b or later.

## Maintainers

* Carlos Rodriguez (Director/master branch)
* Ruben Corrales (Audio Synthesis Scientist)
* Jorge Corrales (Musicology)
* Carlos Ferrin (MIR expert/Development/master branch)

## Installation

### Windows

* Install UsbDk driver

    1. (Windows 7) You must first install Microsoft Security Advisory 3033929 otherwise your USB keyboards and mice will stop working!
    2. Download the latest x64 installer from https://github.com/daynix/UsbDk/releases, install it.
    3. If UsbDk somehow does not work, uninstall UsbDk and follow the libusbK instructions.

## Credits

This project has been supported by the Colombian Goverement Bureau for Science, COLCIENCIAS. 
