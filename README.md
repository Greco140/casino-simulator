# What is it?

Tool developed at Marcelo Vázquez's Hack4u Academy (Aka. S4vitar) during the Introduction to Linux course to practice bash scripting and simulate a roulette in a Casino.

## Example
![Options](/assets/Options.png)

## Use:

The first thing you should do is clone this repository with the following command:

<code>git clone https://github.com/Greco140/casino-simulator.git</code>


Once done, you can go to the folder with:

<code>cd casino-simulator/</code>


Now, give it permission to execute with:

<code>chmod +x ruleta.sh</code>


Now start it with the following syntax:

<code>./ruleta.sh</code>


Once this step is done, a menu like the one you can see in the image above will be displayed.

The first parameter you should use is "-u" and that's because before run the script, you need to install a file called "bundle.js", so now execute this: 

<code>./htbmachines.sh -u</code>

* You should see something like this: 
![Options](/assets/Downloaded.png)

The next thing is to re-execute the script with a menu parameter and the characters to search for, which would result in the following syntax:

<code>./htbmachines.sh -parameter "Characters"</code>

* Example:
![Options](/assets/Find%20by%20name%20-m.png)

Additionally, you can search for a machine by difficulty and by operating system simultaneously using both parameters, looking as follows:

<code>./htbmachines.sh -d "Characters" -o "Characters"</code>

![Options](/assets/Difficulty%20and%20SO.png)
