From: Jean Spector <jean.spector@gmail.com>
Subject: Re: Babeltrace python bindings documentation is no
	up-to-date
Date: Mon, 31 Oct 2016 22:02:55 +0200
Message-ID: <CABVQWN1USj+gH_horiYtB3V0q0nCOQ+NWdknA2AdVwdyMoGtHg__35458.0861320303$1477944387$gmane$org@mail.gmail.com>
References: <CABVQWN0JnR+K9BN11vYX051Q_ZspWHbVnUdUbREb+LgB1pMR8A@mail.gmail.com>
 <CAB4xu_0FBn00woj==OqKyiQ67cNNsKBNcKHKoevP8ki=oOFHTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4508390611288509750=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 2DD9CA545E
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 20:03:39 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id n67so249879996wme.1
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 13:03:17 -0700 (PDT)
In-Reply-To: <CAB4xu_0FBn00woj==OqKyiQ67cNNsKBNcKHKoevP8ki=oOFHTg@mail.gmail.com>
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

--===============4508390611288509750==
Content-Type: multipart/alternative; boundary=047d7bfcfdced3c20105402eb212

--047d7bfcfdced3c20105402eb212
Content-Type: text/plain; charset=UTF-8

Thank you Philippe.

Adding a different documentation page for older versions (it's the latest
package on RHEL 7.2 - so I'd expect more newbies to encounter this issue)
could help anyone trying the Python bindings for the first time.
I'm sure you realize that trying the official example and failing can be
quite frustrating and could turn off potential users. This is especially
true if it comes after other issues(let me know if you'd prefer these to be
sent in separate emails):

RHEL 7.2 uses python 3.4, but babeltrace-python-1.2.4 requires python 3.3,
which is not available anymore - at least not out of the box.
Again, I've solved the issue for myself, so it's not a support call. The
idea is that it would be great if the initial install+run stage was made
less painful.
I believe it would increase the user base as, for instance, I was on the
verge of giving up after building from source has also failed for me.

When trying to build from latest stable source (1.4.0) on RHEL 7.2, I've
encountered a couple of issues:

   1. configure would fail on popt. "ln -s /usr/lib64/libpopt.so.0
   /usr/lib64/libpopt.so" worked around the issue, but there must be a better
   way (or a line in the README).
   2. "python3 -c 'import babeltrace'" would fail with "ImportError:
   /usr/local/lib64/python3.4/site-packages/babeltrace/_nativebt.so: undefined
   symbol: PyInstance_Type"

That's where I gave up trying to build from source. It could be due to the
same python 3.4 - but it's just a guess.

==========

To recap, I see 3 issues here:

   1. Documentation - any platform
   2. Install of the latest  babeltrace-python (1.2.4) - RHEL 7.2
   3. Building from the latest stable source (1.4.0) - RHEL 7.2


In any case, thanks for the great tool. I hope to put it to good use.
Jean


On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector <jean.spector@gmail.com>
> wrote:
> > When trying to use the example from
> > http://diamon.org/babeltrace/docs/python/examples/ (pointed to via
> > http://lttng.org/viewers/), the code is not up-to-date.
> >
> > For instance, the first line in the example (import babeltrace.reader)
> fails
> > as there's no 'reader' to import.
> >
> > I've managed to get over it, but thought it would be better to have a
> > working example code.
>
> I wrote this doc and it was merged into master more than a year ago.
> When writing this doc, I split the `babeltrace` package into the
> `reader` and `writer` subpackages to make the autodocumentation with
> Sphinx easier. Now it looks like this split was never backported to
> v1.2, v1.3, v1.4, and soon v1.5.
>
> The `Babeltrace 1.2.0` version you see on the front page is just the
> current version found when I generated the online version. Really, the
> title should say `Babeltrace (master branch)`. The master branch will
> become Babeltrace 2.0 soon. In the meantime, simply drop the `reader`
> subpackage when you read the doc and try examples. So
>
>     import babeltrace.reader as btreader
>
>     trace_collection = btreader.TraceCollection()
>
> becomes
>
>     import babeltrace as btreader
>
>     trace_collection = btreader.TraceCollection()
>
> For the CTF writer part, drop the `writer` subpackage, and import the
> `CTFWriter` class: you'll find all the documented classes within this
> class (kind of weird, and one of the reasons I created a subpackage
> instead):
>
>     import babeltrace.writer as btwriter
>
>     writer = btwriter.Writer(trace_path)
>
> becomes
>
>     from babeltrace import CTFWriter as btwriter
>
>     writer = btwriter.Writer(trace_path)
>
> Note that the new subpackage split is backward compatible with the
> bindings of v1.x, so the code you write now will continue to work...
> forever.
>
> I might add an equivalent of this response as a note in the generated
> documentation.
>
> BR,
> Phil
>
> >
> > P.S. I'm running RHEL 7.2 with babeltrace-python-1.2.4-1.el7.x86_64
> >
> > Best Regards,
> > Jean
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--047d7bfcfdced3c20105402eb212
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you=C2=A0<span style=3D"font-size:12.8px;white-space=
:nowrap">Philippe.</span><div><span style=3D"font-size:12.8px;white-space:n=
owrap"><br></span><div><span style=3D"font-size:12.8px;white-space:nowrap">=
Adding a different documentation page for older versions (it&#39;s the late=
st package on RHEL 7.2 - so I&#39;d expect more newbies to encounter this i=
ssue) could help anyone trying the Python bindings for the first time.</spa=
n></div><div><span style=3D"font-size:12.8px;white-space:nowrap">I&#39;m su=
re you realize that trying the official example and failing can be quite fr=
ustrating and could turn off potential users. This is especially true if it=
 comes after other issues(let me know if you&#39;d prefer these to be sent =
in separate emails):</span></div><div><span style=3D"font-size:12.8px;white=
-space:nowrap"><br></span></div><div><span style=3D"font-size:12.8px;white-=
space:nowrap">RHEL 7.2 uses python 3.4, but=C2=A0</span><span style=3D"colo=
r:rgb(80,0,80);font-size:12.8px">babeltrace-python-1.2.4 requires python 3.=
3, which is not available anymore - at least not out of the box.</span><br>=
</div><div>Again, I&#39;ve solved the issue for myself, so it&#39;s not a s=
upport call. The idea is that it would be great if the initial install+run =
stage was made less painful.</div><div>I believe it would increase the user=
 base as, for instance, I was on the verge of giving up after building from=
 source has also failed for me.</div><div><br></div><div>When trying to bui=
ld from latest stable source (1.4.0) on RHEL 7.2, I&#39;ve encountered a co=
uple of issues:</div><div><ol><li>configure would fail on popt. &quot;ln -s=
 /usr/lib64/libpopt.so.0 /usr/lib64/libpopt.so&quot; worked around the issu=
e, but there must be a better way (or a line in the README).</li><li>&quot;=
python3 -c &#39;import babeltrace&#39;&quot; would fail with &quot;ImportEr=
ror: /usr/local/lib64/python3.4/site-packages/babeltrace/_nativebt.so: unde=
fined symbol: PyInstance_Type&quot;</li></ol><div>That&#39;s where I gave u=
p trying to build from source. It could be due to the same python 3.4 - but=
 it&#39;s just a guess.</div></div><div><br></div><div>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</div><div><br></div><div>To recap, I see 3 issues here:</div><=
div><ol><li>Documentation - any platform</li><li>Install of the latest=C2=
=A0
babeltrace-python (1.2.4) - RHEL 7.2</li><li>Building from the latest stabl=
e source (1.4.0) - RHEL 7.2</li></ol><div><br></div></div><div>In any case,=
 thanks for the great tool. I hope to put it to good use.</div><div>Jean</d=
iv><div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Oct 31, 2016 at 7:07 PM, Philippe Proulx <span dir=3D"ltr">&=
lt;<a href=3D"mailto:eeppeliteloop@gmail.com" target=3D"_blank">eeppelitelo=
op@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><span>On Sat, Oct 29, 2016 at 9:55 AM, Jean Spector &lt;<a hre=
f=3D"mailto:jean.spector@gmail.com" target=3D"_blank">jean.spector@gmail.co=
m</a>&gt; wrote:<br>
&gt; When trying to use the example from<br>
&gt; <a href=3D"http://diamon.org/babeltrace/docs/python/examples/" rel=3D"=
noreferrer" target=3D"_blank">http://diamon.org/babeltrace/d<wbr>ocs/python=
/examples/</a> (pointed to via<br>
&gt; <a href=3D"http://lttng.org/viewers/" rel=3D"noreferrer" target=3D"_bl=
ank">http://lttng.org/viewers/</a>), the code is not up-to-date.<br>
&gt;<br>
&gt; For instance, the first line in the example (import babeltrace.reader)=
 fails<br>
&gt; as there&#39;s no &#39;reader&#39; to import.<br>
&gt;<br>
&gt; I&#39;ve managed to get over it, but thought it would be better to hav=
e a<br>
&gt; working example code.<br>
<br>
</span>I wrote this doc and it was merged into master more than a year ago.=
<br>
When writing this doc, I split the `babeltrace` package into the<br>
`reader` and `writer` subpackages to make the autodocumentation with<br>
Sphinx easier. Now it looks like this split was never backported to<br>
v1.2, v1.3, v1.4, and soon v1.5.<br>
<br>
The `Babeltrace 1.2.0` version you see on the front page is just the<br>
current version found when I generated the online version. Really, the<br>
title should say `Babeltrace (master branch)`. The master branch will<br>
become Babeltrace 2.0 soon. In the meantime, simply drop the `reader`<br>
subpackage when you read the doc and try examples. So<br>
<br>
=C2=A0 =C2=A0 import babeltrace.reader as btreader<br>
<br>
=C2=A0 =C2=A0 trace_collection =3D btreader.TraceCollection()<br>
<br>
becomes<br>
<br>
=C2=A0 =C2=A0 import babeltrace as btreader<br>
<br>
=C2=A0 =C2=A0 trace_collection =3D btreader.TraceCollection()<br>
<br>
For the CTF writer part, drop the `writer` subpackage, and import the<br>
`CTFWriter` class: you&#39;ll find all the documented classes within this<b=
r>
class (kind of weird, and one of the reasons I created a subpackage<br>
instead):<br>
<br>
=C2=A0 =C2=A0 import babeltrace.writer as btwriter<br>
<br>
=C2=A0 =C2=A0 writer =3D btwriter.Writer(trace_path)<br>
<br>
becomes<br>
<br>
=C2=A0 =C2=A0 from babeltrace import CTFWriter as btwriter<br>
<br>
=C2=A0 =C2=A0 writer =3D btwriter.Writer(trace_path)<br>
<br>
Note that the new subpackage split is backward compatible with the<br>
bindings of v1.x, so the code you write now will continue to work...<br>
forever.<br>
<br>
I might add an equivalent of this response as a note in the generated<br>
documentation.<br>
<br>
BR,<br>
Phil<br>
<span><br>
&gt;<br>
&gt; P.S. I&#39;m running RHEL 7.2 with babeltrace-python-1.2.4-1.el7.<wbr>=
x86_64<br>
&gt;<br>
&gt; Best Regards,<br>
&gt; Jean<br>
&gt;<br>
&gt;<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
</blockquote></div><br></div></div>

--047d7bfcfdced3c20105402eb212--

--===============4508390611288509750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4508390611288509750==--
