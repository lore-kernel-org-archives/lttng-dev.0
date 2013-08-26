From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Mon, 26 Aug 2013 17:13:07 +0200
Message-ID: <CAD7SSK6JEmQhkj-RVmfaDeg5e+ZDMsJvFkkg-VpxSVZojo4MZw__20445.3061371625$1377530069$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
	<CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ@mail.gmail.com>
	<20130826162407.1996f085@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971884268=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VDyTg-0006ac-Rg
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 11:13:18 -0400
Received: by mail-qa0-f49.google.com with SMTP id ia15so1064496qab.15
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 08:13:07 -0700 (PDT)
In-Reply-To: <20130826162407.1996f085@skate>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1971884268==
Content-Type: multipart/alternative; boundary=001a11c2c0b88febe304e4db31d4

--001a11c2c0b88febe304e4db31d4
Content-Type: text/plain; charset=ISO-8859-1

2013/8/26 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

> Dear Jimmy Durand Wesolowski,

Dear Thomas Petazzoni,



> On Mon, 26 Aug 2013 09:43:49 +0200, Jimmy Durand Wesolowski wrote:
>
> > Here is a quick test, without any of my modifications. I had to pass both
> > CFLAGS and LDFLAGS to "./configure", as said earlier, which can be
> > considered
> > a normal process:
> > CFLAGS="-I<URCU_BUILD_PATH>/include" \
> >   CPPFLAGS="-I<URCU_BUILD_PATH>/include" \
> >   LDFLAGS="-L<URCU_BUILD_PATH>/lib" \
> >   ./configure --prefix=${PWD}/build
>
> As said previously, if you're cross-compiling, doing
> --prefix=${PWD}/build is completely wrong. --prefix is the directory
> where the software will be located when executed on the target, not the
> location where the software will be installed when doing 'make install'.
>
Thank you for this information, I shamefully did not remember this, and I
am a buildroot user myself... I will not be using --prefix for cross-
compilation anymore, thank you.

Nevertheless, I did not say that LTTng cannot be cross-compiled without
these changes, but it needs flags at the 'configure' step, and at the
'make' one, as I said earlier, which DESTDIR will not correct, since the
the flags are not given to the sub-Makefiles.


Thank you for the correction,
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--001a11c2c0b88febe304e4db31d4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/26 Thomas Petazzoni <span dir=3D"ltr">&lt;<a href=
=3D"mailto:thomas.petazzoni@free-electrons.com" target=3D"_blank">thomas.pe=
tazzoni@free-electrons.com</a>&gt;</span><br><div class=3D"gmail_extra"><di=
v class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Dear Jimmy Durand Wesolowski,</blockquote><div>Dear Thomas=
 Petazzoni,</div>
<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex"><div class=3D"im">
On Mon, 26 Aug 2013 09:43:49 +0200, Jimmy Durand Wesolowski wrote:<br>
<br>
&gt; Here is a quick test, without any of my modifications. I had to pass b=
oth<br>
&gt; CFLAGS and LDFLAGS to &quot;./configure&quot;, as said earlier, which =
can be<br>
&gt; considered<br>
&gt; a normal process:<br>
&gt; CFLAGS=3D&quot;-I&lt;URCU_BUILD_PATH&gt;/include&quot; \<br>
&gt; =A0 CPPFLAGS=3D&quot;-I&lt;URCU_BUILD_PATH&gt;/include&quot; \<br>
&gt; =A0 LDFLAGS=3D&quot;-L&lt;URCU_BUILD_PATH&gt;/lib&quot; \<br>
&gt; =A0 ./configure --prefix=3D${PWD}/build<br>
<br>
</div>As said previously, if you&#39;re cross-compiling, doing<br>
--prefix=3D${PWD}/build is completely wrong. --prefix is the directory<br>
where the software will be located when executed on the target, not the<br>
location where the software will be installed when doing &#39;make install&=
#39;.<br></blockquote><div>Thank you for this information, I shamefully did=
 not remember this, and I</div><div>am a buildroot user myself... I will no=
t be using --prefix for cross-</div>
<div>compilation anymore, thank you.</div><div><br></div></div><div>Neverth=
eless, I did not say that LTTng cannot be cross-compiled without</div><div>=
these changes, but it needs flags at the &#39;configure&#39; step, and at t=
he</div>
<div>&#39;make&#39; one, as I said earlier, which DESTDIR will not correct,=
 since the</div><div>the flags are not given to the sub-Makefiles.</div><di=
v><br></div><div><br></div><div>Thank you for the correction,</div>-- <br>
<div dir=3D"ltr">Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<=
br></div><div>OneAccess</div></div>
</div></div>

--001a11c2c0b88febe304e4db31d4--


--===============1971884268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1971884268==--
