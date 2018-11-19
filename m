From: mrx <patrik.mrx@gmail.com>
Subject: Re: A question on protocols
Date: Mon, 19 Nov 2018 15:47:21 +0100
Message-ID: <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g__21974.7935575016$1542638739$gmane$org@mail.gmail.com>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
 <20181116171557.GA23758@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4085601958733457036=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by lists.lttng.org (Postfix) with ESMTPS id 42zBWq002mzrpR
 for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2018 09:47:34 -0500 (EST)
Received: by mail-io1-xd36.google.com with SMTP id f6so19372617iob.1
 for <lttng-dev@lists.lttng.org>; Mon, 19 Nov 2018 06:47:34 -0800 (PST)
In-Reply-To: <20181116171557.GA23758@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: jonathan.rajotte-julien@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4085601958733457036==
Content-Type: multipart/alternative; boundary="000000000000dcfc53057b059871"

--000000000000dcfc53057b059871
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 6:16 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Patrick,
>
> On Fri, Nov 16, 2018 at 09:49:52AM +0100, mrx wrote:
> > Hi,
> >
> > I have a need to collect LTTng live-traces from systems with very limit=
ed
> > RAM
> > and flash resources. This tracing will be running continuesly for month=
s
> > monitoring our systems. The only way for me to transport those CTF
> records
> > somewhere else is via HTTP proxy. LTTng doesn't seem to have support fo=
r
> > sending
> > over proxies at all. So I think I really have a challenge a head of me,
> if
> > this
> > is at all possible.
>
> VPN through http proxy. Better alternative would be to speak with your
> sysadmin
> and see what you can do. Keep in mind that the protocol between relayd an=
d
> consumer is in no way "secure".
>

The security between consumerd and relayd isn't an issue as we'd be forced
to keep both on the device. This because we have no way of transporting the
consumerd <-> relayd communication over the HTTP proxy, which is our only
choice. We have already talked to the team in charge of the network paths.


>
> >
> > The plan is to write my own relayd from which I can then stream the
> > received CTF
> > records + metadata to where I can analyze them. For this to work I need
> > documentation on the protocol between consumerd and relayd. I cannot fi=
nd
> > the
> > documentation for this, where can I find it?
>
> The source code.
>
> >
> > Do you think this is a viable solution?
>
> Doubt it. But we never know.
>
> >
> > Once I receive the data where I have the possiblity to analyze it. Then
> I'm
> > not
> > sure if I'm required to write everything to the file system to be able =
to
> > analyze the data. How would I then rotate the logs on disc so I can cle=
an
> > up?
>
> The 2.11 release will include a new feature for session rotation.
>
> See this presentation [1] from J=C3=A9r=C3=A9mie Galarneau explaining how=
 the
> session rotation
> can be used.
>
> [1]
> https://events.linuxfoundation.org/wp-content/uploads/2017/12/Fine-graine=
d-Distributed-Application-Monitoring-Using-LTTng-J%C3%A9r%C3%A9mie-Galarnea=
u-EfficiOS.pdf


I'll for sure look into this.


>
>
>
> > The best for me would be if I didn't have to go via disc at all I think=
.
> >
> > Are there any others working on similar solution, if so, how are they
> > solving this?
> > How would you recommend I solve this?
>
> I would go for session rotation via relayd (not in live mode) with a daem=
on
> watching for ready-to-consume chunks. You can adjust for the granularity
> you need at the target level.
>
> This could be done close to the target then compress the trace chunks and
> send them
> over http(s) to the monitoring pipeline.
>
> >
> > The reason the current relayd doesn't work for me is two-fold:
> > 1. I cannot get relayd to not write down the trace to disc. Can you
> control
> > this at all for live tracing?
>
> What is the real reason for not writing to disk on the relayd side?
>

The relayd side have to be on the device. The device has very limited
amounts of free flash. Even if there were flash available it would wear
down the flash faster than what we'd like.


>
> > 2. I cannot find the documentation for the relayd <-> viewer protocol.
> > Where can I find it?
>
> Source code. The initial design proposal is under doc/ in the lttng-tools
> tree.
>

Thanks!


>
> >
> > It might be that storing the traces on disc is a pre-requisite for
> serving a
> > viewer properly. Perhaps it's just something required by relayd based o=
n
> > how it works internally. I don't know.
>
> You can look at relayd as a specialized ftp server. The user is
> responsible in
> managing the lifetime of the traces generated. The live protocol simply
> allow a
> viewer to see the trace as it get received/stored.
>

That helps in visualizing the different components for me, thanks for that!

It also clarifies some of the problems we face with using relayd as a
solution to our problem.


>
> Nothing prevent you to output on a tmpfs (ramdisk) if hitting the disk is
> such a
> problem.
>

A RAM-based disc might have been a solution if we would have had any
mentionable amounts of RAM to spare for this. Unfortunately we don't have
that.


>
> Keep in mind that trace production is normally much more quicker than tra=
ce
> reading/analysis. A buffering scheme is mostly always necessary.
>

Very valid point, I'll for sure keep that in mind.

This speaks strongly against replacing relayd with something homebrewed, as
was the original plan. We'd probably not be able to shuffle the data fast
enough over the network to keep up with the pace.


>
> You can also use the --trace-file-size and --trace-file-count to limit th=
e
> disk
> footprint of each live session. Make sure to have enough buffer for live
> reading if still using live.
>

This isn't an option as our disc is flash based and we'd like to limit the
wear due to collecting metrics.

Thanks for your insights, much appreciated.

// Patrik

--000000000000dcfc53057b059871
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, No=
v 16, 2018 at 6:16 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonatha=
n.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi Patrick,<br>
<br>
On Fri, Nov 16, 2018 at 09:49:52AM +0100, mrx wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; I have a need to collect LTTng live-traces from systems with very limi=
ted<br>
&gt; RAM<br>
&gt; and flash resources. This tracing will be running continuesly for mont=
hs<br>
&gt; monitoring our systems. The only way for me to transport those CTF rec=
ords<br>
&gt; somewhere else is via HTTP proxy. LTTng doesn&#39;t seem to have suppo=
rt for<br>
&gt; sending<br>
&gt; over proxies at all. So I think I really have a challenge a head of me=
, if<br>
&gt; this<br>
&gt; is at all possible.<br>
<br>
VPN through http proxy. Better alternative would be to speak with your sysa=
dmin<br>
and see what you can do. Keep in mind that the protocol between relayd and<=
br>
consumer is in no way &quot;secure&quot;.<br></blockquote><div><br></div><d=
iv>The security between consumerd and relayd isn&#39;t an issue as we&#39;d=
 be forced to keep both on the device. This because we have no way of trans=
porting the consumerd &lt;-&gt; relayd communication over the HTTP proxy, w=
hich is our only choice. We have already talked to the team in charge of th=
e network paths.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; The plan is to write my own relayd from which I can then stream the<br=
>
&gt; received CTF<br>
&gt; records + metadata to where I can analyze them. For this to work I nee=
d<br>
&gt; documentation on the protocol between consumerd and relayd. I cannot f=
ind<br>
&gt; the<br>
&gt; documentation for this, where can I find it?<br>
<br>
The source code.<br>
<br>
&gt; <br>
&gt; Do you think this is a viable solution?<br>
<br>
Doubt it. But we never know.<br>
<br>
&gt; <br>
&gt; Once I receive the data where I have the possiblity to analyze it. The=
n I&#39;m<br>
&gt; not<br>
&gt; sure if I&#39;m required to write everything to the file system to be =
able to<br>
&gt; analyze the data. How would I then rotate the logs on disc so I can cl=
ean<br>
&gt; up?<br>
<br>
The 2.11 release will include a new feature for session rotation.<br>
<br>
See this presentation [1] from J=C3=A9r=C3=A9mie Galarneau explaining how t=
he session rotation<br>
can be used.<br>
<br>
[1] <a href=3D"https://events.linuxfoundation.org/wp-content/uploads/2017/1=
2/Fine-grained-Distributed-Application-Monitoring-Using-LTTng-J%C3%A9r%C3%A=
9mie-Galarneau-EfficiOS.pdf" rel=3D"noreferrer" target=3D"_blank">https://e=
vents.linuxfoundation.org/wp-content/uploads/2017/12/Fine-grained-Distribut=
ed-Application-Monitoring-Using-LTTng-J%C3%A9r%C3%A9mie-Galarneau-EfficiOS.=
pdf</a></blockquote><div><br></div><div>I&#39;ll for sure look into this.<b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
<br>
&gt; The best for me would be if I didn&#39;t have to go via disc at all I =
think.<br>
&gt; <br>
&gt; Are there any others working on similar solution, if so, how are they<=
br>
&gt; solving this?<br>
&gt; How would you recommend I solve this?<br>
<br>
I would go for session rotation via relayd (not in live mode) with a daemon=
<br>
watching for ready-to-consume chunks. You can adjust for the granularity<br=
>
you need at the target level.<br>
<br>
This could be done close to the target then compress the trace chunks and s=
end them<br>
over http(s) to the monitoring pipeline.<br>
<br>
&gt; <br>
&gt; The reason the current relayd doesn&#39;t work for me is two-fold:<br>
&gt; 1. I cannot get relayd to not write down the trace to disc. Can you co=
ntrol<br>
&gt; this at all for live tracing?<br>
<br>
What is the real reason for not writing to disk on the relayd side?<br></bl=
ockquote><div><br></div><div>The relayd side have to be on the device. The =
device has very limited amounts of free flash. Even if there were flash ava=
ilable it would wear down the flash faster than what we&#39;d like.<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; 2. I cannot find the documentation for the relayd &lt;-&gt; viewer pro=
tocol.<br>
&gt; Where can I find it?<br>
<br>
Source code. The initial design proposal is under doc/ in the lttng-tools t=
ree.<br></blockquote><div><br></div><div>Thanks!<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; It might be that storing the traces on disc is a pre-requisite for ser=
ving a<br>
&gt; viewer properly. Perhaps it&#39;s just something required by relayd ba=
sed on<br>
&gt; how it works internally. I don&#39;t know.<br>
<br>
You can look at relayd as a specialized ftp server. The user is responsible=
 in<br>
managing the lifetime of the traces generated. The live protocol simply all=
ow a<br>
viewer to see the trace as it get received/stored.<br></blockquote><div><br=
></div><div>That helps in visualizing the different components for me, than=
ks for that!</div><div><br></div><div>It also clarifies some of the problem=
s we face with using relayd as a solution to our problem.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<br>
Nothing prevent you to output on a tmpfs (ramdisk) if hitting the disk is s=
uch a<br>
problem.<br></blockquote><div><br></div><div>A RAM-based disc might have be=
en a solution if we would have had any mentionable amounts of RAM to spare =
for this. Unfortunately we don&#39;t have that.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<br>
Keep in mind that trace production is normally much more quicker than trace=
<br>
reading/analysis. A buffering scheme is mostly always necessary.<br></block=
quote><div><br></div><div>Very valid point, I&#39;ll for sure keep that in =
mind.</div><div><br></div><div>This speaks strongly against replacing relay=
d with something homebrewed, as was the original plan. We&#39;d probably no=
t be able to shuffle the data fast enough over the network to keep up with =
the pace.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
You can also use the --trace-file-size and --trace-file-count to limit the =
disk<br>
footprint of each live session. Make sure to have enough buffer for live<br=
>
reading if still using live.<br></blockquote><div><br></div><div>This isn&#=
39;t an option as our disc is flash based and we&#39;d like to limit the we=
ar due to collecting metrics.</div><div><br></div><div>Thanks for your insi=
ghts, much appreciated.</div><div><br></div><div>// Patrik<br></div></div><=
/div>

--000000000000dcfc53057b059871--

--===============4085601958733457036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4085601958733457036==--
