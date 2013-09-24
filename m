From: Matthew Khouzam <matthew.khouzam-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: What is needed to view live traces with TMF
	(X-Post)
Date: Tue, 24 Sep 2013 10:15:35 -0400
Message-ID: <52419E87.7050908@ericsson.com>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

TMF is a trace reading framework in the Linuxtools project. It stands
for Tracing and Monitoring Framework. It is currently developed by
people from Ericsson, Ecole Polytechnique de Montreal, Kalray and more
and used by many companies including montavista and mentor graphics.

Some definitions:
Remote trace reading: read a trace from somewhere else. It does not mean...
Live trace reading: reading a trace while it's being written
Streaming traces: like Youtube. The data comes in progressively and is
read progressively. This can be seen as a combination of the previous
two modes.

TMF should support 2 live tracing modes:

Live trace reading and monitoring
* Live trace reading reads a trace while it's being written, this can be
viewed as mapping Achilles and the turtle's race, the trace will be read
and indexed and the state system will be built progressively. If this is
running on a system for eons, you will need a large hard drive.

* Monitoring would be more like a tail on syslog, much like top and
lttngtop. we will only store the last n-time in memory and have a
special in memory state system and NO ability to seek in the trace, you
only want to see the last n time anyway.

To get this all to work, we will need to modify several components:

1- Parsers: All the parsers right now return null when they reach the
end of file, they should instead return a "no_more_events" object that
would be handled by updated...

2- Requests: The requests will update with the parsers no more events
and retry if need be. This is a large API change and people using TMF as
a data source please give feedback as it is welcome.

3- State System: we need an in memory state system that stores the last
time. The NullStateSystem stores current well, but we need something to
see the last N items.

4- Views: A lot of views will need to be updated. Also, there needs to
be a fundamental "Lock-time" option like pin to time or something.

Going into more details:

1- Parsers: I can separate this into "Directory parsers" and "File parsers"

We are assuming that the trace will append only for more data,
therefore, once the data is read, it will not be re-read. (Please
mention objections if there are any).

The files may contain events out of order and an uncertain last event.

Handling out of order events: The views will need to handle this. The
state sytem by design cannot, so internally, if they are out of order we
need to make the choice, sort, drop or do both the the events. The
tracer must provide information about the packets in order to prevent
going back in time. If events still arrive out of order with no
information on the actual order, a best effort will be applied. The
reader will sort a short heap to make sure the last n (small amount)
events are in order, if an event arrives after that out of order, it
will be dropped. The state system should only be used when there is a
guaranty of sorts that the events will arrive in order.

The trace may also have an incomplete last event read (imagine
multi-line text events with ambiguous grammars). To avoid this, the
before last event should be kept in memory and the last one will only be
committed when the next one is read, or if the file has not been changed
for a safe period determined per type, or if the user says "Stop reading
live". Directory parsers are tricker beasts, basically, they need to
handle everything mentioned above AND handle new files appearing in the
directories. If the event types are stored elsewhere, all the event
types must be updated. It would be preferable but not essential to read
only the delta in the event description files.

In terms of implementation effort, this can be massively parallelized
for each trace type. (eg, CTF can be done at the same time as Syslog)

2- Requests: Requests would need to no longer be eternal unless the user
wants to really trace eternity. A work around could be that the request
is broken down into sub-requests where the first one is big-bang until
now, then now(t-1) until now when the first one is handled and so forth.
They are changing since now, handleData may be saying "No data yet".
This can be handled via polling or signaling, I believe signaling would
be the more efficient method. Right now, if the trace is finished,
handledata returns null, this will trigger a handlecompleted signal, the
request handler must maybe handle also a "not yet" return, to not
dispatch handle event but poll at a later time.

In terms of implementation effort this step depends on having at least
one parser done.

3- The state system will cannot handle the unavoidable out of order
surprise events. It should raise an exception when this happens, which
it does. It also will need to be more transactional. All but the
last branch is written, so you have a get current safe end time (this
should be a few ms tops). An option is to add an in memory barrel back
end if those last ms are essential, I'm looking at you high frequency
traders! (this is a whole new back end and not a trivial job) That way
we can read the most data in real-time.

This step can be done partially independently from 1 and 2

4- Certain views will work well with live reading certain will work well
with monitoring.

To note, this step can be parallelized, but depends on 1-2 and 3
Examples for live:
* Most time-graph gantt chart views. They require in depth reading and
cannot be scrolled constantly to show the most recent info.
* Text tables, reading elder scrolling text is annoying.
Examples for monitoring:
* X-Y Charts, we would need triggering to know when to display for fast
incoming charts. (Something like, fix this point when y crosses this
threshold)
* Indicators (red light green light or gauges or thermometers and such )

Comments are welcome

Matthew
