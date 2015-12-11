From: John Smith <whalajam@gmail.com>
Subject: Re: performance improvement, stop channel tracing, etc
Date: Fri, 11 Dec 2015 15:13:08 -0800
Message-ID: <CANgVouXEHAfT9JHzc22ErRHt=hRbPVBWMMSDpUUVNKEBff0UsQ__40305.3880706013$1450132894$gmane$org@mail.gmail.com>
References: <CANgVouXut+oT0nddOXTd=GXSyysF+AU33wYVcG2eCALjx6MMMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722927542=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f175.google.com ([209.85.223.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1a7WsE-0003wR-B1
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 18:13:16 -0500
Received: by iojd73 with SMTP id d73so24202503ioj.3
 for <lttng-dev@lists.lttng.org>; Fri, 11 Dec 2015 15:13:08 -0800 (PST)
In-Reply-To: <CANgVouXut+oT0nddOXTd=GXSyysF+AU33wYVcG2eCALjx6MMMg@mail.gmail.com>
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

--===============1722927542==
Content-Type: multipart/alternative; boundary=001a113ec554713f610526a77762

--001a113ec554713f610526a77762
Content-Type: text/plain; charset=UTF-8

Forgot few more:

5) CPU and hostname are by default part of the channel context, is it any
way to remove them from the output? there are options to add context but
how do we remove the ones the are there by default?

6) "lttng view": we need to look at session files that have been moved from
its initial location (that was at trace capture time), is it a way to
achieve that?
Also, we'd like to "view" traces per channel based and not the whole
session, is it a way to do so?

thanks, John

On Thu, Dec 10, 2015 at 8:44 PM, John Smith <whalajam@gmail.com> wrote:

> Hi,
> I have a couple of questions, here they are:
>
> 1) tracing latency, on a simple loop tracing test I noticed the latency is
> around 400ns on a 3.2GHz processor, are there ways to reduce this latency?
> One thought about RCU, it is an efficient mechanism for multiple writers
> but when there is a single source for the events, it may not be
> necessary, my understanding is that the trace collection/read is done when
> the sub-buffer is not been populated/written.
>
> 2) I noticed the log [delta] interval (2-nd value) is not actually the
> difference between the two sequential traces (of the same event)
> timestamps, did I miss anything and it represents something else or is a
> bug?
>
> 3) Is there an api available to stop a channel tracing while session has
> started ("lttng start") and of course before it has ended ("lttng stop")?
> That would be useful if we want to stop tracing in case of critical events.
>
> 4) it would be useful if the tracepoint() (I know is a macro now) would
> return some information about the success, overwrite or discard (depending
> on the channel configuration) of the event, is it a way to get this
> information currently?
>
>
> thanks, John
>

--001a113ec554713f610526a77762
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Forgot few more:</div><div><br></div><div>5) CPU and =
hostname are by default part of the channel context, is it any way to remov=
e them from the output? there are options to add context but how do we remo=
ve the ones the are there by default?</div><div><br></div><div>6) &quot;ltt=
ng view&quot;: we need to look at session files that have been moved from i=
ts initial location (that was at trace capture time), is it a way to achiev=
e that?</div><div>Also, we&#39;d like to &quot;view&quot; traces per channe=
l based and not the whole session, is it a way to do so?</div><div><br></di=
v><div>thanks, John</div></div><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Thu, Dec 10, 2015 at 8:44 PM, John Smith <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:whalajam@gmail.com" target=3D"_blank">whalajam@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"lt=
r"><div>Hi,</div><div>I have a couple of=C2=A0questions, here they are:</di=
v><div><br></div><div>1)=C2=A0tracing latency, on a simple loop tracing tes=
t I noticed the latency is around 400ns on a 3.2GHz processor,=C2=A0are=C2=
=A0there ways to reduce this latency? </div><div>One thought about RCU, it=
=C2=A0is an efficient mechanism for multiple writers but when there is a si=
ngle source for the events, it may not be necessary,=C2=A0my understanding =
is=C2=A0that the trace collection/read is done when the sub-buffer is not b=
een populated/written.</div><div><br></div><div>2) I noticed the log [delta=
] interval (2-nd value) is not actually the difference between the two sequ=
ential traces (of the same event) timestamps, did I miss=C2=A0anything=C2=
=A0and it represents something else or is a bug?</div><div><br></div><div>3=
) Is there an api available=C2=A0to stop a channel tracing while session ha=
s started (&quot;lttng start&quot;) and of course before it has ended (&quo=
t;lttng stop&quot;)?</div><div>That would be useful if we want to stop trac=
ing in case of critical events.</div><div><br></div><div>4) it would be use=
ful if the tracepoint() (I know is a macro now) would return some informati=
on about the success, overwrite or discard (depending on the channel config=
uration) of the event, is it a way to get this information currently?</div>=
<div><br></div><div><br></div><div>thanks, John</div></div>
</blockquote></div><br></div>

--001a113ec554713f610526a77762--


--===============1722927542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1722927542==--
