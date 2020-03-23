From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Mon, 23 Mar 2020 11:37:51 -0600
Message-ID: <CADtyBo7ZL2bGqwq5V7Xg7JWSQfndj13TtaOD5tQctB1W1uNWpQ@mail.gmail.com>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
 <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
 <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
 <CADtyBo44MW0=jBnrhh-aqfnrS8RtLAk9zbBZp3ktEhKACWPXdg@mail.gmail.com>
 <4bc0ec69-7587-fe58-691f-5cb23a11cd43@simark.ca>
 <1c4447ea-b67a-eaf0-c9dd-d2c10106b5a7@simark.ca>
 <CADtyBo54YfVYCc6-ODNTxGWBs4HgHZwDED93Z_GVF8APaafYFw@mail.gmail.com>
 <5f7d96c7-bf73-3ef6-012d-27dd8812361a@simark.ca>
 <CADtyBo6gSKTLzyXsU-E=--rdxaUARCV+-2CgA80pm8sH73EZZQ@mail.gmail.com>
 <45822fa3-e680-4946-5919-27b4b5398988@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4559262219374822567=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 48mM6S4GyXz1R39
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 13:38:08 -0400 (EDT)
Received: by mail-oi1-x236.google.com with SMTP id p125so15577158oif.10
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 10:38:08 -0700 (PDT)
In-Reply-To: <45822fa3-e680-4946-5919-27b4b5398988@simark.ca>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Simon Marchi <simark@simark.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============4559262219374822567==
Content-Type: multipart/alternative; boundary="0000000000001e121305a18919bc"

--0000000000001e121305a18919bc
Content-Type: text/plain; charset="UTF-8"

Simon,

See below...

On Mon, Mar 23, 2020 at 11:24 AM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-23 12:56 p.m., Rocky Dunlap wrote:
> > Simon,
> >
> > Success!  This change worked and I was able to build and install with
> icc.  Thank you!
>
> Ok, thanks.  Out of curiosity, did run a "make check"?  That would
> validate that
> the Python bindings (and everything else) works properly.
>

============================================================================
Testsuite summary for babeltrace2 2.1.0-rc1
============================================================================
# TOTAL: 21225
# PASS:  21225
# SKIP:  0
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
============================================================================



>
> > I still get a lot of warnings during the build (see below) which seems
> like configure should work these out ahead of time.  They are easy enough
> to ignore, but if support for intel is added, it would be nice to have
> these cleaned up.  For what it's worth, adding support for additional
> compilers in my experience has greatly improved the quality of library code
> - it tends to snuff out those bugs that are hard to find on a single
> compiler.
>
> I agree, that's why we want to keep babeltrace building with clang (on top
> of having to
> support macOS, on which clang is the default compiler).
>
> We use the AX_APPEND_COMPILE_FLAGS autoconf macro [1] to determine which
> warning flags
> the current compiler supports.  This calls the compiler with each flag
> individually
> to see if the compiler supports that flag.  This requires that the
> compiler errors
> out when passed an invalid flag.  Currently, it looks like icc emits a
> warning, but still
> returns exit code 0 when passed an invalid flag, so we end up enabling all
> of them.  Try
> to check in config.log to see what happens currently.  For example here
> are the test
> results for two flags, one supported and one not supported by clang:
>
> 4625 configure:17825: checking whether C compiler accepts -Winit-self
> 4626 configure:17844: ccache clang -c -gdwarf-5 -g3 -O2 -fsanitize=address
> -Werror -Winit-self  conftest.c >&5
> 4627 configure:17844: $? = 0
> 4628 configure:17853: result: yes
> 4629 configure:17869: : WARN_CFLAGS="$WARN_CFLAGS"
> 4630 configure:17872: $? = 0
> 4631 configure:17825: checking whether C compiler accepts -Wduplicated-cond
> 4632 configure:17844: ccache clang -c -gdwarf-5 -g3 -O2 -fsanitize=address
> -Werror -Wduplicated-cond  conftest.c >&5
> 4633 error: unknown warning option '-Wduplicated-cond'; did you mean
> '-Wduplicate-enum'? [-Werror,-Wunknown-warning-option]
> 4634 configure:17844: $? = 1
>
> If you can come up with the right incantation to make that work well with
> icc, we
> can modify how we call the macro or modify the macro itself (sending a
> patch to
> the upstream, Autoconf Archive).
>
> [1]
> https://www.gnu.org/software/autoconf-archive/ax_append_compile_flags.html


Okay, I'll try to find some time look into this.



>
>
> > If you decide to merge this in, a release patch 2.0.3 would certainly be
> helpful as well!
>
> Things have started to diverge a bit between master and the 2.0 branch,
> I'm not sure if we'll
> be able to backport that, we'll see.
>

Sure, no problem.  I'm not sure what the overall release schedule is, so
maybe it would be a 2.1 at some point soon?


>
> Simon
> >
>
>

--0000000000001e121305a18919bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Simon,<div><br></div><div>See below...</d=
iv></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Mon, Mar 23, 2020 at 11:24 AM Simon Marchi &lt;<a href=3D"mailto:sima=
rk@simark.ca">simark@simark.ca</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On 2020-03-23 12:56 p.m., Rocky Dunlap wrote:=
<br>
&gt; Simon,<br>
&gt; <br>
&gt; Success!=C2=A0 This change worked and I was able to build and install =
with icc.=C2=A0 Thank you!<br>
<br>
Ok, thanks.=C2=A0 Out of curiosity, did run a &quot;make check&quot;?=C2=A0=
 That would validate that<br>
the Python bindings (and everything else) works properly.<br></blockquote><=
div><br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>Testsuite summary for babeltrace2 2.1.0-rc1<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br># TOTAL: 21225<br># PASS: =C2=A021225<br># SKIP: =C2=A00<br># XFAIL:=
 0<br># FAIL: =C2=A00<br># XPASS: 0<br># ERROR: 0<br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div><div><br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I still get a lot of warnings during the build (see below) which seems=
 like configure should work these out ahead of time.=C2=A0 They are easy en=
ough to ignore, but if support for intel is added, it would be nice to have=
 these cleaned up.=C2=A0 For what it&#39;s worth, adding support for additi=
onal compilers in my experience has greatly improved the quality of library=
 code - it tends to snuff out those bugs that are hard to find on a single =
compiler.=C2=A0=C2=A0<br>
<br>
I agree, that&#39;s why we want to keep babeltrace building with clang (on =
top of having to<br>
support macOS, on which clang is the default compiler).<br>
<br>
We use the AX_APPEND_COMPILE_FLAGS autoconf macro [1] to determine which wa=
rning flags<br>
the current compiler supports.=C2=A0 This calls the compiler with each flag=
 individually<br>
to see if the compiler supports that flag.=C2=A0 This requires that the com=
piler errors<br>
out when passed an invalid flag.=C2=A0 Currently, it looks like icc emits a=
 warning, but still<br>
returns exit code 0 when passed an invalid flag, so we end up enabling all =
of them.=C2=A0 Try<br>
to check in config.log to see what happens currently.=C2=A0 For example her=
e are the test<br>
results for two flags, one supported and one not supported by clang:<br>
<br>
4625 configure:17825: checking whether C compiler accepts -Winit-self<br>
4626 configure:17844: ccache clang -c -gdwarf-5 -g3 -O2 -fsanitize=3Daddres=
s -Werror -Winit-self=C2=A0 conftest.c &gt;&amp;5<br>
4627 configure:17844: $? =3D 0<br>
4628 configure:17853: result: yes<br>
4629 configure:17869: : WARN_CFLAGS=3D&quot;$WARN_CFLAGS&quot;<br>
4630 configure:17872: $? =3D 0<br>
4631 configure:17825: checking whether C compiler accepts -Wduplicated-cond=
<br>
4632 configure:17844: ccache clang -c -gdwarf-5 -g3 -O2 -fsanitize=3Daddres=
s -Werror -Wduplicated-cond=C2=A0 conftest.c &gt;&amp;5<br>
4633 error: unknown warning option &#39;-Wduplicated-cond&#39;; did you mea=
n &#39;-Wduplicate-enum&#39;? [-Werror,-Wunknown-warning-option]<br>
4634 configure:17844: $? =3D 1<br>
<br>
If you can come up with the right incantation to make that work well with i=
cc, we<br>
can modify how we call the macro or modify the macro itself (sending a patc=
h to<br>
the upstream, Autoconf Archive).<br>
<br>
[1] <a href=3D"https://www.gnu.org/software/autoconf-archive/ax_append_comp=
ile_flags.html" rel=3D"noreferrer" target=3D"_blank">https://www.gnu.org/so=
ftware/autoconf-archive/ax_append_compile_flags.html</a></blockquote><div><=
br></div><div>Okay, I&#39;ll try to find some time look into this.</div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex"><br>
<br>
&gt; If you decide to merge this in, a release patch 2.0.3 would certainly =
be helpful as well!<br>
<br>
Things have started to diverge a bit between master and the 2.0 branch, I&#=
39;m not sure if we&#39;ll<br>
be able to backport that, we&#39;ll see.<br></blockquote><div><br></div><di=
v>Sure, no problem.=C2=A0 I&#39;m not sure what the overall release schedul=
e is, so maybe it would be a 2.1 at some point soon?</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Simon<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000001e121305a18919bc--

--===============4559262219374822567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============4559262219374822567==--
