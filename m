From: Antoine Busque <abusque@efficios.com>
Subject: Re: lttng-modules no longer build against linux 3.14.x
 longterm kernels
Date: Sat, 21 Mar 2015 15:53:37 -0400
Message-ID: <CA+MZcXuHtkrVm92hEb5JzeMJcvH9_5sB7K2=2qzV2iWV330P-w__45223.0406263427$1426967687$gmane$org@mail.gmail.com>
References: <CAEYzJUHGBQxmtgYVWyzh10xT4wYQa4KWV52CK3Gd1uQDW0jd8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0427521516=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1YZPSr-0003b0-ER
 for lttng-dev@lists.lttng.org; Sat, 21 Mar 2015 15:53:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 42E20340159
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:53:50 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 7yxfdwttA06O for <lttng-dev@lists.lttng.org>;
 Sat, 21 Mar 2015 19:53:49 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 650ED3401DC
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:53:49 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id y1lRItTUT8cr for <lttng-dev@lists.lttng.org>;
 Sat, 21 Mar 2015 19:53:49 +0000 (UTC)
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
 [209.85.223.181])
 by mail.efficios.com (Postfix) with ESMTPSA id C8D083401D1
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 19:53:48 +0000 (UTC)
Received: by ieclw3 with SMTP id lw3so11713710iec.2
 for <lttng-dev@lists.lttng.org>; Sat, 21 Mar 2015 12:53:37 -0700 (PDT)
In-Reply-To: <CAEYzJUHGBQxmtgYVWyzh10xT4wYQa4KWV52CK3Gd1uQDW0jd8A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0427521516==
Content-Type: multipart/alternative; boundary=089e0122edb8eff9020511d1c900

--089e0122edb8eff9020511d1c900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for reporting. A commit that changed the instrumentation of
mm_page_alloc_extfrag in 3.19.2 was backported to 3.14.36. I submitted
a patch fixing this to the list, which should resolve your issue once
merged.

Regards,

Antoine Busque.

On Sat, Mar 21, 2015 at 8:43 AM, Bj=C3=B8rn Forsman <bjorn.forsman@gmail.co=
m>
wrote:

> Hi list,
>
> (I'm not subscribed, please CC me.)
>
> The breakage started with linux 3.14.36. Here is the build error, with
> lttng-modules from master branch (stable-2.6 branch is also affected):
>
> ...
>   LD [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/lib/lttng-lib-ring-buffer.o
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/Makefile:214:
> CONFIG_KALLSYMS_ALL is disabled,
> therefore probe "writeback" is disabled. Rebuild your kernel with this
> configuration option enabled in order to trace this subsystem.
>  CC [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-types.o
>  CC [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-sched.o
>  CC [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-irq.o
>  CC [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-timer.o
>  CC [M]
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-kmem.o
> In file included from
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events
> /lttng-module/../../../probes/define_trace.h:136:0,
>                 from
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events
> /lttng-module/kmem.h:465,
>                 from
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-kmem.c:42:
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events/lttng-module/../../..
> /probes/lttng-events.h:180:6: error: conflicting types for
> 'trace_mm_page_alloc_extfrag'
> void trace_##_name(_proto);
>      ^
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events/lttng-module/../../..
> /probes/lttng-events.h:47:2: note: in expansion of macro
> 'LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP'
>  LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto),
> PARAMS(args))
>  ^
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events/lttng-module/../../..
> /probes/lttng-events.h:107:2: note: in expansion of macro
> 'LTTNG_TRACEPOINT_EVENT_MAP'
>  LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
>  ^
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/../instrumentation/events/lttng-module/../../..
> /probes/../instrumentation/events/lttng-module/kmem.h:334:1: note: in
> expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> LTTNG_TRACEPOINT_EVENT(mm_page_alloc_extfrag,
> ^
> In file included from
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/include/linux/module.h
> :18:0,
>                 from
>
> /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-mo=
dules/probes/lttng-probe-kmem.c:24:
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/include/linux/tracepoint.h:168:21:
> note: pre
> vious definition of 'trace_mm_page_alloc_extfrag' was here
>  static inline void trace_##name(proto)    \
>                     ^
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/include/linux/tracepoint.h:265:3:
> note: in e
> xpansion of macro '__DECLARE_TRACE'
>   __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \
>   ^
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/include/linux/tracepoint.h:399:2:
> note: in e
> xpansion of macro 'DECLARE_TRACE'
>  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>  ^
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/include/trace/events/kmem.h:267:1:
> note: in
> expansion of macro 'TRACE_EVENT'
> TRACE_EVENT(mm_page_alloc_extfrag,
> ^
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/scripts/Makefile.build:314:
> recipe for targe
> t
> '/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-m=
odules/probes/lttng-probe-kmem.o'
> failed
> make[5]: ***
> [/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-m=
odules/probes/lttng-probe-kmem.o]
> Error 1
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/scripts/Makefile.build:455:
> recipe for targe
> t
> '/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-m=
odules/probes'
> failed
> make[4]: ***
> [/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-m=
odules/probes]
> Error 2
>
> /nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules=
/3.14.36/source/Makefile:1276:
> recipe for target '_module_/t
>
> mp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les'
> failed
> make[3]: ***
> [_module_/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0=
/lttng-modules]
> Error 2
> Makefile:133: recipe for target 'sub-make' failed
> make[2]: *** [sub-make] Error 2
> Makefile:26: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
>
> '/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/module=
s/3.14.36/build'
> Makefile:70: recipe for target 'default' failed
> make: *** [default] Error 2
>
> Best regards,
> Bj=C3=B8rn Forsman
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--089e0122edb8eff9020511d1c900
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks for reporting. A =
commit that changed the instrumentation of</div><div>mm_page_alloc_extfrag =
in 3.19.2 was backported to 3.14.36. I submitted</div><div>a patch fixing t=
his to the list, which should resolve your issue once</div><div>merged.</di=
v><div><br></div><div>Regards,</div><div><br></div><div>Antoine Busque.</di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Mar 21,=
 2015 at 8:43 AM, Bj=C3=B8rn Forsman <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:bjorn.forsman@gmail.com" target=3D"_blank">bjorn.forsman@gmail.com</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">Hi list,<br>
<br>
(I&#39;m not subscribed, please CC me.)<br>
<br>
The breakage started with linux 3.14.36. Here is the build error, with<br>
lttng-modules from master branch (stable-2.6 branch is also affected):<br>
<br>
...<br>
=C2=A0 LD [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14=
.36.drv-0/lttng-modules/lib/lttng-lib-ring-buffer.o<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/Makefile:214:<br>
CONFIG_KALLSYMS_ALL is disabled,<br>
therefore probe &quot;writeback&quot; is disabled. Rebuild your kernel with=
 this<br>
configuration option enabled in order to trace this subsystem.<br>
=C2=A0CC [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.=
36.drv-0/lttng-modules/probes/lttng-types.o<br>
=C2=A0CC [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.=
36.drv-0/lttng-modules/probes/lttng-probe-sched.o<br>
=C2=A0CC [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.=
36.drv-0/lttng-modules/probes/lttng-probe-irq.o<br>
=C2=A0CC [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.=
36.drv-0/lttng-modules/probes/lttng-probe-timer.o<br>
=C2=A0CC [M]=C2=A0 /tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.=
36.drv-0/lttng-modules/probes/lttng-probe-kmem.o<br>
In file included from<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events<br>
/lttng-module/../../../probes/define_trace.h:136:0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events<br>
/lttng-module/kmem.h:465,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/lttng-probe-kmem.c:42:<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events/lttng-module/../../..<br>
/probes/lttng-events.h:180:6: error: conflicting types for<br>
&#39;trace_mm_page_alloc_extfrag&#39;<br>
void trace_##_name(_proto);<br>
=C2=A0 =C2=A0 =C2=A0^<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events/lttng-module/../../..<br>
/probes/lttng-events.h:47:2: note: in expansion of macro<br>
&#39;LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP&#39;<br>
=C2=A0LTTNG_TRACEPOINT_EVENT_INSTANCE_MAP(map, name, map, PARAMS(proto),<br=
>
PARAMS(args))<br>
=C2=A0^<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events/lttng-module/../../..<br>
/probes/lttng-events.h:107:2: note: in expansion of macro<br>
&#39;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>
=C2=A0LTTNG_TRACEPOINT_EVENT_MAP(name, name,=C2=A0 =C2=A0 \<br>
=C2=A0^<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/../instrumentation/events/lttng-module/../../..<br>
/probes/../instrumentation/events/lttng-module/kmem.h:334:1: note: in<br>
expansion of macro &#39;LTTNG_TRACEPOINT_EVENT&#39;<br>
LTTNG_TRACEPOINT_EVENT(mm_page_alloc_extfrag,<br>
^<br>
In file included from<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/include/linux/module.h<br>
:18:0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from<br>
/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-modu=
les/probes/lttng-probe-kmem.c:24:<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/include/linux/tracepoint.h:168:21:<br>
note: pre<br>
vious definition of &#39;trace_mm_page_alloc_extfrag&#39; was here<br>
=C2=A0static inline void trace_##name(proto)=C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/include/linux/tracepoint.h:265:3:<br>
note: in e<br>
xpansion of macro &#39;__DECLARE_TRACE&#39;<br>
=C2=A0 __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1, \<br>
=C2=A0 ^<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/include/linux/tracepoint.h:399:2:<br>
note: in e<br>
xpansion of macro &#39;DECLARE_TRACE&#39;<br>
=C2=A0DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))<br>
=C2=A0^<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/include/trace/events/kmem.h:267:1:<br>
note: in<br>
expansion of macro &#39;TRACE_EVENT&#39;<br>
TRACE_EVENT(mm_page_alloc_extfrag,<br>
^<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/scripts/Makefile.build:314:<br>
recipe for targe<br>
t &#39;/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/ltt=
ng-modules/probes/lttng-probe-kmem.o&#39;<br>
failed<br>
make[5]: *** [/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.dr=
v-0/lttng-modules/probes/lttng-probe-kmem.o]<br>
Error 1<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/scripts/Makefile.build:455:<br>
recipe for targe<br>
t &#39;/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/ltt=
ng-modules/probes&#39;<br>
failed<br>
make[4]: *** [/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.dr=
v-0/lttng-modules/probes]<br>
Error 2<br>
/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modules/3=
.14.36/source/Makefile:1276:<br>
recipe for target &#39;_module_/t<br>
mp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.14.36.drv-0/lttng-module=
s&#39;<br>
failed<br>
make[3]: *** [_module_/tmp/nix-build-lttng-modules-2.6.0-rc1-20-g99a570c-3.=
14.36.drv-0/lttng-modules]<br>
Error 2<br>
Makefile:133: recipe for target &#39;sub-make&#39; failed<br>
make[2]: *** [sub-make] Error 2<br>
Makefile:26: recipe for target &#39;all&#39; failed<br>
make[1]: *** [all] Error 2<br>
make[1]: Leaving directory<br>
&#39;/nix/store/5ib7vccbi3mj9y0hr0snas00lagjbai1-linux-3.14.36-dev/lib/modu=
les/3.14.36/build&#39;<br>
Makefile:70: recipe for target &#39;default&#39; failed<br>
make: *** [default] Error 2<br>
<br>
Best regards,<br>
Bj=C3=B8rn Forsman<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div><br></div></div>

--089e0122edb8eff9020511d1c900--


--===============0427521516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0427521516==--
