#!/bin/bash

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt install software-properties-common -y
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt -y upgrade

sudo apt install ros-humble-ros-base -y
sudo apt install python3-colcon-common-extensions -y

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc

mkdir -p ldlidar_ros2_ws/src
sudo apt -y install git
cd ~/ldlidar_ros2/src
git clone https://github.com/ldrobotSensorTeam/ldlidar_stl_ros2.git

sudo chmod 777 /dev/ttyUSB*

cd ~/ldlidar_ros2_ws
colcon build

cd ~/ldlidar_ros2_ws
souce install/setup.bash

sudo apt-get install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y

sudo apt install build-essential cmake gcc-arm-none-eabi libnewlib-arm-none-eabi doxygen git python3 -y
mkdir -p ~/micro_ros_ws/src
cd ~/micro_ros_ws/src
git clone --recurse-submodules https://github.com/raspberrypi/pico-sdk.git
git clone https://github.com/micro-ROS/micro_ros_raspberrypi_pico_sdk.git

cd ~/micro_ros_ws/src/micro_ros_raspberrypi_pico_sdk
mkdir .vscode
echo "{
    "cmake.configureEnvironment": {
        "PICO_SDK_PATH": "/home/$USER/micro_ros_ws/src/pico-sdk",
    },
}" >> .vscode/settings.json

echo "code .

Before running the CMake configuration and building it, we must select the appropriate ‘kit’ (maybe VSCode has already asked you to do so). Open the palette (ctrl+shift+p) and search for CMake: Scan for Kits and then CMake: Select a Kit and make sure to select the compiler we’ve installed above, that is GCC for arm-non-eabi.

We’re all set, let us build the example! Open the palette again and hit CMake: Build." >> .vscode/build_pico.txt

echo "code .

Before running the CMake configuration and building it, we must select the appropriate ‘kit’ (maybe VSCode has already asked you to do so). Open the palette (ctrl+shift+p) and search for CMake: Scan for Kits and then CMake: Select a Kit and make sure to select the compiler we’ve installed above, that is GCC for arm-non-eabi.

We’re all set, let us build the example! Open the palette again and hit CMake: Build."
