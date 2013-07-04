From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: On lost events
Date: Thu, 4 Jul 2013 17:46:54 -0400
Message-ID: <51D5ED4E.2000305__25577.7198625312$1372974474$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1UurN3-0005nL-30
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 17:47:21 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi tracing werewolves,

I want to clear up some stuff about lost events.

Lost events are caused, in lttng 2.x when the tracer does not have
enough memory available to write an event. This can be due to:
* events coming in too fast (faster than we can write them)
* a given event being too large
* we have an event that does a nested wrap around

LTTng will not write the whole packet that is lost. It uses a ring
buffer and the packet will just be overwritten in the buffer, but a
counter will be incremented.
The counter is written in the packet header in the CTF trace.

When reading a trace, if you just read the packet headers, you will see
something as follows:

Packet 1:
ts_begin: 100
ts_end: 200
discarded: 0

Packet 2:
ts_begin: 300
ts_end: 400
discarded: 100

Packet 3:
ts_begin: 500
ts_end: 600
discarded: 100

Packet 4:
ts_begin: 650
ts_end: 750
discarded: 200

With this example, the lost events are located between packets 1, 2 and
packets 3,4.

If the events are too large, they are discarded in the current packet,
lttng does not split events into packets (yet?), and this is lost during
a current packet.

That means if the events are lost between 1 and 2, they are potentially
in the range of [200-400] but probably in [200-300]
The next lost event are between 3 and 4 (events discarded is a total
count, not local to that packet), so 100 events are also lost between
[600-750] but likely in between [600-650]. If you can confirm that all
events WITH CONTEXTS are smaller than the packet sizes, I think it's a
shoe in that it's between the packets and not containing the next packet.

Hope this clarifies some issues, it did for me!

Matthew
