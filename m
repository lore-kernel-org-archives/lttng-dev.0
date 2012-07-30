From: Rui Han <r.han@umiami.edu>
Subject: Re: Module lttng_tracer not found.
Date: Mon, 30 Jul 2012 10:54:47 -0400
Message-ID: <CABy43G-aYm2jJafJwCOuY7S8uWk3gr-trcYV=KSvDc-h89d3hg__15431.3481915326$1343660116$gmane$org@mail.gmail.com>
References: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
	<d3178decf5274978aa02a2c99545b900@UMEX001.cgcent.miami.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1883799928=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1SvrMz-0003tS-Db
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 10:54:53 -0400
Received: by qcsc21 with SMTP id c21so3307461qcs.35
	for <lttng-dev@lists.lttng.org>; Mon, 30 Jul 2012 07:54:47 -0700 (PDT)
In-Reply-To: <d3178decf5274978aa02a2c99545b900@UMEX001.cgcent.miami.edu>
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

--===============1883799928==
Content-Type: multipart/alternative; boundary=e89a8fb205fe38386004c60d3ef3

--e89a8fb205fe38386004c60d3ef3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thansks. I downloaded the packages and followed the README to install.
My problem has been solved, it turns out the kernel got updated since my
last use of lttng.

Regards,
Rui

On Mon, Jul 30, 2012 at 10:16 AM, Alexandre Montplaisir <
alexmonthy@voxpopuli.im> wrote:

> Hi,
>
> What steps did you use to install LTTng?
>
> Also can you please paste the output of:
> $ apt-cache policy lttng-modules-dkms
>
>
> Thanks,
>
> --
> Alexandre Montplaisir
> DORSAL lab,
> =C9cole Polytechnique de Montr=E9al
>
>
>
> On 12-07-29 04:26 PM, Rui Han wrote:
> > Hi,
> >
> > I used lttng last week and didn't touch it ever since. I am trying to u=
se
> > it again. I use lttng list -k, it give me error messages:
> >
> > FATAL: Module lttng_tracer not found.
> > Error: Unable to load module lttng-tracer
> > Error: Unable to remove module lttng-tracer
> > Warning: No kernel tracer available
> > Error: Unable to list kernel events
> >
> > I run kernel tracing as root. At first, I thought I have to start the
> > daemon by lttng-sessiond command. It gave me the error: "Error: Already
> > running daemon." At this time, I can create session, it gave "Session
> > session created. Traces will be written in
> > /root/lttng-traces/session-20120729-160806". However, it failed to
> generate
> > a single term of tracing. While I tried lsmod, there are no lttng relat=
ed
> > module in the list. Which I remember there were several. The same thing
> > happened to my two ubuntu systems. I restarted the system, it still
> doesn't
> > work. Does any one know how to make lttng work again in this situation?
> >
> > Thank you very much.
> >
> > Best regards,
> > Rui
>
>

--e89a8fb205fe38386004c60d3ef3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thansks. I downloaded the packages and followed the README to install.=A0<d=
iv>My problem has been solved, it turns out the kernel got updated since my=
 last use of lttng.=A0</div><div><br></div><div>Regards,</div><div>Rui<br><=
br>
<div class=3D"gmail_quote">On Mon, Jul 30, 2012 at 10:16 AM, Alexandre Mont=
plaisir <span dir=3D"ltr">&lt;<a href=3D"mailto:alexmonthy@voxpopuli.im" ta=
rget=3D"_blank">alexmonthy@voxpopuli.im</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
Hi,<br>
<br>
What steps did you use to install LTTng?<br>
<br>
Also can you please paste the output of:<br>
$ apt-cache policy lttng-modules-dkms<br>
<br>
<br>
Thanks,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Alexandre Montplaisir<br>
DORSAL lab,<br>
=C9cole Polytechnique de Montr=E9al<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
On 12-07-29 04:26 PM, Rui Han wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I used lttng last week and didn&#39;t touch it ever since. I am trying=
 to use<br>
&gt; it again. I use lttng list -k, it give me error messages:<br>
&gt;<br>
&gt; FATAL: Module lttng_tracer not found.<br>
&gt; Error: Unable to load module lttng-tracer<br>
&gt; Error: Unable to remove module lttng-tracer<br>
&gt; Warning: No kernel tracer available<br>
&gt; Error: Unable to list kernel events<br>
&gt;<br>
&gt; I run kernel tracing as root. At first, I thought I have to start the<=
br>
&gt; daemon by lttng-sessiond command. It gave me the error: &quot;Error: A=
lready<br>
&gt; running daemon.&quot; At this time, I can create session, it gave &quo=
t;Session<br>
&gt; session created. Traces will be written in<br>
&gt; /root/lttng-traces/session-20120729-160806&quot;. However, it failed t=
o generate<br>
&gt; a single term of tracing. While I tried lsmod, there are no lttng rela=
ted<br>
&gt; module in the list. Which I remember there were several. The same thin=
g<br>
&gt; happened to my two ubuntu systems. I restarted the system, it still do=
esn&#39;t<br>
&gt; work. Does any one know how to make lttng work again in this situation=
?<br>
&gt;<br>
&gt; Thank you very much.<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Rui<br>
<br>
</div></div></blockquote></div><br></div>

--e89a8fb205fe38386004c60d3ef3--


--===============1883799928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1883799928==--
