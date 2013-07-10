From: tarek slaymia <tarek.slaymia@gmail.com>
Subject: Re: New LTTNG user : Question about Kprobe and function
 commandline options
Date: Tue, 9 Jul 2013 22:00:22 -0400
Message-ID: <CAP7TvLd1N98ttK5OK4tCsFGWxzN3ng07+QcEnP7POg47V=g-Sw__14328.8797735751$1373421665$gmane$org@mail.gmail.com>
References: <CAPxN80BVxGkHob1CcQOZcSBcskiN5p3yC78+O5PHSSRr1HU=FA@mail.gmail.com>
	<20130623142140.GC21999@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0154828881=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <20130623142140.GC21999@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0154828881==
Content-Type: multipart/alternative; boundary=089e0158c3d4ec8d8d04e11ea3ff

--089e0158c3d4ec8d8d04e11ea3ff
Content-Type: text/plain; charset=ISO-8859-1

Hi,

can we retrieve kernel data structures addresses or contents using LTTng ?

regards.


2013/6/23 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jessica Foest (jessica.foest@gmail.com) wrote:
> > Hi,
> > i tried to apply kprobe to a system call , so i used probe and function
> > option :
> >
> > lttng enable-event aname -k --probe sys_open+0x0
> > this command returns ip value
> >
> > lttng enable-event aname -k --function sys_open
> > this command returns ip and parent_ip values .
> >
> > what does these values ip and parent_ip means ?
>
> ip: instruction pointer of the function,
> parent_ip: instruction pointer of the caller.
>
> >
> > I try to apply probe and function options to some kernel symbols like
> > initialized date (like xen_vcpu_info symbol), read only data (like
> > linux_prob_banner symbol) and code (like reserve_ebda_region symbol) it
> > displays to me : Enable kernel event failed ,warning some command went(s)
> > wrong.
> > Did i make a mistake or it's a limitation in LTTng ?
>
> It's kprobes: you can only add breakpoints to code, not data.
>
> Thanks,
>
> Mathieu
>
> > regards.
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--089e0158c3d4ec8d8d04e11ea3ff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>can we retrieve kernel data str=
uctures addresses or contents using LTTng ?<br><br></div>regards.<br></div>=
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2013/6/23 Mat=
hieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</span>=
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">* Jessica Foest (<a href=
=3D"mailto:jessica.foest@gmail.com">jessica.foest@gmail.com</a>) wrote:<br>
&gt; Hi,<br>
&gt; i tried to apply kprobe to a system call , so i used probe and functio=
n<br>
&gt; option :<br>
&gt;<br>
&gt; lttng enable-event aname -k --probe sys_open+0x0<br>
&gt; this command returns ip value<br>
&gt;<br>
&gt; lttng enable-event aname -k --function sys_open<br>
&gt; this command returns ip and parent_ip values .<br>
&gt;<br>
&gt; what does these values ip and parent_ip means ?<br>
<br>
</div>ip: instruction pointer of the function,<br>
parent_ip: instruction pointer of the caller.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; I try to apply probe and function options to some kernel symbols like<=
br>
&gt; initialized date (like xen_vcpu_info symbol), read only data (like<br>
&gt; linux_prob_banner symbol) and code (like reserve_ebda_region symbol) i=
t<br>
&gt; displays to me : Enable kernel event failed ,warning some command went=
(s)<br>
&gt; wrong.<br>
&gt; Did i make a mistake or it&#39;s a limitation in LTTng ?<br>
<br>
</div>It&#39;s kprobes: you can only add breakpoints to code, not data.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; regards.<br>
<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</font></span></blockquote></div><br></div>

--089e0158c3d4ec8d8d04e11ea3ff--


--===============0154828881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0154828881==--
