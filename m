From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Userspace Tracing and Backtraces
Date: Mon, 9 Mar 2015 15:38:47 -0400
Message-ID: <CAC6yHM4AXG5btHdaoHjuCwzCDvPn9AORyh8gvo-VOua7ndWF2w__25584.572289563$1425929994$gmane$org@mail.gmail.com>
References: <BY2SR01MB595A5A400E2211CC7567298C81F0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
 <CAC6yHM6VLGQgjF4tS1dLg749rEZ8DKMMda=DsrihLCoQ9sHPdw@mail.gmail.com>
 <BY2SR01MB5952376CA9DE7B8211078C8C81C0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1278395722=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.giraldeau@gmail.com>) id 1YV3Vs-0008O8-Rw
 for lttng-dev@lists.lttng.org; Mon, 09 Mar 2015 15:38:53 -0400
Received: by qcvp6 with SMTP id p6so7942898qcv.5
 for <lttng-dev@lists.lttng.org>; Mon, 09 Mar 2015 12:38:47 -0700 (PDT)
In-Reply-To: <BY2SR01MB5952376CA9DE7B8211078C8C81C0@BY2SR01MB595.namsdf01.sdf.exchangelabs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1278395722==
Content-Type: multipart/alternative; boundary=001a1133b62ccde2df0510e02ef2

--001a1133b62ccde2df0510e02ef2
Content-Type: text/plain; charset=UTF-8

2015-03-06 13:51 GMT-05:00 Brian Robbins <brianrob@microsoft.com>:

>  Thanks Francis.
>
>
>
> Is it accurate to say then that the array of addresses would need to be
> captured by app code by writing a stack walker by hand
>

Yes, the callstack can be recorded in userspace. You would need a
tracepoint with a varying length field:

TRACEPOINT_EVENT(myprovider, callstack,
TP_ARGS(unsigned long *, buf, size_t, depth),
TP_FIELDS(
ctf_sequence(unsigned long, addr, buf, size_t, depth)
)
)

In the app code, use libunwind [1] to get the addresses, then call the
tracepoint:

  do_unwind() // use libunwind here
  tracepoint(myprovider, buf, depth);

However, the unwind will be done whether or not the tracepoint is active
(~10us-100us in steady state, so it's may become expansive if called
often). I know there was discussion about tp_code() for such use case (some
code to call before the tracepoint only if it is enabled). Or you can
cheat:

if (__builtin_expect(!!(__tracepoint_myprovider___callstack.state), 0)) {
    do_unwind(...)
    tracepoint(myprovider, buf, depth);
}

That said, instead of having a callstack tracepoint, IMHO the best solution
would be instead extending lttng-ust to add callstack event context (itself
linked to libunwind). Then, recording the callstack would be simple like
that:

  $ lttng add-context -u -t callstack



> or using the perf capture mechanism that you describe below?
>


Perf is peeking at the userspace from kernel space, it's another story. I
guess that libunwind was not ported to the kernel because it is a large
chunk of complicated code that performs a lot of I/O and computation, while
copying a portion of the stack is really about KISS and low runtime
overhead.

Cheers,

Francis

--001a1133b62ccde2df0510e02ef2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2015=
-03-06 13:51 GMT-05:00 Brian Robbins <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:brianrob@microsoft.com" target=3D"_blank">brianrob@microsoft.com</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-st=
yle:solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">Thanks Francis.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt;font-family:Calibri,sa=
ns-serif;color:rgb(31,73,125)">Is it accurate to say then that the array of=
 addresses would need to be captured by app code by writing a stack walker =
by hand</span></p></div></div></blockquote><div><br></div><div>Yes, the cal=
lstack can be recorded in userspace. You would need a tracepoint with a var=
ying length field:</div><div><br></div><div>TRACEPOINT_EVENT(myprovider, ca=
llstack,<br></div><div><div><span class=3D"" style=3D"white-space:pre">	</s=
pan>TP_ARGS(unsigned long *, buf, size_t, depth),</div><div><span class=3D"=
" style=3D"white-space:pre">	</span>TP_FIELDS(</div><div><span class=3D"" s=
tyle=3D"white-space:pre">		</span>ctf_sequence(unsigned long, addr, buf, si=
ze_t, depth)</div><div><span class=3D"" style=3D"white-space:pre">	</span>)=
</div><div>)</div></div><div><br></div><div>In the app code, use libunwind =
[1] to get the addresses, then call the tracepoint:=C2=A0</div><div><br></d=
iv><div>=C2=A0 do_unwind() // use libunwind here</div><div>=C2=A0 tracepoin=
t(myprovider, buf, depth);</div><div><br></div><div>However, the unwind wil=
l be done whether or not the tracepoint is active (~10us-100us in steady st=
ate, so it&#39;s may become expansive if called often). I know there was di=
scussion about tp_code() for such use case (some code to call before the tr=
acepoint only if it is enabled). Or you can cheat:=C2=A0</div><div><br></di=
v><div>if (__builtin_expect(!!(__tracepoint_myprovider___callstack.state), =
0)) {<br></div><div>=C2=A0 =C2=A0 do_unwind(...)</div><div>=C2=A0 =C2=A0 tr=
acepoint(myprovider, buf, depth);<br></div><div>}</div><div><br></div><div>=
That said, instead of having a callstack tracepoint, IMHO the best solution=
 would be instead extending lttng-ust to add callstack event context (itsel=
f linked to libunwind). Then, recording the callstack would be simple like =
that:</div><div><br></div><div>=C2=A0 $ lttng add-context -u -t callstack<b=
r></div><div><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-colo=
r:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div lang=3D"E=
N-US" link=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNormal"><span styl=
e=3D"font-size:11pt;font-family:Calibri,sans-serif;color:rgb(31,73,125)">or=
 using the perf capture mechanism
 that you describe below?</span></p></div></div></blockquote><div><br></div=
><div><br></div><div>Perf is peeking at the userspace from kernel space, it=
&#39;s another story. I guess that libunwind was not ported to the kernel b=
ecause it is a large chunk of complicated code that performs a lot of I/O a=
nd computation, while copying a portion of the stack is really about KISS a=
nd low runtime overhead.</div><div><br></div><div>Cheers,</div><div><br></d=
iv><div>Francis</div></div></div></div>

--001a1133b62ccde2df0510e02ef2--


--===============1278395722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1278395722==--
