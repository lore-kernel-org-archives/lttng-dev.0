From: Jonnavithula Sharma <sarmajprs@gmail.com>
Subject: Re: lttng Crash seen after stopping the traces.
Date: Tue, 30 Jul 2013 11:08:21 +0530
Message-ID: <CAJD=Q56myG=OuBXv2At2NEB0eqXOqjtTqVAMA5SZf2BgmmZ3Cg__2628.5954205834$1375162761$gmane$org@mail.gmail.com>
References: <CAJD=Q56dkx1jCUF0n03XFCs64hFmuDYELy+FVF9joZ8nxDUpDw@mail.gmail.com>
	<CA+jJMxt0kJJv2F26Myzcvms_6tSXAo269Zg5fMXyeXEn5eH95A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976017091=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sarmajprs@gmail.com>) id 1V42dg-0007iw-9V
	for lttng-dev@lists.lttng.org; Tue, 30 Jul 2013 01:38:32 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so4776038wes.34
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 22:38:22 -0700 (PDT)
In-Reply-To: <CA+jJMxt0kJJv2F26Myzcvms_6tSXAo269Zg5fMXyeXEn5eH95A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org, suprasad.desai@gmail.com
List-Id: lttng-dev@lists.lttng.org

--===============0976017091==
Content-Type: multipart/alternative; boundary=047d7bdc8e865cb6b904e2b40427

--047d7bdc8e865cb6b904e2b40427
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,

We tried with the latest version(2.2.1) of lttng-modules. We are able to
reproduce the same crash with the same steps.

Am i missing anything here?

Regards,
Sarma J


On Mon, Jul 29, 2013 at 9:05 PM, J=E9r=E9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Hi,
>
> Can you try to reproduce the problem with the latest version of
> lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer
> that may correct your problem.
>
> Thanks for reporting,
> J=E9r=E9mie
>
> On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma
> <sarmajprs@gmail.com> wrote:
> > Hi
> >
> > We are currently running lttng on our CPE with 64 MB RAM.We are
> observing a
> > crash after stopping the traces and even if we leave our CPE for few mi=
n
> > after starting the trace we are observing this crash.Please find the
> > attachment for the crash log.
> >
> > Let us know if any one has faced this issue and your help is highly
> > appreciated in resolving this issue.
> >
> >
> > Regards,
> > Sarma J
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
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7bdc8e865cb6b904e2b40427
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Jeremie,<br><br></div>We tried with=
 the latest version(2.2.1) of lttng-modules. We are able to reproduce the s=
ame crash with the same steps.<br><br></div>Am i missing anything here?<br>
<br></div>Regards,<br></div>Sarma J<br></div><div class=3D"gmail_extra"><br=
><br><div class=3D"gmail_quote">On Mon, Jul 29, 2013 at 9:05 PM, J=E9r=E9mi=
e Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@effic=
ios.com" target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wr=
ote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
Can you try to reproduce the problem with the latest version of<br>
lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer<br>
that may correct your problem.<br>
<br>
Thanks for reporting,<br>
J=E9r=E9mie<br>
<div><div class=3D"h5"><br>
On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma<br>
&lt;<a href=3D"mailto:sarmajprs@gmail.com">sarmajprs@gmail.com</a>&gt; wrot=
e:<br>
&gt; Hi<br>
&gt;<br>
&gt; We are currently running lttng on our CPE with 64 MB RAM.We are observ=
ing a<br>
&gt; crash after stopping the traces and even if we leave our CPE for few m=
in<br>
&gt; after starting the trace we are observing this crash.Please find the<b=
r>
&gt; attachment for the crash log.<br>
&gt;<br>
&gt; Let us know if any one has faced this issue and your help is highly<br=
>
&gt; appreciated in resolving this issue.<br>
&gt;<br>
&gt;<br>
&gt; Regards,<br>
&gt; Sarma J<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
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
J=E9r=E9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7bdc8e865cb6b904e2b40427--


--===============0976017091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0976017091==--
