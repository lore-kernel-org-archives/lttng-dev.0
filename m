From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Userspace Tracing and Backtraces
Date: Fri, 6 Mar 2015 10:12:49 -0500
Message-ID: <CAC6yHM6VLGQgjF4tS1dLg749rEZ8DKMMda=DsrihLCoQ9sHPdw__15635.0110228688$1425654854$gmane$org@mail.gmail.com>
References: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1402094348=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YTtvq-0002eR-W8
 for lttng-dev@lists.lttng.org; Fri, 06 Mar 2015 10:12:57 -0500
Received: by qgfi50 with SMTP id i50so13176195qgf.9
 for <lttng-dev@lists.lttng.org>; Fri, 06 Mar 2015 07:12:49 -0800 (PST)
In-Reply-To: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1402094348==
Content-Type: multipart/alternative; boundary=001a1135bbca1cf7ae0510a01ed5

--001a1135bbca1cf7ae0510a01ed5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015-03-05 17:39 GMT-05:00 Brian Robbins <brianrob@microsoft.com>:

>  Hello,
>
>
>
> I=E2=80=99m looking into using the userspace tracing capabilities of LTTn=
g, and I
> wanted to find out if it is possible to capture a stack backtrace when a
> userspace tracepoint is hit.
>


The simple way is to use a tracepoint, where there is an array of
addresses. Symbols resolution can be done offline using the baddr events
indicating the address of shared libraries, and using libdwarf to parse
ELF.

To get the actual backtrace, you can use either frame pointers, but most
linux distributions compiles with -fomit-frame-pointers, and then this
method does not work (even of your own program is compiled with
-fno-omit-frame-pointer, a shared library, like libc, without frame pointer
in the middle of the stack does break the frame chain). Then, stack unwind
(using libunwind for instance) is necessary.

It could be nice to add such feature an event context to lttng-ust, it
would allow to record the ELF callstack for any userspace event. The
question is whether doing the unwind online (but it is quite costly in
time), or do it offline, like perf is doing, by recording 2 pages of the
stack with registers (but records much more data, and may not work if there
are large variables on the stack, and requires additional support for JIT
code).

Cheers,

Francis

--001a1135bbca1cf7ae0510a01ed5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2015=
-03-05 17:39 GMT-05:00 Brian Robbins <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:brianrob@microsoft.com" target=3D"_blank">brianrob@microsoft.com</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-st=
yle:solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div>
<p class=3D"MsoNormal">Hello,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">I=E2=80=99m looking into using the userspace tracing=
 capabilities of LTTng, and I wanted to find out if it is possible to captu=
re a stack backtrace when a userspace tracepoint is hit.</p></div></div></b=
lockquote><div><br></div><div><br></div><div>The simple way is to use a tra=
cepoint, where there is an array of addresses. Symbols resolution can be do=
ne offline using the baddr events indicating the address of shared librarie=
s, and using libdwarf to parse ELF.=C2=A0</div><div><br></div><div>To get t=
he actual backtrace, you can use either frame pointers, but most linux dist=
ributions compiles with -fomit-frame-pointers, and then this method does no=
t work (even of your own program is compiled with -fno-omit-frame-pointer, =
a shared library, like libc, without frame pointer in the middle of the sta=
ck does break the frame chain). Then, stack unwind (using libunwind for ins=
tance) is necessary.=C2=A0</div><div><br></div><div>It could be nice to add=
 such feature an event context to lttng-ust, it would allow to record the E=
LF callstack for any userspace event. The question is whether doing the unw=
ind online (but it is quite costly in time), or do it offline, like perf is=
 doing, by recording 2 pages of the stack with registers (but records much =
more data, and may not work if there are large variables on the stack, and =
requires additional support for JIT code).=C2=A0</div><div><br></div><div>C=
heers,<br></div><div><br></div><div>Francis</div></div></div></div>

--001a1135bbca1cf7ae0510a01ed5--


--===============1402094348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1402094348==--
