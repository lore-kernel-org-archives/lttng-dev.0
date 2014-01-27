From: Krishanth TJ <krishanthtj@gmail.com>
Subject: Re: Lttng state dump traces not present in 13.04 Ubuntu
 server distribution
Date: Mon, 27 Jan 2014 11:30:44 +0530
Message-ID: <CAAoqFdTREawK0vSn1aVLCGs9PhFj8JJNjsHopiE8G8dYHv_6zQ__5166.83295504681$1390802504$gmane$org@mail.gmail.com>
References: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>
	<52E161A8.4070908@voxpopuli.im>
	<CAAoqFdRZaoLW_r2bdaZvU+wwMtMS1nHuBNkumznqRY-_yOPh6g@mail.gmail.com>
	<52E2AE2E.2020907@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1601818481=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f196.google.com ([209.85.223.196])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <krishanthtj@gmail.com>) id 1W7fFa-0004Mr-2s
	for lttng-dev@lists.lttng.org; Mon, 27 Jan 2014 01:00:52 -0500
Received: by mail-ie0-f196.google.com with SMTP id e14so2434338iej.11
	for <lttng-dev@lists.lttng.org>; Sun, 26 Jan 2014 22:00:44 -0800 (PST)
In-Reply-To: <52E2AE2E.2020907@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1601818481==
Content-Type: multipart/alternative; boundary=20cf301af619a2624004f0ed6d27

--20cf301af619a2624004f0ed6d27
Content-Type: text/plain; charset=ISO-8859-1

Yes, they do appear in "lttng list -k" event list.

Regards,
Krish.

On Fri, Jan 24, 2014 at 11:47 PM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

> Hmm, ok, if you use "lttng list -k" do they appear in the list of
> available events?
>
> One other thing I can think about is that the statedump itself takes a
> little bit of time to execute, so the statedump events are never at the
> very start of the trace. So if your traces are very short it's possible
> to miss them entirely.
>
> Cheers,
> Alexandre
>
>
> On 14-01-24 08:54 AM, Krishanth TJ wrote:
> > Hi,
> >
> > I have confirmed that the "lttng-modules-dkms" package was successfully
> > installed.
> >
> > $ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4
> > 2013-09-28 LTTng modules 2.3.2
> >     * Blacklist kernels 3.10.13 and 3.11.2
> >
> > I have even confirmed with few debug printk's in lttng_statedump.ko that
> > the module is indeed loaded and the tracepoints are getting called. But
> > still babeltrace output fails to show lttng_statedump_events.
> >
> > Am I missing something here?
> >
> > Regards,
> > Krish.
> >
>
>

--20cf301af619a2624004f0ed6d27
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Yes, they do appear in &quo=
t;lttng list -k&quot; event list.<br><br></div><div class=3D"gmail_extra">R=
egards,<br></div><div class=3D"gmail_extra">Krish.<br></div><div class=3D"g=
mail_extra">
<br><div class=3D"gmail_quote">On Fri, Jan 24, 2014 at 11:47 PM, Alexandre =
Montplaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.im=
" target=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
Hmm, ok, if you use &quot;lttng list -k&quot; do they appear in the list of=
<br>
available events?<br>
<br>
One other thing I can think about is that the statedump itself takes a<br>
little bit of time to execute, so the statedump events are never at the<br>
very start of the trace. So if your traces are very short it&#39;s possible=
<br>
to miss them entirely.<br>
<br>
Cheers,<br>
Alexandre<br>
<div class=3D""><div class=3D"h5"><br>
<br>
On 14-01-24 08:54 AM, Krishanth TJ wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have confirmed that the &quot;lttng-modules-dkms&quot; package was s=
uccessfully<br>
&gt; installed.<br>
&gt;<br>
&gt; $ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4<br>
&gt; 2013-09-28 LTTng modules 2.3.2<br>
&gt; =A0 =A0 * Blacklist kernels 3.10.13 and 3.11.2<br>
&gt;<br>
&gt; I have even confirmed with few debug printk&#39;s in lttng_statedump.k=
o that<br>
&gt; the module is indeed loaded and the tracepoints are getting called. Bu=
t<br>
&gt; still babeltrace output fails to show lttng_statedump_events.<br>
&gt;<br>
&gt; Am I missing something here?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Krish.<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--20cf301af619a2624004f0ed6d27--


--===============1601818481==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1601818481==--
