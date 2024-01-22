# What is it?

Tool developed at Marcelo Vázquez's Hack4u Academy (Aka. S4vitar) during the Introduction to Linux course to practice bash scripting and simulate a roulette in a Casino.

## Example
![Options](/assets/menu.png)

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

You have to run the script and give it two parameters, the firt parameter is -m and it refers to the money you're going to play with and the second parameter is -t that refers to the technique:

Using the technique martingala:
<code>./ruleta.sh -m 5000 -t martingala</code>

* You should see something like this: 
![Options](/assets/martingala.png)

