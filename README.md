# PROYECTOMIR UNIAJC

## Table of Contents

* [Description](README.md#description)
* [Requirements](README.md#requirements)
* [Installation](README.md#installation)
* [Maintainers](README.md#maintainers)

## Description

A set of tools to analyze and visualize Music Information Retrieval algorithms over Pop-Music Audio signals.

This Source is organized as follows:

1) The principal Graphic user interface (GUI), GUI_UNIAJC_MIR.m/fig, has four buttons addressing to four MIR modules: Tonal, Beat Tracking, Chord Recognition, and Melody Recognition. 
2) Each module resides in its own folder, however resources are shared from the same folders such as Resources folder and MIRLib folder.
3) Resource folder contains icons and images for all the GUI's.
4) MIRLib folder has basic functions for MIR algorithm implementations. Generla Audio Content Analysis (DOI: [![DOI](http://www.audiocontentanalysis.org/)), Chroma Calculations and Beat tracking has been compiled from differents place on the web.

If you are using libfreenect2 in an academic context, please cite our work using the following DOI: [![DOI](https://zenodo.org/badge/20096/OpenKinect/libfreenect2.svg)](https://zenodo.org/badge/latestdoi/20096/OpenKinect/libfreenect2)

If you use the KDE depth unwrapping algorithm implemented in the library, please also cite this ECCV 2016 [paper](http://users.isy.liu.se/cvl/perfo/abstracts/jaremo16.html).

This driver supports:
* RGB image transfer
* IR and depth image transfer
* registration of RGB and depth images

Missing features:
* firmware updates (see [issue #460](https://github.com/OpenKinect/libfreenect2/issues/460) for WiP)

Watch the OpenKinect wiki at www.openkinect.org and the mailing list at https://groups.google.com/forum/#!forum/openkinect for the latest developments and more information about the K4W2 USB protocol.

The API reference documentation is provided here https://openkinect.github.io/libfreenect2/.

## Requirements

### Hardware requirements

* USB 3.0 controller. USB 2 is not supported.

Intel and NEC USB 3.0 host controllers are known to work. ASMedia controllers are known to not work.

Virtual machines likely do not work, because USB 3.0 isochronous transfer is quite delicate.


## Maintainers

* Joshua Blake <joshblake@gmail.com>
* Florian Echtler
* Christian Kerl
* Lingzhu Xiang (development/master branch)

## Installation

### Windows

* Install UsbDk driver

    1. (Windows 7) You must first install Microsoft Security Advisory 3033929 otherwise your USB keyboards and mice will stop working!
    2. Download the latest x64 installer from https://github.com/daynix/UsbDk/releases, install it.
    3. If UsbDk somehow does not work, uninstall UsbDk and follow the libusbK instructions.

    This doesn't interfere with the Microsoft SDK. Do not install both UsbDK and libusbK drivers
* (Alternatively) Install libusbK driver

    You don't need the Kinect for Windows v2 SDK to build and install libfreenect2, though it doesn't hurt to have it too. You don't need to uninstall the SDK or the driver before doing this procedure.

    Install the libusbK backend driver for libusb. Please follow the steps exactly:

    1. Download Zadig from http://zadig.akeo.ie/.
    2. Run Zadig and in options, check "List All Devices" and uncheck "Ignore Hubs or Composite Parents"
    3. Select the "Xbox NUI Sensor (composite parent)" from the drop-down box. (Important: Ignore the "NuiSensor Adaptor" varieties, which are the adapter, NOT the Kinect) The current driver will list usbccgp. USB ID is VID 045E, PID 02C4 or 02D8.
    4. Select libusbK (v3.0.7.0 or newer) from the replacement driver list.
    5. Click the "Replace Driver" button. Click yes on the warning about replacing a system driver. (This is because it is a composite parent.)

    To uninstall the libusbK driver (and get back the official SDK driver, if installed):

    1. Open "Device Manager"
    2. Under "libusbK USB Devices" tree, right click the "Xbox NUI Sensor (Composite Parent)" device and select uninstall.
    3. Important: Check the "Delete the driver software for this device." checkbox, then click OK.

    If you already had the official SDK driver installed and you want to use it:

    4. In Device Manager, in the Action menu, click "Scan for hardware changes."

    This will enumerate the Kinect sensor again and it will pick up the K4W2 SDK driver, and you should be ready to run KinectService.exe again immediately.

    You can go back and forth between the SDK driver and the libusbK driver very quickly and easily with these steps.

* Build libusb

    Open a Git shell (GitHub for Windows), or any shell that has access to git.exe and msbuild.exe
    ```
cd depends/
.\install_libusb_vs2013.cmd
```
    Or `install_libusb_vs2015.cmd`. If you see some errors, you can always open the cmd files and follow the git commands, and maybe build `libusb_201x.sln` with Visual Studio by hand. Building with "Win32" is not recommended as it results in lower performance.
* Install TurboJPEG

    Download from http://sourceforge.net/projects/libjpeg-turbo/files, extract it to `c:\libjpeg-turbo64` or `depends/libjpeg-turbo64`, or anywhere as specified by the environment variable `TurboJPEG_ROOT`.
* Install GLFW

    Download from http://www.glfw.org/download.html (64-bit), extract as `depends/glfw` (rename `glfw-3.x.x.bin.WIN64` to `glfw`), or anywhere as specified by the environment variable `GLFW_ROOT`.
* Install OpenCL (optional)
    1. Intel GPU: Download "Intel® SDK for OpenCL™ Applications 2016" from https://software.intel.com/en-us/intel-opencl (requires free registration) and install it.
* Install CUDA (optional, Nvidia only)
    1. Download CUDA Toolkit and install it. NOTE: CUDA 7.5 does not support Visual Studio 2015.
* Install OpenNI2 (optional)

    Download OpenNI 2.2.0.33 (x64) from http://structure.io/openni, install it to default locations (`C:\Program Files...`).
* Build

    The default installation path is `install`, you may change it by editing `CMAKE_INSTALL_PREFIX`.
    ```
mkdir build && cd build
cmake .. -G "Visual Studio 12 2013 Win64"
cmake --build . --config RelWithDebInfo --target install
```
    Or `-G "Visual Studio 14 2015 Win64"`.
* Run the test program: `.\install\bin\Protonect.exe`, or start debugging in Visual Studio.
* Test OpenNI2 (optional)

    Copy freenect2-openni2.dll, and other dll files (libusb-1.0.dll, glfw.dll, etc.) in `install\bin` to `C:\Program Files\OpenNI2\Tools\OpenNI2\Drivers`. Then run `C:\Program Files\OpenNI\Tools\NiViewer.exe`. Environment variable `LIBFREENECT2_PIPELINE` can be set to `cl`, `cuda`, etc to specify the pipeline.

### Mac OSX

Use your favorite package managers (brew, ports, etc.) to install most if not all dependencies:

* Make sure these build tools are available: wget, git, cmake, pkg-config. Xcode may provide some of them. Install the rest via package managers.
* Download libfreenect2 source

    ```
git clone https://github.com/OpenKinect/libfreenect2.git
cd libfreenect2
```
* Install dependencies: libusb, GLFW

```
brew update
brew install libusb
brew tap homebrew/versions
brew install glfw3
```
* Install TurboJPEG (optional)

    ```
brew tap homebrew/science
brew install jpeg-turbo
```
* Install CUDA (optional): TODO
* Install OpenNI2 (optional)

    ```
brew install openni2
export OPENNI2_REDIST=/usr/local/lib/ni2
export OPENNI2_INCLUDE=/usr/local/include/ni2
```
* Build

    - Verify: You can install `clinfo` to verify if you have correctly set up the OpenCL stack.
* Install CUDA (optional, Nvidia only):
    - (Ubuntu 14.04 only) Download `cuda-repo-ubuntu1404...*.deb` ("deb (network)") from Nvidia website, follow their installation instructions, including `apt-get install cuda` which installs Nvidia graphics driver.
    - (Jetson TK1) It is preloaded.
    - (Nvidia/Intel dual GPUs) After `apt-get install cuda`, use `sudo prime-select intel` to use Intel GPU for desktop.
    - (Other) Follow Nvidia website's instructions.
* Install VAAPI (optional, Intel only)
    1. (Ubuntu 14.04 only) `sudo dpkg -i debs/{libva,i965}*deb; sudo apt-get install -f`
    2. (Other) `sudo apt-get install libva-dev libjpeg-dev`
    3. Linux kernels 4.1 to 4.3 have performance regression. Use 4.0 and earlier or 4.4 and later (Though Ubuntu kernel 4.2.0-28.33~14.04.1 has backported the fix).
* Install OpenNI2 (optional)
    1. (Ubuntu 14.04 only) `sudo apt-add-repository ppa:deb-rob/ros-trusty && sudo apt-get update` (You don't need this if you have ROS repos), then `sudo apt-get install libopenni2-dev`
    2. (Other) `sudo apt-get install libopenni2-dev`.
* Build

    ```
cd ..
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2
make
make install
```
    You need to specify `cmake -Dfreenect2_DIR=$HOME/freenect2/lib/cmake/freenect2` for CMake based third-party application to find libfreenect2.
* Set up udev rules for device access: `sudo cp ../platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/`, then replug the Kinect.
* Run the test program: `./bin/Protonect`
* Run OpenNI2 test (optional): `sudo apt-get install openni2-utils && sudo make install-openni2 && NiViewer2`. Environment variable `LIBFREENECT2_PIPELINE` can be set to `cl`, `cuda`, etc to specify the pipeline.
