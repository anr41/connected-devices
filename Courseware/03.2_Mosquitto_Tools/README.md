# Simple Pub/Sub Testing with MQTT and Mosquitto

## MQTT
As we have discussed, MQTT is a Publish/Subscribe protocol.  We are using the open source Mosquitto MQTT broker.  Clients that wish to publish messages or subscribe and receive messages connect to the broker.

## Mosquitto Clients
When we installed the Mosquitto broker in the previous assignment, we also installed another package, "mosquitto-clients", that contains *mosquitto_pub* and *mosquitto_sub*, programs that allow you interact with MQTT brokers from the command-line, publishing and subscribing messages, respectively.

Note:  These tools can be very handy for testing, debugging, sanity-checks, etc.  They allow you to publish messages and subscribe to topics with very little effort. You can use them to insert messages, as well as "snoop" on topics.

For these exercises, you will want to open up more than one command shell connection to the Pi (e.g., two SSH connections, or use tmux or screen if you like).  One shell will be for publishing and the other for subscribing.

## MQTT "Hello World"

In your first shell subscribe to the "hello" topic:

```
pi@raspberrypi ~ $ mosquitto_sub -v -t hello
```

In your second shell publish to the "hello" topic:
```
pi@raspberrypi:~$ mosquitto_pub -t hello -m world
```

As soon as you press Return in the second shell, you should see the message displayed in the first shell.

You can read the man pages for both tools:

```
pi@raspberrypi:~$ man mosquitto_pub
```

and 

```
pi@raspberrypi:~$ man mosquitto_sub
```

but in brief:

* -t allows you to specify the topic name
* -v on *mosquitto_sub* enables verbose mode, causing it to display the topic name, not just the message payload, immediately before the message (in our example above, without the "-t" option the output would only have been ```world``` since the topic is ```hello```
* -m on *mosquitto_pub* allows you to specify the message payload

*Note:* both commands will default to connecting to the broker on localhost, with the default port number of 1883 if not specified.

To kill *mosquitto_sub*, press CTRL-C.

## Topic Wildcards
When an MQTT client publishes a message it must specify a topic name.  When a subscriber subscribes to a topic, however, it can subscribe to a collection of topics using the "+" and "#" wildcard characters.  "+" specifies a single "level" and "#" specifies an entire sub-tree of topic names.

In your first shell:

```
pi@raspberrypi ~ $ mosquitto_sub -v -t home/kitchen/#
```

to subscribe to all topics in the "home/kitchen/" hiearchy.

In your second shell:

```
pi@raspberrypi:~$ mosquitto_pub -t home/kitchen/temp -m 75.2F 
```

should cause the topic and message to appear in the first window, since "home/kitchen/temp" is a matched by "home/kitchen/#".


## Retained Messages
When clients publish messages infrequently, subscribers may have to wait quite a long time to receive a message, informing them of the current state of some component (e.g., the current temperature from a sensor that only updates every hour).  MQTT supports "Retained Messages" to minimize these delays.

When a client publishes a message, it can optionally mark that message with the "RETAIN" flag.  That will cause the broker to not only deliver that message to any currently subscribed clients on that topic, but also to store that message to deliver to any client that subscribes to that topic in the future.  The *mosquitto_pub* app supports Retained Messages via the "-r" flag.

In your first shell:

```
pi@raspberrypi:~$ mosquitto_pub -t home/kitchen/temp -m 75.2F 
```

After pressing Return in the first shell, run the following in the second shell:

```
pi@raspberrypi ~ $ mosquitto_sub -v -t home/kitchen/temp
```

Wait a moment and verify you do not see any messages (since the subscriber was not subscribed and listening when the publisher published the message).  Press CTRL-C.

In your first shell:

```
pi@raspberrypi:~$ mosquitto_pub -t home/kitchen/temp -m 75.2F -r
```

After pressing Return in the first shell, run the following in the second shell:

```
pi@raspberrypi ~ $ mosquitto_sub -v -t home/kitchen/temp
```

You should see the the message displayed, even though the publisher published it some time ago.  You can press CTRL-C, and run the *mosquitto_sub* command again, and again, and still see that Retained message show up each time you subscribe to that topic.

Once a Retained Message is set on a topic, how do you remove it (short of completely resetting broker)?  

Next up: go to [Introduction to Python Paho](../03.3_Python_Paho/README.md)

&copy; 2015-18 LeanDog, Inc. and Nick Barendt
