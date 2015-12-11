From: John Smith <whalajam@gmail.com>
Subject: performance improvement, stop channel tracing, etc
Date: Thu, 10 Dec 2015 20:44:40 -0800
Message-ID: <CANgVouXut+oT0nddOXTd=GXSyysF+AU33wYVcG2eCALjx6MMMg__39983.7227575064$1450132867$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0045460626=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1a7FZV-0006Xx-VR
 for lttng-dev@lists.lttng.org; Thu, 10 Dec 2015 23:44:47 -0500
Received: by mail-ig0-f180.google.com with SMTP id su19so31400261igc.0
 for <lttng-dev@lists.lttng.org>; Thu, 10 Dec 2015 20:44:45 -0800 (PST)
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

--===============0045460626==
Content-Type: multipart/alternative; boundary=047d7b3a98ae3cb20b052697fb98

--047d7b3a98ae3cb20b052697fb98
Content-Type: text/plain; charset=UTF-8

Hi,
I have a couple of questions, here they are:

1) tracing latency, on a simple loop tracing test I noticed the latency is
around 400ns on a 3.2GHz processor, are there ways to reduce this latency?
One thought about RCU, it is an efficient mechanism for multiple writers
but when there is a single source for the events, it may not be
necessary, my understanding is that the trace collection/read is done when
the sub-buffer is not been populated/written.

2) I noticed the log [delta] interval (2-nd value) is not actually the
difference between the two sequential traces (of the same event)
timestamps, did I miss anything and it represents something else or is a
bug?

3) Is there an api available to stop a channel tracing while session has
started ("lttng start") and of course before it has ended ("lttng stop")?
That would be useful if we want to stop tracing in case of critical events.

4) it would be useful if the tracepoint() (I know is a macro now) would
return some information about the success, overwrite or discard (depending
on the channel configuration) of the event, is it a way to get this
information currently?


thanks, John

--047d7b3a98ae3cb20b052697fb98
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I have a couple of=C2=A0questions, here=
 they are:</div><div><br></div><div>1)=C2=A0tracing latency, on a simple lo=
op tracing test I noticed the latency is around 400ns on a 3.2GHz processor=
,=C2=A0are=C2=A0there ways to reduce this latency? </div><div>One thought a=
bout RCU, it=C2=A0is an efficient mechanism for multiple writers but when t=
here is a single source for the events, it may not be necessary,=C2=A0my un=
derstanding is=C2=A0that the trace collection/read is done when the sub-buf=
fer is not been populated/written.</div><div><br></div><div>2) I noticed th=
e log [delta] interval (2-nd value) is not actually the difference between =
the two sequential traces (of the same event) timestamps, did I miss=C2=A0a=
nything=C2=A0and it represents something else or is a bug?</div><div><br></=
div><div>3) Is there an api available=C2=A0to stop a channel tracing while =
session has started (&quot;lttng start&quot;) and of course before it has e=
nded (&quot;lttng stop&quot;)?</div><div>That would be useful if we want to=
 stop tracing in case of critical events.</div><div><br></div><div>4) it wo=
uld be useful if the tracepoint() (I know is a macro now) would return some=
 information about the success, overwrite or discard (depending on the chan=
nel configuration) of the event, is it a way to get this information curren=
tly?</div><div><br></div><div><br></div><div>thanks, John</div></div>

--047d7b3a98ae3cb20b052697fb98--


--===============0045460626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0045460626==--
