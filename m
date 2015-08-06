From: jamie explorer <jamieexplorer@gmail.com>
Subject: Re: 32-bit application crash
Date: Thu, 6 Aug 2015 21:20:45 +0530
Message-ID: <CACh_V544Vsom7gnQab_MhcaeRu7jQpzPuCmWWROn-aeFsUFc=Q__1477.22443002767$1438876322$gmane$org@mail.gmail.com>
References: <CACh_V55XxDDx3rRyGr53XVgqav66SyyJU21YiezyXeUS_p6vKg@mail.gmail.com>
 <CACh_V56NjOL-asm-CJ7UZXW_7ArTXDqrH5TkVs=PPZhJK8C=jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0919610431=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jamieexplorer@gmail.com>) id 1ZNNRT-0005Co-Be
 for lttng-dev@lists.lttng.org; Thu, 06 Aug 2015 11:50:59 -0400
Received: by oip136 with SMTP id 136so39623103oip.1
 for <lttng-dev@lists.lttng.org>; Thu, 06 Aug 2015 08:50:45 -0700 (PDT)
In-Reply-To: <CACh_V56NjOL-asm-CJ7UZXW_7ArTXDqrH5TkVs=PPZhJK8C=jQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0919610431==
Content-Type: multipart/alternative; boundary=001a113dfc7681bb0f051ca67b14

--001a113dfc7681bb0f051ca67b14
Content-Type: text/plain; charset=UTF-8

Hi All,
Here is more info.
I'm using 2.6 lttng-ust
I'm seeing this crash on 32-bit app's only when compiling with g++
compiler. Dont see this issue when compiling with gcc.
is there any known issue or fix for this.

Thanks,
Anand Neeli



/Jam

On Wed, Aug 5, 2015 at 10:43 PM, jamie explorer <jamieexplorer@gmail.com>
wrote:

> Hi All,
> i looked into this further, generated .c file with expanded macros for
> debugging
> Some of the function pointer are not populated correctly.
> I have attached the expanded source files which i used.
> please see the following GDB analysis:
>
>
> (gdb) bt
> #0  0x00000000 in ?? ()
> #1  0x080490a0 in __event_probe__sample_tracepoint___message
> (__tp_data=0x80512d0,
>     text=0x804ca64 "Hello World\n") at sample_tracepoint.c:8567
>
> #2  0x0804ba23 in __tracepoint_cb_sample_tracepoint___message (
>     text=0x804ca64 "Hello World\n")
>     at /build/home/jam/gentp/src/sample.c:4026
> #3  main (argc=1, argv=0xffffdd74)
>     at /build/home/jam/gentp/src/sample.c:4731
>
> ****bc_runtime->filter* --- is not populated correctly, because of which
> it crashes
> *(gdb) frame 1*
> #1  0x080490a0 in __event_probe__sample_tracepoint___message
> (__tp_data=0x80512d0,
>     text=0x804ca64 "Hello World\n") at sample_tracepoint.c:8567
> 8567     if (__builtin_expect(!!(*bc_runtime->filter*(bc_runtime,
> __stackvar.__filter_stack_data) & LTTNG_FILTER_RECORD_FLAG), 0))
>
>
> *(gdb) list*
> 8562     (__stackvar.__filter_stack_data, __tp_data,text);
> 8563     for (bc_runtime = ((__typeof__(*bc_runtime) *) ((char *)
> ((reinterpret_cast<__typeof__((&__event->bytecode_runtime_head)->next)>(tracepoint_dlopen.rcu_dereference_sym_bp((reinterpret_cast<void
> *>((&__event->bytecode_runtime_head)->next)))))) - (unsigned long)
> (&((__typeof__(*bc_runtime) *) 0)->node)));
> 8564     &bc_runtime->node != (&__event->bytecode_runtime_head);
> 8565     bc_runtime = ((__typeof__(*bc_runtime) *) ((char *)
> ((reinterpret_cast<__typeof__(bc_runtime->node.next)>(tracepoint_dlopen.rcu_dereference_sym_bp((reinterpret_cast<void
> *>(bc_runtime->node.next)))))) - (unsigned long)
> (&((__typeof__(*bc_runtime) *) 0)->node))))
> 8566     {
> *8567     if (__builtin_expect(!!(bc_runtime->filter(bc_runtime,
> __stackvar.__filter_stack_data) & LTTNG_FILTER_RECORD_FLAG), 0))*
> 8568      __filter_record = 1;
> 8569     } if (__builtin_expect(!!(!__filter_record), 1)) return;
> 8570     } __event_len =
> 8571
>
>
> *printing bc_runtime shows filter is 0*
> *(gdb) p *bc_runtime *
> $3 = {bc = 0x0,* filter = 0x0,* link_failed = 0, node = {next =
> 0x8051304,
>     prev = 0x8051304}}
>
>
> *also i see __event->bytecode_runtime_head->prev = 0x1 which may be wrong*
> *(gdb) p *__event*
> $4 = {id = 2, chan = 0xf6c047c0, enabled = 1,
>   desc = 0x804c700 <__event_desc___sample_tracepoint_message>,
> _deprecated1 = 0x0,
>   ctx = 0x0, instrumentation = LTTNG_UST_TRACEPOINT, u = {<No data
> fields>}, node = {
>     next = 0x8051344, prev = 0x0}, _deprecated2 = {next = 0x0, prev =
> 0x0},
>   _deprecated3 = 0x0, _deprecated4 = 0,
> *bytecode_runtime_head = {next = 0x8051304,     prev = 0x1}*,
> has_enablers_without_bytecode = 134552592, enablers_ref_head = {
>     next = 0x8051c10, prev = 0x0}, hlist = {next = 0xf6c00ea0, prev =
> 0x1},
>   registered = 89}
>
>
> I guess this structure is populated in tracepoint_register using urcu.
> Can anyone give me more pointers to debug this. Is this a known issue and
> is there any patch which i can use
>
>
> /Jam
>
>
>
> On Mon, Aug 3, 2015 at 4:19 PM, jamie explorer <jamieexplorer@gmail.com>
> wrote:
>
>> Hi,
>> i am trying to run 32-bit application and see crash at the the line where
>> "tracepoint" is used.
>> i am using sample application given in
>> lttng-ust-2.6.0/doc/examples/gen-tp/
>> Not able to understand why the problem is seen only with 32-bit apps? Can
>> experts here pls help me fix this.
>>
>> Have tried using ELF 32-bit app on Intel 80386 and PowerPC and see the
>> crash. Where as 64-bit applications have no problem.
>>
>> following is the code where it crashes
>>         for (i = 0; i < 100000; i++) {
>>                 tracepoint(sample_tracepoint, message,  "Hello World\n");
>>  <<<< Crash here
>>                 usleep(1);
>>         }
>>
>> GDB output:
>>
>> #0  0x00000000 in ?? ()
>> #1  0x10001e54 in __event_probe__sample_tracepoint___message (
>>     __tp_data=0x10015420, text=0x100034a4 "Hello World\n")
>>     at /build/home/jam/gentp/sample_tracepoint.h:13
>> #2  0x10000b9c in __tracepoint_cb_sample_tracepoint___message (
>>     text=0x100034a4 "Hello World\n")
>>     at //build/home/jam/gentp/sample_tracepoint.h:13
>> #3  main (argc=<optimized out>, argv=<optimized out>)
>>     at /build/home/jam/gentp/sample.c:115
>>
>>
>> i am running 32-bit version of lttng-sessiond
>> root@host:~# ps aux | grep lttng
>> root      4224  0.0  0.0  92212  1648 ?        Ssl  00:42   0:00
>> /usr/bin/lttng-sessiond --consumerd32-path
>> /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ -b
>> --no-kernel
>> root      4243  0.0  0.0  64212   956 ?        Sl   00:42   0:00
>> lttng-consumerd  -u --consumerd-cmd-sock
>> /var/run/lttng/ustconsumerd32/command --consumerd-err-sock
>> /var/run/lttng/ustconsumerd32/error --group tracing
>>
>>
>>
>> /Jam
>>
>
>

--001a113dfc7681bb0f051ca67b14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>Here is more info.</div><div>I&#39;m using 2.6=
 lttng-ust</div><div>I&#39;m seeing this crash on 32-bit app&#39;s only whe=
n compiling with g++ compiler. Dont see this issue when compiling with gcc.=
</div><div>is there any known issue or fix for this.</div><div><br></div><d=
iv>Thanks,</div><div>Anand Neeli</div><div><div class=3D"gmail_extra"><br c=
lear=3D"all"><div><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div=
 dir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">/Jam</di=
v></div></div></div></div>
<br><div class=3D"gmail_quote">On Wed, Aug 5, 2015 at 10:43 PM, jamie explo=
rer <span dir=3D"ltr">&lt;<a href=3D"mailto:jamieexplorer@gmail.com" target=
=3D"_blank">jamieexplorer@gmail.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div dir=3D"ltr"><span class=3D"">Hi All,<div>i looked int=
o this further, generated .c file with expanded macros for debugging</div><=
div>Some of the function pointer are not populated correctly.</div><div>I h=
ave attached the expanded source files which i used.</div></span><div>pleas=
e see the following GDB analysis:</div><div><br></div><br>(gdb) bt<span cla=
ss=3D""><span><br>#0 =C2=A00x00000000 in ?? ()<br></span></span><div><div c=
lass=3D"h5">#1 =C2=A00x080490a0 in __event_probe__sample_tracepoint___messa=
ge (__tp_data=3D0x80512d0,=C2=A0<br>=C2=A0 =C2=A0 text=3D0x804ca64 &quot;He=
llo World\n&quot;) at sample_tracepoint.c:8567<br><br>#2 =C2=A00x0804ba23 i=
n __tracepoint_cb_sample_tracepoint___message (<br>=C2=A0 =C2=A0 text=3D0x8=
04ca64 &quot;Hello World\n&quot;)<br>=C2=A0 =C2=A0 at=C2=A0<span style=3D"f=
ont-size:12.8000001907349px">/build/home/jam/gentp</span>/src/sample.c:4026=
<br>#3 =C2=A0main (argc=3D1, argv=3D0xffffdd74)<br>=C2=A0 =C2=A0 at=C2=A0<s=
pan style=3D"font-size:12.8000001907349px">/build/home/jam/gentp/</span>src=
/sample.c:4731<br><br><b>***bc_runtime-&gt;filter</b>=C2=A0--- is not popul=
ated correctly, because of which it crashes<br><b>(gdb) frame 1</b><br>#1 =
=C2=A00x080490a0 in __event_probe__sample_tracepoint___message (__tp_data=
=3D0x80512d0,=C2=A0<br>=C2=A0 =C2=A0 text=3D0x804ca64 &quot;Hello World\n&q=
uot;) at sample_tracepoint.c:8567<br>8567 =C2=A0 =C2=A0 if (__builtin_expec=
t(!!(<b>bc_runtime-&gt;filter</b>(bc_runtime, __stackvar.__filter_stack_dat=
a) &amp; LTTNG_FILTER_RECORD_FLAG), 0))<br><br><br><b>(gdb) list</b><br>856=
2 =C2=A0 =C2=A0 (__stackvar.__filter_stack_data, __tp_data,text);<br>8563 =
=C2=A0 =C2=A0 for (bc_runtime =3D ((__typeof__(*bc_runtime) *) ((char *) ((=
reinterpret_cast&lt;__typeof__((&amp;__event-&gt;bytecode_runtime_head)-&gt=
;next)&gt;(tracepoint_dlopen.rcu_dereference_sym_bp((reinterpret_cast&lt;vo=
id *&gt;((&amp;__event-&gt;bytecode_runtime_head)-&gt;next)))))) - (unsigne=
d long) (&amp;((__typeof__(*bc_runtime) *) 0)-&gt;node)));<br>8564 =C2=A0 =
=C2=A0 &amp;bc_runtime-&gt;node !=3D (&amp;__event-&gt;bytecode_runtime_hea=
d);<br>8565 =C2=A0 =C2=A0 bc_runtime =3D ((__typeof__(*bc_runtime) *) ((cha=
r *) ((reinterpret_cast&lt;__typeof__(bc_runtime-&gt;node.next)&gt;(tracepo=
int_dlopen.rcu_dereference_sym_bp((reinterpret_cast&lt;void *&gt;(bc_runtim=
e-&gt;node.next)))))) - (unsigned long) (&amp;((__typeof__(*bc_runtime) *) =
0)-&gt;node))))<br>8566 =C2=A0 =C2=A0 {<br><b>8567 =C2=A0 =C2=A0 if (__buil=
tin_expect(!!(bc_runtime-&gt;filter(bc_runtime, __stackvar.__filter_stack_d=
ata) &amp; LTTNG_FILTER_RECORD_FLAG), 0))</b><br>8568 =C2=A0 =C2=A0 =C2=A0_=
_filter_record =3D 1;<br>8569 =C2=A0 =C2=A0 } if (__builtin_expect(!!(!__fi=
lter_record), 1)) return;<br>8570 =C2=A0 =C2=A0 } __event_len =3D<br>8571<b=
r><br><br><b>printing bc_runtime shows filter is 0</b><br><b>(gdb) p *bc_ru=
ntime=C2=A0</b><br>$3 =3D {bc =3D 0x0,<b>=C2=A0filter =3D 0x0,</b>=C2=A0lin=
k_failed =3D 0, node =3D {next =3D 0x8051304,=C2=A0<br>=C2=A0 =C2=A0 prev =
=3D 0x8051304}}<br><br><br><b>also i see __event-&gt;bytecode_runtime_head-=
&gt;prev =3D 0x1 which may be wrong</b><br><b>(gdb) p *__event</b><br>$4 =
=3D {id =3D 2, chan =3D 0xf6c047c0, enabled =3D 1,=C2=A0<br>=C2=A0 desc =3D=
 0x804c700 &lt;__event_desc___sample_tracepoint_message&gt;, _deprecated1 =
=3D 0x0,=C2=A0<br>=C2=A0 ctx =3D 0x0, instrumentation =3D LTTNG_UST_TRACEPO=
INT, u =3D {&lt;No data fields&gt;}, node =3D {<br>=C2=A0 =C2=A0 next =3D 0=
x8051344, prev =3D 0x0}, _deprecated2 =3D {next =3D 0x0, prev =3D 0x0},=C2=
=A0<br>=C2=A0 _deprecated3 =3D 0x0, _deprecated4 =3D 0,=C2=A0<b>bytecode_ru=
ntime_head =3D {next =3D 0x8051304,=C2=A0<br>=C2=A0 =C2=A0 prev =3D 0x1}</b=
>, has_enablers_without_bytecode =3D 134552592, enablers_ref_head =3D {<br>=
=C2=A0 =C2=A0 next =3D 0x8051c10, prev =3D 0x0}, hlist =3D {next =3D 0xf6c0=
0ea0, prev =3D 0x1},=C2=A0<br>=C2=A0 registered =3D 89}<div><br></div><div>=
<br></div><div>I guess this structure is populated in tracepoint_register u=
sing urcu.</div><div>Can anyone give me more pointers to debug this. Is thi=
s a known issue and is there any patch which i can use</div><div><br></div>=
<div><br></div><div class=3D"gmail_extra"><div dir=3D"ltr"><div style=3D"fo=
nt-size:12.8000001907349px"><div dir=3D"ltr">/Jam</div><div><br></div></div=
></div></div></div></div><div class=3D"gmail_extra"><div><div><div dir=3D"l=
tr"><div dir=3D"ltr"><br></div></div></div></div>
<br><div class=3D"gmail_quote"><div><div class=3D"h5">On Mon, Aug 3, 2015 a=
t 4:19 PM, jamie explorer <span dir=3D"ltr">&lt;<a href=3D"mailto:jamieexpl=
orer@gmail.com" target=3D"_blank">jamieexplorer@gmail.com</a>&gt;</span> wr=
ote:<br></div></div><div><div class=3D"h5"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"ltr">Hi,<div>i am trying to run 32-bit application and see crash=
 at the the line where &quot;tracepoint&quot; is used.</div><div>i am using=
 sample application given in lttng-ust-2.6.0/doc/examples/gen-tp/</div><div=
>Not able to understand why the problem is seen only with 32-bit apps? Can =
experts here pls help me fix this.</div><div><br></div><div>Have tried usin=
g=C2=A0ELF 32-bit app on Intel 80386 and PowerPC and see the crash. Where a=
s 64-bit applications have no problem.</div><div><br></div><div>following i=
s the code where it crashes</div><div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
(i =3D 0; i &lt; 100000; i++) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tracepoint(sample_tracepoint, message, =C2=A0&quot=
;Hello World\n&quot;); =C2=A0&lt;&lt;&lt;&lt; Crash here</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(1);=C2=A0</div><div=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div></div><div><br></div><div>GDB output:</=
div><div><br></div><div><div><div><div dir=3D"ltr">#0 =C2=A00x00000000 in ?=
? ()<br>#1 =C2=A00x10001e54 in __event_probe__sample_tracepoint___message (=
<br>=C2=A0 =C2=A0 __tp_data=3D0x10015420, text=3D0x100034a4 &quot;Hello Wor=
ld\n&quot;)<br>=C2=A0 =C2=A0 at /build/home/jam/gentp/sample_tracepoint.h:1=
3<br>#2 =C2=A00x10000b9c in __tracepoint_cb_sample_tracepoint___message (<b=
r>=C2=A0 =C2=A0 text=3D0x100034a4 &quot;Hello World\n&quot;)<br>=C2=A0 =C2=
=A0 at //build/home/jam/gentp/sample_tracepoint.h:13<br>#3 =C2=A0main (argc=
=3D&lt;optimized out&gt;, argv=3D&lt;optimized out&gt;)<br>=C2=A0 =C2=A0 at=
=C2=A0/build/home/jam/gentp/sample.c:115<br><div dir=3D"ltr"><br></div><div=
 dir=3D"ltr"><br></div><div>i am running 32-bit version of lttng-sessiond</=
div><div dir=3D"ltr"><div dir=3D"ltr">root@host:~# ps aux | grep lttng</div=
><div dir=3D"ltr">root =C2=A0 =C2=A0 =C2=A04224 =C2=A00.0 =C2=A00.0 =C2=A09=
2212 =C2=A01648 ? =C2=A0 =C2=A0 =C2=A0 =C2=A0Ssl =C2=A000:42 =C2=A0 0:00 /u=
sr/bin/lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consu=
merd --consumerd32-libdir /usr/lib/ -b --no-kernel</div><div dir=3D"ltr">ro=
ot =C2=A0 =C2=A0 =C2=A04243 =C2=A00.0 =C2=A00.0 =C2=A064212 =C2=A0 956 ? =
=C2=A0 =C2=A0 =C2=A0 =C2=A0Sl =C2=A0 00:42 =C2=A0 0:00 lttng-consumerd =C2=
=A0-u --consumerd-cmd-sock /var/run/lttng/ustconsumerd32/command --consumer=
d-err-sock /var/run/lttng/ustconsumerd32/error --group tracing</div><div><b=
r></div></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br></div><div di=
r=3D"ltr">/Jam</div></div></div></div>
</div></div>
</blockquote></div></div></div><br></div></div>
</blockquote></div><br></div></div></div>

--001a113dfc7681bb0f051ca67b14--


--===============0919610431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0919610431==--
