<<<<<<< HEAD
<<<<<<< HEAD
# JMeter Guidence
# Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
    * [Java OpenJDK](#java-openjdk)
    * [Apache JMeter](#apache-jmeter)
    * [Property File Reader](#install-property-file-reader)
3. [Change ENV Properties](#change-env-properties)
4. [Properties](#properties)

# Requirements
1. Java OpenJDK (can be download via apt) - [Java OpenJDK Download Page](https://www.oracle.com/java/technologies/downloads/)
2. Apache JMeter (can be download via wget) - [JMeter Download Page](https://jmeter.apache.org/download_jmeter.cgi)

# Installation
## Java OpenJDK
Open terminal and use this command
```sh
# To see all available editions of OpenJDK, search the apt libraries use
apt-cache search openjdk

# Here using openjdk-21-jdk
sudo apt install openjdk-21-jdk -y
```
Wait until installation complete then check the installation result using command `java -version`

## Apache JMeter
  1. First, check on the download page to get the latest version.  
      Open terminal and run this command
      ```sh
      # Here using apache-jmeter-5.6.3
      wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
      ```
  2. Then Extract the downloaded tgz file.
      ```sh
      # Extract the downloaded tar file:
      tar -xvzf apache-jmeter-5.5.tgz
      ```
  3. Move JMeter to a Preferred Location.
      ```sh
      # Here move it to preferred location it can be anywhere based on your preferences
      mv apache-jmeter-5.5 ~/CodeU/apache-jmeter
      ```
  4. Set Environment Variables.
      * To make it easier to run JMeter, you can set environment variables by editing the .bashrc file:
        ```sh
        nano ~/.bashrc
        ```
      * Add the following lines at the end of the file, remember the JMETER_HOME should be same as your preferred location of your JMeter.
        ```sh
        export JMETER_HOME=~/CodeU/apache-jmeter
        export PATH=$JMETER_HOME/bin:$PATH
        ```
      * Save the file and reload the .bashrc file:
        ```sh
        source ~/.bashrc
        ```
  5. Verify JMeter Installation:
      * Run the following command to verify the installation:
        ```sh
        jmeter -v
        ```
        You should see the JMeter version details, it means installation success
  6. Run JMeter:
      Since we already set the path we can open JMeter on any location, run
      ```sh
      jmeter
      ```
      It should open the JMeter GUI.

## Install Property File Reader
  1. Copy `tag-jmeter-extn-1.1.jar` 
  2. Paste to `..\JMeter\apache-jmeter-5.6.3\lib\ext`
  3. Restart terminal and JMeter

# Change Env Properties
  1. Open Jmeter - go to apache-jmeter folder - on terminal "open bin/jmeter"
  2. Open Test Plan `jmx_file.jmx`
  3. Change variable ENV:
    a. `staging` = staging enviroment config and global variable
  nb: `staging` equal to folder inside properties folder

# Properties
  1. `env_config.properties` = config for enviroment such as host or base url, port, sql, etc
=======
# JMeter Guidence
# Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
    * [Java OpenJDK](#java-openjdk)
    * [Apache JMeter](#apache-jmeter)
    * [Property File Reader](#install-property-file-reader)
3. [Change ENV Properties](#change-env-properties)
4. [Properties](#properties)

# Requirements
1. Java OpenJDK (can be download via apt) - [Java OpenJDK Download Page](https://www.oracle.com/java/technologies/downloads/)
2. Apache JMeter (can be download via wget) - [JMeter Download Page](https://jmeter.apache.org/download_jmeter.cgi)

# Installation
## Java OpenJDK
Open terminal and use this command
```sh
# To see all available editions of OpenJDK, search the apt libraries use
apt-cache search openjdk

# Here using openjdk-21-jdk
sudo apt install openjdk-21-jdk -y
```
Wait until installation complete then check the installation result using command `java -version`

## Apache JMeter
  1. First, check on the download page to get the latest version.  
      Open terminal and run this command
      ```sh
      # Here using apache-jmeter-5.6.3
      wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
      ```
  2. Then Extract the downloaded tgz file.
      ```sh
      # Extract the downloaded tar file:
      tar -xvzf apache-jmeter-5.5.tgz
      ```
  3. Move JMeter to a Preferred Location.
      ```sh
      # Here move it to preferred location it can be anywhere based on your preferences
      mv apache-jmeter-5.5 ~/CodeU/apache-jmeter
      ```
  4. Set Environment Variables.
      * To make it easier to run JMeter, you can set environment variables by editing the .bashrc file:
        ```sh
        nano ~/.bashrc
        ```
      * Add the following lines at the end of the file, remember the JMETER_HOME should be same as your preferred location of your JMeter.
        ```sh
        export JMETER_HOME=~/CodeU/apache-jmeter
        export PATH=$JMETER_HOME/bin:$PATH
        ```
      * Save the file and reload the .bashrc file:
        ```sh
        source ~/.bashrc
        ```
  5. Verify JMeter Installation:
      * Run the following command to verify the installation:
        ```sh
        jmeter -v
        ```
        You should see the JMeter version details, it means installation success
  6. Run JMeter:
      Since we already set the path we can open JMeter on any location, run
      ```sh
      jmeter
      ```
      It should open the JMeter GUI.

## Install Property File Reader
  1. Copy `tag-jmeter-extn-1.1.jar` 
  2. Paste to `..\JMeter\apache-jmeter-5.6.3\lib\ext`
  3. Restart terminal and JMeter

# Change Env Properties
  1. Open Jmeter - go to apache-jmeter folder - on terminal "open bin/jmeter"
  2. Open Test Plan `jmx_file.jmx`
  3. Change variable ENV:
    a. `staging` = staging enviroment config and global variable
  nb: `staging` equal to folder inside properties folder

# Properties
  1. `env_config.properties` = config for enviroment such as host or base url, port, sql, etc
>>>>>>> 1c2c74a0534084be0519f88a3ab8e6f4f69ecb30
=======
# JMeter Guidence
# Table of Contents
1. [Requirements](#requirements)
2. [Installation](#installation)
    * [Java OpenJDK](#java-openjdk)
    * [Apache JMeter](#apache-jmeter)
    * [Property File Reader](#install-property-file-reader)
3. [Change ENV Properties](#change-env-properties)
4. [Properties](#properties)

# Requirements
1. Java OpenJDK (can be download via apt) - [Java OpenJDK Download Page](https://www.oracle.com/java/technologies/downloads/)
2. Apache JMeter (can be download via wget) - [JMeter Download Page](https://jmeter.apache.org/download_jmeter.cgi)

# Installation
## Java OpenJDK
Open terminal and use this command
```sh
# To see all available editions of OpenJDK, search the apt libraries use
apt-cache search openjdk

# Here using openjdk-21-jdk
sudo apt install openjdk-21-jdk -y
```
Wait until installation complete then check the installation result using command `java -version`

## Apache JMeter
  1. First, check on the download page to get the latest version.  
      Open terminal and run this command
      ```sh
      # Here using apache-jmeter-5.6.3
      wget https://downloads.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz
      ```
  2. Then Extract the downloaded tgz file.
      ```sh
      # Extract the downloaded tar file:
      tar -xvzf apache-jmeter-5.5.tgz
      ```
  3. Move JMeter to a Preferred Location.
      ```sh
      # Here move it to preferred location it can be anywhere based on your preferences
      mv apache-jmeter-5.5 ~/CodeU/apache-jmeter
      ```
  4. Set Environment Variables.
      * To make it easier to run JMeter, you can set environment variables by editing the .bashrc file:
        ```sh
        nano ~/.bashrc
        ```
      * Add the following lines at the end of the file, remember the JMETER_HOME should be same as your preferred location of your JMeter.
        ```sh
        export JMETER_HOME=~/CodeU/apache-jmeter
        export PATH=$JMETER_HOME/bin:$PATH
        ```
      * Save the file and reload the .bashrc file:
        ```sh
        source ~/.bashrc
        ```
  5. Verify JMeter Installation:
      * Run the following command to verify the installation:
        ```sh
        jmeter -v
        ```
        You should see the JMeter version details, it means installation success
  6. Run JMeter:
      Since we already set the path we can open JMeter on any location, run
      ```sh
      jmeter
      ```
      It should open the JMeter GUI.

## Install Property File Reader
  1. Copy `tag-jmeter-extn-1.1.jar` 
  2. Paste to `..\JMeter\apache-jmeter-5.6.3\lib\ext`
  3. Restart terminal and JMeter

# Change Env Properties
  1. Open Jmeter - go to apache-jmeter folder - on terminal "open bin/jmeter"
  2. Open Test Plan `jmx_file.jmx`
  3. Change variable ENV:
    a. `staging` = staging enviroment config and global variable
  nb: `staging` equal to folder inside properties folder

# Properties
  1. `env_config.properties` = config for enviroment such as host or base url, port, sql, etc
>>>>>>> 2666d2b90b8d2b665c3dbd746426f3cfe9063f60
  2. `env_var.properties` = enviroment variable such as token, open api credentials, etc