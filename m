From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [LTTNG][LTTng-ust] "Out of system" building patches.
Date: Mon, 26 Aug 2013 09:43:49 +0200
Message-ID: <CAD7SSK7_sNYZE5knPEJuJwnj+OXmpcXg1EGGThnT4HW5+s5+KQ__47364.9859581657$1377503076$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125523.GB26852@Krystal>
	<CAMaFG-3HCsKngNE1cNv9PfCFuhnHwsON=T-q084ZjD+1Aj2Zqg@mail.gmail.com>
	<20130824175909.GA12409@Krystal>
	<CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2057076567=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VDrSt-00051R-9U
	for lttng-dev@lists.lttng.org; Mon, 26 Aug 2013 03:43:56 -0400
Received: by mail-qe0-f43.google.com with SMTP id t7so1568132qeb.16
	for <lttng-dev@lists.lttng.org>; Mon, 26 Aug 2013 00:43:49 -0700 (PDT)
In-Reply-To: <CAMaFG-2cJ+uGdwC5hHMBHUs+HBciaPXtYQ6YAkwan5bL9O=9Og@mail.gmail.com>
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

--===============2057076567==
Content-Type: multipart/alternative; boundary=047d7b6da17ebfbed604e4d4eaba

--047d7b6da17ebfbed604e4d4eaba
Content-Type: text/plain; charset=ISO-8859-1

2013/8/24 Jimmy Durand <jimmy.durand.wesolowski@gmail.com>

> 2013/8/24 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
>> * Jimmy Durand (jimmy.durand.wesolowski@gmail.com) wrote:
>> > 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> >
>> > > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
>> > > > Hi,
>> > > >
>> > > >
>> > > > Here are some patches to allow installing LTTng-ust out of the
>> system
>> > > > directories, ie building with "./configure --prefix", without
>> having to
>> > > set
>> > > > C/CPP/LDFLAGS at both the configure and the make building steps.
>> > >
>> > > Usually, setting CPPFLAGS/CFLAGS/LDFLAGS at configure time is enough,
>> > > e.g.:
>> > >
>> > > LDFLAGS=/usr/local/lib ./configure
>> > >
>> > > What feature is this patchset adding that is not covered by the usual
>> > > approach ? Or what is it fixing ?
>> > >
>> > Actually, this is enough for a regular system build, but if you wish to
>> > build
>> > it in another directory with --prefix=<PATH>, which is the case for
>> cross-
>> > compiling, this not enough.
>>
>> It might be a failure of my imagination but.. why is
>> CPPFLAGS/CFLAGS/LDFLAGS not enough to get UST to fetch the dependencies
>> it needs (e.g. userspace RCU) when they have been installed in
>> non-standard paths (because e.g. userspace RCU has been configured with
>> a --prefix path for sake of cross-compiling).
>>
> When building the doc/examples source directories, it seems that the
> Makefiles are
> not using the compiler and the flags set during the './configure' stage.
>
> Can you give a more detailed use-case that CPPFLAGS/CFLAGS/LDFLAGS fail
>> to cover ?
>>
> Yes, I will send it a complete use case Monday morning (UTC+1).
>

Here is a quick test, without any of my modifications. I had to pass both
CFLAGS and LDFLAGS to "./configure", as said earlier, which can be
considered
a normal process:
CFLAGS="-I<URCU_BUILD_PATH>/include" \
  CPPFLAGS="-I<URCU_BUILD_PATH>/include" \
  LDFLAGS="-L<URCU_BUILD_PATH>/lib" \
  ./configure --prefix=${PWD}/build

Now, running "make all install", I would expect the build to succeed. But,
in
the "doc/examples" subdirectories, for example "easy-ust", I have the
following error:
../../../include/lttng/tracepoint-rcu.h:26:27: fatal error:
urcu/compiler.h: \
No such file or directory

I have to run "make all" with the CFLAGS set to have a successful build
(actually I even had to add a -I${PWD}/include to the "./configure" step,
'sample_tracepoint.o' would not build otherwise).


Thank you,
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--047d7b6da17ebfbed604e4d4eaba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/24 Jimmy Durand <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:jimmy.durand.wesolowski@gmail.com" target=3D"_blank">jimmy.durand.weso=
lowski@gmail.com</a>&gt;</span><br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div dir=3D"ltr">2013/8/24 Mathieu Desnoyers <span dir=3D"=
ltr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank=
">mathieu.desnoyers@efficios.com</a>&gt;</span><br>
<div class=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"im">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div>* Jimmy Durand (<a href=3D"mailto:jimmy.durand.wesolo=
wski@gmail.com" target=3D"_blank">jimmy.durand.wesolowski@gmail.com</a>) wr=
ote:<br>



&gt; 2013/8/22 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt;<br>
&gt; &gt; * Jimmy Durand Wesolowski (<a href=3D"mailto:jimmy.durand.wesolow=
ski@gmail.com" target=3D"_blank">jimmy.durand.wesolowski@gmail.com</a>) wro=
te:<br>
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
a --prefix path for sake of cross-compiling).<br></blockquote></div><div>Wh=
en building the doc/examples source directories, it seems that=A0the Makefi=
les are</div><div>not using the compiler and the flags set during the &#39;=
./configure&#39; stage.</div>
<div class=3D"im">

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">
Can you give a more detailed use-case that CPPFLAGS/CFLAGS/LDFLAGS fail<br>
to cover ?<br></blockquote></div><div>Yes, I will send it a complete use ca=
se Monday morning (UTC+1).</div></div></div></div></blockquote></div><div c=
lass=3D"gmail_extra"><br></div>Here is a quick test, without any of my modi=
fications. I had to pass both</div>
<div class=3D"gmail_extra">CFLAGS and LDFLAGS to &quot;./configure&quot;, a=
s said earlier, which can be considered</div><div class=3D"gmail_extra">a n=
ormal process:</div><div class=3D"gmail_extra">CFLAGS=3D&quot;-I&lt;URCU_BU=
ILD_PATH&gt;/include&quot; \</div>
<div class=3D"gmail_extra">=A0 CPPFLAGS=3D&quot;-I&lt;URCU_BUILD_PATH&gt;/i=
nclude&quot; \</div><div class=3D"gmail_extra">=A0 LDFLAGS=3D&quot;-L&lt;UR=
CU_BUILD_PATH&gt;/lib&quot; \</div><div class=3D"gmail_extra">=A0 ./configu=
re --prefix=3D${PWD}/build<br clear=3D"all">
<div><br></div><div>Now, running &quot;make all install&quot;, I would expe=
ct the build to succeed. But, in</div><div>the &quot;doc/examples&quot; sub=
directories, for example &quot;easy-ust&quot;, I have the</div><div>followi=
ng error:</div>
<div><div>../../../include/lttng/tracepoint-rcu.h:26:27: fatal error: urcu/=
compiler.h: \</div><div>No such file or directory</div></div><div><br></div=
><div>I have to run &quot;make all&quot; with the CFLAGS set to have a succ=
essful build</div>
<div>(actually I even had to add a -I${PWD}/include to the &quot;./configur=
e&quot; step,</div><div>&#39;sample_tracepoint.o&#39; would not build other=
wise).<br></div><div><br></div><div><br></div><div>Thank you,</div>-- <br>
<div dir=3D"ltr">Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<=
br></div><div>OneAccess</div></div>
</div></div>

--047d7b6da17ebfbed604e4d4eaba--


--===============2057076567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2057076567==--
