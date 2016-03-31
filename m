From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Building lttng-modules against linux 3.2.65
Date: Wed, 30 Mar 2016 21:50:55 -0400
Message-ID: <CAF4oYfGH0cc2nJJrCxvDA4EPY2tJ5wnGjbhw-6UCd6WpS9L13A__47643.5913857587$1459389078$gmane$org@mail.gmail.com>
References: <FB820BF5-3F00-4E08-870A-906953D29BBC@gmail.com>
 <CAF4oYfGJYtX30BhiR98eT-7dUinYX1Fsd5+fUjrHJhR8CkT17w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2887579561169135217=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com
 [209.85.223.180])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 7E356A0644
 for <lttng-dev@lists.lttng.org>; Thu, 31 Mar 2016 01:50:56 +0000 (UTC)
Received: by mail-io0-f180.google.com with SMTP id g185so98840267ioa.2
 for <lttng-dev@lists.lttng.org>; Wed, 30 Mar 2016 18:50:56 -0700 (PDT)
In-Reply-To: <CAF4oYfGJYtX30BhiR98eT-7dUinYX1Fsd5+fUjrHJhR8CkT17w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Junho Suh <redrattus@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2887579561169135217==
Content-Type: multipart/alternative; boundary=001a113ff0bc39968f052f4e7eda

--001a113ff0bc39968f052f4e7eda
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junho,

Also, it looks like you are building via OpenEmbedded/yocto. Could you
provide us with more information on your environnement (oe/yocto
version,recipe etc.).

Thanks

On Wed, Mar 30, 2016 at 9:46 PM, Jonathan Rajotte <
jonathan.r.julien@gmail.com> wrote:

> Hi Junho,
>
> Can you reproduce this with the latest 2.7 stable branch of lttng-modules
> or master ?
>
> Also there is a newer release for 2.6 which is v2.6.4 so you might want t=
o
> try this also.
>
> Cheers
>
> On Wed, Mar 30, 2016 at 9:38 PM, Junho Suh <redrattus@gmail.com> wrote:
>
>> Hi,
>>
>> I am currently building the LTTng 2.6.1 against the linux kernel 3.2.65.
>> When building lttng-modules, I get the below error:
>>
>> It seems the proper definition of "page->index" can not be found in the
>> right header file.
>> I also patch the Makefile by following the link (
>> https://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html)
>> which has similar problem, but it doesn=E2=80=99t work.
>>
>> Anybody can help me?
>>
>> Thanks~
>>
>> =3D=3D=3D
>> Log data follows:
>> | DEBUG: Executing shell function do_compile
>> | NOTE: make -j 2 -e MAKEFLAGS=3D
>> KERNEL_SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge=
/kernel-source
>> KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedg=
e/kernel-source
>> KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-openswitch-linux-gcc
>>  LD=3Dx86_64-openswitch-linux-ld.bfd  AR=3Dx86_64-openswitch-linux-ar
>>  O=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-=
build-artifacts
>> |
>> LTTNG_KERNELDIR=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/=
wedge/kernel-source
>> make -C
>> /home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-sourc=
e
>> M=3D/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linu=
x/lttng-modules/2.6.1-r0/git
>> modules
>> | make[1]: Entering directory
>> `/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-sour=
ce'
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/Makefile:250:
>> CONFIG_KALLSYMS_ALL is disabled, therefore probe "writeback" is disabled=
.
>> Rebuild your kernel with this configuration option enabled in order to
>> trace this subsystem.
>> |   CC [M]
>>  /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/l=
ttng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o
>> | In file included from
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/define_trace.h:136:0,
>> |                  from
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/ext3=
.h:902,
>> |                  from
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.c:49:
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:
>> In function '__event_probe__ext3__page_op':
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:253:24:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(index, page->index)
>> |                         ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:253:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(index, page->index)
>> |    ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:254:22:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(ino, page->mapping->host->i_ino)
>> |                       ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:254:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(ino, page->mapping->host->i_ino)
>> |    ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:255:22:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
>> |                       ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:255:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
>> |    ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:
>> In function '__event_probe__ext3_invalidatepage':
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:344:24:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(index, page->index)
>> |                         ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:41:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:45:9:
>> note: in expansion of macro 'PARAMS'
>> |          PARAMS(assign),    \
>> |          ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:107:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
>> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:111:4:
>> note: in expansion of macro 'PARAMS'
>> |     PARAMS(assign),     \
>> |     ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
>> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:344:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(index, page->index)
>> |    ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:346:37:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
>> |                                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:41:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:45:9:
>> note: in expansion of macro 'PARAMS'
>> |          PARAMS(assign),    \
>> |          ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:107:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
>> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:111:4:
>> note: in expansion of macro 'PARAMS'
>> |     PARAMS(assign),     \
>> |     ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
>> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:346:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
>> |    ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:347:37:
>> error: dereferencing pointer to incomplete type
>> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
>> |                                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:904:2:
>> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
>> |   _assign              \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:154:21:
>> note: in expansion of macro 'PARAMS'
>> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
>> |                      ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:41:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
>> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:45:9:
>> note: in expansion of macro 'PARAMS'
>> |          PARAMS(assign),    \
>> |          ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:107:2:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
>> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/lttng-events.h:111:4:
>> note: in expansion of macro 'PARAMS'
>> |     PARAMS(assign),     \
>> |     ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
>> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
>> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
>> |  ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
>> note: in expansion of macro 'TP_fast_assign'
>> |   TP_fast_assign(
>> |   ^
>> |
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:347:3:
>> note: in expansion of macro 'tp_assign'
>> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
>> |    ^
>> | make[4]: ***
>> [/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/l=
ttng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o]
>> Error 1
>> | make[3]: ***
>> [/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/l=
ttng-modules/2.6.1-r0/git/probes]
>> Error 2
>> | make[2]: ***
>> [_module_/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch=
-linux/lttng-modules/2.6.1-r0/git]
>> Error 2
>> | make[1]: *** [sub-make] Error 2
>> | make[1]: Leaving directory
>> `/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-sour=
ce'
>> | make: *** [default] Error 2
>> | ERROR: oe_runmake failed
>> | WARNING: exit code 1 from a shell command.
>> | ERROR: Function failed: do_compile (log file is located at
>> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/temp/log.do_compile.22702)
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>
>
> --
> Jonathan Rajotte Julien
>
>


--=20
Jonathan Rajotte Julien

--001a113ff0bc39968f052f4e7eda
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Junho,<div><br></div><div>Also, it looks like you are b=
uilding via OpenEmbedded/yocto. Could you provide us with more information =
on your environnement (oe/yocto version,recipe etc.).</div><div><br></div><=
div>Thanks</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Wed, Mar 30, 2016 at 9:46 PM, Jonathan Rajotte <span dir=3D"ltr">&l=
t;<a href=3D"mailto:jonathan.r.julien@gmail.com" target=3D"_blank">jonathan=
.r.julien@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div dir=3D"ltr">Hi Junho,<div><br></div><div>Can you reproduce this with =
the latest 2.7 stable branch of lttng-modules or master ?</div><div><br></d=
iv><div>Also there is a newer release for 2.6 which is v2.6.4 so you might =
want to try this also.</div><div><br></div><div>Cheers</div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div class=3D"h5">On =
Wed, Mar 30, 2016 at 9:38 PM, Junho Suh <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:redrattus@gmail.com" target=3D"_blank">redrattus@gmail.com</a>&gt;</sp=
an> wrote:<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=3D=
"h5"><div style=3D"word-wrap:break-word">Hi,<br><br>I am currently building=
 the LTTng 2.6.1 against the linux kernel 3.2.65.<br>When building lttng-mo=
dules, I get the below error:<br><br>It seems the proper definition of &quo=
t;page-&gt;index&quot; can not be found in the right header file.<br>I also=
 patch the Makefile by following the link (<a href=3D"https://lists.lttng.o=
rg/pipermail/lttng-dev/2013-September/021322.html" target=3D"_blank">https:=
//lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html</a>) which=
 has similar problem, but it doesn=E2=80=99t work.<br><br>Anybody can help =
me?<br><br>Thanks~<div><br>=3D=3D=3D<br>Log data follows:<br>| DEBUG: Execu=
ting shell function do_compile<br>| NOTE: make -j 2 -e MAKEFLAGS=3D KERNEL_=
SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-so=
urce KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/we=
dge/kernel-source KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-openswitch-linux-gcc =
=C2=A0LD=3Dx86_64-openswitch-linux-ld.bfd =C2=A0AR=3Dx86_64-openswitch-linu=
x-ar =C2=A0O=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/=
kernel-build-artifacts<br>| LTTNG_KERNELDIR=3D/home/wedge/workspace/ops-bui=
ld/build/tmp/work-shared/wedge/kernel-source make -C /home/wedge/workspace/=
ops-build/build/tmp/work-shared/wedge/kernel-source M=3D/home/wedge/workspa=
ce/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/g=
it modules<br>| make[1]: Entering directory `/home/wedge/workspace/ops-buil=
d/build/tmp/work-shared/wedge/kernel-source&#39;<br>| /home/wedge/workspace=
/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git=
/probes/Makefile:250: CONFIG_KALLSYMS_ALL is disabled, therefore probe &quo=
t;writeback&quot; is disabled. Rebuild your kernel with this configuration =
option enabled in order to trace this subsystem.<br>| =C2=A0=C2=A0CC [M] =
=C2=A0/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux=
/lttng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o<br>| In file included=
 from /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux=
/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/.=
./../../probes/define_trace.h:136:0,<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /=
home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-=
modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/ext3.h:9=
02,<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /home/wedge/workspace/ops-build/bu=
ild/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/lttng=
-probe-ext3.c:49:<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge=
-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/even=
ts/lttng-module/../../../probes/../instrumentation/events/lttng-module/ext3=
.h: In function &#39;__event_probe__ext3__page_op&#39;:<br>| /home/wedge/wo=
rkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1=
-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../in=
strumentation/events/lttng-module/ext3.h:253:24: error: dereferencing point=
er to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(index, page-&gt;inde=
x)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-modu=
le/../../../probes/lttng-events.h:904:2: note: in definition of macro &#39;=
LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=C2=A0_assign =C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>|=
 =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-op=
enswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/=
lttng-module/../../../probes/lttng-events.h:154:21: note: in expansion of m=
acro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS(_tstruct), PARAMS(_assi=
gn), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-modu=
le/../../../probes/../instrumentation/events/lttng-module/ext3.h:240:1: not=
e: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=A0=
LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br>| =C2=A0^<br>| /home/wedge/w=
orkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.=
1-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../i=
nstrumentation/events/lttng-module/ext3.h:252:2: note: in expansion of macr=
o &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(<br>| =C2=A0=C2=
=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-modu=
le/../../../probes/../instrumentation/events/lttng-module/ext3.h:253:3: not=
e: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=A0=C2=A0tp_assi=
gn(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspa=
ce/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/g=
it/probes/../instrumentation/events/lttng-module/../../../probes/../instrum=
entation/events/lttng-module/ext3.h:254:22: error: dereferencing pointer to=
 incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(ino, page-&gt;mapping-&gt=
;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/lttng-events.h:904:2: note: in definition of macro &#=
39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=C2=A0_assign =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<b=
r>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge=
-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/even=
ts/lttng-module/../../../probes/lttng-events.h:154:21: note: in expansion o=
f macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS(_tstruct), PARAMS(_a=
ssign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/../instrumentation/events/lttng-module/ext3.h:240:1: =
note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=
=A0LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br>| =C2=A0^<br>| /home/wedg=
e/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2=
.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/.=
./instrumentation/events/lttng-module/ext3.h:252:2: note: in expansion of m=
acro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(<br>| =C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/../instrumentation/events/lttng-module/ext3.h:254:3: =
note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=A0=C2=A0tp_a=
ssign(ino, page-&gt;mapping-&gt;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0^<br=
>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:255:22: error: de=
referencing pointer to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(dev=
, page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/=
build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../=
instrumentation/events/lttng-module/../../../probes/lttng-events.h:904:2: n=
ote: in definition of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>=
| =C2=A0=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/=
ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/=
probes/../instrumentation/events/lttng-module/../../../probes/lttng-events.=
h:154:21: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=
=A0PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/=
build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../=
instrumentation/events/lttng-module/../../../probes/../instrumentation/even=
ts/lttng-module/ext3.h:240:1: note: in expansion of macro &#39;LTTNG_TRACEP=
OINT_EVENT_CLASS&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op=
,<br>| =C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-op=
enswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/=
lttng-module/../../../probes/../instrumentation/events/lttng-module/ext3.h:=
252:2: note: in expansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=
=A0TP_fast_assign(<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/=
build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../=
instrumentation/events/lttng-module/../../../probes/../instrumentation/even=
ts/lttng-module/ext3.h:255:3: note: in expansion of macro &#39;tp_assign&#3=
9;<br>| =C2=A0=C2=A0=C2=A0tp_assign(dev, page-&gt;mapping-&gt;host-&gt;i_sb=
-&gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/b=
uild/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../i=
nstrumentation/events/lttng-module/../../../probes/../instrumentation/event=
s/lttng-module/ext3.h: In function &#39;__event_probe__ext3_invalidatepage&=
#39;:<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-=
linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-mod=
ule/../../../probes/../instrumentation/events/lttng-module/ext3.h:344:24: e=
rror: dereferencing pointer to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_as=
sign(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp=
/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumen=
tation/events/lttng-module/../../../probes/lttng-events.h:904:2: note: in d=
efinition of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=
=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build=
/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/..=
/instrumentation/events/lttng-module/../../../probes/lttng-events.h:154:21:=
 note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS=
(_tstruct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp=
/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumen=
tation/events/lttng-module/../../../probes/lttng-events.h:41:2: note: in ex=
pansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=A0=C2=A0LT=
TNG_TRACEPOINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>|=
 /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../=
../probes/lttng-events.h:45:9: note: in expansion of macro &#39;PARAMS&#39;=
<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign),=
 =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/lttng-events.h:107:2: note: in expansion of macro &#3=
9;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=C2=A0LTTNG_TRACEPOINT_EVENT_M=
AP(name, name, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/work=
space/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r=
0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng-e=
vents.h:111:4: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=
=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=
=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-ope=
nswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/l=
ttng-module/../../../probes/../instrumentation/events/lttng-module/ext3.h:3=
30:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT&#39;<br>| =C2=
=A0LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br>| =C2=A0^<br>| /home/wedg=
e/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2=
.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/.=
./instrumentation/events/lttng-module/ext3.h:343:2: note: in expansion of m=
acro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(<br>| =C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/../instrumentation/events/lttng-module/ext3.h:344:3: =
note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=A0=C2=A0tp_a=
ssign(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/work=
space/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r=
0/git/probes/../instrumentation/events/lttng-module/../../../probes/../inst=
rumentation/events/lttng-module/ext3.h:346:37: error: dereferencing pointer=
 to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(ino, (unsigned long)pa=
ge-&gt;mapping-&gt;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-bui=
ld/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/=
../instrumentation/events/lttng-module/../../../probes/lttng-events.h:904:2=
: note: in definition of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<=
br>| =C2=A0=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspa=
ce/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/g=
it/probes/../instrumentation/events/lttng-module/../../../probes/lttng-even=
ts.h:154:21: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=
=C2=A0PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-bui=
ld/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/=
../instrumentation/events/lttng-module/../../../probes/lttng-events.h:41:2:=
 note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =
=C2=A0=C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=A0\<br>| =C2=
=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-opensw=
itch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttn=
g-module/../../../probes/lttng-events.h:45:9: note: in expansion of macro &=
#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
PARAMS(assign), =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/=
wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation=
/events/lttng-module/../../../probes/lttng-events.h:107:2: note: in expansi=
on of macro &#39;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=C2=A0LTTNG_TRA=
CEPOINT_EVENT_MAP(name, name, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /=
home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-=
modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../..=
/probes/lttng-events.h:111:4: note: in expansion of macro &#39;PARAMS&#39;<=
br>| =C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0=C2=A0\<br>|=
 =C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/w=
ork/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumenta=
tion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mo=
dule/ext3.h:330:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT&=
#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br>| =C2=A0^<br=
>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in e=
xpansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(=
<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wed=
ge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/ev=
ents/lttng-module/../../../probes/../instrumentation/events/lttng-module/ex=
t3.h:346:3: note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=
=A0=C2=A0tp_assign(ino, (unsigned long)page-&gt;mapping-&gt;host-&gt;i_ino)=
<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/wo=
rk/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentat=
ion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mod=
ule/ext3.h:347:37: error: dereferencing pointer to incomplete type<br>| =C2=
=A0=C2=A0=C2=A0tp_assign(dev, (unsigned long)page-&gt;mapping-&gt;host-&gt;=
i_sb-&gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wed=
ge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/ev=
ents/lttng-module/../../../probes/lttng-events.h:904:2: note: in definition=
 of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=C2=A0_ass=
ign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tm=
p/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrume=
ntation/events/lttng-module/../../../probes/lttng-events.h:154:21: note: in=
 expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS(_tstruct=
), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wed=
ge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/ev=
ents/lttng-module/../../../probes/lttng-events.h:41:2: note: in expansion o=
f macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=A0=C2=A0LTTNG_TRACE=
POINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/we=
dge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules=
/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../probes=
/lttng-events.h:45:9: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=
=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<=
br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/=
lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/..=
/../../probes/lttng-events.h:107:2: note: in expansion of macro &#39;LTTNG_=
TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=C2=A0LTTNG_TRACEPOINT_EVENT_MAP(name,=
 name, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/op=
s-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/pr=
obes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h:=
111:4: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=
=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=
=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-modu=
le/../../../probes/../instrumentation/events/lttng-module/ext3.h:330:1: not=
e: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT&#39;<br>| =C2=A0LTTNG_=
TRACEPOINT_EVENT(ext3_invalidatepage,<br>| =C2=A0^<br>| /home/wedge/workspa=
ce/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/g=
it/probes/../instrumentation/events/lttng-module/../../../probes/../instrum=
entation/events/lttng-module/ext3.h:343:2: note: in expansion of macro &#39=
;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(<br>| =C2=A0=C2=A0^<br=
>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../.=
./../probes/../instrumentation/events/lttng-module/ext3.h:347:3: note: in e=
xpansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=A0=C2=A0tp_assign(dev,=
 (unsigned long)page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br>| =C2=A0=
=C2=A0=C2=A0^<br>| make[4]: *** [/home/wedge/workspace/ops-build/build/tmp/=
work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/lttng-probe-e=
xt3.o] Error 1<br>| make[3]: *** [/home/wedge/workspace/ops-build/build/tmp=
/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes] Error 2<br>=
| make[2]: *** [_module_/home/wedge/workspace/ops-build/build/tmp/work/wedg=
e-openswitch-linux/lttng-modules/2.6.1-r0/git] Error 2<br>| make[1]: *** [s=
ub-make] Error 2<br>| make[1]: Leaving directory `/home/wedge/workspace/ops=
-build/build/tmp/work-shared/wedge/kernel-source&#39;<br>| make: *** [defau=
lt] Error 2<br>| ERROR: oe_runmake failed<br>| WARNING: exit code 1 from a =
shell command.<br>| ERROR: Function failed: do_compile (log file is located=
 at /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/l=
ttng-modules/2.6.1-r0/temp/log.do_compile.22702)</div></div><br></div></div=
>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
<br></blockquote></div><span class=3D"HOEnZb"><font color=3D"#888888"><br><=
br clear=3D"all"><div><br></div>-- <br><div><div dir=3D"ltr"><div><div dir=
=3D"ltr">Jonathan Rajotte Julien<div><br></div></div></div></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajott=
e Julien<div><br></div></div></div></div></div>
</div>

--001a113ff0bc39968f052f4e7eda--

--===============2887579561169135217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2887579561169135217==--
