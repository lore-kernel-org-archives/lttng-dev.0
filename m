From: Raphael Zulliger <zulliger@indel.ch>
Subject: LTTng unreliable and useless under heavy loaded systems?
Date: Wed, 07 Jan 2015 17:10:30 +0100
Message-ID: <54AD5A76.7070004__18196.3013754741$1420647108$gmane$org@indel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ms9.webland.ch ([92.43.217.109] helo=ms9smtp.webland.ch)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mailadmin@indel.ch>) id 1Y8tBz-0001oN-3E
 for lttng-dev@lists.lttng.org; Wed, 07 Jan 2015 11:10:47 -0500
Received: from macserver.private ([84.72.1.67])
 by ms9smtp.webland.ch (Webland Mail Server v. 10.4.1) with ASMTP id
 01201501071710345151
 for <lttng-dev@lists.lttng.org>; Wed, 07 Jan 2015 17:10:34 +0100
Received: from [192.168.1.66] (unknown [192.168.1.66])
 by macserver.private (Postfix) with ESMTP id 155FE2168BA9
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jan 2015 17:10:30 +0100 (CET)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

First of all: LTTng seems to be a great piece of software. Great docs 
and good visualization tools (Eclipse) are available. I mention this to 
clarify that I like LTTng...

... unfortunately, for the issue I've started using it, it doesn't work 
very well. I contact the list because I hope you have some tips and 
tricks for me.

I have a Ubuntu 14.04/32, i5 Quadcore. The goal is to run an existing 
application as jitter less as possible. To tune the system, I've 
programmed a simple test-application which sends a UDP frame to an 
embedded system and waits for the response. If the time until test-app 
receives the response is bigger than 5ms, it consider that a big jitter 
and exits. In that case, I want to find out what caused the jitter of > 
5ms. NOTE: I run my application with real-time prio 99 (which could 
matter in this case, I guess)

Here's how I initially run my measurement (all as sudo):
   lttng create
   lttng enable-channel channel0 -k
   lttng enable-event -k --all -c channel0
   lttng start
   chrt -f 50 ./run_my_test-application_here
   lttng stop
   lttng destroy
Then, I start compiling a kernel image and run bonnie++ to generate 
system load. It takes about 1h until a jitter > 5ms occurs... but it 
happens.

Unfortunately, whenever the big jitter (which are around 6ms up to 25ms) 
occur, LTTng is not able to record the events around the time the delay 
happened. Means: I got really nice graphs in Eclipse - but not at the 
points where it would be useful... I also verified this with "babeltrace 
.... > /dev/null" which reported the loss of various events.

I read the docs and then tried to increase the buffers. I tried several 
numbers, the final version is:
   lttng enable-channel channel0 -k --num-subbuf 32 --subbuf-size 1M
But it doesn't help. From my point of view, the result is still the same 
as before it doesn't obviously loose less events than before. (Side 
note: Actually, I also tried with "subbuf 16" and "subbuf-size 10M" but 
then my system crashed: X gone, no keyboard input possible anymore but 
(surprisingly) no kernel dump)

(Side note: There's one more thing to mention: The system is setup with 
isolcpu=1,2,3 (because core 1..3 run real-time apps other than the one 
mentioned here) - thus everything, including lttng daemons, ran on CPU0 
so far.)

Finally, I tried to run lttng-sessiond and lttng-consumerd on a separate 
CPU core (CPU3) and even changed policy to SCHED_FIFO and prio to 99 - 
but lttng still looses events. This really surpises me...

I do understand that it is a good feature that lttng discards events 
when buffers are full... but in my case, it seems to render lttng useless.
(Note: I did not yes use the "buffer overwrite" feature, but I guess the 
events of interest will still be lost)

My question: Is there anything else I can do on my system (which is a 
not a production system, just a developer machine) to make lttng work 
for my scenario?

Any input is very welcome!
Raphael
