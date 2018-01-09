From: Majid Rezazadeh <majid3612@gmail.com>
Subject: Re: LD_PRELOAD applications using lttng-ust-pthread
Date: Tue, 9 Jan 2018 17:22:47 -0500
Message-ID: <CACbQsw_PXGsc3LcC=g_TJ9vx4=LKoqd_DCw=fx-OPHUDdhdQ=w__33938.1673177288$1515536463$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0300697244717575844=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pg0-x236.google.com (mail-pg0-x236.google.com
 [IPv6:2607:f8b0:400e:c05::236])
 by lists.lttng.org (Postfix) with ESMTPS id 3zGRV10gXgzpLj
 for <lttng-dev@lists.lttng.org>; Tue,  9 Jan 2018 22:22:48 +0000 (UTC)
Received: by mail-pg0-x236.google.com with SMTP id j4so8971321pgp.1
 for <lttng-dev@lists.lttng.org>; Tue, 09 Jan 2018 14:22:48 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0300697244717575844==
Content-Type: multipart/alternative; boundary="94eb2c140702c722a505625f5a73"

--94eb2c140702c722a505625f5a73
Content-Type: text/plain; charset="UTF-8"

Thanks for your response

I reran my test in gdb and got the following information:

(gdb) run
Starting program: /usr/bin/env LD_PRELOAD=test.so firefox
process 5288 is executing new program: /bin/dash
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7de73a8 in ?? () from /lib64/ld-linux-x86-64.so.2

Does it provide enough information?

Thanks

On Tue, Jan 9, 2018 at 10:43 AM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:
> > Hi all
> >
> > I am using lttng-ust-libc-wrapper for instrumenting some calls to libc
> for
> > some applications like Firefox and Chrome, but I receive "Segmentation
> > fault (core dumped)". I compile lttng-ust-pthread.c (gcc -fPIC -shared
> -o
> > test.so lttng-ust-pthread.c -ldl) and then I use "LD_PRELOAD=test.so
> > firefox" but I receive segmentation fault (I have exported
> LD_LIBRARY_PATH
> > to the absolute path of test.so file). I found out that when I replace
>
> Could you give us more information regarding the coredump?
>
> "thread apply all bt" in gdb with the corefile loaded.
>
> Make sure to compile with debug symbol and rerun your test.
>
> > tracepoints with printf in lttng_ust_pthread.c, I receive no error. It
> > seems that hooking tracepoints in this wrapper makes some problems. Do
> you
> > have any idea in this regard?
> >
> > Thanks
> >
> > Majid
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--94eb2c140702c722a505625f5a73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Thanks for your response<=
/span><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.=
8px">I reran my test in gdb and got the following information:</div><div st=
yle=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px"><div>(gd=
b) run</div><div>Starting program: /usr/bin/env LD_PRELOAD=3Dtest.so firefo=
x</div><div>process 5288 is executing new program: /bin/dash</div><div>[Thr=
ead debugging using libthread_db enabled]</div><div>Using host libthread_db=
 library &quot;/lib/x86_64-linux-gnu/<wbr>libthread_db.so.1&quot;.</div><di=
v><br></div><div>Program received signal SIGSEGV, Segmentation fault.</div>=
<div>0x00007ffff7de73a8 in ?? () from /lib64/ld-linux-x86-64.so.2</div></di=
v><div style=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px"=
>Does it provide enough information?</div><div style=3D"font-size:12.8px"><=
br></div><div style=3D"font-size:12.8px">Thanks</div><div class=3D"gmail-yj=
6qo gmail-ajU" style=3D"font-size:12.8px"></div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Tue, Jan 9, 2018 at 10:43 AM, Jonathan Ra=
jotte-Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julie=
n@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Jan 08, 2018 at 10:35:39PM -0500, Majid Rezazadeh wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I am using lttng-ust-libc-wrapper for instrumenting some calls to libc=
 for<br>
&gt; some applications like Firefox and Chrome, but I receive &quot;Segment=
ation<br>
&gt; fault (core dumped)&quot;. I compile lttng-ust-pthread.c (gcc -fPIC -s=
hared=C2=A0 -o<br>
&gt; test.so lttng-ust-pthread.c -ldl) and then I use &quot;LD_PRELOAD=3Dte=
st.so<br>
&gt; firefox&quot; but I receive segmentation fault (I have exported LD_LIB=
RARY_PATH<br>
&gt; to the absolute path of test.so file). I found out that when I replace=
<br>
<br>
</span>Could you give us more information regarding the coredump?<br>
<br>
&quot;thread apply all bt&quot; in gdb with the corefile loaded.<br>
<br>
Make sure to compile with debug symbol and rerun your test.<br>
<span class=3D""><br>
&gt; tracepoints with printf in lttng_ust_pthread.c, I receive no error. It=
<br>
&gt; seems that hooking tracepoints in this wrapper makes some problems. Do=
 you<br>
&gt; have any idea in this regard?<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; Majid<br>
<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div></div>

--94eb2c140702c722a505625f5a73--

--===============0300697244717575844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0300697244717575844==--
