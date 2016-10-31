From: Jean Spector <jean.spector@gmail.com>
Subject: Re: Babeltrace python bindings documentation is no
	up-to-date
Date: Mon, 31 Oct 2016 22:44:30 +0200
Message-ID: <CABVQWN2z5v77Y=EDvW5MFWVhB46Wn7+QyfxH8mwUSSip7UwyqA__33118.6235104271$1477946830$gmane$org@mail.gmail.com>
References: <CABVQWN0JnR+K9BN11vYX051Q_ZspWHbVnUdUbREb+LgB1pMR8A@mail.gmail.com>
 <CAB4xu_0FBn00woj==OqKyiQ67cNNsKBNcKHKoevP8ki=oOFHTg@mail.gmail.com>
 <CABVQWN1USj+gH_horiYtB3V0q0nCOQ+NWdknA2AdVwdyMoGtHg@mail.gmail.com>
 <CAB4xu_1Q8QekRhmAEUNf7ML+9zRXOEj5Afiw-3EeuB_pmHC4kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4219971428698823390=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 by lists.lttng.org (Postfix) with ESMTPS id E190B1569A
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 20:45:24 +0000 (UTC)
Received: by mail-wm0-x233.google.com with SMTP id n67so251710443wme.1
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 13:44:52 -0700 (PDT)
In-Reply-To: <CAB4xu_1Q8QekRhmAEUNf7ML+9zRXOEj5Afiw-3EeuB_pmHC4kA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4219971428698823390==
Content-Type: multipart/alternative; boundary=047d7bf10a60859ef505402f47ed

--047d7bf10a60859ef505402f47ed
Content-Type: text/plain; charset=UTF-8

On Mon, Oct 31, 2016 at 10:38 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Mon, Oct 31, 2016 at 4:02 PM, Jean Spector <jean.spector@gmail.com>
> wrote:
> > Thank you Philippe.
> >
> > Adding a different documentation page for older versions (it's the latest
> > package on RHEL 7.2 - so I'd expect more newbies to encounter this issue)
> > could help anyone trying the Python bindings for the first time.
> > I'm sure you realize that trying the official example and failing can be
> > quite frustrating and could turn off potential users.
>
> I'll make sure to make the doc as clear as possible. The main problem here
> is
> that the module is simply not Sphinx-documented in Babeltrace 1.x. I guess
> I could search and replace the package names in the doc before publishing
> it.
> I'll find a way to make it clear anyway.
>
Thank you

>
> > This is especially
> > true if it comes after other issues(let me know if you'd prefer these to
> be
> > sent in separate emails):
> >
> > RHEL 7.2 uses python 3.4, but babeltrace-python-1.2.4 requires python
> 3.3,
> > which is not available anymore - at least not out of the box.
>
> What do you mean? The bindings work just fine with Python 3.4 and Python
> 3.5.
>
It's a matter of rpm dependencies.
Once installed, it might work fine with python 3.4 - but yum just refuses
to install it on RHEL 7.2


> > Again, I've solved the issue for myself, so it's not a support call. The
> > idea is that it would be great if the initial install+run stage was made
> > less painful.
> > I believe it would increase the user base as, for instance, I was on the
> > verge of giving up after building from source has also failed for me.
> >
> > When trying to build from latest stable source (1.4.0) on RHEL 7.2, I've
> > encountered a couple of issues:
> >
> > configure would fail on popt. "ln -s /usr/lib64/libpopt.so.0
> > /usr/lib64/libpopt.so" worked around the issue, but there must be a
> better
> > way (or a line in the README).
> > "python3 -c 'import babeltrace'" would fail with "ImportError:
> > /usr/local/lib64/python3.4/site-packages/babeltrace/_nativebt.so:
> undefined
> > symbol: PyInstance_Type"
> >
> > That's where I gave up trying to build from source. It could be due to
> the
> > same python 3.4 - but it's just a guess.
>
> The official channel for reporting bugs is the bug tracker
> <https://bugs.lttng.org/projects/babeltrace/>. If you create an issue
> there, we
> can ask for details about the environment and context and track the bug to
> remember it.
>
> I have no idea what's going wrong here, but if you create an issue we
> can test the
> same environment (RHEL 7.2) and see if we can reproduce the bug.
>
> Will do


> >
> > ==========
> >
> > To recap, I see 3 issues here:
> >
> > Documentation - any platform
> > Install of the latest  babeltrace-python (1.2.4) - RHEL 7.2
> > Building from the latest stable source (1.4.0) - RHEL 7.2
> >
> >
> > In any case, thanks for the great tool. I hope to put it to good use.
> > Jean
>
> Thanks for the feedback! We appreciate.
>
> Phil
>
> >
> >
> > On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx <
> eeppeliteloop@gmail.com>
> > wrote:
> >>
> >> On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector <jean.spector@gmail.com>
> >> wrote:
> >> > When trying to use the example from
> >> > http://diamon.org/babeltrace/docs/python/examples/ (pointed to via
> >> > http://lttng.org/viewers/), the code is not up-to-date.
> >> >
> >> > For instance, the first line in the example (import babeltrace.reader)
> >> > fails
> >> > as there's no 'reader' to import.
> >> >
> >> > I've managed to get over it, but thought it would be better to have a
> >> > working example code.
> >>
> >> I wrote this doc and it was merged into master more than a year ago.
> >> When writing this doc, I split the `babeltrace` package into the
> >> `reader` and `writer` subpackages to make the autodocumentation with
> >> Sphinx easier. Now it looks like this split was never backported to
> >> v1.2, v1.3, v1.4, and soon v1.5.
> >>
> >> The `Babeltrace 1.2.0` version you see on the front page is just the
> >> current version found when I generated the online version. Really, the
> >> title should say `Babeltrace (master branch)`. The master branch will
> >> become Babeltrace 2.0 soon. In the meantime, simply drop the `reader`
> >> subpackage when you read the doc and try examples. So
> >>
> >>     import babeltrace.reader as btreader
> >>
> >>     trace_collection = btreader.TraceCollection()
> >>
> >> becomes
> >>
> >>     import babeltrace as btreader
> >>
> >>     trace_collection = btreader.TraceCollection()
> >>
> >> For the CTF writer part, drop the `writer` subpackage, and import the
> >> `CTFWriter` class: you'll find all the documented classes within this
> >> class (kind of weird, and one of the reasons I created a subpackage
> >> instead):
> >>
> >>     import babeltrace.writer as btwriter
> >>
> >>     writer = btwriter.Writer(trace_path)
> >>
> >> becomes
> >>
> >>     from babeltrace import CTFWriter as btwriter
> >>
> >>     writer = btwriter.Writer(trace_path)
> >>
> >> Note that the new subpackage split is backward compatible with the
> >> bindings of v1.x, so the code you write now will continue to work...
> >> forever.
> >>
> >> I might add an equivalent of this response as a note in the generated
> >> documentation.
> >>
> >> BR,
> >> Phil
> >>
> >> >
> >> > P.S. I'm running RHEL 7.2 with babeltrace-python-1.2.4-1.el7.x86_64
> >> >
> >> > Best Regards,
> >> > Jean
> >> >
> >> >
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> >
> >
> >
>

--047d7bf10a60859ef505402f47ed
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Oct 31, 2016 at 10:38 PM, Philippe Proulx <span dir=3D"ltr">&lt=
;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppeliteloop=
@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Mon, Oct 31, 2016 at 4:02 PM, Jean Spector &lt;<a href=3D"mailt=
o:jean.spector@gmail.com">jean.spector@gmail.com</a>&gt; wrote:<br>
&gt; Thank you Philippe.<br>
&gt;<br>
&gt; Adding a different documentation page for older versions (it&#39;s the=
 latest<br>
&gt; package on RHEL 7.2 - so I&#39;d expect more newbies to encounter this=
 issue)<br>
&gt; could help anyone trying the Python bindings for the first time.<br>
&gt; I&#39;m sure you realize that trying the official example and failing =
can be<br>
&gt; quite frustrating and could turn off potential users.<br>
<br>
</span>I&#39;ll make sure to make the doc as clear as possible. The main pr=
oblem here is<br>
that the module is simply not Sphinx-documented in Babeltrace 1.x. I guess<=
br>
I could search and replace the package names in the doc before publishing i=
t.<br>
I&#39;ll find a way to make it clear anyway.<br></blockquote><div>Thank you=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; This is especially<br>
&gt; true if it comes after other issues(let me know if you&#39;d prefer th=
ese to be<br>
&gt; sent in separate emails):<br>
&gt;<br>
&gt; RHEL 7.2 uses python 3.4, but babeltrace-python-1.2.4 requires python =
3.3,<br>
&gt; which is not available anymore - at least not out of the box.<br>
<br>
</span>What do you mean? The bindings work just fine with Python 3.4 and Py=
thon 3.5.<br></blockquote><div>It&#39;s a matter of rpm dependencies.</div>=
<div>Once installed, it might work fine with python 3.4 - but yum just refu=
ses to install it on RHEL 7.2</div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<span class=3D""><br>
&gt; Again, I&#39;ve solved the issue for myself, so it&#39;s not a support=
 call. The<br>
&gt; idea is that it would be great if the initial install+run stage was ma=
de<br>
&gt; less painful.<br>
&gt; I believe it would increase the user base as, for instance, I was on t=
he<br>
&gt; verge of giving up after building from source has also failed for me.<=
br>
&gt;<br>
&gt; When trying to build from latest stable source (1.4.0) on RHEL 7.2, I&=
#39;ve<br>
&gt; encountered a couple of issues:<br>
&gt;<br>
&gt; configure would fail on popt. &quot;ln -s /usr/lib64/libpopt.so.0<br>
&gt; /usr/lib64/libpopt.so&quot; worked around the issue, but there must be=
 a better<br>
&gt; way (or a line in the README).<br>
&gt; &quot;python3 -c &#39;import babeltrace&#39;&quot; would fail with &qu=
ot;ImportError:<br>
&gt; /usr/local/lib64/python3.4/<wbr>site-packages/babeltrace/_<wbr>nativeb=
t.so: undefined<br>
&gt; symbol: PyInstance_Type&quot;<br>
&gt;<br>
&gt; That&#39;s where I gave up trying to build from source. It could be du=
e to the<br>
&gt; same python 3.4 - but it&#39;s just a guess.<br>
<br>
</span>The official channel for reporting bugs is the bug tracker<br>
&lt;<a href=3D"https://bugs.lttng.org/projects/babeltrace/" rel=3D"noreferr=
er" target=3D"_blank">https://bugs.lttng.org/<wbr>projects/babeltrace/</a>&=
gt;. If you create an issue there, we<br>
can ask for details about the environment and context and track the bug to<=
br>
remember it.<br>
<br>
I have no idea what&#39;s going wrong here, but if you create an issue we<b=
r>
can test the<br>
same environment (RHEL 7.2) and see if we can reproduce the bug.<br>
<span class=3D""><br></span></blockquote><div>Will do</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D"">
&gt;<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;<br>
&gt; To recap, I see 3 issues here:<br>
&gt;<br>
&gt; Documentation - any platform<br>
&gt; Install of the latest=C2=A0 babeltrace-python (1.2.4) - RHEL 7.2<br>
&gt; Building from the latest stable source (1.4.0) - RHEL 7.2<br>
&gt;<br>
&gt;<br>
&gt; In any case, thanks for the great tool. I hope to put it to good use.<=
br>
&gt; Jean<br>
<br>
</span>Thanks for the feedback! We appreciate.<br>
<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx &lt;<a href=3D"mailto=
:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector &lt;<a href=3D"mailt=
o:jean.spector@gmail.com">jean.spector@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt; &gt; When trying to use the example from<br>
&gt;&gt; &gt; <a href=3D"http://diamon.org/babeltrace/docs/python/examples/=
" rel=3D"noreferrer" target=3D"_blank">http://diamon.org/babeltrace/<wbr>do=
cs/python/examples/</a> (pointed to via<br>
&gt;&gt; &gt; <a href=3D"http://lttng.org/viewers/" rel=3D"noreferrer" targ=
et=3D"_blank">http://lttng.org/viewers/</a>), the code is not up-to-date.<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; For instance, the first line in the example (import babeltrac=
e.reader)<br>
&gt;&gt; &gt; fails<br>
&gt;&gt; &gt; as there&#39;s no &#39;reader&#39; to import.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;ve managed to get over it, but thought it would be bett=
er to have a<br>
&gt;&gt; &gt; working example code.<br>
&gt;&gt;<br>
&gt;&gt; I wrote this doc and it was merged into master more than a year ag=
o.<br>
&gt;&gt; When writing this doc, I split the `babeltrace` package into the<b=
r>
&gt;&gt; `reader` and `writer` subpackages to make the autodocumentation wi=
th<br>
&gt;&gt; Sphinx easier. Now it looks like this split was never backported t=
o<br>
&gt;&gt; v1.2, v1.3, v1.4, and soon v1.5.<br>
&gt;&gt;<br>
&gt;&gt; The `Babeltrace 1.2.0` version you see on the front page is just t=
he<br>
&gt;&gt; current version found when I generated the online version. Really,=
 the<br>
&gt;&gt; title should say `Babeltrace (master branch)`. The master branch w=
ill<br>
&gt;&gt; become Babeltrace 2.0 soon. In the meantime, simply drop the `read=
er`<br>
&gt;&gt; subpackage when you read the doc and try examples. So<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace.reader as btreader<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0trace_collection =3D btreader.TraceCollection()=
<br>
&gt;&gt;<br>
&gt;&gt; becomes<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace as btreader<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0trace_collection =3D btreader.TraceCollection()=
<br>
&gt;&gt;<br>
&gt;&gt; For the CTF writer part, drop the `writer` subpackage, and import =
the<br>
&gt;&gt; `CTFWriter` class: you&#39;ll find all the documented classes with=
in this<br>
&gt;&gt; class (kind of weird, and one of the reasons I created a subpackag=
e<br>
&gt;&gt; instead):<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace.writer as btwriter<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0writer =3D btwriter.Writer(trace_path)<br>
&gt;&gt;<br>
&gt;&gt; becomes<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0from babeltrace import CTFWriter as btwriter<br=
>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0writer =3D btwriter.Writer(trace_path)<br>
&gt;&gt;<br>
&gt;&gt; Note that the new subpackage split is backward compatible with the=
<br>
&gt;&gt; bindings of v1.x, so the code you write now will continue to work.=
..<br>
&gt;&gt; forever.<br>
&gt;&gt;<br>
&gt;&gt; I might add an equivalent of this response as a note in the genera=
ted<br>
&gt;&gt; documentation.<br>
&gt;&gt;<br>
&gt;&gt; BR,<br>
&gt;&gt; Phil<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; P.S. I&#39;m running RHEL 7.2 with babeltrace-python-1.2.4-1.=
el7.<wbr>x86_64<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Best Regards,<br>
&gt;&gt; &gt; Jean<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
<wbr>bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt; &gt;<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div></div>

--047d7bf10a60859ef505402f47ed--

--===============4219971428698823390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4219971428698823390==--
