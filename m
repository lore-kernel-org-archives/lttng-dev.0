From: Divya Vyas <dvyas@mvista.com>
Subject: Re: Merge two LTTng CTF traces into one
Date: Thu, 8 Jan 2015 22:58:15 +0530
Message-ID: <CA+=dQ-_DGAtobYX8W=mQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA__13034.131381619$1420738233$gmane$org@mail.gmail.com>
References: <1431870336.8158578.1419253660346.JavaMail.root@polymtl.ca>
 <549835FE.8090508@ericsson.com> <54985ACE.1000502@ericsson.com>
 <CA+=dQ-_sjNg3jj11Psm+wrKbbyS1Ox1kHZyoFwQ2MSfP+SqvuQ@mail.gmail.com>
 <5499C549.2@ericsson.com> <5499CF78.3090301@versatic.net>
 <CA+=dQ-9zwf=0Qnf8mCwWionoOo-BxRyScb607-0wfoi2hBO8XA@mail.gmail.com>
 <54AAB14E.70004@versatic.net>
 <CA+=dQ--wqUbkbW3MXh-4X1NrJ-qp=8B4dh6ydutgGzEcOXHxUA@mail.gmail.com>
 <CA+=dQ-9ZmQJJKZOcoL6kQX5kSMKDZ9HMS2xkjstMiw-5bz79EQ@mail.gmail.com>
 <CA+=dQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gmail.com>
 <54AC0D33.80805@versatic.net>
 <CA+=dQ-_CaEvWV6uF+01tZFmfhSoHE0g=OGBKoKNC5cwMaWDSew@mail.gmail.com>
 <54AD41E8.7050604@versatic.net>
 <CA+=dQ--GJj1rt4jTFOc-sV4YMNb+jpWXnWT_7oULab-FiXRJaQ@mail.gmail.com>
 <54AD844D.4000800@versatic.net>
 <CA+=dQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gmail.com>
 <54AEB378.8090101@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1708584563=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dvyas@mvista.com>) id 1Y9Gsf-00019j-4J
 for lttng-dev@lists.lttng.org; Thu, 08 Jan 2015 12:28:23 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so4786581wiv.2
 for <lttng-dev@lists.lttng.org>; Thu, 08 Jan 2015 09:28:15 -0800 (PST)
In-Reply-To: <54AEB378.8090101@versatic.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Genevi=C3=A8ve_Bastien?= <gbastien@versatic.net>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, =?UTF-8?Q?Fran=C3=A7ois_Doray?= <francois.doray@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============1708584563==
Content-Type: multipart/alternative; boundary=001a11c2691e7ffb02050c275df0

--001a11c2691e7ffb02050c275df0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Jan 8, 2015 10:12 PM, "Genevi=C3=A8ve Bastien" <gbastien@versatic.net> w=
rote:
>
> Hi Divya,
>
> I'm putting you back on the lttng-dev mailing list, please reply to that
list in the future so other people can answer, because I think that trace
synchronization is not exactly what you are looking for here...

I am sorry I clicked reply instead of reply to all.

I have a host and on top of that I have multiple guests. Suppose like from
9 to 9:30 I want to analyze the host information as well as guest
information in single view and in a synchronized way. As the guest time is
different from host . I need the guest traces referenced at host time . and
I tracecompass I can see the host traces as well as guest traces in a
synchronized way.

I hope now I gave the clear picture of what I am doing. Please let me know
if u need some explanation.
>
>> I tried the sessions at same time and communication events in between
and it worked :)
>> I am getting quality as accurate and I can see both traces merged .
>
> Excellent!
>
>>
>> Now I come at my second  point i.e taking traces from lttng sessions at
different machines and at different time and may be communication events or
might be not.
>
> If the sessions are taken are different moments, they can _never_
synchronize.

Yes I think you told that they can be analyzed by applying offset but not
synchronized.

Trace synchronization first matches events such that one single event from
a trace (for example "sending a packet") can be correlated to exactly one
event in the second trace (the reception of that packet). If that is the
case, the first event can have a timestamp of now and the second be timed
to January 1st 1970, trace synchronization will work and the 2 traces will
have a common time reference after synchronization.

What is the criteria of timestamps to be synchronized? How much two
timestamps matched for synchronization
>
>
>>
>> So In my opinion I need to apply time offset on one of the trace to
match the beginning so that they can be synchronized .
>>
>> So like first trace timestamp starts at 07:13:59 .499 222 870 and other
starts at 11:21:35.537 682 885 . Then I can apply timeoffset ( How much
offset ? In apply time offset advanced option If reference time is 7:13....
then target time will be 11:21:35... it will calculate the offset ) on one
of the trace to match traces .
>>
>> Is it possible to synchronize the traces then ? Actually I tried these
steps but not getting the synchronized traces but then both traces
beginning is exactly same ( obviously it will as applied by the offset)
>>
>> Please let me know how can I synchronize the traces from different
machines and at different time
>
> I'm not sure what your end goal is exactly. Do you want to compare trace
executions? I am cc'ing Fran=C3=A7ois Doray who is currently working on a t=
race
comparison utility. Here's a presentation he did recently:
http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%20Traces%20to%20=
Diagnose%20Performance%20Variations.pdf
>
> His work is still experimental and available on github. If that's what
you're interested in, he might give you some information on how to use it.
>
> Otherwise, please explain what you are trying to achieve.
>
> Genevi=C3=A8ve
>
>
>
>>
>>
>>
>> On Thu, Jan 8, 2015 at 12:39 AM, Genevi=C3=A8ve Bastien <gbastien@versat=
ic.net>
wrote:
>>>
>>> On 15-01-07 11:32 AM, Divya Vyas wrote:
>>>>
>>>> Hi ,
>>>>
>>>> I have some comments below and thanks a lot for your help
>>>>
>>>> On Jan 7, 2015 7:55 PM, "Genevi=C3=A8ve Bastien" <gbastien@versatic.ne=
t>
wrote:
>>>> >
>>>> > Hi Divya,
>>>> >
>>>> >
>>>> > On 15-01-07 01:24 AM, Divya Vyas wrote:
>>>> >>
>>>> >>
>>>> >> Hi Genevieve,
>>>> >>
>>>> >> My target to is merge the traces of two different machines taken on
different time or same time .
>>>> >
>>>> > Trace synchronization works by first matching events corresponding
to the sending and the reception of a TCP packet from both traces, and then
taking those matched events and computing a formula that will transform
timestamps from one trace to the same clock as another trace. So only
traces taken at the same time (meaning together, not the same clock time of
course) will work.
>>>>
>>>> I am not getting this last point , where the traces are taken
together. You mean that we start lttng session on two machines at around
same time and then during  session use some communication events . Then
take the traces into tracecompass for synchronization in experiment.  I am
not getting in which cases time offset is needed?
>>>
>>>
>>> Yes, two sessions on two machines at the same time and they communicate
during those sessions. Then you can synchronize traces. The following
traces are used in unit tests to test trace synchronization if you wish to
see what it looks like:
http://archive.eclipse.org/tracecompass/test-traces/ctf/synctraces.tar.gz
>>>
>>>> In what traces I need to apply time offset so that their beginning
matches. Is it applicable on the above case which I am thinking above.
>>>
>>>
>>> You never _need_ to apply time offset. It is if you have traces that do
not contain communication events, and you want one of them to be offsetted
by a certain time. For example, you have a trace taken GST-5 and one at
GST, you cannot synchronize them because they don't have communication
events but you want to analyze them with the same time reference, you would
offset the one at GST-5 by +5 hours.
>>>
>>> Or if you have a custom event that you know happened at the same time
on both traces, but synchronization does not support that event, then you
can offset one trace so that both events from both traces have the same
timestamp.
>>>
>>> Time offsetting is a manual process by the user, while trace
synchronization is an automatic analysis using pre-defined events to
compute a formula to transform timestamps from one trace to the same clock
as the other.
>>>
>>>> >
>>>> >
>>>> >>
>>>> >> Actually synchronization was not working on different machine so I
tried on same machine.  But now I got it correctly I think so :)
>>>> >
>>>> > Indeed, you have the right events now, with the net_dev_queue and
netif_receive_skb. So you should be OK. But I *think* this method works
only when on a LAN. If your computers communicate through internet, you're
better off with the inet_sock_local_[in|out] method
>>>>
>>>> They are connected through LAN only.
>>>>
>>>> >
>>>> >>
>>>> >> For different time we need to apply offset so that their beginning
matches. I think I need to do this .
>>>> >>
>>>> >> I tried applying offset on eclipse luna ( I added linux tools in
install new software)   but I am not getting this option " Apply time
offset ".
>>>> >
>>>> > It is in master only so far, so you should use tracecompass to have
this option.
>>>> >
>>>> >>
>>>> >> I tried on tracecompass also, where I am getting time offset option
but the synchronization view is empty . The window is not showing anything.
The tracecompass version is 0.1.0
>>>> >
>>>> > The time offset does not involve synchronization at all, it is just
an offset, so you would not see anything in the synchronization view. But
in the "Properties" view, when you select the trace, the time offset is
displayed.
>>>>
>>>> I meant to say that I tried synchronizing the traces in tracecompass
without time offset . The synchronizing view is empty.
>>>> It should show at least quality absent etc.
>>>
>>>
>>> Quality absent would show only if the traces are from different
machines. If you are trying to synchronize traces from the same machine,
that view will stay empty.
>>>
>>> Genevi=C3=A8ve
>>>
>>>
>>
>

--001a11c2691e7ffb02050c275df0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jan 8, 2015 10:12 PM, &quot;Genevi=C3=A8ve Bastien&quot; &lt;<a href=3D"=
mailto:gbastien@versatic.net">gbastien@versatic.net</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Divya,<br>
&gt;<br>
&gt; I&#39;m putting you back on the lttng-dev mailing list, please reply t=
o that list in the future so other people can answer, because I think that =
trace synchronization is not exactly what you are looking for here...<br></=
p>
<p dir=3D"ltr">I am sorry I clicked reply instead of reply to all.</p>
<p dir=3D"ltr">I have a host and on top of that I have multiple guests. Sup=
pose like from 9 to 9:30 I want to analyze the host information as well as =
guest information in single view and in a synchronized way. As the guest ti=
me is different from host . I need the guest traces referenced at host time=
 . and I tracecompass I can see the host traces as well as guest traces in =
a synchronized way.</p>
<p dir=3D"ltr">I hope now I gave the clear picture of what I am doing. Plea=
se let me know if u need some explanation.=C2=A0 <br>
&gt;<br>
&gt;&gt; I tried the sessions at same time and communication events in betw=
een and it worked :)<br>
&gt;&gt; I am getting quality as accurate and I can see both traces merged =
.<br>
&gt;<br>
&gt; Excellent!<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Now I come at my second=C2=A0 point i.e taking traces from lttng s=
essions at different machines and at different time and may be communicatio=
n events or might be not.<br>
&gt;<br>
&gt; If the sessions are taken are different moments, they can _never_ sync=
hronize.</p>
<p dir=3D"ltr">Yes I think you told that they can be analyzed by applying o=
ffset but not synchronized. </p>
<p dir=3D"ltr"> Trace synchronization first matches events such that one si=
ngle event from a trace (for example &quot;sending a packet&quot;) can be c=
orrelated to exactly one event in the second trace (the reception of that p=
acket). If that is the case, the first event can have a timestamp of now an=
d the second be timed to January 1st 1970, trace synchronization will work =
and the 2 traces will have a common time reference after synchronization.</=
p>
<p dir=3D"ltr">What is the criteria of timestamps to be synchronized? How m=
uch two timestamps matched for synchronization<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; So In my opinion I need to apply time offset on one of the trace t=
o match the beginning so that they can be synchronized . <br>
&gt;&gt;<br>
&gt;&gt; So like first trace timestamp starts at 07:13:59 .499 222 870 and =
other starts at 11:21:35.537 682 885 . Then I can apply timeoffset ( How mu=
ch offset ? In apply time offset advanced option If reference time is 7:13.=
... then target time will be 11:21:35... it will calculate the offset ) on =
one of the trace to match traces .<br>
&gt;&gt;<br>
&gt;&gt; Is it possible to synchronize the traces then ? Actually I tried t=
hese steps but not getting the synchronized traces but then both traces beg=
inning is exactly same ( obviously it will as applied by the offset) <br>
&gt;&gt;<br>
&gt;&gt; Please let me know how can I synchronize the traces from different=
 machines and at different time <br>
&gt;<br>
&gt; I&#39;m not sure what your end goal is exactly. Do you want to compare=
 trace executions? I am cc&#39;ing Fran=C3=A7ois Doray who is currently wor=
king on a trace comparison utility. Here&#39;s a presentation he did recent=
ly: <a href=3D"http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%2=
0Traces%20to%20Diagnose%20Performance%20Variations.pdf">http://ahls.dorsal.=
polymtl.ca/system/files/Comparison%20of%20Traces%20to%20Diagnose%20Performa=
nce%20Variations.pdf</a><br>
&gt;<br>
&gt; His work is still experimental and available on github. If that&#39;s =
what you&#39;re interested in, he might give you some information on how to=
 use it.<br>
&gt;<br>
&gt; Otherwise, please explain what you are trying to achieve.<br>
&gt;<br>
&gt; Genevi=C3=A8ve<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jan 8, 2015 at 12:39 AM, Genevi=C3=A8ve Bastien &lt;<a hre=
f=3D"mailto:gbastien@versatic.net">gbastien@versatic.net</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 15-01-07 11:32 AM, Divya Vyas wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi ,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I have some comments below and thanks a lot for your help<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Jan 7, 2015 7:55 PM, &quot;Genevi=C3=A8ve Bastien&quot;=
 &lt;<a href=3D"mailto:gbastien@versatic.net">gbastien@versatic.net</a>&gt;=
 wrote:<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Hi Divya,<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; On 15-01-07 01:24 AM, Divya Vyas wrote:<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Hi Genevieve,<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; My target to is merge the traces of two different=
 machines taken on different time or same time .<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Trace synchronization works by first matching events =
corresponding to the sending and the reception of a TCP packet from both tr=
aces, and then taking those matched events and computing a formula that wil=
l transform timestamps from one trace to the same clock as another trace. S=
o only traces taken at the same time (meaning together, not the same clock =
time of course) will work.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I am not getting this last point , where the traces are ta=
ken together. You mean that we start lttng session on two machines at aroun=
d same time and then during=C2=A0 session use some communication events . T=
hen take the traces into tracecompass for synchronization in experiment.=C2=
=A0 I am not getting in which cases time offset is needed?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Yes, two sessions on two machines at the same time and they co=
mmunicate during those sessions. Then you can synchronize traces. The follo=
wing traces are used in unit tests to test trace synchronization if you wis=
h to see what it looks like: <a href=3D"http://archive.eclipse.org/tracecom=
pass/test-traces/ctf/synctraces.tar.gz">http://archive.eclipse.org/tracecom=
pass/test-traces/ctf/synctraces.tar.gz</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; In what traces I need to apply time offset so that their b=
eginning matches. Is it applicable on the above case which I am thinking ab=
ove.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You never _need_ to apply time offset. It is if you have trace=
s that do not contain communication events, and you want one of them to be =
offsetted by a certain time. For example, you have a trace taken GST-5 and =
one at GST, you cannot synchronize them because they don&#39;t have communi=
cation events but you want to analyze them with the same time reference, yo=
u would offset the one at GST-5 by +5 hours.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Or if you have a custom event that you know happened at the sa=
me time on both traces, but synchronization does not support that event, th=
en you can offset one trace so that both events from both traces have the s=
ame timestamp.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Time offsetting is a manual process by the user, while trace s=
ynchronization is an automatic analysis using pre-defined events to compute=
 a formula to transform timestamps from one trace to the same clock as the =
other.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; Actually synchronization was not working on diffe=
rent machine so I tried on same machine.=C2=A0 But now I got it correctly I=
 think so :)<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Indeed, you have the right events now, with the net_d=
ev_queue and netif_receive_skb. So you should be OK. But I *think* this met=
hod works only when on a LAN. If your computers communicate through interne=
t, you&#39;re better off with the inet_sock_local_[in|out] method<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; They are connected through LAN only.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; For different time we need to apply offset so tha=
t their beginning matches. I think I need to do this .<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; I tried applying offset on eclipse luna ( I added=
 linux tools in install new software)=C2=A0=C2=A0 but I am not getting this=
 option &quot; Apply time offset &quot;. <br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; It is in master only so far, so you should use tracec=
ompass to have this option.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;&gt; I tried on tracecompass also, where I am getting =
time offset option but the synchronization view is empty . The window is no=
t showing anything. The tracecompass version is 0.1.0<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; The time offset does not involve synchronization at a=
ll, it is just an offset, so you would not see anything in the synchronizat=
ion view. But in the &quot;Properties&quot; view, when you select the trace=
, the time offset is displayed.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I meant to say that I tried synchronizing the traces in tr=
acecompass without time offset . The synchronizing view is empty.<br>
&gt;&gt;&gt;&gt; It should show at least quality absent etc.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Quality absent would show only if the traces are from differen=
t machines. If you are trying to synchronize traces from the same machine, =
that view will stay empty. <br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Genevi=C3=A8ve<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</p>

--001a11c2691e7ffb02050c275df0--


--===============1708584563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1708584563==--
