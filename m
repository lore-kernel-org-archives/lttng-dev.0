From: Jimmy Durand <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Sat, 24 Aug 2013 17:34:16 +0200
Message-ID: <CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg__36704.7725049362$1377358538$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0437305495=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <phoenixonrebirth@gmail.com>) id 1VDFrO-0003ab-2M
	for lttng-dev@lists.lttng.org; Sat, 24 Aug 2013 11:34:44 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so1783297pbc.23
	for <lttng-dev@lists.lttng.org>; Sat, 24 Aug 2013 08:34:36 -0700 (PDT)
In-Reply-To: <20130822125523.GB26852@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0437305495==
Content-Type: multipart/alternative; boundary=047d7bdcab58b4abdf04e4b3424e

--047d7bdcab58b4abdf04e4b3424e
Content-Type: text/plain; charset=ISO-8859-1

2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > Hi,
> >
> >
> > Here are some patches to allow installing LTTng-ust out of the system
> > directories, ie building with "./configure --prefix", without having to
> set
> > C/CPP/LDFLAGS at both the configure and the make building steps.
>
> Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,
> e.g.:
>
> LDFLAGS=/usr/local/lib ./configure
>
> What feature is this patchset adding that is not covered by the usual
> approach ? Or what is it fixing ?
>
Actually, this is enough for a regular system build, but if you wish to
build
it in another directory with --prefix=<PATH>, which is the case for cross-
compiling, this not enough.


Thanks,

Thank you,
-- 
Jimmy Durand Wesolowski
Linux System Engineer & amateur photographer
OpenWide

--047d7bdcab58b4abdf04e4b3424e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/22 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.com</a>&gt;</span><br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">* Jimmy Durand Wesolowski =
(<a href=3D"mailto:jimmy.durand.wesolowski@gmail.com">jimmy.durand.wesolows=
ki@gmail.com</a>) wrote:<br>


&gt; Hi,<br>
&gt;<br>
&gt;<br>
&gt; Here are some patches to allow installing LTTng-ust out of the system<=
br>
&gt; directories, ie building with &quot;./configure --prefix&quot;, withou=
t having to set<br>
&gt; C/CPP/LDFLAGS at both the configure and the make building steps.<br>
<br>
</div>Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,=
<br>
e.g.:<br>
<br>
LDFLAGS=3D/usr/local/lib ./configure<br>
<br>
What feature is this patchset adding that is not covered by the usual<br>
approach ? Or what is it fixing ?<br></blockquote><div>Actually, this is en=
ough for a regular system build, but if you wish to build</div><div>it in a=
nother directory with --prefix=3D&lt;PATH&gt;, which is the case for cross-=
</div>

<div>compiling, this not enough.</div><div><br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
Thanks,</blockquote><div>Thank you,=A0</div></div>-- <br>Jimmy=A0Durand Wes=
olowski<br>Linux System Engineer &amp; amateur photographer<br>OpenWide
</div></div>

--047d7bdcab58b4abdf04e4b3424e--


--===============0437305495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0437305495==--
