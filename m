From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: UST improvement ideas
Date: Wed, 26 Nov 2014 20:47:22 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD6FBCF753__42758.4593337544$1417034888$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XtjUn-00036s-Ey
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 15:47:31 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: David Goulet <dgoulet@ev0ke.net>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Tue, 25 Nov 2014 14:04:04 -0500
From: David Goulet <dgoulet@ev0ke.net>

> 1) Having a way to use counters in the trace.
>
> So basically, lots of our measurements are based on timing things which t=
racepoints are really useful for that but we also gather stuff like "How ma=
ny elements seen of an object in the past hour?". It's doable with tracepoi=
nt but when the number goes up to millions quickly, it does not really scal=
e to have a million tp for one single counter.
>
> The rough idea is this:
>
>	[...]
>	tracepoint_counter_inc(mycomponent, mycounter, n);
>	[...]
>
> where "n" is the amount to increment the counter designated by mycomponen=
t:mycounter.
>
> When the buffers are flushed or/and the tracing stop, this counter could =
simply be updated in the trace and, for instance, babeltrace could print th=
em at the beginning of the output.

The semantics of these "counters" has to be thought through carefully.  A m=
eans of setting the counter's initial value should be available (i.e. trace=
point_counter_set(mycomponent, mycounter, n);), and maybe also a means of "=
flushing" the counter (i.e. tracepoint_counter_flush(mycomponent, mycounter=
, myevent);, where mycomponent:myevent has a single-argument signature of t=
he same type as the counter) ---"flushing" in this case means forcing a tra=
cepoint event to be issued with the current counter's value as its payload.

Should counters be assigned to channels and enabled/disabled just like even=
ts?  If a counter is assigned to multiple channels within a trace, the same=
 value should transpire in each channel.  On the other hand, if the counter=
 is assigned in several separate traces, the values should be independent o=
f each other.  When a counter/channel/trace is disabled, should the counter=
 ignore any tracepoint_counter_set/_inc/_flush commands?  Finally, what hap=
pens when an application dynamically unloads the provider handling the coun=
ter and later loads it back in?  Presumably the counter value resets to its=
 default zero (here's another idea: maybe the counter's default creation va=
lue can be non-zero, and is set in the tracepoint template by the tracepoin=
t-counter creation macros).

Maybe counters can be handled in truly event-like fashion: when a counter i=
s created, set, or destroyed, an implicit event occurs (described in the tr=
acepoint template by the tracepoint-counter creation macros).  Simply incre=
menting the counter does not trigger an event.  The application API is then=
 decoupled from the LTTng trace, and the lttng client does not need to be c=
hanged at all, being unaware of counters.

Here's a strawman for discussion:

In the instrumented apps, simply include tp.h as usual, and use any or all =
of the counter API methods: tracepoint_counter_set(component, counter, valu=
e), tracepoint_counter_inc(component, counter, value), tracepoint_counter_f=
lush(component, counter).  In the tracepoint header, the counter is defined=
 like this:

TRACEPOINT_COUNTER (<provider name>, <counter name>, TPC_INITIAL_VALUE(<typ=
e>, <value>), TPC_FIELD( ctf_<scalar>(<type>, <field name>, <counter name>)=
 ) )

Whenever the counter is created by the instrumented app (by any one of the =
three methods), a <provider name>:<counter name>_created event occurs.  Whe=
never the counter is destroyed (the instrumented app terminates or unloads =
the provider), a <provider name>:<counter name>_destroyed event occurs.  Wh=
enever the counter is flushed, a <provider name>:<counter name>_report even=
t occurs.  All events report the counter's value.

The counter's events cannot be called directly from the instrumented app.  =
On the lttng client side, one assigns the counter's three events to channel=
s and enables/disables them as usual.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
