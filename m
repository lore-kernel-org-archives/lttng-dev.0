From: mrx <patrik.mrx@gmail.com>
Subject: Re: A question on protocols
Date: Tue, 20 Nov 2018 19:23:31 +0100
Message-ID: <CANzOjBhMS2aw+oCtOuk6To0F0uDVkqXKd5cK8TmGg6jwzDXCkg__31229.9842866652$1542738110$gmane$org@mail.gmail.com>
References: <CANzOjBhikh_81hsu4b3pvneBNEX+PWjzWfx_K-jc-s0X0==zDQ@mail.gmail.com>
 <20181116171557.GA23758@joraj-alpa>
 <CANzOjBgXXbPXHw6oZetVr3pOJq51Pg+aWUpRP0f0WhZUqEdB8g@mail.gmail.com>
 <20181119184641.GA8739@joraj-alpa>
 <CANzOjBg2J-N=BaVesc=WKWwJMiOUX+FsunTdzZBUM-tNvOC7bw@mail.gmail.com>
 <20181120171639.GA12088@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8094448347426044779=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-it1-x12f.google.com (mail-it1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by lists.lttng.org (Postfix) with ESMTPS id 42zvGm4xVVzr1L
 for <lttng-dev@lists.lttng.org>; Tue, 20 Nov 2018 13:23:44 -0500 (EST)
Received: by mail-it1-x12f.google.com with SMTP id a205-v6so4817459itd.4
 for <lttng-dev@lists.lttng.org>; Tue, 20 Nov 2018 10:23:44 -0800 (PST)
In-Reply-To: <20181120171639.GA12088@joraj-alpa>
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

--===============8094448347426044779==
Content-Type: multipart/alternative; boundary="000000000000c4dcd1057b1cbbe3"

--000000000000c4dcd1057b1cbbe3
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 20, 2018 at 6:16 PM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Patrick,
>
> > Sure, so given this I cannot use relayd for our purposes. The only other
> > option would be to set LTTng to local tracing, which we don't have flash
> > for. My hope was that we could somehow stream the CTF records somewhere
> > else, over that HTTP proxy, ot be analyzed. As you explained earlier, the
> > relayd can be viewed as a FTP server of sorts. So that will most likely
> not
> > work.
>
> A possibility would be to spare some RAM (not easy I know), mount a tmpfs,
> configure the session to output to the tmpfs, use session rotation based on
> size, send the data, remove the data, rinse and repeat. Now the question
> is what
> is the amount of tracing data generated and the amount of RAM available.
>
> > We have RAM for the tracing buffer, no issues there. The tracing buffer
> is
> > just a temporary medium until you get the trace on disc, possibly via
> > relayd. Correct?
>
> Yes.
>
> The consumerd is responsible for fetching the data from the buffers, then
> it
> output it locally or send it over the network to lttng-relayd.
>
> You can take a look at the interaction here:
>
> https://lttng.org/docs/v2.10/#doc-plumbing


Is the contents of the RAM buffer already proper CTF records ready to be
consumed, or is there some transformation that needs to take place as well?
If so, can i find that in some library or is it part of the consumerd code
base?

If i were to read the ring buffer instead of consumerd, then i would
perhaps be in a situation where I could stream the ring buffer to another
machine over that HTTP proxy? That way I wouldn't need any RAM disc or
anything, the data is already stored.

The consumerd logic that reads the ring buffer, is that part of some
library i could take advantage of?


>
>
> >
> > I interpretted your RAM disc suggestion as a place where I could store
> the
> > trace instead of using flash.
>
> This was the correct interpretation.
>
> >
> > Perhaps i could have been more clear on the situation as well.
> >
> > We have LTTng tracing capabilites on our devices. During development we
> can
> > use LTTng on the device and relayd on our dev machines and everything
> works
> > great.
>
> Glad to hear it.
>

We're very pleased with LTTng.


>
> >
> > In production, the situation is different.
> >
> > The only means we have of transporting anything from the device is a HTTP
> > proxy. We're trying to find a way where we can keep a conitnuous LTTng
> > trace on the device, tunnel it through the HTTP proxy and analyze the
> data
> > remotely.
> >
> > The devices are in the embedded realm, limited amounts of RAM, CPU, and
> > flash. This limits what we can do on the device when it comes to storage
> > for example.
> >
> > Hopefully I've made our situation a bit more clear.
> >
> > Based on our discussion so far, I have to say that LTTng is starting to
> > look less and less as a viable way forward for us.
>
> It would be quite disappointing if you would not be able to reuse the work
> done
> for instrumenting your applications.
>

Quite so, which is why we're trying so hard to find a viable way forward.

Regards,
Patrik

--000000000000c4dcd1057b1cbbe3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue=
, Nov 20, 2018 at 6:16 PM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jon=
athan.rajotte-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Patrick,<br>
<br>
&gt; Sure, so given this I cannot use relayd for our purposes. The only oth=
er<br>
&gt; option would be to set LTTng to local tracing, which we don&#39;t have=
 flash<br>
&gt; for. My hope was that we could somehow stream the CTF records somewher=
e<br>
&gt; else, over that HTTP proxy, ot be analyzed. As you explained earlier, =
the<br>
&gt; relayd can be viewed as a FTP server of sorts. So that will most likel=
y not<br>
&gt; work.<br>
<br>
A possibility would be to spare some RAM (not easy I know), mount a tmpfs,<=
br>
configure the session to output to the tmpfs, use session rotation based on=
<br>
size, send the data, remove the data, rinse and repeat. Now the question is=
 what<br>
is the amount of tracing data generated and the amount of RAM available.<br=
>
<br>
&gt; We have RAM for the tracing buffer, no issues there. The tracing buffe=
r is<br>
&gt; just a temporary medium until you get the trace on disc, possibly via<=
br>
&gt; relayd. Correct?<br>
<br>
Yes.<br>
<br>
The consumerd is responsible for fetching the data from the buffers, then i=
t<br>
output it locally or send it over the network to lttng-relayd.<br>
<br>
You can take a look at the interaction here:<br>
<br>
<a href=3D"https://lttng.org/docs/v2.10/#doc-plumbing" rel=3D"noreferrer" t=
arget=3D"_blank">https://lttng.org/docs/v2.10/#doc-plumbing</a></blockquote=
><div><br></div><div>Is the contents of the RAM buffer already proper CTF r=
ecords ready to be consumed, or is there some transformation that needs to =
take place as well? If so, can i find that in some library or is it part of=
 the consumerd code base?</div><div><br></div><div>If i were to read the ri=
ng buffer instead of consumerd, then i would perhaps be in a situation wher=
e I could stream the ring buffer to another machine over that HTTP proxy? T=
hat way I wouldn&#39;t need any RAM disc or anything, the data is already s=
tored.<br></div><div><br></div><div>The consumerd logic that reads the ring=
 buffer, is that part of some library i could take advantage of?<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
&gt; <br>
&gt; I interpretted your RAM disc suggestion as a place where I could store=
 the<br>
&gt; trace instead of using flash.<br>
<br>
This was the correct interpretation.<br>
<br>
&gt; <br>
&gt; Perhaps i could have been more clear on the situation as well.<br>
&gt; <br>
&gt; We have LTTng tracing capabilites on our devices. During development w=
e can<br>
&gt; use LTTng on the device and relayd on our dev machines and everything =
works<br>
&gt; great.<br>
<br>
Glad to hear it.<br></blockquote><div><br></div><div>We&#39;re very pleased=
 with LTTng.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; In production, the situation is different.<br>
&gt; <br>
&gt; The only means we have of transporting anything from the device is a H=
TTP<br>
&gt; proxy. We&#39;re trying to find a way where we can keep a conitnuous L=
TTng<br>
&gt; trace on the device, tunnel it through the HTTP proxy and analyze the =
data<br>
&gt; remotely.<br>
&gt; <br>
&gt; The devices are in the embedded realm, limited amounts of RAM, CPU, an=
d<br>
&gt; flash. This limits what we can do on the device when it comes to stora=
ge<br>
&gt; for example.<br>
&gt; <br>
&gt; Hopefully I&#39;ve made our situation a bit more clear.<br>
&gt; <br>
&gt; Based on our discussion so far, I have to say that LTTng is starting t=
o<br>
&gt; look less and less as a viable way forward for us.<br>
<br>
It would be quite disappointing if you would not be able to reuse the work =
done<br>
for instrumenting your applications.<br></blockquote><div><br></div><div>Qu=
ite so, which is why we&#39;re trying so hard to find a viable way forward.=
</div><div><br></div><div>Regards,</div><div>Patrik<br>
</div></div></div>

--000000000000c4dcd1057b1cbbe3--

--===============8094448347426044779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8094448347426044779==--
