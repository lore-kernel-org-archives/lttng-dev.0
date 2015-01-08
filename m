From: =?UTF-8?B?R2VuZXZpw6h2ZSBCYXN0aWVu?= <gbastien@versatic.net>
Subject: Re: Merge two LTTng CTF traces into one
Date: Thu, 08 Jan 2015 11:42:32 -0500
Message-ID: <54AEB378.8090101__23647.9842722931$1420735468$gmane$org@versatic.net>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0082422491=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout.easydns.com ([64.68.201.141])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gbastien@versatic.net>) id 1Y9GAS-0000tF-2C
 for lttng-dev@lists.lttng.org; Thu, 08 Jan 2015 11:42:47 -0500
In-Reply-To: <CA+=dQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <dvyas@mvista.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: =?UTF-8?B?RnJhbsOnb2lzIERvcmF5?= <francois.doray@gmail.com>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0082422491==
Content-Type: multipart/alternative;
 boundary="------------050300060309060902080002"

This is a multi-part message in MIME format.
--------------050300060309060902080002
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t08Ggv2e008234

Hi Divya,

I'm putting you back on the lttng-dev mailing list, please reply to that=20
list in the future so other people can answer, because I think that=20
trace synchronization is not exactly what you are looking for here...

> I tried the sessions at same time and communication events in between=20
> and it worked :)
> I am getting quality as accurate and I can see both traces merged .
Excellent!
>
> Now I come at my second  point i.e taking traces from lttng sessions=20
> at different machines and at different time and may be communication=20
> events or might be not.
If the sessions are taken are different moments, they can _never_=20
synchronize. Trace synchronization first matches events such that one=20
single event from a trace (for example "sending a packet") can be=20
correlated to exactly one event in the second trace (the reception of=20
that packet). If that is the case, the first event can have a timestamp=20
of now and the second be timed to January 1st 1970, trace=20
synchronization will work and the 2 traces will have a common time=20
reference after synchronization.

>
> So In my opinion I need to apply time offset on one of the trace to=20
> match the beginning so that they can be synchronized .
>
> So like first trace timestamp starts at 07:13:59 .499 222 870 and=20
> other starts at 11:21:35.537 682 885 . Then I can apply timeoffset (=20
> How much offset ? In apply time offset advanced option If reference=20
> time is 7:13.... then target time will be 11:21:35... it will=20
> calculate the offset ) on one of the trace to match traces .
>
> Is it possible to synchronize the traces then ? Actually I tried these=20
> steps but not getting the synchronized traces but then both traces=20
> beginning is exactly same ( obviously it will as applied by the offset)
>
> Please let me know how can I synchronize the traces from different=20
> machines and at different time
I'm not sure what your end goal is exactly. Do you want to compare trace=20
executions? I am cc'ing Fran=C3=A7ois Doray who is currently working on a=
=20
trace comparison utility. Here's a presentation he did recently:=20
http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%20Traces%20to%=
20Diagnose%20Performance%20Variations.pdf

His work is still experimental and available on github. If that's what=20
you're interested in, he might give you some information on how to use it.

Otherwise, please explain what you are trying to achieve.

Genevi=C3=A8ve


>
>
> On Thu, Jan 8, 2015 at 12:39 AM, Genevi=C3=A8ve Bastien=20
> <gbastien@versatic.net <mailto:gbastien@versatic.net>> wrote:
>
>     On 15-01-07 11:32 AM, Divya Vyas wrote:
>>
>>     Hi ,
>>
>>     I have some comments below and thanks a lot for your help
>>
>>     On Jan 7, 2015 7:55 PM, "Genevi=C3=A8ve Bastien"
>>     <gbastien@versatic.net <mailto:gbastien@versatic.net>> wrote:
>>     >
>>     > Hi Divya,
>>     >
>>     >
>>     > On 15-01-07 01:24 AM, Divya Vyas wrote:
>>     >>
>>     >>
>>     >> Hi Genevieve,
>>     >>
>>     >> My target to is merge the traces of two different machines
>>     taken on different time or same time .
>>     >
>>     > Trace synchronization works by first matching events
>>     corresponding to the sending and the reception of a TCP packet
>>     from both traces, and then taking those matched events and
>>     computing a formula that will transform timestamps from one trace
>>     to the same clock as another trace. So only traces taken at the
>>     same time (meaning together, not the same clock time of course)
>>     will work.
>>
>>     I am not getting this last point , where the traces are taken
>>     together. You mean that we start lttng session on two machines at
>>     around same time and then during  session use some communication
>>     events . Then take the traces into tracecompass for
>>     synchronization in experiment.  I am not getting in which cases
>>     time offset is needed?
>>
>
>     Yes, two sessions on two machines at the same time and they
>     communicate during those sessions. Then you can synchronize
>     traces. The following traces are used in unit tests to test trace
>     synchronization if you wish to see what it looks like:
>     http://archive.eclipse.org/tracecompass/test-traces/ctf/synctraces.=
tar.gz
>
>>     In what traces I need to apply time offset so that their
>>     beginning matches. Is it applicable on the above case which I am
>>     thinking above.
>>
>
>     You never _need_ to apply time offset. It is if you have traces
>     that do not contain communication events, and you want one of them
>     to be offsetted by a certain time. For example, you have a trace
>     taken GST-5 and one at GST, you cannot synchronize them because
>     they don't have communication events but you want to analyze them
>     with the same time reference, you would offset the one at GST-5 by
>     +5 hours.
>
>     Or if you have a custom event that you know happened at the same
>     time on both traces, but synchronization does not support that
>     event, then you can offset one trace so that both events from both
>     traces have the same timestamp.
>
>     Time offsetting is a manual process by the user, while trace
>     synchronization is an automatic analysis using pre-defined events
>     to compute a formula to transform timestamps from one trace to the
>     same clock as the other.
>
>>     >
>>     >
>>     >>
>>     >> Actually synchronization was not working on different machine
>>     so I tried on same machine.  But now I got it correctly I think so=
 :)
>>     >
>>     > Indeed, you have the right events now, with the net_dev_queue
>>     and netif_receive_skb. So you should be OK. But I *think* this
>>     method works only when on a LAN. If your computers communicate
>>     through internet, you're better off with the
>>     inet_sock_local_[in|out] method
>>
>>     They are connected through LAN only.
>>
>>     >
>>     >>
>>     >> For different time we need to apply offset so that their
>>     beginning matches. I think I need to do this .
>>     >>
>>     >> I tried applying offset on eclipse luna ( I added linux tools
>>     in install new software)   but I am not getting this option "
>>     Apply time offset ".
>>     >
>>     > It is in master only so far, so you should use tracecompass to
>>     have this option.
>>     >
>>     >>
>>     >> I tried on tracecompass also, where I am getting time offset
>>     option but the synchronization view is empty . The window is not
>>     showing anything. The tracecompass version is 0.1.0
>>     >
>>     > The time offset does not involve synchronization at all, it is
>>     just an offset, so you would not see anything in the
>>     synchronization view. But in the "Properties" view, when you
>>     select the trace, the time offset is displayed.
>>
>>     I meant to say that I tried synchronizing the traces in
>>     tracecompass without time offset . The synchronizing view is empty.
>>     It should show at least quality absent etc.
>>
>
>     Quality absent would show only if the traces are from different
>     machines. If you are trying to synchronize traces from the same
>     machine, that view will stay empty.
>
>     Genevi=C3=A8ve
>
>
>


--------------050300060309060902080002
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t08Ggv2e008234

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div>Hi Divya,<br>
      <br>
      I'm putting you back on the lttng-dev mailing list, please reply
      to that list in the future so other people can answer, because I
      think that trace synchronization is not exactly what you are
      looking for here...<br>
      <br>
    </div>
    <blockquote
cite=3D"mid:CA+=3DdQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gm=
ail.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div>
                  <div>I tried the sessions at same time and
                    communication events in between and it worked :)<br>
                  </div>
                  I am getting quality as accurate and I can see both
                  traces merged .<br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Excellent!<br>
    <blockquote
cite=3D"mid:CA+=3DdQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gm=
ail.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div>
                <div><br>
                </div>
                Now I come at my second=C2=A0 point i.e taking traces fro=
m
                lttng sessions at different machines and at different
                time and may be communication events or might be not.<br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    If the sessions are taken are different moments, they can _never_
    synchronize. Trace synchronization first matches events such that
    one single event from a trace (for example "sending a packet") can
    be correlated to exactly one event in the second trace (the
    reception of that packet). If that is the case, the first event can
    have a timestamp of now and the second be timed to January 1st 1970,
    trace synchronization will work and the 2 traces will have a common
    time reference after synchronization.<br>
    <br>
    <blockquote
cite=3D"mid:CA+=3DdQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gm=
ail.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>
              <div><br>
              </div>
              So In my opinion I need to apply time offset on one of the
              trace to match the beginning so that they can be
              synchronized . <br>
              <br>
            </div>
            So like first trace timestamp starts at 07:13:59 .499 222
            870 and other starts at 11:21:35.537 682 885 . Then I can
            apply timeoffset ( How much offset ? In apply time offset
            advanced option If reference time is 7:13.... then target
            time will be 11:21:35... it will calculate the offset ) on
            one of the trace to match traces .<br>
            <br>
          </div>
          Is it possible to synchronize the traces then ? Actually I
          tried these steps but not getting the synchronized traces but
          then both traces beginning is exactly same ( obviously it will
          as applied by the offset) <br>
          <br>
        </div>
        Please let me know how can I synchronize the traces from
        different machines and at different time <br>
      </div>
    </blockquote>
    I'm not sure what your end goal is exactly. Do you want to compare
    trace executions? I am cc'ing Fran=C3=A7ois Doray who is currently
    working on a trace comparison utility. Here's a presentation he did
    recently:
<a class=3D"moz-txt-link-freetext" href=3D"http://ahls.dorsal.polymtl.ca/=
system/files/Comparison%20of%20Traces%20to%20Diagnose%20Performance%20Var=
iations.pdf">http://ahls.dorsal.polymtl.ca/system/files/Comparison%20of%2=
0Traces%20to%20Diagnose%20Performance%20Variations.pdf</a><br>
    <br>
    His work is still experimental and available on github. If that's
    what you're interested in, he might give you some information on how
    to use it.<br>
    <br>
    Otherwise, please explain what you are trying to achieve.<br>
    <br>
    Genevi=C3=A8ve<br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CA+=3DdQ-_u2D47dkEt_20YeGBZYBOTiADX6BWq8FR-7XWaOko10A@mail.gm=
ail.com"
      type=3D"cite">
      <div dir=3D"ltr">=C2=A0
        <div>
          <div>
            <div>
              <div>
                <div><br>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">On Thu, Jan 8, 2015 at 12:39 AM,
          Genevi=C3=A8ve Bastien <span dir=3D"ltr">&lt;<a
              moz-do-not-send=3D"true" href=3D"mailto:gbastien@versatic.n=
et"
              target=3D"_blank">gbastien@versatic.net</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
                <div>On 15-01-07 11:32 AM, Divya Vyas wrote:<br>
                </div>
                <blockquote type=3D"cite">
                  <p dir=3D"ltr">Hi ,</p>
                  <p dir=3D"ltr">I have some comments below and thanks a
                    lot for your help</p>
                  <p dir=3D"ltr">On Jan 7, 2015 7:55 PM, "Genevi=C3=A8ve
                    Bastien" &lt;<a moz-do-not-send=3D"true"
                      href=3D"mailto:gbastien@versatic.net"
                      target=3D"_blank">gbastien@versatic.net</a>&gt;
                    wrote:<br>
                    &gt;<br>
                    &gt; Hi Divya,<br>
                    &gt;<br>
                    &gt;<br>
                    &gt; On 15-01-07 01:24 AM, Divya Vyas wrote:<br>
                    &gt;&gt;<br>
                    &gt;&gt;<br>
                    &gt;&gt; Hi Genevieve,<br>
                    &gt;&gt;<br>
                    &gt;&gt; My target to is merge the traces of two
                    different machines taken on different time or same
                    time .<br>
                    &gt;<br>
                    &gt; Trace synchronization works by first matching
                    events corresponding to the sending and the
                    reception of a TCP packet from both traces, and then
                    taking those matched events and computing a formula
                    that will transform timestamps from one trace to the
                    same clock as another trace. So only traces taken at
                    the same time (meaning together, not the same clock
                    time of course) will work.<br>
                  </p>
                  <p dir=3D"ltr">I am not getting this last point , where
                    the traces are taken together. You mean that we
                    start lttng session on two machines at around same
                    time and then during=C2=A0 session use some communica=
tion
                    events . Then take the traces into tracecompass for
                    synchronization in experiment.=C2=A0 I am not getting=
 in
                    which cases time offset is needed? </p>
                </blockquote>
                <br>
              </span> Yes, two sessions on two machines at the same time
              and they communicate during those sessions. Then you can
              synchronize traces. The following traces are used in unit
              tests to test trace synchronization if you wish to see
              what it looks like:
              <a moz-do-not-send=3D"true"
href=3D"http://archive.eclipse.org/tracecompass/test-traces/ctf/synctrace=
s.tar.gz"
                target=3D"_blank">http://archive.eclipse.org/tracecompass=
/test-traces/ctf/synctraces.tar.gz</a><span
                class=3D""><br>
                <br>
                <blockquote type=3D"cite">
                  <p dir=3D"ltr">In what traces I need to apply time
                    offset so that their beginning matches. Is it
                    applicable on the above case which I am thinking
                    above.<br>
                  </p>
                </blockquote>
                <br>
              </span> You never _need_ to apply time offset. It is if
              you have traces that do not contain communication events,
              and you want one of them to be offsetted by a certain
              time. For example, you have a trace taken GST-5 and one at
              GST, you cannot synchronize them because they don't have
              communication events but you want to analyze them with the
              same time reference, you would offset the one at GST-5 by
              +5 hours.<br>
              <br>
              Or if you have a custom event that you know happened at
              the same time on both traces, but synchronization does not
              support that event, then you can offset one trace so that
              both events from both traces have the same timestamp.<br>
              <br>
              Time offsetting is a manual process by the user, while
              trace synchronization is an automatic analysis using
              pre-defined events to compute a formula to transform
              timestamps from one trace to the same clock as the other.<s=
pan
                class=3D""><br>
                <br>
                <blockquote type=3D"cite">
                  <p dir=3D"ltr"> &gt;<br>
                    &gt;<br>
                    &gt;&gt;<br>
                    &gt;&gt; Actually synchronization was not working on
                    different machine so I tried on same machine.=C2=A0 B=
ut
                    now I got it correctly I think so :)<br>
                    &gt;<br>
                    &gt; Indeed, you have the right events now, with the
                    net_dev_queue and netif_receive_skb. So you should
                    be OK. But I *think* this method works only when on
                    a LAN. If your computers communicate through
                    internet, you're better off with the
                    inet_sock_local_[in|out] method</p>
                  <p dir=3D"ltr">They are connected through LAN only.<br>
                  </p>
                  <p dir=3D"ltr">&gt;<br>
                    &gt;&gt;<br>
                    &gt;&gt; For different time we need to apply offset
                    so that their beginning matches. I think I need to
                    do this .<br>
                    &gt;&gt;<br>
                    &gt;&gt; I tried applying offset on eclipse luna ( I
                    added linux tools in install new software)=C2=A0=C2=A0=
 but I
                    am not getting this option " Apply time offset ". <br=
>
                    &gt;<br>
                    &gt; It is in master only so far, so you should use
                    tracecompass to have this option.<br>
                    &gt;<br>
                    &gt;&gt;<br>
                    &gt;&gt; I tried on tracecompass also, where I am
                    getting time offset option but the synchronization
                    view is empty . The window is not showing anything.
                    The tracecompass version is 0.1.0<br>
                    &gt;<br>
                    &gt; The time offset does not involve
                    synchronization at all, it is just an offset, so you
                    would not see anything in the synchronization view.
                    But in the "Properties" view, when you select the
                    trace, the time offset is displayed.</p>
                  <p dir=3D"ltr">I meant to say that I tried synchronizin=
g
                    the traces in tracecompass without time offset . The
                    synchronizing view is empty.<br>
                    It should show at least quality absent etc. </p>
                </blockquote>
                <br>
              </span> Quality absent would show only if the traces are
              from different machines. If you are trying to synchronize
              traces from the same machine, that view will stay empty. <b=
r>
              <span class=3D"HOEnZb"><font color=3D"#888888"> <br>
                  Genevi=C3=A8ve<br>
                  <br>
                  <br>
                </font></span></div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------050300060309060902080002--


--===============0082422491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0082422491==--
