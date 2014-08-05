From: RGIAS MUG <rajhindunews@gmail.com>
Subject: Re: User Space Events Not creating Logs
Date: Tue, 5 Aug 2014 11:56:33 +0530
Message-ID: <CAHtXXvaKopJqp7HC_3AnvnCEjHU8q8b_1iVk4RgM-n_vYSUVMg__38018.860112834$1407253029$gmane$org@mail.gmail.com>
References: <CAHtXXvZY4qLtHpR_iREiCeAUrYfzVCLhKQrPnHbNctpnMJ11eg@mail.gmail.com>
 <CA+jJMxtFdfbg4n_EYpP_3CZvrjKtnqHJO-umpmY6QxpCkRSVaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1324153914=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <rajhindunews@gmail.com>) id 1XEYCm-0006rk-4H
 for lttng-dev@lists.lttng.org; Tue, 05 Aug 2014 02:26:44 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so341332lbg.20
 for <lttng-dev@lists.lttng.org>; Mon, 04 Aug 2014 23:26:34 -0700 (PDT)
In-Reply-To: <CA+jJMxtFdfbg4n_EYpP_3CZvrjKtnqHJO-umpmY6QxpCkRSVaQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1324153914==
Content-Type: multipart/alternative; boundary=089e013d170cdaeb9704ffdbef97

--089e013d170cdaeb9704ffdbef97
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,

                I didn't try the latest stable version. But i solved the
problem. In my kernel i am using busybox. So i don't have sudo related
things in my kernel..  I just created a group tracing..  In order to get
the user space trace, first i will start lttng-sessiond as a root user.
Then I will create a new connection via putty. then i can log into the user
mode who is having the root access. Then create a directory /home/user
using mkdir command. If we follow the lttng tracing commands hereafter,
then i could see the user space logs.



Thanks & Regards,
Rajivgandhi


On Tue, Jul 29, 2014 at 12:05 AM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Is this reproductible on stable 2.5?
>
> Thanks,
> J=C3=A9r=C3=A9mie
>
> On Mon, Jul 28, 2014 at 1:36 AM, RGIAS MUG <rajhindunews@gmail.com> wrote=
:
> > Hi All,
> >
> >         I am using the lttng (LTTng Trace Control) 2.3.1 - Dominus
> Vobiscum.
> > I had attached the log file with lttng-sessiond and sample user space
> > tracing applivcation with full verbosity option.
> >
> >        The User space tracing events logs were not available. Same thin=
g
> > when i tried in ubuntu, there i am able to see some message
> communications
> > which was not present in my linux machine having 3.10 kernel.
> >
> >        I attached the log file for ur reference..
> >
> >
> >
> >
> >
> >
> >
> >
> > Thanks & Regards,
> > Rajivgandhi
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--089e013d170cdaeb9704ffdbef97
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jeremie,<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I didn&#39;t try the latest stable version. Bu=
t i solved the problem. In my kernel i am using busybox. So i don&#39;t hav=
e sudo related things in my kernel.. =C2=A0I just created a group tracing..=
 =C2=A0In order to get the user space trace, first i will start lttng-sessi=
ond as a root user. Then I will create a new connection via putty. then i c=
an log into the user mode who is having the root access. Then create a dire=
ctory /home/user using mkdir command. If we follow the lttng tracing comman=
ds hereafter, then i could see the user space logs.</div>
<div><br></div><div><br></div><div><br></div><div>Thanks &amp; Regards,</di=
v><div>Rajivgandhi</div></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">On Tue, Jul 29, 2014 at 12:05 AM, J=C3=A9r=C3=A9mie Galarn=
eau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com"=
 target=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Is this reproductible on stable 2.5?<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
On Mon, Jul 28, 2014 at 1:36 AM, RGIAS MUG &lt;<a href=3D"mailto:rajhindune=
ws@gmail.com">rajhindunews@gmail.com</a>&gt; wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am using the lttng (LTTng Trace Control)=
 2.3.1 - Dominus Vobiscum.<br>
&gt; I had attached the log file with lttng-sessiond and sample user space<=
br>
&gt; tracing applivcation with full verbosity option.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0The User space tracing events logs were not=
 available. Same thing<br>
&gt; when i tried in ubuntu, there i am able to see some message communicat=
ions<br>
&gt; which was not present in my linux machine having 3.10 kernel.<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0I attached the log file for ur reference..<=
br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Thanks &amp; Regards,<br>
&gt; Rajivgandhi<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--089e013d170cdaeb9704ffdbef97--


--===============1324153914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1324153914==--
