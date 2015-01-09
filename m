From: =?UTF-8?B?R2VuZXZpw6h2ZSBCYXN0aWVu?= <gbastien@versatic.net>
Subject: Re: Merge two LTTng CTF traces into one
Date: Fri, 09 Jan 2015 12:08:31 -0500
Message-ID: <54B00B0F.2060500__11072.58415218$1420823429$gmane$org@versatic.net>
References: <1431870336.8158578.1419253660346.JavaMail.root@polymtl.ca>	<549835FE.8090508@ericsson.com>	<54985ACE.1000502@ericsson.com>	<CA+=dQ-_sjNg3jj11Psm+wrKbbyS1Ox1kHZyoFwQ2MSfP+SqvuQ@mail.gmail.com>	<5499C549.2@ericsson.com>	<5499CF78.3090301@versatic.net>	<CA+=dQ-9zwf=0Qnf8mCwWionoOo-BxRyScb607-0wfoi2hBO8XA@mail.gmail.com>	<54AAB14E.70004@versatic.net>	<CA+=dQ--wqUbkbW3MXh-4X1NrJ-qp=8B4dh6ydutgGzEcOXHxUA@mail.gmail.com>	<CA+=dQ-9ZmQJJKZOcoL6kQX5kSMKDZ9HMS2xkjstMiw-5bz79EQ@mail.gmail.com>	<CA+=dQ-8oGmyKDfNEfLwu_WLeouu0XXxQVigciVBDV3T6dQJ+pg@mail.gmail.com>	<54AC0D33.80805@versatic.net>	<CA+=dQ-_CaEvWV6uF+01tZFmfhSoHE0g=OGBKoKNC5cwMaWDSew@mail.gmail.com>	<54AD41E8.7050604@versatic.net>	<CA+=dQ--GJj1rt4jTFOc-sV4YMNb+jpWXnWT_7oULab-FiXRJaQ@mail.gmail.com>	<54AD844D.4000800@versatic.net>
 	<CA+=dQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gmail.com>	<54AEB378.8090101@versatic.net>
 <CA+=dQ-_DGAtobYX8W=mQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918409413=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout.easydns.com ([64.68.201.141])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gbastien@versatic.net>) id 1Y9d34-0008I9-7R
 for lttng-dev@lists.lttng.org; Fri, 09 Jan 2015 12:08:36 -0500
In-Reply-To: <CA+=dQ-_DGAtobYX8W=mQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1918409413==
Content-Type: multipart/alternative;
 boundary="------------040005020701090407020802"

This is a multi-part message in MIME format.
--------------040005020701090407020802
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t09H8mvZ017115

On 01/08/2015 12:28 PM, Divya Vyas wrote:
>
>
> On Jan 8, 2015 10:12 PM, "Genevi=C3=A8ve Bastien" <gbastien@versatic.ne=
t=20
> <mailto:gbastien@versatic.net>> wrote:
> >
> > Hi Divya,
> >
> > I'm putting you back on the lttng-dev mailing list, please reply to=20
> that list in the future so other people can answer, because I think=20
> that trace synchronization is not exactly what you are looking for here=
...
>
> I am sorry I clicked reply instead of reply to all.
>
> I have a host and on top of that I have multiple guests. Suppose like=20
> from 9 to 9:30 I want to analyze the host information as well as guest=20
> information in single view and in a synchronized way. As the guest=20
> time is different from host . I need the guest traces referenced at=20
> host time . and I tracecompass I can see the host traces as well as=20
> guest traces in a synchronized way.
>
Then your traces are taken at the same time.  The ideal in your case is=20
to have your machines communicate, at least a few TCP packets during the=20
duration of the trace so they can be synchronized. If you trace a=20
virtual machine guest and host for 30 minutes, chances are the time=20
drift between the clocks is important so simple time offsetting at a=20
point that you know (either the beginnings of the trace or a precise=20
point in the trace) will correlate justly the traces at this point but=20
the further you go from there, the less accurate the time will be. Trace=20
synchronization accounts for the time drift so if you have accurate=20
synchronization, then the same accuracy applies to the whole trace.

Also, I may point you to a recently contributed Virtual Machine=20
Analysis. Part of it is in master, some still on gerrit (the view for=20
instance). The documentation is still unexistent. It works with the=20
Qemu/KVM virtualizer, and needs some custom compilation of lttng-modules=20
on both guest and host. It is still experimental. It allows to associate=20
a host process with a guest CPU so that you can see on the guest whether=20
the CPU was actually running or preempted on the host. If you're using=20
Qemu/KVM and are interested in this analysis, I can work on the=20
documentation sooner than later.


> I hope now I gave the clear picture of what I am doing. Please let me=20
> know if u need some explanation.
> >
> >> I tried the sessions at same time and communication events in=20
> between and it worked :)
> >> I am getting quality as accurate and I can see both traces merged .
> >
> > Excellent!
> >
> >>
> >> Now I come at my second  point i.e taking traces from lttng=20
> sessions at different machines and at different time and may be=20
> communication events or might be not.
> >
> > If the sessions are taken are different moments, they can _never_=20
> synchronize.
>
> Yes I think you told that they can be analyzed by applying offset but=20
> not synchronized.
>
> Trace synchronization first matches events such that one single event=20
> from a trace (for example "sending a packet") can be correlated to=20
> exactly one event in the second trace (the reception of that packet).=20
> If that is the case, the first event can have a timestamp of now and=20
> the second be timed to January 1st 1970, trace synchronization will=20
> work and the 2 traces will have a common time reference after=20
> synchronization.
>
> What is the criteria of timestamps to be synchronized? How much two=20
> timestamps matched for synchronization
>
There is no criteria for the timestamp. Matching events is the important=20
part of the process. If you are interested in trace synchronization, I=20
invite you to read this article by Masoume Jabbarifar [1]. It is at the=20
base of what is implemented in Trace Compass.

[1] http://link.springer.com/article/10.1007/s10922-014-9331-7#page-1


Genevi=C3=A8ve



> >
> >
> >>
> >> So In my opinion I need to apply time offset on one of the trace to=20
> match the beginning so that they can be synchronized .
> >>
> >> So like first trace timestamp starts at 07:13:59 .499 222 870 and=20
> other starts at 11:21:35.537 682 885 . Then I can apply timeoffset (=20
> How much offset ? In apply time offset advanced option If reference=20
> time is 7:13.... then target time will be 11:21:35... it will=20
> calculate the offset ) on one of the trace to match traces .
> >>
> >> Is it possible to synchronize the traces then ? Actually I tried=20
> these steps but not getting the synchronized traces but then both=20
> traces beginning is exactly same ( obviously it will as applied by the=20
> offset)
> >>
> >> Please let me know how can I synchronize the traces from different=20
> machines and at different time
> >
> > I'm not sure what your end goal is exactly. Do you want to compare=20
> trace executions? I am cc'ing Fran=C3=A7ois Doray who is currently work=
ing=20
> on a trace comparison utility. Here's a presentation he did recently:=20
> http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%20Traces%20t=
o%20Diagnose%20Performance%20Variations.pdf
> >
> > His work is still experimental and available on github. If that's=20
> what you're interested in, he might give you some information on how=20
> to use it.
> >
> > Otherwise, please explain what you are trying to achieve.
> >
> > Genevi=C3=A8ve
> >
> >
> >
> >>
> >>
> >>
> >> On Thu, Jan 8, 2015 at 12:39 AM, Genevi=C3=A8ve Bastien=20
> <gbastien@versatic.net <mailto:gbastien@versatic.net>> wrote:
> >>>
> >>> On 15-01-07 11:32 AM, Divya Vyas wrote:
> >>>>
> >>>> Hi ,
> >>>>
> >>>> I have some comments below and thanks a lot for your help
> >>>>
> >>>> On Jan 7, 2015 7:55 PM, "Genevi=C3=A8ve Bastien"=20
> <gbastien@versatic.net <mailto:gbastien@versatic.net>> wrote:
> >>>> >
> >>>> > Hi Divya,
> >>>> >
> >>>> >
> >>>> > On 15-01-07 01:24 AM, Divya Vyas wrote:
> >>>> >>
> >>>> >>
> >>>> >> Hi Genevieve,
> >>>> >>
> >>>> >> My target to is merge the traces of two different machines=20
> taken on different time or same time .
> >>>> >
> >>>> > Trace synchronization works by first matching events=20
> corresponding to the sending and the reception of a TCP packet from=20
> both traces, and then taking those matched events and computing a=20
> formula that will transform timestamps from one trace to the same=20
> clock as another trace. So only traces taken at the same time (meaning=20
> together, not the same clock time of course) will work.
> >>>>
> >>>> I am not getting this last point , where the traces are taken=20
> together. You mean that we start lttng session on two machines at=20
> around same time and then during  session use some communication=20
> events . Then take the traces into tracecompass for synchronization in=20
> experiment.  I am not getting in which cases time offset is needed?
> >>>
> >>>
> >>> Yes, two sessions on two machines at the same time and they=20
> communicate during those sessions. Then you can synchronize traces.=20
> The following traces are used in unit tests to test trace=20
> synchronization if you wish to see what it looks like:=20
> http://archive.eclipse.org/tracecompass/test-traces/ctf/synctraces.tar.=
gz
> >>>
> >>>> In what traces I need to apply time offset so that their=20
> beginning matches. Is it applicable on the above case which I am=20
> thinking above.
> >>>
> >>>
> >>> You never _need_ to apply time offset. It is if you have traces=20
> that do not contain communication events, and you want one of them to=20
> be offsetted by a certain time. For example, you have a trace taken=20
> GST-5 and one at GST, you cannot synchronize them because they don't=20
> have communication events but you want to analyze them with the same=20
> time reference, you would offset the one at GST-5 by +5 hours.
> >>>
> >>> Or if you have a custom event that you know happened at the same=20
> time on both traces, but synchronization does not support that event,=20
> then you can offset one trace so that both events from both traces=20
> have the same timestamp.
> >>>
> >>> Time offsetting is a manual process by the user, while trace=20
> synchronization is an automatic analysis using pre-defined events to=20
> compute a formula to transform timestamps from one trace to the same=20
> clock as the other.
> >>>
> >>>> >
> >>>> >
> >>>> >>
> >>>> >> Actually synchronization was not working on different machine=20
> so I tried on same machine.  But now I got it correctly I think so :)
> >>>> >
> >>>> > Indeed, you have the right events now, with the net_dev_queue=20
> and netif_receive_skb. So you should be OK. But I *think* this method=20
> works only when on a LAN. If your computers communicate through=20
> internet, you're better off with the inet_sock_local_[in|out] method
> >>>>
> >>>> They are connected through LAN only.
> >>>>
> >>>> >
> >>>> >>
> >>>> >> For different time we need to apply offset so that their=20
> beginning matches. I think I need to do this .
> >>>> >>
> >>>> >> I tried applying offset on eclipse luna ( I added linux tools=20
> in install new software)   but I am not getting this option " Apply=20
> time offset ".
> >>>> >
> >>>> > It is in master only so far, so you should use tracecompass to=20
> have this option.
> >>>> >
> >>>> >>
> >>>> >> I tried on tracecompass also, where I am getting time offset=20
> option but the synchronization view is empty . The window is not=20
> showing anything. The tracecompass version is 0.1.0
> >>>> >
> >>>> > The time offset does not involve synchronization at all, it is=20
> just an offset, so you would not see anything in the synchronization=20
> view. But in the "Properties" view, when you select the trace, the=20
> time offset is displayed.
> >>>>
> >>>> I meant to say that I tried synchronizing the traces in=20
> tracecompass without time offset . The synchronizing view is empty.
> >>>> It should show at least quality absent etc.
> >>>
> >>>
> >>> Quality absent would show only if the traces are from different=20
> machines. If you are trying to synchronize traces from the same=20
> machine, that view will stay empty.
> >>>
> >>> Genevi=C3=A8ve
> >>>
> >>>
> >>
> >
>


--------------040005020701090407020802
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t09H8mvZ017115

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 01/08/2015 12:28 PM, Divya Vyas
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CA+=3DdQ-_DGAtobYX8W=3DmQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA@mail.=
gmail.com"
      type=3D"cite">
      <p dir=3D"ltr"><br>
        On Jan 8, 2015 10:12 PM, "Genevi=C3=A8ve Bastien" &lt;<a
          moz-do-not-send=3D"true" href=3D"mailto:gbastien@versatic.net">=
gbastien@versatic.net</a>&gt;
        wrote:<br>
        &gt;<br>
        &gt; Hi Divya,<br>
        &gt;<br>
        &gt; I'm putting you back on the lttng-dev mailing list, please
        reply to that list in the future so other people can answer,
        because I think that trace synchronization is not exactly what
        you are looking for here...<br>
      </p>
      <p dir=3D"ltr">I am sorry I clicked reply instead of reply to all.<=
/p>
      <p dir=3D"ltr">I have a host and on top of that I have multiple
        guests. Suppose like from 9 to 9:30 I want to analyze the host
        information as well as guest information in single view and in a
        synchronized way. As the guest time is different from host . I
        need the guest traces referenced at host time . and I
        tracecompass I can see the host traces as well as guest traces
        in a synchronized way.</p>
    </blockquote>
    Then your traces are taken at the same time.=C2=A0 The ideal in your =
case
    is to have your machines communicate, at least a few TCP packets
    during the duration of the trace so they can be synchronized. If you
    trace a virtual machine guest and host for 30 minutes, chances are
    the time drift between the clocks is important so simple time
    offsetting at a point that you know (either the beginnings of the
    trace or a precise point in the trace) will correlate justly the
    traces at this point but the further you go from there, the less
    accurate the time will be. Trace synchronization accounts for the
    time drift so if you have accurate synchronization, then the same
    accuracy applies to the whole trace.<br>
    <br>
    Also, I may point you to a recently contributed Virtual Machine
    Analysis. Part of it is in master, some still on gerrit (the view
    for instance). The documentation is still unexistent. It works with
    the Qemu/KVM virtualizer, and needs some custom compilation of
    lttng-modules on both guest and host. It is still experimental. It
    allows to associate a host process with a guest CPU so that you can
    see on the guest whether the CPU was actually running or preempted
    on the host. If you're using Qemu/KVM and are interested in this
    analysis, I can work on the documentation sooner than later.<br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CA+=3DdQ-_DGAtobYX8W=3DmQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA@mail.=
gmail.com"
      type=3D"cite">
      <p dir=3D"ltr">I hope now I gave the clear picture of what I am
        doing. Please let me know if u need some explanation.=C2=A0 <br>
        &gt;<br>
        &gt;&gt; I tried the sessions at same time and communication
        events in between and it worked :)<br>
        &gt;&gt; I am getting quality as accurate and I can see both
        traces merged .<br>
        &gt;<br>
        &gt; Excellent!<br>
        &gt;<br>
        &gt;&gt;<br>
        &gt;&gt; Now I come at my second=C2=A0 point i.e taking traces fr=
om
        lttng sessions at different machines and at different time and
        may be communication events or might be not.<br>
        &gt;<br>
        &gt; If the sessions are taken are different moments, they can
        _never_ synchronize.</p>
      <p dir=3D"ltr">Yes I think you told that they can be analyzed by
        applying offset but not synchronized. </p>
      <p dir=3D"ltr"> Trace synchronization first matches events such tha=
t
        one single event from a trace (for example "sending a packet")
        can be correlated to exactly one event in the second trace (the
        reception of that packet). If that is the case, the first event
        can have a timestamp of now and the second be timed to January
        1st 1970, trace synchronization will work and the 2 traces will
        have a common time reference after synchronization.</p>
      <p dir=3D"ltr">What is the criteria of timestamps to be
        synchronized? How much two timestamps matched for
        synchronization<br>
      </p>
    </blockquote>
    There is no criteria for the timestamp. Matching events is the
    important part of the process. If you are interested in trace
    synchronization, I invite you to read this article by Masoume
    Jabbarifar [1]. It is at the base of what is implemented in Trace
    Compass.<br>
    <br>
    [1]
    <a class=3D"moz-txt-link-freetext" href=3D"http://link.springer.com/a=
rticle/10.1007/s10922-014-9331-7#page-1">http://link.springer.com/article=
/10.1007/s10922-014-9331-7#page-1</a><br>
    <br>
    <br>
    Genevi=C3=A8ve<br>
    <br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CA+=3DdQ-_DGAtobYX8W=3DmQUyJMPD8LD4b6FQDrnC9SqmQr_0gWAA@mail.=
gmail.com"
      type=3D"cite">
      <p dir=3D"ltr">
        &gt;<br>
        &gt;<br>
        &gt;&gt;<br>
        &gt;&gt; So In my opinion I need to apply time offset on one of
        the trace to match the beginning so that they can be
        synchronized . <br>
        &gt;&gt;<br>
        &gt;&gt; So like first trace timestamp starts at 07:13:59 .499
        222 870 and other starts at 11:21:35.537 682 885 . Then I can
        apply timeoffset ( How much offset ? In apply time offset
        advanced option If reference time is 7:13.... then target time
        will be 11:21:35... it will calculate the offset ) on one of the
        trace to match traces .<br>
        &gt;&gt;<br>
        &gt;&gt; Is it possible to synchronize the traces then ?
        Actually I tried these steps but not getting the synchronized
        traces but then both traces beginning is exactly same (
        obviously it will as applied by the offset) <br>
        &gt;&gt;<br>
        &gt;&gt; Please let me know how can I synchronize the traces
        from different machines and at different time <br>
        &gt;<br>
        &gt; I'm not sure what your end goal is exactly. Do you want to
        compare trace executions? I am cc'ing Fran=C3=A7ois Doray who is
        currently working on a trace comparison utility. Here's a
        presentation he did recently: <a moz-do-not-send=3D"true"
href=3D"http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%20Trac=
es%20to%20Diagnose%20Performance%20Variations.pdf">http://ahls.dorsal.pol=
ymtl.ca/system/files/Comparison%20of%20Traces%20to%20Diagnose%20Performan=
ce%20Variations.pdf</a><br>
        &gt;<br>
        &gt; His work is still experimental and available on github. If
        that's what you're interested in, he might give you some
        information on how to use it.<br>
        &gt;<br>
        &gt; Otherwise, please explain what you are trying to achieve.<br=
>
        &gt;<br>
        &gt; Genevi=C3=A8ve<br>
        &gt;<br>
        &gt;<br>
        &gt;<br>
        &gt;&gt; =C2=A0<br>
        &gt;&gt;<br>
        &gt;&gt;<br>
        &gt;&gt; On Thu, Jan 8, 2015 at 12:39 AM, Genevi=C3=A8ve Bastien =
&lt;<a
          moz-do-not-send=3D"true" href=3D"mailto:gbastien@versatic.net">=
gbastien@versatic.net</a>&gt;
        wrote:<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; On 15-01-07 11:32 AM, Divya Vyas wrote:<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; Hi ,<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; I have some comments below and thanks a lot for
        your help<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; On Jan 7, 2015 7:55 PM, "Genevi=C3=A8ve Bastien"
        &lt;<a moz-do-not-send=3D"true"
          href=3D"mailto:gbastien@versatic.net">gbastien@versatic.net</a>=
&gt;
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
        &gt;&gt;&gt;&gt; &gt;&gt; My target to is merge the traces of
        two different machines taken on different time or same time .<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt; Trace synchronization works by first
        matching events corresponding to the sending and the reception
        of a TCP packet from both traces, and then taking those matched
        events and computing a formula that will transform timestamps
        from one trace to the same clock as another trace. So only
        traces taken at the same time (meaning together, not the same
        clock time of course) will work.<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; I am not getting this last point , where the
        traces are taken together. You mean that we start lttng session
        on two machines at around same time and then during=C2=A0 session=
 use
        some communication events . Then take the traces into
        tracecompass for synchronization in experiment.=C2=A0 I am not
        getting in which cases time offset is needed?<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Yes, two sessions on two machines at the same time
        and they communicate during those sessions. Then you can
        synchronize traces. The following traces are used in unit tests
        to test trace synchronization if you wish to see what it looks
        like: <a moz-do-not-send=3D"true"
href=3D"http://archive.eclipse.org/tracecompass/test-traces/ctf/synctrace=
s.tar.gz">http://archive.eclipse.org/tracecompass/test-traces/ctf/synctra=
ces.tar.gz</a><br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; In what traces I need to apply time offset so
        that their beginning matches. Is it applicable on the above case
        which I am thinking above.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; You never _need_ to apply time offset. It is if you
        have traces that do not contain communication events, and you
        want one of them to be offsetted by a certain time. For example,
        you have a trace taken GST-5 and one at GST, you cannot
        synchronize them because they don't have communication events
        but you want to analyze them with the same time reference, you
        would offset the one at GST-5 by +5 hours.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Or if you have a custom event that you know
        happened at the same time on both traces, but synchronization
        does not support that event, then you can offset one trace so
        that both events from both traces have the same timestamp.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Time offsetting is a manual process by the user,
        while trace synchronization is an automatic analysis using
        pre-defined events to compute a formula to transform timestamps
        from one trace to the same clock as the other.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt; Actually synchronization was not
        working on different machine so I tried on same machine.=C2=A0 Bu=
t
        now I got it correctly I think so :)<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt; Indeed, you have the right events now,
        with the net_dev_queue and netif_receive_skb. So you should be
        OK. But I *think* this method works only when on a LAN. If your
        computers communicate through internet, you're better off with
        the inet_sock_local_[in|out] method<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; They are connected through LAN only.<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt; For different time we need to apply
        offset so that their beginning matches. I think I need to do
        this .<br>
        &gt;&gt;&gt;&gt; &gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt; I tried applying offset on eclipse
        luna ( I added linux tools in install new software)=C2=A0=C2=A0 b=
ut I am
        not getting this option " Apply time offset ". <br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt; It is in master only so far, so you should
        use tracecompass to have this option.<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt;<br>
        &gt;&gt;&gt;&gt; &gt;&gt; I tried on tracecompass also, where I
        am getting time offset option but the synchronization view is
        empty . The window is not showing anything. The tracecompass
        version is 0.1.0<br>
        &gt;&gt;&gt;&gt; &gt;<br>
        &gt;&gt;&gt;&gt; &gt; The time offset does not involve
        synchronization at all, it is just an offset, so you would not
        see anything in the synchronization view. But in the
        "Properties" view, when you select the trace, the time offset is
        displayed.<br>
        &gt;&gt;&gt;&gt;<br>
        &gt;&gt;&gt;&gt; I meant to say that I tried synchronizing the
        traces in tracecompass without time offset . The synchronizing
        view is empty.<br>
        &gt;&gt;&gt;&gt; It should show at least quality absent etc.<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Quality absent would show only if the traces are
        from different machines. If you are trying to synchronize traces
        from the same machine, that view will stay empty. <br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt; Genevi=C3=A8ve<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;&gt;<br>
        &gt;&gt;<br>
        &gt;<br>
      </p>
    </blockquote>
    <br>
  </body>
</html>

--------------040005020701090407020802--


--===============1918409413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1918409413==--
