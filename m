From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: adding new channel
Date: Sat, 21 Feb 2015 00:55:58 +0530
Message-ID: <CAM5kDqzCq1ALXOSy2aAE+hB6=e2aFOQQ2snHdGx1WA0vjnBHtA__1607.51861189983$1424460412$gmane$org@mail.gmail.com>
References: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
 <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1477357473=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YOtDA-0003al-0L
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 14:26:06 -0500
Received: by mail-wg0-f46.google.com with SMTP id a1so14996006wgh.5
 for <lttng-dev@lists.lttng.org>; Fri, 20 Feb 2015 11:25:58 -0800 (PST)
In-Reply-To: <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1477357473==
Content-Type: multipart/alternative; boundary=e89a8f6427eea8b3eb050f8a0551

--e89a8f6427eea8b3eb050f8a0551
Content-Type: text/plain; charset=UTF-8

Thanks for the reply.

I think adding channels on the fly must be supported.
From debugging point of view, it will be good if we can add channels on the
fly with each channel having different set of events.
Even "stop tracing" and adding channel doesnt help now.

Thanks,
Anand Neeli

On Sat, Feb 21, 2015 at 12:35 AM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli <anand.neeli@gmail.com>
> wrote:
> > Hi All,
> > Is adding a new channel to an existing(running) session supported?
>
> No.
> >
> > i get following error when doing this.
> > Error: Channel myc5: Tracing already started
> >
> > Is there any way to add channels on the fly?
>
> No. LTTng's documentation [1] states:
>
>     Note: Because of a current limitation, all channels must be
>     created prior to beginning tracing in a given tracing session,
>     i.e. before the first time you do lttng start.
>
>     Since a channel is automatically created by enable-event
>     only for the specified domain, you cannot, for example, enable
>     a kernel domain event, start tracing and then enable a user
>     space domain event because no user space channel exists
>     yet and it's too late to create one.
>
>     For this reason, make sure to configure your channels
>     properly before starting the tracers for the first time!
>
> Phil
>
> [1] http://lttng.org/docs/#doc-enabling-disabling-channels
>
> > I'm using 2.4.1 version
> >
> > Thanks,
> > Anand Neeli
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--e89a8f6427eea8b3eb050f8a0551
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the reply.<div><br></div><div>I think adding ch=
annels on the fly must be supported.</div><div>From debugging point of view=
, it will be good if we can add channels on the fly with each channel havin=
g different set of events.</div><div>Even &quot;stop tracing&quot; and addi=
ng channel doesnt help now.</div><div><br></div><div>Thanks,</div><div>Anan=
d Neeli</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Sat, Feb 21, 2015 at 12:35 AM, Philippe Proulx <span dir=3D"ltr">&lt;<=
a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop@g=
mail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli &lt;<a href=3D"mailto=
:anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt; wrote:<br>
&gt; Hi All,<br>
&gt; Is adding a new channel to an existing(running) session supported?<br>
<br>
</span>No.<br>
<span class=3D"">&gt;<br>
&gt; i get following error when doing this.<br>
&gt; Error: Channel myc5: Tracing already started<br>
&gt;<br>
&gt; Is there any way to add channels on the fly?<br>
<br>
</span>No. LTTng&#39;s documentation [1] states:<br>
<br>
=C2=A0 =C2=A0 Note: Because of a current limitation, all channels must be<b=
r>
=C2=A0 =C2=A0 created prior to beginning tracing in a given tracing session=
,<br>
=C2=A0 =C2=A0 i.e. before the first time you do lttng start.<br>
<br>
=C2=A0 =C2=A0 Since a channel is automatically created by enable-event<br>
=C2=A0 =C2=A0 only for the specified domain, you cannot, for example, enabl=
e<br>
=C2=A0 =C2=A0 a kernel domain event, start tracing and then enable a user<b=
r>
=C2=A0 =C2=A0 space domain event because no user space channel exists<br>
=C2=A0 =C2=A0 yet and it&#39;s too late to create one.<br>
<br>
=C2=A0 =C2=A0 For this reason, make sure to configure your channels<br>
=C2=A0 =C2=A0 properly before starting the tracers for the first time!<br>
<br>
Phil<br>
<br>
[1] <a href=3D"http://lttng.org/docs/#doc-enabling-disabling-channels" targ=
et=3D"_blank">http://lttng.org/docs/#doc-enabling-disabling-channels</a><br=
>
<span class=3D""><br>
&gt; I&#39;m using 2.4.1 version<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
</span>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
</blockquote></div><br></div>

--e89a8f6427eea8b3eb050f8a0551--


--===============1477357473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1477357473==--
