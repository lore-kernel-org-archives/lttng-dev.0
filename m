From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Building lttng-modules against linux 3.2.65
Date: Wed, 30 Mar 2016 21:46:05 -0400
Message-ID: <CAF4oYfGJYtX30BhiR98eT-7dUinYX1Fsd5+fUjrHJhR8CkT17w__18081.307973671$1459388784$gmane$org@mail.gmail.com>
References: <FB820BF5-3F00-4E08-870A-906953D29BBC@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4286552943335297828=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id B8CE4A0644
 for <lttng-dev@lists.lttng.org>; Thu, 31 Mar 2016 01:46:06 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id q128so95323851iof.3
 for <lttng-dev@lists.lttng.org>; Wed, 30 Mar 2016 18:46:06 -0700 (PDT)
In-Reply-To: <FB820BF5-3F00-4E08-870A-906953D29BBC@gmail.com>
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

--===============4286552943335297828==
Content-Type: multipart/alternative; boundary=001a1140ff10f4ae3a052f4e6c90

--001a1140ff10f4ae3a052f4e6c90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junho,

Can you reproduce this with the latest 2.7 stable branch of lttng-modules
or master ?

Also there is a newer release for 2.6 which is v2.6.4 so you might want to
try this also.

Cheers

On Wed, Mar 30, 2016 at 9:38 PM, Junho Suh <redrattus@gmail.com> wrote:

> Hi,
>
> I am currently building the LTTng 2.6.1 against the linux kernel 3.2.65.
> When building lttng-modules, I get the below error:
>
> It seems the proper definition of "page->index" can not be found in the
> right header file.
> I also patch the Makefile by following the link (
> https://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html)
> which has similar problem, but it doesn=E2=80=99t work.
>
> Anybody can help me?
>
> Thanks~
>
> =3D=3D=3D
> Log data follows:
> | DEBUG: Executing shell function do_compile
> | NOTE: make -j 2 -e MAKEFLAGS=3D
> KERNEL_SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/=
kernel-source
> KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge=
/kernel-source
> KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-openswitch-linux-gcc
>  LD=3Dx86_64-openswitch-linux-ld.bfd  AR=3Dx86_64-openswitch-linux-ar
>  O=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-b=
uild-artifacts
> |
> LTTNG_KERNELDIR=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/w=
edge/kernel-source
> make -C
> /home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source
> M=3D/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux=
/lttng-modules/2.6.1-r0/git
> modules
> | make[1]: Entering directory
> `/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-sourc=
e'
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/Makefile:250:
> CONFIG_KALLSYMS_ALL is disabled, therefore probe "writeback" is disabled.
> Rebuild your kernel with this configuration option enabled in order to
> trace this subsystem.
> |   CC [M]
>  /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o
> | In file included from
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/define_trace.h:136:0,
> |                  from
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/ext3.=
h:902,
> |                  from
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.c:49:
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:
> In function '__event_probe__ext3__page_op':
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:24:
> error: dereferencing pointer to incomplete type
> |    tp_assign(index, page->index)
> |                         ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(index, page->index)
> |    ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:22:
> error: dereferencing pointer to incomplete type
> |    tp_assign(ino, page->mapping->host->i_ino)
> |                       ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(ino, page->mapping->host->i_ino)
> |    ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:22:
> error: dereferencing pointer to incomplete type
> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
> |                       ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
> |    ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:
> In function '__event_probe__ext3_invalidatepage':
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:24:
> error: dereferencing pointer to incomplete type
> |    tp_assign(index, page->index)
> |                         ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9:
> note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4:
> note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(index, page->index)
> |    ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:37:
> error: dereferencing pointer to incomplete type
> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
> |                                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9:
> note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4:
> note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
> |    ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:37:
> error: dereferencing pointer to incomplete type
> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
> |                                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2:
> note: in definition of macro 'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21:
> note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9:
> note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4:
> note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1:
> note: in expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2:
> note: in expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> |
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:3:
> note: in expansion of macro 'tp_assign'
> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
> |    ^
> | make[4]: ***
> [/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o]
> Error 1
> | make[3]: ***
> [/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lt=
tng-modules/2.6.1-r0/git/probes]
> Error 2
> | make[2]: ***
> [_module_/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-=
linux/lttng-modules/2.6.1-r0/git]
> Error 2
> | make[1]: *** [sub-make] Error 2
> | make[1]: Leaving directory
> `/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-sourc=
e'
> | make: *** [default] Error 2
> | ERROR: oe_runmake failed
> | WARNING: exit code 1 from a shell command.
> | ERROR: Function failed: do_compile (log file is located at
> /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/temp/log.do_compile.22702)
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
Jonathan Rajotte Julien

--001a1140ff10f4ae3a052f4e6c90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Junho,<div><br></div><div>Can you reproduce this with t=
he latest 2.7 stable branch of lttng-modules or master ?</div><div><br></di=
v><div>Also there is a newer release for 2.6 which is v2.6.4 so you might w=
ant to try this also.</div><div><br></div><div>Cheers</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar 30, 2016 at 9:3=
8 PM, Junho Suh <span dir=3D"ltr">&lt;<a href=3D"mailto:redrattus@gmail.com=
" target=3D"_blank">redrattus@gmail.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div style=3D"word-wrap:break-word">Hi,<br><br>I am cu=
rrently building the LTTng 2.6.1 against the linux kernel 3.2.65.<br>When b=
uilding lttng-modules, I get the below error:<br><br>It seems the proper de=
finition of &quot;page-&gt;index&quot; can not be found in the right header=
 file.<br>I also patch the Makefile by following the link (<a href=3D"https=
://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html" target=
=3D"_blank">https://lists.lttng.org/pipermail/lttng-dev/2013-September/0213=
22.html</a>) which has similar problem, but it doesn=E2=80=99t work.<br><br=
>Anybody can help me?<br><br>Thanks~<div><br>=3D=3D=3D<br>Log data follows:=
<br>| DEBUG: Executing shell function do_compile<br>| NOTE: make -j 2 -e MA=
KEFLAGS=3D KERNEL_SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shar=
ed/wedge/kernel-source KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/=
tmp/work-shared/wedge/kernel-source KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-ope=
nswitch-linux-gcc =C2=A0LD=3Dx86_64-openswitch-linux-ld.bfd =C2=A0AR=3Dx86_=
64-openswitch-linux-ar =C2=A0O=3D/home/wedge/workspace/ops-build/build/tmp/=
work-shared/wedge/kernel-build-artifacts<br>| LTTNG_KERNELDIR=3D/home/wedge=
/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source make -C /hom=
e/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source M=3D/=
home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-=
modules/2.6.1-r0/git modules<br>| make[1]: Entering directory `/home/wedge/=
workspace/ops-build/build/tmp/work-shared/wedge/kernel-source&#39;<br>| /ho=
me/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-mo=
dules/2.6.1-r0/git/probes/Makefile:250: CONFIG_KALLSYMS_ALL is disabled, th=
erefore probe &quot;writeback&quot; is disabled. Rebuild your kernel with t=
his configuration option enabled in order to trace this subsystem.<br>| =C2=
=A0=C2=A0CC [M] =C2=A0/home/wedge/workspace/ops-build/build/tmp/work/wedge-=
openswitch-linux/lttng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o<br>| =
In file included from /home/wedge/workspace/ops-build/build/tmp/work/wedge-=
openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/event=
s/lttng-module/../../../probes/define_trace.h:136:0,<br>| =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0from /home/wedge/workspace/ops-build/build/tmp/work/wedge-opens=
witch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/ltt=
ng-module/ext3.h:902,<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from /home/wedge/work=
space/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r=
0/git/probes/lttng-probe-ext3.c:49:<br>| /home/wedge/workspace/ops-build/bu=
ild/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../in=
strumentation/events/lttng-module/../../../probes/../instrumentation/events=
/lttng-module/ext3.h: In function &#39;__event_probe__ext3__page_op&#39;:<b=
r>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/l=
ttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../=
../../probes/../instrumentation/events/lttng-module/ext3.h:253:24: error: d=
ereferencing pointer to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(in=
dex, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/=
wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation=
/events/lttng-module/../../../probes/lttng-events.h:904:2: note: in definit=
ion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=C2=A0_=
assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build=
/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instr=
umentation/events/lttng-module/../../../probes/lttng-events.h:154:21: note:=
 in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS(_tstr=
uct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/=
wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation=
/events/lttng-module/../../../probes/../instrumentation/events/lttng-module=
/ext3.h:240:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLAS=
S&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br>| =C2=A0^<=
br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/=
lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/..=
/../../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in=
 expansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assig=
n(<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/w=
edge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/=
events/lttng-module/../../../probes/../instrumentation/events/lttng-module/=
ext3.h:253:3: note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=
=C2=A0=C2=A0tp_assign(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0^<br>| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng=
-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../.=
./probes/../instrumentation/events/lttng-module/ext3.h:254:22: error: deref=
erencing pointer to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(ino, p=
age-&gt;mapping-&gt;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/wo=
rk/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentat=
ion/events/lttng-module/../../../probes/lttng-events.h:904:2: note: in defi=
nition of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE&#39;<br>| =C2=A0=C2=
=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/bu=
ild/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../in=
strumentation/events/lttng-module/../../../probes/lttng-events.h:154:21: no=
te: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0PARAMS(_t=
struct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/wo=
rk/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentat=
ion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mod=
ule/ext3.h:240:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_C=
LASS&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br>| =C2=
=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-modu=
le/../../../probes/../instrumentation/events/lttng-module/ext3.h:252:2: not=
e: in expansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_=
assign(<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/w=
ork/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumenta=
tion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mo=
dule/ext3.h:254:3: note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=
=A0=C2=A0=C2=A0tp_assign(ino, page-&gt;mapping-&gt;host-&gt;i_ino)<br>| =C2=
=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-=
openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/event=
s/lttng-module/../../../probes/../instrumentation/events/lttng-module/ext3.=
h:255:22: error: dereferencing pointer to incomplete type<br>| =C2=A0=C2=A0=
=C2=A0tp_assign(dev, page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br>| =C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/wo=
rkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1=
-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng=
-events.h:904:2: note: in definition of macro &#39;LTTNG_TRACEPOINT_EVENT_C=
LASS_CODE&#39;<br>| =C2=A0=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /hom=
e/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-mod=
ules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../pr=
obes/lttng-events.h:154:21: note: in expansion of macro &#39;PARAMS&#39;<br=
>| =C2=A0=C2=A0=C2=A0PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))<br>=
| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/wo=
rkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1=
-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../in=
strumentation/events/lttng-module/ext3.h:240:1: note: in expansion of macro=
 &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT_C=
LASS(ext3__page_op,<br>| =C2=A0^<br>| /home/wedge/workspace/ops-build/build=
/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instr=
umentation/events/lttng-module/../../../probes/../instrumentation/events/lt=
tng-module/ext3.h:252:2: note: in expansion of macro &#39;TP_fast_assign&#3=
9;<br>| =C2=A0=C2=A0TP_fast_assign(<br>| =C2=A0=C2=A0^<br>| /home/wedge/wor=
kspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-=
r0/git/probes/../instrumentation/events/lttng-module/../../../probes/../ins=
trumentation/events/lttng-module/ext3.h:255:3: note: in expansion of macro =
&#39;tp_assign&#39;<br>| =C2=A0=C2=A0=C2=A0tp_assign(dev, page-&gt;mapping-=
&gt;host-&gt;i_sb-&gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/work=
space/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r=
0/git/probes/../instrumentation/events/lttng-module/../../../probes/../inst=
rumentation/events/lttng-module/ext3.h: In function &#39;__event_probe__ext=
3_invalidatepage&#39;:<br>| /home/wedge/workspace/ops-build/build/tmp/work/=
wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation=
/events/lttng-module/../../../probes/../instrumentation/events/lttng-module=
/ext3.h:344:24: error: dereferencing pointer to incomplete type<br>| =C2=A0=
=C2=A0=C2=A0tp_assign(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/o=
ps-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/p=
robes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h=
:904:2: note: in definition of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS_CODE=
&#39;<br>| =C2=A0=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/w=
orkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.=
1-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttn=
g-events.h:154:21: note: in expansion of macro &#39;PARAMS&#39;<br>| =C2=A0=
=C2=A0=C2=A0PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))<br>| =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/o=
ps-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/p=
robes/../instrumentation/events/lttng-module/../../../probes/lttng-events.h=
:41:2: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<b=
r>| =C2=A0=C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=A0\<br>| =
=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-ope=
nswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/l=
ttng-module/../../../probes/lttng-events.h:45:9: note: in expansion of macr=
o &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/wo=
rk/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentat=
ion/events/lttng-module/../../../probes/lttng-events.h:107:2: note: in expa=
nsion of macro &#39;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=C2=A0LTTNG_=
TRACEPOINT_EVENT_MAP(name, name, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>=
| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro &#39;PARAMS&#3=
9;<br>| =C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0=C2=A0\<b=
r>| =C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tm=
p/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrume=
ntation/events/lttng-module/../../../probes/../instrumentation/events/lttng=
-module/ext3.h:330:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVE=
NT&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br>| =C2=A0^=
<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux=
/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/.=
./../../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: i=
n expansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assi=
gn(<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/=
wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation=
/events/lttng-module/../../../probes/../instrumentation/events/lttng-module=
/ext3.h:344:3: note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=
=C2=A0=C2=A0tp_assign(index, page-&gt;index)<br>| =C2=A0=C2=A0=C2=A0^<br>| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng=
-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../.=
./probes/../instrumentation/events/lttng-module/ext3.h:346:37: error: deref=
erencing pointer to incomplete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(ino, (=
unsigned long)page-&gt;mapping-&gt;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/wo=
rkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1=
-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng=
-events.h:904:2: note: in definition of macro &#39;LTTNG_TRACEPOINT_EVENT_C=
LASS_CODE&#39;<br>| =C2=A0=C2=A0_assign =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /hom=
e/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-mod=
ules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../pr=
obes/lttng-events.h:154:21: note: in expansion of macro &#39;PARAMS&#39;<br=
>| =C2=A0=C2=A0=C2=A0PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))<br>=
| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/wo=
rkspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1=
-r0/git/probes/../instrumentation/events/lttng-module/../../../probes/lttng=
-events.h:41:2: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLA=
SS&#39;<br>| =C2=A0=C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=
=A0\<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work=
/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentatio=
n/events/lttng-module/../../../probes/lttng-events.h:45:9: note: in expansi=
on of macro &#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/=
build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../=
instrumentation/events/lttng-module/../../../probes/lttng-events.h:107:2: n=
ote: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=
=C2=A0LTTNG_TRACEPOINT_EVENT_MAP(name, name, =C2=A0=C2=A0=C2=A0\<br>| =C2=
=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-opensw=
itch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttn=
g-module/../../../probes/lttng-events.h:111:4: note: in expansion of macro =
&#39;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=
=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops=
-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/pro=
bes/../instrumentation/events/lttng-module/../../../probes/../instrumentati=
on/events/lttng-module/ext3.h:330:1: note: in expansion of macro &#39;LTTNG=
_TRACEPOINT_EVENT&#39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT(ext3_invalidatepag=
e,<br>| =C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-o=
penswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events=
/lttng-module/../../../probes/../instrumentation/events/lttng-module/ext3.h=
:343:2: note: in expansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=
=A0TP_fast_assign(<br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/=
build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../=
instrumentation/events/lttng-module/../../../probes/../instrumentation/even=
ts/lttng-module/ext3.h:346:3: note: in expansion of macro &#39;tp_assign&#3=
9;<br>| =C2=A0=C2=A0=C2=A0tp_assign(ino, (unsigned long)page-&gt;mapping-&g=
t;host-&gt;i_ino)<br>| =C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-b=
uild/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probe=
s/../instrumentation/events/lttng-module/../../../probes/../instrumentation=
/events/lttng-module/ext3.h:347:37: error: dereferencing pointer to incompl=
ete type<br>| =C2=A0=C2=A0=C2=A0tp_assign(dev, (unsigned long)page-&gt;mapp=
ing-&gt;host-&gt;i_sb-&gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
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
instrumentation/events/lttng-module/../../../probes/lttng-events.h:41:2: no=
te: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT_CLASS&#39;<br>| =C2=
=A0=C2=A0LTTNG_TRACEPOINT_EVENT_CLASS(map, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=
=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitc=
h-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-m=
odule/../../../probes/lttng-events.h:45:9: note: in expansion of macro &#39=
;PARAMS&#39;<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PAR=
AMS(assign), =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wed=
ge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/ev=
ents/lttng-module/../../../probes/lttng-events.h:107:2: note: in expansion =
of macro &#39;LTTNG_TRACEPOINT_EVENT_MAP&#39;<br>| =C2=A0=C2=A0LTTNG_TRACEP=
OINT_EVENT_MAP(name, name, =C2=A0=C2=A0=C2=A0\<br>| =C2=A0=C2=A0^<br>| /hom=
e/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-mod=
ules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../../../pr=
obes/lttng-events.h:111:4: note: in expansion of macro &#39;PARAMS&#39;<br>=
| =C2=A0=C2=A0=C2=A0=C2=A0PARAMS(assign), =C2=A0=C2=A0=C2=A0=C2=A0\<br>| =
=C2=A0=C2=A0=C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/wo=
rk/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentat=
ion/events/lttng-module/../../../probes/../instrumentation/events/lttng-mod=
ule/ext3.h:330:1: note: in expansion of macro &#39;LTTNG_TRACEPOINT_EVENT&#=
39;<br>| =C2=A0LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br>| =C2=A0^<br>=
| /home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in ex=
pansion of macro &#39;TP_fast_assign&#39;<br>| =C2=A0=C2=A0TP_fast_assign(<=
br>| =C2=A0=C2=A0^<br>| /home/wedge/workspace/ops-build/build/tmp/work/wedg=
e-openswitch-linux/lttng-modules/2.6.1-r0/git/probes/../instrumentation/eve=
nts/lttng-module/../../../probes/../instrumentation/events/lttng-module/ext=
3.h:347:3: note: in expansion of macro &#39;tp_assign&#39;<br>| =C2=A0=C2=
=A0=C2=A0tp_assign(dev, (unsigned long)page-&gt;mapping-&gt;host-&gt;i_sb-&=
gt;s_dev)<br>| =C2=A0=C2=A0=C2=A0^<br>| make[4]: *** [/home/wedge/workspace=
/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git=
/probes/lttng-probe-ext3.o] Error 1<br>| make[3]: *** [/home/wedge/workspac=
e/ops-build/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/gi=
t/probes] Error 2<br>| make[2]: *** [_module_/home/wedge/workspace/ops-buil=
d/build/tmp/work/wedge-openswitch-linux/lttng-modules/2.6.1-r0/git] Error 2=
<br>| make[1]: *** [sub-make] Error 2<br>| make[1]: Leaving directory `/hom=
e/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source&#39;<=
br>| make: *** [default] Error 2<br>| ERROR: oe_runmake failed<br>| WARNING=
: exit code 1 from a shell command.<br>| ERROR: Function failed: do_compile=
 (log file is located at /home/wedge/workspace/ops-build/build/tmp/work/wed=
ge-openswitch-linux/lttng-modules/2.6.1-r0/temp/log.do_compile.22702)</div>=
</div><br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonathan Rajo=
tte Julien<div><br></div></div></div></div></div>
</div>

--001a1140ff10f4ae3a052f4e6c90--

--===============4286552943335297828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4286552943335297828==--
