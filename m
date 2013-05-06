From: Philippe Proulx <philippe.proulx@polymtl.ca>
Subject: Re: Java code for CTF trace writing?
Date: Mon, 6 May 2013 11:26:12 -0400
Message-ID: <CAB4xu_0sYwYKrUnktZUWrY-17k_voQcniq=m_U392z6jsFc=Gg__26883.9137898341$1367854043$gmane$org@mail.gmail.com>
References: <CAB4xu_1zOHUD03dQ57DxKpQ1RWorocGK_0URCaxnohHB1FLEDw@mail.gmail.com>
	<5176AAFA.8060905@ericsson.com>
	<1962635283.7490228.1366741297558.JavaMail.root@vmware.com>
	<5176D556.8040801@ericsson.com>
	<1218416875.7614701.1366750233878.JavaMail.root@vmware.com>
	<A94B468263DDE2448A14367F590EB97301D4DA41@ltcfiswmsgmb15>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0265776097=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eeppeliteloop@gmail.com>) id 1UZNJR-00072V-6B
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 11:26:49 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so3531573lbi.18
	for <lttng-dev@lists.lttng.org>; Mon, 06 May 2013 08:26:43 -0700 (PDT)
In-Reply-To: <A94B468263DDE2448A14367F590EB97301D4DA41@ltcfiswmsgmb15>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ostermueller, Erik" <Erik.Ostermueller@fisglobal.com>
Cc: Dominique Toupin <dominique.toupin@ericsson.com>, Linux Tools developer discussions <linuxtools-dev@eclipse.org>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0265776097==
Content-Type: multipart/alternative; boundary=001a11c33caaf49b7c04dc0e5337

--001a11c33caaf49b7c04dc0e5337
Content-Type: text/plain; charset=ISO-8859-1

I don't think so, but usually you would have a trace for your Java events
and another one for OS events that are recorded simultaneously.

Then you simply open both with Babeltrace or your favorite trace viewer and
you should see interleaving events.

You might have problems with events timing synchronization though if you
plan to produce your own CTF trace.

Philippe Proulx


On Mon, May 6, 2013 at 10:33 AM, Ostermueller, Erik <
Erik.Ostermueller@fisglobal.com> wrote:

> Hello all,
>
> I've got a question about the Java code that writes CTF traces.
> Would this design provide a single trace with Java events and OS events in
> the same trace?
> Here is an example:
>
> Consider an all-Java program that sends an XML requests request over HTTP.
> Would like the trace detail to show Java method activity as well as OS
> activity that opens/closes the socket.
>
> This could be very helpful for unveiling the details of how Java code
> consumes hardware resources.
>
> Thanks,
> --Erik
>
> -----Original Message-----
> From: Aaron Spear [mailto:aspear@vmware.com]
> Sent: Tuesday, April 23, 2013 3:51 PM
> To: Matthew Khouzam
> Cc: Philippe Proulx; Dominique Toupin; lttng-dev@lists.lttng.org; Linux
> Tools developer discussions
> Subject: Re: [lttng-dev] Java code for CTF trace writing?
>
> > When would you be available to work on this feature, I would love to
> > sync up our efforts for this.
>
> The way things look right now, I will have bandwidth for it in another
> month, so middle to end of May. Perhaps sooner if all the stars align.
>
> Aaron
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _____________
> The information contained in this message is proprietary and/or
> confidential. If you are not the intended recipient, please: (i) delete the
> message and all copies; (ii) do not disclose, distribute or use the message
> in any manner; and (iii) notify the sender immediately. In addition, please
> be aware that any message addressed to our domain is subject to archiving
> and review by persons other than the intended recipient. Thank you.
>
>

--001a11c33caaf49b7c04dc0e5337
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t think so, but usually you would have a trace f=
or your Java events and another one for OS events that are recorded simulta=
neously.<div><br></div><div style>Then you simply open both with Babeltrace=
 or your favorite trace viewer and you should see interleaving events.</div=
>

<div style><br></div><div style>You might have problems with events timing =
synchronization though if you plan to produce your own CTF trace.</div></di=
v><div class=3D"gmail_extra"><br clear=3D"all"><div>Philippe Proulx</div>
<br><br><div class=3D"gmail_quote">On Mon, May 6, 2013 at 10:33 AM, Ostermu=
eller, Erik <span dir=3D"ltr">&lt;<a href=3D"mailto:Erik.Ostermueller@fisgl=
obal.com" target=3D"_blank">Erik.Ostermueller@fisglobal.com</a>&gt;</span> =
wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello all,<br>
<br>
I&#39;ve got a question about the Java code that writes CTF traces.<br>
Would this design provide a single trace with Java events and OS events in =
the same trace?<br>
Here is an example:<br>
<br>
Consider an all-Java program that sends an XML requests request over HTTP.<=
br>
Would like the trace detail to show Java method activity as well as OS acti=
vity that opens/closes the socket.<br>
<br>
This could be very helpful for unveiling the details of how Java code consu=
mes hardware resources.<br>
<br>
Thanks,<br>
--Erik<br>
<div><div class=3D"h5"><br>
-----Original Message-----<br>
From: Aaron Spear [mailto:<a href=3D"mailto:aspear@vmware.com">aspear@vmwar=
e.com</a>]<br>
Sent: Tuesday, April 23, 2013 3:51 PM<br>
To: Matthew Khouzam<br>
Cc: Philippe Proulx; Dominique Toupin; <a href=3D"mailto:lttng-dev@lists.lt=
tng.org">lttng-dev@lists.lttng.org</a>; Linux Tools developer discussions<b=
r>
Subject: Re: [lttng-dev] Java code for CTF trace writing?<br>
<br>
&gt; When would you be available to work on this feature, I would love to<b=
r>
&gt; sync up our efforts for this.<br>
<br>
The way things look right now, I will have bandwidth for it in another mont=
h, so middle to end of May. Perhaps sooner if all the stars align.<br>
<br>
Aaron<br>
<br>
</div></div><div class=3D"im">_____________________________________________=
__<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br>
_____________<br>
</div>The information contained in this message is proprietary and/or confi=
dential. If you are not the intended recipient, please: (i) delete the mess=
age and all copies; (ii) do not disclose, distribute or use the message in =
any manner; and (iii) notify the sender immediately. In addition, please be=
 aware that any message addressed to our domain is subject to archiving and=
 review by persons other than the intended recipient. Thank you.<br>


<br>
</blockquote></div><br></div>

--001a11c33caaf49b7c04dc0e5337--


--===============0265776097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0265776097==--
