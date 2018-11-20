From: mrx <patrik.mrx@gmail.com>
Subject: Re: A question on protocols
Date: Tue, 20 Nov 2018 12:02:16 +0100
Message-ID: <CANzOjBg2J-N=BaVesc=WKWwJMiOUX+FsunTdzZBUM-tNvOC7bw__10841.0867200748$1542711634$gmane$org@mail.gmail.com>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
 <20181116171557.GA23758@joraj-alpa>
 <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g@mail.gmail.com>
 <20181119184641.GA8739@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6193539365396477017=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x134.google.com (mail-it1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 by lists.lttng.org (Postfix) with ESMTPS id 42zjTd2dWszqdw
 for <lttng-dev@lists.lttng.org>; Tue, 20 Nov 2018 06:02:29 -0500 (EST)
Received: by mail-it1-x134.google.com with SMTP id x19so2711926itl.1
 for <lttng-dev@lists.lttng.org>; Tue, 20 Nov 2018 03:02:28 -0800 (PST)
In-Reply-To: <20181119184641.GA8739@joraj-alpa>
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

--===============6193539365396477017==
Content-Type: multipart/alternative; boundary="000000000000b42591057b169128"

--000000000000b42591057b169128
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 19, 2018 at 7:46 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Patrick,
>
> > The security between consumerd and relayd isn't an issue as we'd be
> forced
> > to keep both on the device. This because we have no way of transporting
> the
> > consumerd <-> relayd communication over the HTTP proxy, which is our only
> > choice. We have already talked to the team in charge of the network
> paths.
>
> In that case using lttng-relayd yield no advantage unless you are able to
> have
> a device running only lttng-relayd and gathering data from other devices
> and
> then sending the data via http.
>

Unfortunately, we're don't have any external device that can run the
lttng-relayd component.


>
>
> >
> > The relayd side have to be on the device. The device has very limited
> > amounts of free flash. Even if there were flash available it would wear
> > down the flash faster than what we'd like.
>
> Not sure I follow here. The whole point of lttng-relayd is to be off the
> device
> being traced and to relay trace data using network only (skipping disk).
>

Sure, so given this I cannot use relayd for our purposes. The only other
option would be to set LTTng to local tracing, which we don't have flash
for. My hope was that we could somehow stream the CTF records somewhere
else, over that HTTP proxy, ot be analyzed. As you explained earlier, the
relayd can be viewed as a FTP server of sorts. So that will most likely not
work.


>
> > A RAM-based disc might have been a solution if we would have had any
> > mentionable amounts of RAM to spare for this. Unfortunately we don't have
> > that.
>
> In all cases you will need some RAM somewhere if using LTTng (and I think
> any
> other monitoring/tracing tools) since we need to allocate tracing buffer.
>

We have RAM for the tracing buffer, no issues there. The tracing buffer is
just a temporary medium until you get the trace on disc, possibly via
relayd. Correct?

I interpretted your RAM disc suggestion as a place where I could store the
trace instead of using flash.


>
> > >
> > > Keep in mind that trace production is normally much more quicker than
> trace
> > > reading/analysis. A buffering scheme is mostly always necessary.
> > >
> >
> > Very valid point, I'll for sure keep that in mind.
> >
> > This speaks strongly against replacing relayd with something homebrewed,
> as
> > was the original plan. We'd probably not be able to shuffle the data fast
> > enough over the network to keep up with the pace.
>
> If you are unable to "reserve" RAM/network bandwidth and/or use FLASH this
> is
> slowly becoming a "you can't have your cake and eat it too" situation.
> This must
> be frustrating...
>
> > >
> > > You can also use the --trace-file-size and --trace-file-count to limit
> the
> > > disk
> > > footprint of each live session. Make sure to have enough buffer for
> live
> > > reading if still using live.
> > >
> >
> > This isn't an option as our disc is flash based and we'd like to limit
> the
> > wear due to collecting metrics.
>
> I was under the impression that the lttng-relayd process was on another
> device.
> I misunderstood the situation.
>

Perhaps i could have been more clear on the situation as well.

We have LTTng tracing capabilites on our devices. During development we can
use LTTng on the device and relayd on our dev machines and everything works
great.

In production, the situation is different.

The only means we have of transporting anything from the device is a HTTP
proxy. We're trying to find a way where we can keep a conitnuous LTTng
trace on the device, tunnel it through the HTTP proxy and analyze the data
remotely.

The devices are in the embedded realm, limited amounts of RAM, CPU, and
flash. This limits what we can do on the device when it comes to storage
for example.

Hopefully I've made our situation a bit more clear.

Based on our discussion so far, I have to say that LTTng is starting to
look less and less as a viable way forward for us.

Regards,
Patrik

--000000000000b42591057b169128
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Mon=
, Nov 19, 2018 at 7:46 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jon=
athan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Patrick,<br>
<br>
&gt; The security between consumerd and relayd isn&#39;t an issue as we&#39=
;d be forced<br>
&gt; to keep both on the device. This because we have no way of transportin=
g the<br>
&gt; consumerd &lt;-&gt; relayd communication over the HTTP proxy, which is=
 our only<br>
&gt; choice. We have already talked to the team in charge of the network pa=
ths.<br>
<br>
In that case using lttng-relayd yield no advantage unless you are able to h=
ave<br>
a device running only lttng-relayd and gathering data from other devices an=
d<br>
then sending the data via http.<br></blockquote><div><br></div><div>Unfortu=
nately, we&#39;re don&#39;t have any external device that can run the lttng=
-relayd component.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
<br>
&gt; <br>
&gt; The relayd side have to be on the device. The device has very limited<=
br>
&gt; amounts of free flash. Even if there were flash available it would wea=
r<br>
&gt; down the flash faster than what we&#39;d like.<br>
<br>
Not sure I follow here. The whole point of lttng-relayd is to be off the de=
vice<br>
being traced and to relay trace data using network only (skipping disk).<br=
></blockquote><div><br></div><div>Sure, so given this I cannot use relayd f=
or our purposes. The only other option would be to set LTTng to local traci=
ng, which we don&#39;t have flash for. My hope was that we could somehow st=
ream the CTF records somewhere else, over that HTTP proxy, ot be analyzed. =
As you explained earlier, the relayd can be viewed as a FTP server of sorts=
. So that will most likely not work.<br></div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<br>
&gt; A RAM-based disc might have been a solution if we would have had any<b=
r>
&gt; mentionable amounts of RAM to spare for this. Unfortunately we don&#39=
;t have<br>
&gt; that.<br>
<br>
In all cases you will need some RAM somewhere if using LTTng (and I think a=
ny<br>
other monitoring/tracing tools) since we need to allocate tracing buffer.<b=
r></blockquote><div><br></div><div>We have RAM for the tracing buffer, no i=
ssues there. The tracing buffer is just a temporary medium until you get th=
e trace on disc, possibly via relayd. Correct?</div><div><br></div><div>I i=
nterpretted your RAM disc suggestion as a place where I could store the tra=
ce instead of using flash.<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">
<br>
&gt; &gt;<br>
&gt; &gt; Keep in mind that trace production is normally much more quicker =
than trace<br>
&gt; &gt; reading/analysis. A buffering scheme is mostly always necessary.<=
br>
&gt; &gt;<br>
&gt; <br>
&gt; Very valid point, I&#39;ll for sure keep that in mind.<br>
&gt; <br>
&gt; This speaks strongly against replacing relayd with something homebrewe=
d, as<br>
&gt; was the original plan. We&#39;d probably not be able to shuffle the da=
ta fast<br>
&gt; enough over the network to keep up with the pace.<br>
<br>
If you are unable to &quot;reserve&quot; RAM/network bandwidth and/or use F=
LASH this is<br>
slowly becoming a &quot;you can&#39;t have your cake and eat it too&quot; s=
ituation. This must<br>
be frustrating...<br>
<br>
&gt; &gt;<br>
&gt; &gt; You can also use the --trace-file-size and --trace-file-count to =
limit the<br>
&gt; &gt; disk<br>
&gt; &gt; footprint of each live session. Make sure to have enough buffer f=
or live<br>
&gt; &gt; reading if still using live.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This isn&#39;t an option as our disc is flash based and we&#39;d like =
to limit the<br>
&gt; wear due to collecting metrics.<br>
<br>
I was under the impression that the lttng-relayd process was on another dev=
ice.<br>
I misunderstood the situation.<br></blockquote><div><br></div><div>Perhaps =
i could have been more clear on the situation as well. <br></div><div><br><=
/div><div>We have LTTng tracing capabilites on our devices. During developm=
ent we can use LTTng on the device and relayd on our dev machines and every=
thing works great.</div><div><br></div><div>In production, the situation is=
 different.</div><div><br></div><div>The only means we have of transporting=
 anything from the device is a HTTP proxy. We&#39;re trying to find a way w=
here we can keep a conitnuous LTTng trace on the device, tunnel it through =
the HTTP proxy and analyze the data remotely.</div><div><br></div><div>The =
devices are in the embedded realm, limited amounts of RAM, CPU, and flash. =
This limits what we can do on the device when it comes to storage for examp=
le.</div><div><br></div><div>Hopefully I&#39;ve made our situation a bit mo=
re clear.</div><div><br></div><div>Based on our discussion so far, I have t=
o say that LTTng is starting to look less and less as a viable way forward =
for us.</div><div><br></div><div>Regards,</div><div>Patrik<br></div></div><=
/div>

--000000000000b42591057b169128--

--===============6193539365396477017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6193539365396477017==--
