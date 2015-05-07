From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: lttng-relayd core
Date: Thu, 7 May 2015 17:38:01 +0530
Message-ID: <CAM5kDqwXNTxf5YaP-m7MhyLZVy=JcH4_g+xbwvwx3LZdbr2YNQ__45773.8289413557$1431000548$gmane$org@mail.gmail.com>
References: <CAM5kDqxgbBpA29j3J66BkMoFJidEhPiHeJ+Vdtp8-3PacrD5ww@mail.gmail.com>
 <1598887302.39240.1430234504111.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0400688010=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YqKb1-0006la-6r
 for lttng-dev@lists.lttng.org; Thu, 07 May 2015 08:08:11 -0400
Received: by widdi4 with SMTP id di4so239477594wid.0
 for <lttng-dev@lists.lttng.org>; Thu, 07 May 2015 05:08:01 -0700 (PDT)
In-Reply-To: <1598887302.39240.1430234504111.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============0400688010==
Content-Type: multipart/alternative; boundary=f46d04428cdc60992905157cc3e3

--f46d04428cdc60992905157cc3e3
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

Sorry for replying late on this thread.
I have informed about the funding request to levels above me. But looks
like it may take more time to get decision.
So far i have been working to qualify usage of lttng on our platform and
ran into multiple crashes and usage issues.
I really appreciate the support efficios have given me so far.
Will let you know if there is any progress in funding part.

Thanks,
Anand Neeli

On Tue, Apr 28, 2015 at 8:51 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Hi Anand,
>
> This bug report lacks a lot of information we need to reproduce the
> issue. We'll soon come up with a "bug report guideline" on the lttng.org
> website.
>
> Also, we can't help but noticing that the amount of support you have been
> requiring those past months seems better suited to the commercial LTTng
> support offered by EfficiOS. In addition to give you the amount of support
> you need, this is one of the main mechanisms for funding LTTng project
> maintenance work.
>
> Best Regards,
>
> Mathieu
>
>
> ------------------------------
>
> Hi All,
>
> Found this crash in 2.6.0
> Is there any open issue or workaround. Please help me with more info on
> this crash.
>
>
> (gdb) bt
> #0  0x00007fc62fe5bff9 in __GI_raise (sig=sig@entry=6)
>     at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #1  0x00007fc62fe5f068 in __GI_abort () at abort.c:89
> #2  0x00007fc62fe55146 in __assert_fail_base (
>     fmt=0x7fc62ff8d230 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n",
>     assertion=assertion@entry=0x425ba2 "!obj->refcount",
>     file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
>     function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
> "ctf_trace_destroy") at assert.c:92
> #3  0x00007fc62fe551f2 in __GI___assert_fail (
>     assertion=assertion@entry=0x425ba2 "!obj->refcount",
>     file=file@entry=0x425b92 "ctf-trace.c", line=line@entry=55,
>     function=function@entry=0x425d80 <__PRETTY_FUNCTION__.5729>
> "ctf_trace_destroy") at assert.c:101
> #4  0x00000000004110e0 in ctf_trace_destroy (obj=0x7fc61001e320)
>     at ctf-trace.c:55
> #5  0x00000000004131f7 in session_destroy (
>     session=session@entry=0x7fc61001a3c0) at session.c:177
> #6  0x0000000000413311 in session_try_destroy (ht=ht@entry=0x6330e0,
>     session=session@entry=0x7fc61001a3c0) at session.c:149
> #7  0x00000000004078a7 in destroy_session (session=0x7fc61001a3c0,
>     sessions_ht=0x6330e0) at main.c:1058
> #8  0x0000000000407a7d in destroy_connection (
> ---Type <return> to continue, or q <return> to quit---
>     relay_connections_ht=<optimized out>, conn=0x7fc624000d00) at
> main.c:2418
> #9  0x000000000040aa11 in relay_thread_worker (data=<optimized out>)
>     at main.c:2568
> #10 0x00007fc6301d8fe3 in start_thread (arg=0x7fc62e2f1700)
>     at pthread_create.c:312
> #11 0x00007fc62ff0eafd in clone ()
>     at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
> (gdb)
> (gdb)
>
>
> Thanks,
> Anand Neeli
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--f46d04428cdc60992905157cc3e3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mathieu,<div><br></div><div>Sorry for replying late on =
this thread.</div><div>I have informed about the funding request to levels =
above me. But looks like it may take more time to get decision.</div><div>S=
o far i have been working to qualify usage of lttng on our platform and ran=
 into multiple crashes and usage issues.</div><div>I really appreciate the =
support efficios have given me so far.</div><div>Will let you know if there=
 is any progress in funding part.</div><div><br></div><div>Thanks,</div><di=
v>Anand Neeli</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Tue, Apr 28, 2015 at 8:51 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;=
<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu=
.desnoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><div><div style=3D"font-family:times new roman,new york,times,serif;fo=
nt-size:12pt;color:#000000"><div>Hi Anand,<br></div><div><br></div><div>Thi=
s bug report lacks a lot of information we need to reproduce the<br></div><=
div>issue. We&#39;ll soon come up with a &quot;bug report guideline&quot; o=
n the <a href=3D"http://lttng.org" target=3D"_blank">lttng.org</a><br></div=
><div>website.<br></div><div><br></div><div>Also, we can&#39;t help but not=
icing that the amount of support you have been</div><div>requiring those pa=
st months seems better suited to the commercial LTTng</div><div>support off=
ered by EfficiOS. In addition to give you the amount of support</div><div>y=
ou need, this is one of the main mechanisms for funding LTTng project</div>=
<div>maintenance work.</div><div><br></div><div>Best Regards,<br></div><div=
><br></div><div>Mathieu<br></div><div><br></div><div><br></div><hr><blockqu=
ote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt"><div><div class=3D"h5"><d=
iv dir=3D"ltr">Hi All,<div><br></div><div>Found this crash in 2.6.0</div><d=
iv>Is there any open issue or workaround. Please help me with more info on =
this crash.</div><div><br></div><div><br></div><div>







<p></p></div><div><div>(gdb) bt</div><div>#0 =C2=A00x00007fc62fe5bff9 in __=
GI_raise (sig=3Dsig@entry=3D6)</div><div>=C2=A0 =C2=A0 at ../nptl/sysdeps/u=
nix/sysv/linux/raise.c:56</div><div>#1 =C2=A00x00007fc62fe5f068 in __GI_abo=
rt () at abort.c:89</div><div>#2 =C2=A00x00007fc62fe55146 in __assert_fail_=
base (</div><div>=C2=A0 =C2=A0 fmt=3D0x7fc62ff8d230 &quot;%s%s%s:%u: %s%sAs=
sertion `%s&#39; failed.\n%n&quot;,=C2=A0</div><div>=C2=A0 =C2=A0 assertion=
=3Dassertion@entry=3D0x425ba2 &quot;!obj-&gt;refcount&quot;,=C2=A0</div><di=
v>=C2=A0 =C2=A0 file=3Dfile@entry=3D0x425b92 &quot;ctf-trace.c&quot;, line=
=3Dline@entry=3D55,=C2=A0</div><div>=C2=A0 =C2=A0 function=3Dfunction@entry=
=3D0x425d80 &lt;__PRETTY_FUNCTION__.5729&gt; &quot;ctf_trace_destroy&quot;)=
 at assert.c:92</div><div>#3 =C2=A00x00007fc62fe551f2 in __GI___assert_fail=
 (</div><div>=C2=A0 =C2=A0 assertion=3Dassertion@entry=3D0x425ba2 &quot;!ob=
j-&gt;refcount&quot;,=C2=A0</div><div>=C2=A0 =C2=A0 file=3Dfile@entry=3D0x4=
25b92 &quot;ctf-trace.c&quot;, line=3Dline@entry=3D55,=C2=A0</div><div>=C2=
=A0 =C2=A0 function=3Dfunction@entry=3D0x425d80 &lt;__PRETTY_FUNCTION__.572=
9&gt; &quot;ctf_trace_destroy&quot;) at assert.c:101</div><div>#4 =C2=A00x0=
0000000004110e0 in ctf_trace_destroy (obj=3D0x7fc61001e320)</div><div>=C2=
=A0 =C2=A0 at ctf-trace.c:55</div><div>#5 =C2=A00x00000000004131f7 in sessi=
on_destroy (</div><div>=C2=A0 =C2=A0 session=3Dsession@entry=3D0x7fc61001a3=
c0) at session.c:177</div><div>#6 =C2=A00x0000000000413311 in session_try_d=
estroy (ht=3Dht@entry=3D0x6330e0,=C2=A0</div><div>=C2=A0 =C2=A0 session=3Ds=
ession@entry=3D0x7fc61001a3c0) at session.c:149</div><div>#7 =C2=A00x000000=
00004078a7 in destroy_session (session=3D0x7fc61001a3c0,=C2=A0</div><div>=
=C2=A0 =C2=A0 sessions_ht=3D0x6330e0) at main.c:1058</div><div>#8 =C2=A00x0=
000000000407a7d in destroy_connection (</div><div>---Type &lt;return&gt; to=
 continue, or q &lt;return&gt; to quit---</div><div>=C2=A0 =C2=A0 relay_con=
nections_ht=3D&lt;optimized out&gt;, conn=3D0x7fc624000d00) at main.c:2418<=
/div><div>#9 =C2=A00x000000000040aa11 in relay_thread_worker (data=3D&lt;op=
timized out&gt;)</div><div>=C2=A0 =C2=A0 at main.c:2568</div><div>#10 0x000=
07fc6301d8fe3 in start_thread (arg=3D0x7fc62e2f1700)</div><div>=C2=A0 =C2=
=A0 at pthread_create.c:312</div><div>#11 0x00007fc62ff0eafd in clone ()</d=
iv><div>=C2=A0 =C2=A0 at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111</div=
><div>(gdb)=C2=A0</div><div>(gdb)=C2=A0</div></div><div><br></div><div><br>=
</div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></div>
<br></div></div>_______________________________________________<br>lttng-de=
v mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cg=
i-bin/mailman/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><span class=3D"HOEnZb"><font color=3D=
"#888888"><br></font></span></blockquote><span class=3D"HOEnZb"><font color=
=3D"#888888"><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://=
www.efficios.com" target=3D"_blank">http://www.efficios.com</a><span name=
=3D"x"></span><br></div></font></span></div></div></blockquote></div><br></=
div></div>

--f46d04428cdc60992905157cc3e3--


--===============0400688010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0400688010==--
