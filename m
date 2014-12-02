From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: not able to read 32-bit app traces running on a
 64-bit system with relayd
Date: Tue, 2 Dec 2014 23:40:18 +0530
Message-ID: <CAM5kDqwQRsHgvJe6SO8nOuVrRWD9U1bKRbQiqE6GxJe=+Hz==g__17970.4875838526$1417543872$gmane$org@mail.gmail.com>
References: <CAM5kDqwPV+vjutz54Jss+mYUT+__DLFmyvQ81qrgDHwwnCOpwg@mail.gmail.com>
 <CA+jJMxsjoYPtY5izafcerH04UPm1uB9B0x_nhCu5D0K4nob1TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0424342057=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Xvru4-0004Ae-CU
 for lttng-dev@lists.lttng.org; Tue, 02 Dec 2014 13:10:26 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so21854579wid.12
 for <lttng-dev@lists.lttng.org>; Tue, 02 Dec 2014 10:10:18 -0800 (PST)
In-Reply-To: <CA+jJMxsjoYPtY5izafcerH04UPm1uB9B0x_nhCu5D0K4nob1TA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0424342057==
Content-Type: multipart/alternative; boundary=047d7b66fa67c4f90a05093fa38e

--047d7b66fa67c4f90a05093fa38e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=A9mie,
Thanks for verifying this.

Is this a issue with relayd? or babeltrace?
Coz i see this only with 32-bit applications running on a 64-bit system,
along with relay of traces using relayd

Thanks,
Anand Neeli

On Tue, Dec 2, 2014 at 11:03 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> On Tue, Dec 2, 2014 at 8:01 AM, Anand Neeli <anand.neeli@gmail.com> wrote=
:
> > Hi All,
> > I have verified that i'm able to read the attached 32-bit and 64-bit
> traces
> > using eclipse trace compass.
> > Where as babeltrace fails to read 32-bit traces.
> > Can anyone please let me know what could be the issue here.
> >
>
> Deleting the index folder of the 32 bit trace seems to make it
> possible for babeltrace to read the trace... Reproducible on
> Babeltrace master.
>
> Would you mind opening a bug report against Babeltrace on bugs.lttng.org?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> > Thanks,
> > Anand Neeli
> >
> > ---------- Forwarded message ----------
> > From: Anand Neeli <anand.neeli@gmail.com>
> > Date: Thu, Nov 27, 2014 at 5:01 PM
> > Subject: not able to read 32-bit app traces running on a 64-bit system
> with
> > relayd
> > To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
> >
> >
> > Hi All,
> > I'm running both 32-bit and 64-bit app's on a 64-bit system.  I have
> > consumerd's build for both 32-bit and 64-bits (followed
> > http://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system)
> >
> > I'm seeing problem in reading 32-bit app traces, although it is logging
> > something and logfile size in lttng-traces/ is increasing.
> > I have compiled same app for 64-bit and it works fine.
> >
> > One more point here is that, this happens only when relaying traces.
> Without
> > using relayd and by using local tracing i dont see any issues.
> >
> > Attached are the logs from 32-bit and 64-bit app's. There sizes are sam=
e
> > except the files in index/
> >
> > I'm using 2.4.1 lttng and tried 1.2.0 and 1.2.1 version of babeltrace.
> >
> > Can anyone please tell me how can i avoid this problem.
> >
> > Thanks,
> > Anand Neeli
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b66fa67c4f90a05093fa38e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0<span style=3D"font-family:arial,sans-serif;font-s=
ize:13px">J=C3=A9r=C3=A9mie,</span><div><font face=3D"arial, sans-serif">Th=
anks for=C2=A0verifying=C2=A0this.</font></div><div><font face=3D"arial, sa=
ns-serif"><br></font></div><div><font face=3D"arial, sans-serif">Is this a =
issue with relayd? or babeltrace?</font></div><div><font face=3D"arial, san=
s-serif">Coz i see this only with 32-bit applications running on a 64-bit s=
ystem, along with relay of traces using relayd</font></div><div><font face=
=3D"arial, sans-serif"><br></font></div><div><font face=3D"arial, sans-seri=
f">Thanks,</font></div><div><font face=3D"arial, sans-serif">Anand Neeli</f=
ont></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">O=
n Tue, Dec 2, 2014 at 11:03 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D"lt=
r">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blank">=
jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">On Tue, Dec 2, 2014 at 8:01 AM, Anand Neeli =
&lt;<a href=3D"mailto:anand.neeli@gmail.com">anand.neeli@gmail.com</a>&gt; =
wrote:<br>
&gt; Hi All,<br>
&gt; I have verified that i&#39;m able to read the attached 32-bit and 64-b=
it traces<br>
&gt; using eclipse trace compass.<br>
&gt; Where as babeltrace fails to read 32-bit traces.<br>
&gt; Can anyone please let me know what could be the issue here.<br>
&gt;<br>
<br>
</span>Deleting the index folder of the 32 bit trace seems to make it<br>
possible for babeltrace to read the trace... Reproducible on<br>
Babeltrace master.<br>
<br>
Would you mind opening a bug report against Babeltrace on <a href=3D"http:/=
/bugs.lttng.org" target=3D"_blank">bugs.lttng.org</a>?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<span class=3D""><br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
&gt; ---------- Forwarded message ----------<br>
&gt; From: Anand Neeli &lt;<a href=3D"mailto:anand.neeli@gmail.com">anand.n=
eeli@gmail.com</a>&gt;<br>
&gt; Date: Thu, Nov 27, 2014 at 5:01 PM<br>
&gt; Subject: not able to read 32-bit app traces running on a 64-bit system=
 with<br>
&gt; relayd<br>
&gt; To: &quot;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a>&quot; &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng=
-dev@lists.lttng.org</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt; Hi All,<br>
&gt; I&#39;m running both 32-bit and 64-bit app&#39;s on a 64-bit system.=
=C2=A0 I have<br>
&gt; consumerd&#39;s build for both 32-bit and 64-bits (followed<br>
&gt; <a href=3D"http://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-b=
it-system" target=3D"_blank">http://lttng.org/docs/#doc-instrumenting-32-bi=
t-app-on-64-bit-system</a>)<br>
&gt;<br>
&gt; I&#39;m seeing problem in reading 32-bit app traces, although it is lo=
gging<br>
&gt; something and logfile size in lttng-traces/ is increasing.<br>
&gt; I have compiled same app for 64-bit and it works fine.<br>
&gt;<br>
&gt; One more point here is that, this happens only when relaying traces. W=
ithout<br>
&gt; using relayd and by using local tracing i dont see any issues.<br>
&gt;<br>
&gt; Attached are the logs from 32-bit and 64-bit app&#39;s. There sizes ar=
e same<br>
&gt; except the files in index/<br>
&gt;<br>
&gt; I&#39;m using 2.4.1 lttng and tried 1.2.0 and 1.2.1 version of babeltr=
ace.<br>
&gt;<br>
&gt; Can anyone please tell me how can i avoid this problem.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Anand Neeli<br>
&gt;<br>
&gt;<br>
</span>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7b66fa67c4f90a05093fa38e--


--===============0424342057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0424342057==--
