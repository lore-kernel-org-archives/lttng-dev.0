From: Jean Spector <jean.spector@gmail.com>
Subject: Re: Babeltrace python bindings documentation is no
	up-to-date
Date: Tue, 1 Nov 2016 07:52:07 +0200
Message-ID: <CABVQWN0FJBu4vOWCD9iZ4tf6P9SxLG8K5a5vMzRkbahAGxWGDQ__29632.2234826677$1478009950$gmane$org@mail.gmail.com>
References: <CABVQWN0JnR+K9BN11vYX051Q_ZspWHbVnUdUbREb+LgB1pMR8A@mail.gmail.com>
 <CAB4xu_0FBn00woj==OqKyiQ67cNNsKBNcKHKoevP8ki=oOFHTg@mail.gmail.com>
 <CABVQWN1USj+gH_horiYtB3V0q0nCOQ+NWdknA2AdVwdyMoGtHg@mail.gmail.com>
 <CAB4xu_1Q8QekRhmAEUNf7ML+9zRXOEj5Afiw-3EeuB_pmHC4kA@mail.gmail.com>
 <CAB4xu_3zS6OHGrZbEYWEB6T-gQf=yhetiTR=aKm5BpwNpNYV0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2354207769576224229=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com
 [IPv6:2a00:1450:400c:c09::231])
 by lists.lttng.org (Postfix) with ESMTPS id CF7EE158E9
 for <lttng-dev@lists.lttng.org>; Tue,  1 Nov 2016 05:52:42 +0000 (UTC)
Received: by mail-wm0-x231.google.com with SMTP id n67so267223935wme.1
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 22:52:09 -0700 (PDT)
In-Reply-To: <CAB4xu_3zS6OHGrZbEYWEB6T-gQf=yhetiTR=aKm5BpwNpNYV0A@mail.gmail.com>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2354207769576224229==
Content-Type: multipart/alternative; boundary=001a11468b18c97ff6054036ec2b

--001a11468b18c97ff6054036ec2b
Content-Type: text/plain; charset=UTF-8

I couldn't reproduce the issues I had when building from source on my VM
and don't have a vanilla RHEL 7.2 now to reproduce :-(

Regarding documentation, current changes look all right. Adding a note
regarding software collections will certainly help.

There's another minor issue I see in the docs. They mention the package
name on Debian and Ubuntu, but not on RHEL and Fedora - even though there's
an rpm available.

In any case, thank you very much for your help.

-Jean

On Nov 1, 2016 02:52, "Philippe Proulx" <eeppeliteloop@gmail.com> wrote:

> On Mon, Oct 31, 2016 at 4:38 PM, Philippe Proulx
> <eeppeliteloop@gmail.com> wrote:
> > On Mon, Oct 31, 2016 at 4:02 PM, Jean Spector <jean.spector@gmail.com>
> wrote:
> >> Thank you Philippe.
> >>
> >> Adding a different documentation page for older versions (it's the
> latest
> >> package on RHEL 7.2 - so I'd expect more newbies to encounter this
> issue)
> >> could help anyone trying the Python bindings for the first time.
> >> I'm sure you realize that trying the official example and failing can be
> >> quite frustrating and could turn off potential users.
> >
> > I'll make sure to make the doc as clear as possible. The main problem
> here is
> > that the module is simply not Sphinx-documented in Babeltrace 1.x. I
> guess
> > I could search and replace the package names in the doc before
> publishing it.
> > I'll find a way to make it clear anyway.
>
> Jean,
>
> See <http://diamon.org/babeltrace/docs/python/> again.
>
> I added an important admonition to each page which at least explains what
> to do if you're using Babeltrace 1.x. Plus the indicated version is
> now `2.0.0-pre`.
>
> It should not be so complicated to understand for newcomers. That's the
> best
> I can do for the moment; writing a different version for Babeltrace
> 1.x is out of
> the question.
>
> Phil
>
> >
> >> This is especially
> >> true if it comes after other issues(let me know if you'd prefer these
> to be
> >> sent in separate emails):
> >>
> >> RHEL 7.2 uses python 3.4, but babeltrace-python-1.2.4 requires python
> 3.3,
> >> which is not available anymore - at least not out of the box.
> >
> > What do you mean? The bindings work just fine with Python 3.4 and Python
> 3.5.
> >
> >> Again, I've solved the issue for myself, so it's not a support call. The
> >> idea is that it would be great if the initial install+run stage was made
> >> less painful.
> >> I believe it would increase the user base as, for instance, I was on the
> >> verge of giving up after building from source has also failed for me.
> >>
> >> When trying to build from latest stable source (1.4.0) on RHEL 7.2, I've
> >> encountered a couple of issues:
> >>
> >> configure would fail on popt. "ln -s /usr/lib64/libpopt.so.0
> >> /usr/lib64/libpopt.so" worked around the issue, but there must be a
> better
> >> way (or a line in the README).
> >> "python3 -c 'import babeltrace'" would fail with "ImportError:
> >> /usr/local/lib64/python3.4/site-packages/babeltrace/_nativebt.so:
> undefined
> >> symbol: PyInstance_Type"
> >>
> >> That's where I gave up trying to build from source. It could be due to
> the
> >> same python 3.4 - but it's just a guess.
> >
> > The official channel for reporting bugs is the bug tracker
> > <https://bugs.lttng.org/projects/babeltrace/>. If you create an issue
> there, we
> > can ask for details about the environment and context and track the bug
> to
> > remember it.
> >
> > I have no idea what's going wrong here, but if you create an issue we
> > can test the
> > same environment (RHEL 7.2) and see if we can reproduce the bug.
> >
> >>
> >> ==========
> >>
> >> To recap, I see 3 issues here:
> >>
> >> Documentation - any platform
> >> Install of the latest  babeltrace-python (1.2.4) - RHEL 7.2
> >> Building from the latest stable source (1.4.0) - RHEL 7.2
> >>
> >>
> >> In any case, thanks for the great tool. I hope to put it to good use.
> >> Jean
> >
> > Thanks for the feedback! We appreciate.
> >
> > Phil
> >
> >>
> >>
> >> On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx <
> eeppeliteloop@gmail.com>
> >> wrote:
> >>>
> >>> On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector <jean.spector@gmail.com>
> >>> wrote:
> >>> > When trying to use the example from
> >>> > http://diamon.org/babeltrace/docs/python/examples/ (pointed to via
> >>> > http://lttng.org/viewers/), the code is not up-to-date.
> >>> >
> >>> > For instance, the first line in the example (import
> babeltrace.reader)
> >>> > fails
> >>> > as there's no 'reader' to import.
> >>> >
> >>> > I've managed to get over it, but thought it would be better to have a
> >>> > working example code.
> >>>
> >>> I wrote this doc and it was merged into master more than a year ago.
> >>> When writing this doc, I split the `babeltrace` package into the
> >>> `reader` and `writer` subpackages to make the autodocumentation with
> >>> Sphinx easier. Now it looks like this split was never backported to
> >>> v1.2, v1.3, v1.4, and soon v1.5.
> >>>
> >>> The `Babeltrace 1.2.0` version you see on the front page is just the
> >>> current version found when I generated the online version. Really, the
> >>> title should say `Babeltrace (master branch)`. The master branch will
> >>> become Babeltrace 2.0 soon. In the meantime, simply drop the `reader`
> >>> subpackage when you read the doc and try examples. So
> >>>
> >>>     import babeltrace.reader as btreader
> >>>
> >>>     trace_collection = btreader.TraceCollection()
> >>>
> >>> becomes
> >>>
> >>>     import babeltrace as btreader
> >>>
> >>>     trace_collection = btreader.TraceCollection()
> >>>
> >>> For the CTF writer part, drop the `writer` subpackage, and import the
> >>> `CTFWriter` class: you'll find all the documented classes within this
> >>> class (kind of weird, and one of the reasons I created a subpackage
> >>> instead):
> >>>
> >>>     import babeltrace.writer as btwriter
> >>>
> >>>     writer = btwriter.Writer(trace_path)
> >>>
> >>> becomes
> >>>
> >>>     from babeltrace import CTFWriter as btwriter
> >>>
> >>>     writer = btwriter.Writer(trace_path)
> >>>
> >>> Note that the new subpackage split is backward compatible with the
> >>> bindings of v1.x, so the code you write now will continue to work...
> >>> forever.
> >>>
> >>> I might add an equivalent of this response as a note in the generated
> >>> documentation.
> >>>
> >>> BR,
> >>> Phil
> >>>
> >>> >
> >>> > P.S. I'm running RHEL 7.2 with babeltrace-python-1.2.4-1.el7.x86_64
> >>> >
> >>> > Best Regards,
> >>> > Jean
> >>> >
> >>> >
> >>> > _______________________________________________
> >>> > lttng-dev mailing list
> >>> > lttng-dev@lists.lttng.org
> >>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>> >
> >>
> >>
>

--001a11468b18c97ff6054036ec2b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I couldn&#39;t reproduce the issues I had when building from=
 source on my VM and don&#39;t have a vanilla RHEL 7.2 now to reproduce :-(=
</p>
<p dir=3D"ltr">Regarding documentation, current changes look all right. Add=
ing a note regarding software collections will certainly help.</p>
<p dir=3D"ltr">There&#39;s another minor issue I see in the docs. They ment=
ion the package name on Debian and Ubuntu, but not on RHEL and Fedora - eve=
n though there&#39;s an rpm available.</p>
<p dir=3D"ltr">In any case, thank you very much for your help.</p>
<p dir=3D"ltr">-Jean</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Nov 1, 2016 02=
:52, &quot;Philippe Proulx&quot; &lt;<a href=3D"mailto:eeppeliteloop@gmail.=
com">eeppeliteloop@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On Mon, Oct 31, 2016 at 4:38 PM, Philippe Proulx<br=
>
&lt;<a href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&=
gt; wrote:<br>
&gt; On Mon, Oct 31, 2016 at 4:02 PM, Jean Spector &lt;<a href=3D"mailto:je=
an.spector@gmail.com">jean.spector@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Thank you Philippe.<br>
&gt;&gt;<br>
&gt;&gt; Adding a different documentation page for older versions (it&#39;s=
 the latest<br>
&gt;&gt; package on RHEL 7.2 - so I&#39;d expect more newbies to encounter =
this issue)<br>
&gt;&gt; could help anyone trying the Python bindings for the first time.<b=
r>
&gt;&gt; I&#39;m sure you realize that trying the official example and fail=
ing can be<br>
&gt;&gt; quite frustrating and could turn off potential users.<br>
&gt;<br>
&gt; I&#39;ll make sure to make the doc as clear as possible. The main prob=
lem here is<br>
&gt; that the module is simply not Sphinx-documented in Babeltrace 1.x. I g=
uess<br>
&gt; I could search and replace the package names in the doc before publish=
ing it.<br>
&gt; I&#39;ll find a way to make it clear anyway.<br>
<br>
Jean,<br>
<br>
See &lt;<a href=3D"http://diamon.org/babeltrace/docs/python/" rel=3D"norefe=
rrer" target=3D"_blank">http://diamon.org/babeltrace/<wbr>docs/python/</a>&=
gt; again.<br>
<br>
I added an important admonition to each page which at least explains what<b=
r>
to do if you&#39;re using Babeltrace 1.x. Plus the indicated version is<br>
now `2.0.0-pre`.<br>
<br>
It should not be so complicated to understand for newcomers. That&#39;s the=
 best<br>
I can do for the moment; writing a different version for Babeltrace<br>
1.x is out of<br>
the question.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt;&gt; This is especially<br>
&gt;&gt; true if it comes after other issues(let me know if you&#39;d prefe=
r these to be<br>
&gt;&gt; sent in separate emails):<br>
&gt;&gt;<br>
&gt;&gt; RHEL 7.2 uses python 3.4, but babeltrace-python-1.2.4 requires pyt=
hon 3.3,<br>
&gt;&gt; which is not available anymore - at least not out of the box.<br>
&gt;<br>
&gt; What do you mean? The bindings work just fine with Python 3.4 and Pyth=
on 3.5.<br>
&gt;<br>
&gt;&gt; Again, I&#39;ve solved the issue for myself, so it&#39;s not a sup=
port call. The<br>
&gt;&gt; idea is that it would be great if the initial install+run stage wa=
s made<br>
&gt;&gt; less painful.<br>
&gt;&gt; I believe it would increase the user base as, for instance, I was =
on the<br>
&gt;&gt; verge of giving up after building from source has also failed for =
me.<br>
&gt;&gt;<br>
&gt;&gt; When trying to build from latest stable source (1.4.0) on RHEL 7.2=
, I&#39;ve<br>
&gt;&gt; encountered a couple of issues:<br>
&gt;&gt;<br>
&gt;&gt; configure would fail on popt. &quot;ln -s /usr/lib64/libpopt.so.0<=
br>
&gt;&gt; /usr/lib64/libpopt.so&quot; worked around the issue, but there mus=
t be a better<br>
&gt;&gt; way (or a line in the README).<br>
&gt;&gt; &quot;python3 -c &#39;import babeltrace&#39;&quot; would fail with=
 &quot;ImportError:<br>
&gt;&gt; /usr/local/lib64/python3.4/<wbr>site-packages/babeltrace/_<wbr>nat=
ivebt.so: undefined<br>
&gt;&gt; symbol: PyInstance_Type&quot;<br>
&gt;&gt;<br>
&gt;&gt; That&#39;s where I gave up trying to build from source. It could b=
e due to the<br>
&gt;&gt; same python 3.4 - but it&#39;s just a guess.<br>
&gt;<br>
&gt; The official channel for reporting bugs is the bug tracker<br>
&gt; &lt;<a href=3D"https://bugs.lttng.org/projects/babeltrace/" rel=3D"nor=
eferrer" target=3D"_blank">https://bugs.lttng.org/<wbr>projects/babeltrace/=
</a>&gt;. If you create an issue there, we<br>
&gt; can ask for details about the environment and context and track the bu=
g to<br>
&gt; remember it.<br>
&gt;<br>
&gt; I have no idea what&#39;s going wrong here, but if you create an issue=
 we<br>
&gt; can test the<br>
&gt; same environment (RHEL 7.2) and see if we can reproduce the bug.<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt;<br>
&gt;&gt; To recap, I see 3 issues here:<br>
&gt;&gt;<br>
&gt;&gt; Documentation - any platform<br>
&gt;&gt; Install of the latest=C2=A0 babeltrace-python (1.2.4) - RHEL 7.2<b=
r>
&gt;&gt; Building from the latest stable source (1.4.0) - RHEL 7.2<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; In any case, thanks for the great tool. I hope to put it to good u=
se.<br>
&gt;&gt; Jean<br>
&gt;<br>
&gt; Thanks for the feedback! We appreciate.<br>
&gt;<br>
&gt; Phil<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx &lt;<a href=3D"ma=
ilto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector &lt;<a href=3D"m=
ailto:jean.spector@gmail.com">jean.spector@gmail.com</a>&gt;<br>
&gt;&gt;&gt; wrote:<br>
&gt;&gt;&gt; &gt; When trying to use the example from<br>
&gt;&gt;&gt; &gt; <a href=3D"http://diamon.org/babeltrace/docs/python/examp=
les/" rel=3D"noreferrer" target=3D"_blank">http://diamon.org/babeltrace/<wb=
r>docs/python/examples/</a> (pointed to via<br>
&gt;&gt;&gt; &gt; <a href=3D"http://lttng.org/viewers/" rel=3D"noreferrer" =
target=3D"_blank">http://lttng.org/viewers/</a>), the code is not up-to-dat=
e.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; For instance, the first line in the example (import babel=
trace.reader)<br>
&gt;&gt;&gt; &gt; fails<br>
&gt;&gt;&gt; &gt; as there&#39;s no &#39;reader&#39; to import.<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; I&#39;ve managed to get over it, but thought it would be =
better to have a<br>
&gt;&gt;&gt; &gt; working example code.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I wrote this doc and it was merged into master more than a yea=
r ago.<br>
&gt;&gt;&gt; When writing this doc, I split the `babeltrace` package into t=
he<br>
&gt;&gt;&gt; `reader` and `writer` subpackages to make the autodocumentatio=
n with<br>
&gt;&gt;&gt; Sphinx easier. Now it looks like this split was never backport=
ed to<br>
&gt;&gt;&gt; v1.2, v1.3, v1.4, and soon v1.5.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; The `Babeltrace 1.2.0` version you see on the front page is ju=
st the<br>
&gt;&gt;&gt; current version found when I generated the online version. Rea=
lly, the<br>
&gt;&gt;&gt; title should say `Babeltrace (master branch)`. The master bran=
ch will<br>
&gt;&gt;&gt; become Babeltrace 2.0 soon. In the meantime, simply drop the `=
reader`<br>
&gt;&gt;&gt; subpackage when you read the doc and try examples. So<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace.reader as btreader<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0trace_collection =3D btreader.TraceCollecti=
on()<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; becomes<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace as btreader<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0trace_collection =3D btreader.TraceCollecti=
on()<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; For the CTF writer part, drop the `writer` subpackage, and imp=
ort the<br>
&gt;&gt;&gt; `CTFWriter` class: you&#39;ll find all the documented classes =
within this<br>
&gt;&gt;&gt; class (kind of weird, and one of the reasons I created a subpa=
ckage<br>
&gt;&gt;&gt; instead):<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0import babeltrace.writer as btwriter<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0writer =3D btwriter.Writer(trace_path)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; becomes<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0from babeltrace import CTFWriter as btwrite=
r<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0writer =3D btwriter.Writer(trace_path)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Note that the new subpackage split is backward compatible with=
 the<br>
&gt;&gt;&gt; bindings of v1.x, so the code you write now will continue to w=
ork...<br>
&gt;&gt;&gt; forever.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I might add an equivalent of this response as a note in the ge=
nerated<br>
&gt;&gt;&gt; documentation.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; BR,<br>
&gt;&gt;&gt; Phil<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; P.S. I&#39;m running RHEL 7.2 with babeltrace-python-1.2.=
4-1.el7.<wbr>x86_64<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Best Regards,<br>
&gt;&gt;&gt; &gt; Jean<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@li=
sts.lttng.org</a><br>
&gt;&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/=
cgi-<wbr>bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
</blockquote></div></div>

--001a11468b18c97ff6054036ec2b--

--===============2354207769576224229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2354207769576224229==--
