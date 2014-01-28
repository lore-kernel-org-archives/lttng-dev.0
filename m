From: Shariyar <syed.shariyar@gmail.com>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Tue, 28 Jan 2014 12:32:14 -0500
Message-ID: <CAKQh6pgwetoHcw3fxRHqHcvEZOVcYFmia_xivgAH+YPO3ZxzkA__5786.19137309051$1390930401$gmane$org@mail.gmail.com>
References: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw@mail.gmail.com>
	<1390930183.52e7e90758145@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1064595712=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1W8CWP-0004Pe-De
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 12:32:30 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so631435pbb.31
	for <lttng-dev@lists.lttng.org>; Tue, 28 Jan 2014 09:32:19 -0800 (PST)
In-Reply-To: <1390930183.52e7e90758145@www.imp.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1064595712==
Content-Type: multipart/alternative; boundary=047d7b2e486e87144504f10b34c8

--047d7b2e486e87144504f10b34c8
Content-Type: text/plain; charset=ISO-8859-1

It is not present in the system even after reinstalling ust libs from PPA.
I am working on Ubuntu 12.04.1 LTS, 64 bit.

Regards,
Shariyar


On Tue, Jan 28, 2014 at 12:29 PM, Suchakrapani Datt Sharma <
suchakrapani.sharma@polymtl.ca> wrote:

> Check if the liblttng-ust-cyg-profile.so is present in system using
> 'locate'. On
> my system its in /usr/lib64
>
> Then give the absolute path -
>
> *LD_PRELOAD=/usr/lib64/liblttng-ust-cyg-profile.so* appname
>
> This works for me.
>
> --
> Suchakra
>
> Quoting Shariyar <syed.shariyar@gmail.com>:
>
> > Hi,
> >
> > I am trying to collect function entry and exit points in a trace. I  have
> > followed the instructions written on the following man page:
> >
> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.html
> .
> >
> >
> > In my system, UST tracepoint tracing  is working fine and I am able to
> > collect traces with the statically typed tracepoints in the code.
> However,
> > there is no liblttng-ust-cyg-profile.so in my system and I get an error
> > when I execute the following:
> >
> >        *LD_PRELOAD=liblttng-ust-cyg-profile.so* appname
> >
> > Please let me know how to get it to work?
> >
> > Thanks,
> > Shariyar
> >
>
>
>

--047d7b2e486e87144504f10b34c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>It is not present in the system even after reinstalli=
ng ust libs from PPA. I am working on Ubuntu 12.04.1 LTS, 64 bit. <br><br><=
/div>Regards,<br>Shariyar</div><div class=3D"gmail_extra"><br><br><div clas=
s=3D"gmail_quote">
On Tue, Jan 28, 2014 at 12:29 PM, Suchakrapani Datt Sharma <span dir=3D"ltr=
">&lt;<a href=3D"mailto:suchakrapani.sharma@polymtl.ca" target=3D"_blank">s=
uchakrapani.sharma@polymtl.ca</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">Check if the liblttng-ust-cyg-profi=
le.so is present in system using &#39;locate&#39;. On<br>
my system its in /usr/lib64<br>
<br>
Then give the absolute path -<br>
<br>
*LD_PRELOAD=3D/usr/lib64/liblttng-ust-cyg-profile.so* appname<br>
<br>
This works for me.<br>
<br>
--<br>
Suchakra<br>
<br>
Quoting Shariyar &lt;<a href=3D"mailto:syed.shariyar@gmail.com">syed.shariy=
ar@gmail.com</a>&gt;:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am trying to collect function entry and exit points in a trace. I =
=A0have<br>
&gt; followed the instructions written on the following man page:<br>
&gt; <a href=3D"http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-c=
yg-profile.3.html" target=3D"_blank">http://manpages.ubuntu.com/manpages/tr=
usty/man3/lttng-ust-cyg-profile.3.html</a>.<br>
&gt;<br>
&gt;<br>
&gt; In my system, UST tracepoint tracing =A0is working fine and I am able =
to<br>
&gt; collect traces with the statically typed tracepoints in the code. Howe=
ver,<br>
&gt; there is no liblttng-ust-cyg-profile.so in my system and I get an erro=
r<br>
&gt; when I execute the following:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0*LD_PRELOAD=3Dliblttng-ust-cyg-profile.so* appname<br>
&gt;<br>
&gt; Please let me know how to get it to work?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Shariyar<br>
&gt;<br>
<br>
<br>
</div></div></blockquote></div><br></div>

--047d7b2e486e87144504f10b34c8--


--===============1064595712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1064595712==--
