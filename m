From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Babeltrace2 - compilation error with intel18
Date: Mon, 23 Mar 2020 10:56:32 -0600
Message-ID: <CADtyBo6gSKTLzyXsU-E=--rdxaUARCV+-2CgA80pm8sH73EZZQ@mail.gmail.com>
References: <CADtyBo7jFiv-E-DCp4kYfY7WRSLsN3Oos6iRr35Sy9o=iNZKOg@mail.gmail.com>
 <b2e4fcfb-eb65-5205-1de3-0e0dbfb7fb48@simark.ca>
 <CADtyBo7Qjjb_f=45oTaSw4d=dQd5YVt6A2r7z7R5WYrxZ4eVTg@mail.gmail.com>
 <60fcd0f0-e89c-5e04-8185-8cf34a92fe04@simark.ca>
 <CADtyBo44MW0=jBnrhh-aqfnrS8RtLAk9zbBZp3ktEhKACWPXdg@mail.gmail.com>
 <4bc0ec69-7587-fe58-691f-5cb23a11cd43@simark.ca>
 <1c4447ea-b67a-eaf0-c9dd-d2c10106b5a7@simark.ca>
 <CADtyBo54YfVYCc6-ODNTxGWBs4HgHZwDED93Z_GVF8APaafYFw@mail.gmail.com>
 <5f7d96c7-bf73-3ef6-012d-27dd8812361a@simark.ca>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5136610679899477666=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by lists.lttng.org (Postfix) with ESMTPS id 48mLBn2Qzdz1R2v
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 12:56:48 -0400 (EDT)
Received: by mail-oi1-x235.google.com with SMTP id k8so15499809oik.2
 for <lttng-dev@lists.lttng.org>; Mon, 23 Mar 2020 09:56:48 -0700 (PDT)
In-Reply-To: <5f7d96c7-bf73-3ef6-012d-27dd8812361a@simark.ca>
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

--===============5136610679899477666==
Content-Type: multipart/alternative; boundary="000000000000556b0105a18885a8"

--000000000000556b0105a18885a8
Content-Type: text/plain; charset="UTF-8"

Simon,

Success!  This change worked and I was able to build and install with icc.
Thank you!

I still get a lot of warnings during the build (see below) which seems like
configure should work these out ahead of time.  They are easy enough to
ignore, but if support for intel is added, it would be nice to have these
cleaned up.  For what it's worth, adding support for additional compilers
in my experience has greatly improved the quality of library code - it
tends to snuff out those bugs that are hard to find on a single compiler.

If you decide to merge this in, a release patch 2.0.3 would certainly be
helpful as well!


Example warnings below:
icc: command line warning #10006: ignoring unknown option '-Wnested-externs'
icc: command line warning #10006: ignoring unknown option
'-Wtautological-constant-out-of-range-compare'
icc: command line warning #10006: ignoring unknown option '-Wnested-externs'
icc: command line warning #10006: ignoring unknown option
'-Wno-format-nonliteral'
icc: command line warning #10006: ignoring unknown option
'-Wno-format-nonliteral'
icc: command line warning #10006: ignoring unknown option
'-Wmissing-noreturn'
icc: command line warning #10006: ignoring unknown option
'-Wmissing-noreturn'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-cond'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-branches'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-cond'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-branches'
icc: command line warning #10006: ignoring unknown option '-Wlogical-op'
icc: command line warning #10006: ignoring unknown option '-Wlogical-op'
icc: command line warning #10006: ignoring unknown option
'-Wno-cast-function-type'
icc: command line warning #10006: ignoring unknown option
'-Wno-cast-function-type'
icc: command line warning #10006: ignoring unknown option
'-Wnull-dereference'
icc: command line warning #10006: ignoring unknown option
'-Wredundant-decls'
icc: command line warning #10006: ignoring unknown option
'-Wjump-misses-init'
icc: command line warning #10006: ignoring unknown option
'-Wsuggest-attribute=format'
icc: command line warning #10006: ignoring unknown option
'-Wtautological-constant-out-of-range-compare'
icc: command line warning #10006: ignoring unknown option '-Wnested-externs'
icc: command line warning #10006: ignoring unknown option
'-Wno-format-nonliteral'
icc: command line warning #10006: ignoring unknown option
'-Wmissing-noreturn'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-cond'
icc: command line warning #10006: ignoring unknown option
'-Wduplicated-branches'
icc: command line warning #10006: ignoring unknown option '-Wlogical-op'
icc: command line warning #10006: ignoring unknown option
'-Wno-cast-function-type'
icc: command line warning #10006: ignoring unknown option
'-Wnull-dereference'
icc: command line warning #10006: ignoring unknown option
'-Wredundant-decls'
icc: command line warning #10006: ignoring unknown option
'-Wjump-misses-init'
icc: command line warning #10006: ignoring unknown option
'-Wsuggest-attribute=format'
icc: command line warning #10006: ignoring unknown option
'-Wtautological-constant-out-of-range-compare'


On Mon, Mar 23, 2020 at 10:14 AM Simon Marchi <simark@simark.ca> wrote:

> On 2020-03-23 12:05 p.m., Rocky Dunlap wrote:
> > Simon,
> >
> > Yes, I will be happy to give this a try.  What's the easiest way to get
> this patch?  (Sorry, I'm less familiar with Gerrit...)
> >
> > Rocky
>
> You need a babeltrace git repository.  If you don't already have one, you
> can clone it from here:
>
>   https://github.com/efficios/babeltrace
>
> You can then click the "DOWNLOAD" button on the patch's review page, or
> press `d` (a keybinding).
>
> Copy the "Checkout" command (the first one) and paste it in your shell
> (while having the
> repository as the current working directory).  You'll then have the code
> corresponding to
> the proposed patch checked out and ready to build.  Note that when you
> build from the git
> repo, you need to run ./bootstrap first, to generate the configure script.
>
> Simon
>
>

--000000000000556b0105a18885a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Simon,<div><br></div><div>Success!=C2=A0 This change worke=
d and I was able to build and install with icc.=C2=A0 Thank you!</div><div>=
<br></div><div>I still get a lot of warnings during the build (see below) w=
hich seems like configure should work these out ahead of time.=C2=A0 They a=
re easy enough to ignore, but if support for intel is added, it would be ni=
ce to have these cleaned up.=C2=A0 For what it&#39;s worth, adding support =
for additional compilers in my experience has greatly improved the quality =
of library code - it tends to snuff out those bugs that are hard to find on=
 a single compiler.=C2=A0=C2=A0</div><div><br></div><div>If you decide to m=
erge this in, a release patch 2.0.3 would certainly be helpful as well!</di=
v><div><br></div><div><br></div><div>Example warnings below:</div><div>icc:=
 command line warning #10006: ignoring unknown option &#39;-Wnested-externs=
&#39;<br>icc: command line warning #10006: ignoring unknown option &#39;-Wt=
autological-constant-out-of-range-compare&#39;<br>icc: command line warning=
 #10006: ignoring unknown option &#39;-Wnested-externs&#39;<br>icc: command=
 line warning #10006: ignoring unknown option &#39;-Wno-format-nonliteral&#=
39;<br>icc: command line warning #10006: ignoring unknown option &#39;-Wno-=
format-nonliteral&#39;<br>icc: command line warning #10006: ignoring unknow=
n option &#39;-Wmissing-noreturn&#39;<br>icc: command line warning #10006: =
ignoring unknown option &#39;-Wmissing-noreturn&#39;<br>icc: command line w=
arning #10006: ignoring unknown option &#39;-Wduplicated-cond&#39;<br>icc: =
command line warning #10006: ignoring unknown option &#39;-Wduplicated-bran=
ches&#39;<br>icc: command line warning #10006: ignoring unknown option &#39=
;-Wduplicated-cond&#39;<br>icc: command line warning #10006: ignoring unkno=
wn option &#39;-Wduplicated-branches&#39;<br>icc: command line warning #100=
06: ignoring unknown option &#39;-Wlogical-op&#39;<br>icc: command line war=
ning #10006: ignoring unknown option &#39;-Wlogical-op&#39;<br>icc: command=
 line warning #10006: ignoring unknown option &#39;-Wno-cast-function-type&=
#39;<br>icc: command line warning #10006: ignoring unknown option &#39;-Wno=
-cast-function-type&#39;<br>icc: command line warning #10006: ignoring unkn=
own option &#39;-Wnull-dereference&#39;<br>icc: command line warning #10006=
: ignoring unknown option &#39;-Wredundant-decls&#39;<br>icc: command line =
warning #10006: ignoring unknown option &#39;-Wjump-misses-init&#39;<br>icc=
: command line warning #10006: ignoring unknown option &#39;-Wsuggest-attri=
bute=3Dformat&#39;<br>icc: command line warning #10006: ignoring unknown op=
tion &#39;-Wtautological-constant-out-of-range-compare&#39;<br>icc: command=
 line warning #10006: ignoring unknown option &#39;-Wnested-externs&#39;<br=
>icc: command line warning #10006: ignoring unknown option &#39;-Wno-format=
-nonliteral&#39;<br>icc: command line warning #10006: ignoring unknown opti=
on &#39;-Wmissing-noreturn&#39;<br>icc: command line warning #10006: ignori=
ng unknown option &#39;-Wduplicated-cond&#39;<br>icc: command line warning =
#10006: ignoring unknown option &#39;-Wduplicated-branches&#39;<br>icc: com=
mand line warning #10006: ignoring unknown option &#39;-Wlogical-op&#39;<br=
>icc: command line warning #10006: ignoring unknown option &#39;-Wno-cast-f=
unction-type&#39;<br>icc: command line warning #10006: ignoring unknown opt=
ion &#39;-Wnull-dereference&#39;<br>icc: command line warning #10006: ignor=
ing unknown option &#39;-Wredundant-decls&#39;<br>icc: command line warning=
 #10006: ignoring unknown option &#39;-Wjump-misses-init&#39;<br>icc: comma=
nd line warning #10006: ignoring unknown option &#39;-Wsuggest-attribute=3D=
format&#39;<br>icc: command line warning #10006: ignoring unknown option &#=
39;-Wtautological-constant-out-of-range-compare&#39;<br></div><div><br></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Mar 23, 2020 at 10:14 AM Simon Marchi &lt;<a href=3D"mailto:simar=
k@simark.ca">simark@simark.ca</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">On 2020-03-23 12:05 p.m., Rocky Dunlap wrote:<=
br>
&gt; Simon,<br>
&gt; <br>
&gt; Yes, I will be happy to give this a try.=C2=A0 What&#39;s the easiest =
way to get this patch?=C2=A0 (Sorry, I&#39;m less familiar with Gerrit...)<=
br>
&gt; <br>
&gt; Rocky<br>
<br>
You need a babeltrace git repository.=C2=A0 If you don&#39;t already have o=
ne, you can clone it from here:<br>
<br>
=C2=A0 <a href=3D"https://github.com/efficios/babeltrace" rel=3D"noreferrer=
" target=3D"_blank">https://github.com/efficios/babeltrace</a><br>
<br>
You can then click the &quot;DOWNLOAD&quot; button on the patch&#39;s revie=
w page, or press `d` (a keybinding).<br>
<br>
Copy the &quot;Checkout&quot; command (the first one) and paste it in your =
shell (while having the<br>
repository as the current working directory).=C2=A0 You&#39;ll then have th=
e code corresponding to<br>
the proposed patch checked out and ready to build.=C2=A0 Note that when you=
 build from the git<br>
repo, you need to run ./bootstrap first, to generate the configure script.<=
br>
<br>
Simon<br>
<br>
</blockquote></div>

--000000000000556b0105a18885a8--

--===============5136610679899477666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5136610679899477666==--
