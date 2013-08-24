From: Jimmy Durand <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Sat, 24 Aug 2013 21:42:15 +0200
Message-ID: <CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og__25829.1979124353$1377373404$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0499564666=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <phoenixonrebirth@gmail.com>) id 1VDJjN-000086-OB
	for lttng-dev@lists.lttng.org; Sat, 24 Aug 2013 15:42:46 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1933619pab.29
	for <lttng-dev@lists.lttng.org>; Sat, 24 Aug 2013 12:42:36 -0700 (PDT)
In-Reply-To: <20130824175909.GA12409@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0499564666==
Content-Type: multipart/alternative; boundary=bcaec52154df9a3e6204e4b6b97c

--bcaec52154df9a3e6204e4b6b97c
Content-Type: text/plain; charset=ISO-8859-1

2013/8/24 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand (jimmy.durand.wesolowski@gmail.com) wrote:
> > 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > > > Hi,
> > > >
> > > >
> > > > Here are some patches to allow installing LTTng-ust out of the system
> > > > directories, ie building with "./configure --prefix", without having
> to
> > > set
> > > > C/CPP/LDFLAGS at both the configure and the make building steps.
> > >
> > > Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,
> > > e.g.:
> > >
> > > LDFLAGS=/usr/local/lib ./configure
> > >
> > > What feature is this patchset adding that is not covered by the usual
> > > approach ? Or what is it fixing ?
> > >
> > Actually, this is enough for a regular system build, but if you wish to
> > build
> > it in another directory with --prefix=<PATH>, which is the case for
> cross-
> > compiling, this not enough.
>
> It might be a failure of my imagination but.. why is
> CPPFLAGS/CFLAGS/LDFLAGS not enough to get UST to fetch the dependencies
> it needs (e.g. userspace RCU) when they have been installed in
> non-standard paths (because e.g. userspace RCU has been configured with
> a --prefix path for sake of cross-compiling).
>
When building the doc/examples source directories, it seems that the
Makefiles are
not using the compiler and the flags set during the './configure' stage.

Can you give a more detailed use-case that CPPFLAGS/CFLAGS/LDFLAGS fail
> to cover ?
>
Yes, I will send it a complete use case Monday morning (UTC+1).

Thanks,

Thank you for the support,
-- 
Jimmy Durand Wesolowski
Linux System Engineer & amateur photographer
OpenWide

--bcaec52154df9a3e6204e4b6b97c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/24 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.com</a>&gt;</span><br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">* Jimmy Durand (<a href=3D"mailto:jimmy.=
durand.wesolowski@gmail.com">jimmy.durand.wesolowski@gmail.com</a>) wrote:<=
br>


&gt; 2013/8/22 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt;<br>
&gt; &gt; * Jimmy Durand Wesolowski (<a href=3D"mailto:jimmy.durand.wesolow=
ski@gmail.com">jimmy.durand.wesolowski@gmail.com</a>) wrote:<br>
&gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Here are some patches to allow installing LTTng-ust out of t=
he system<br>
&gt; &gt; &gt; directories, ie building with &quot;./configure --prefix&quo=
t;, without having to<br>
&gt; &gt; set<br>
&gt; &gt; &gt; C/CPP/LDFLAGS at both the configure and the make building st=
eps.<br>
&gt; &gt;<br>
&gt; &gt; Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is eno=
ugh,<br>
&gt; &gt; e.g.:<br>
&gt; &gt;<br>
&gt; &gt; LDFLAGS=3D/usr/local/lib ./configure<br>
&gt; &gt;<br>
&gt; &gt; What feature is this patchset adding that is not covered by the u=
sual<br>
&gt; &gt; approach ? Or what is it fixing ?<br>
&gt; &gt;<br>
&gt; Actually, this is enough for a regular system build, but if you wish t=
o<br>
&gt; build<br>
&gt; it in another directory with --prefix=3D&lt;PATH&gt;, which is the cas=
e for cross-<br>
&gt; compiling, this not enough.<br>
<br>
</div>It might be a failure of my imagination but.. why is<br>
CPPFLAGS/CFLAGS/LDFLAGS not enough to get UST to fetch the dependencies<br>
it needs (e.g. userspace RCU) when they have been installed in<br>
non-standard paths (because e.g. userspace RCU has been configured with<br>
a --prefix path for sake of cross-compiling).<br></blockquote><div>When bui=
lding the doc/examples source directories, it seems that=A0the Makefiles ar=
e</div><div>not using the compiler and the flags set during the &#39;./conf=
igure&#39; stage.</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
Can you give a more detailed use-case that CPPFLAGS/CFLAGS/LDFLAGS fail<br>
to cover ?<br></blockquote><div>Yes, I will send it a complete use case Mon=
day morning (UTC+1).</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:r=
gb(204,204,204);border-left-style:solid;padding-left:1ex">


Thanks,</blockquote></div><div>Thank you for the support,</div>-- <br>Jimmy=
=A0Durand Wesolowski<br>Linux System Engineer &amp; amateur photographer<br=
>OpenWide
</div></div>

--bcaec52154df9a3e6204e4b6b97c--


--===============0499564666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0499564666==--
