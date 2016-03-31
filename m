From: Junho Suh <redrattus@gmail.com>
Subject: Re: Building lttng-modules against linux 3.2.65
Date: Thu, 31 Mar 2016 12:35:24 +0900
Message-ID: <5F4A5551-0889-478F-8F0C-BD5C1296AF89__45803.9786237807$1459395353$gmane$org@gmail.com>
References: <FB820BF5-3F00-4E08-870A-906953D29BBC@gmail.com>
 <CAF4oYfGJYtX30BhiR98eT-7dUinYX1Fsd5+fUjrHJhR8CkT17w@mail.gmail.com>
 <CAF4oYfGH0cc2nJJrCxvDA4EPY2tJ5wnGjbhw-6UCd6WpS9L13A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/mixed; boundary="===============4690128004415256290=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
 [209.85.192.175])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 97441A0644
 for <lttng-dev@lists.lttng.org>; Thu, 31 Mar 2016 03:35:30 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id n5so58716197pfn.2
 for <lttng-dev@lists.lttng.org>; Wed, 30 Mar 2016 20:35:30 -0700 (PDT)
In-Reply-To: <CAF4oYfGH0cc2nJJrCxvDA4EPY2tJ5wnGjbhw-6UCd6WpS9L13A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============4690128004415256290==
Content-Type: multipart/alternative; boundary="Apple-Mail=_9F606E02-2130-4F80-B879-7E275E8E5A70"


--Apple-Mail=_9F606E02-2130-4F80-B879-7E275E8E5A70
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan

Thanks for helping me. I attach the recipe files that related to the =
lttng-modules building.
Also, I use Poky 1.8 distro version.

Junho Suh

> On Mar 31, 2016, at 10:50 AM, Jonathan Rajotte =
<jonathan.r.julien@gmail.com> wrote:
>=20
> Hi Junho,
>=20
> Also, it looks like you are building via OpenEmbedded/yocto. Could you =
provide us with more information on your environnement (oe/yocto =
version,recipe etc.).
>=20
> Thanks
>=20
> On Wed, Mar 30, 2016 at 9:46 PM, Jonathan Rajotte =
<jonathan.r.julien@gmail.com <mailto:jonathan.r.julien@gmail.com>> =
wrote:
> Hi Junho,
>=20
> Can you reproduce this with the latest 2.7 stable branch of =
lttng-modules or master ?
>=20
> Also there is a newer release for 2.6 which is v2.6.4 so you might =
want to try this also.
>=20
> Cheers
>=20
> On Wed, Mar 30, 2016 at 9:38 PM, Junho Suh <redrattus@gmail.com =
<mailto:redrattus@gmail.com>> wrote:
> Hi,
>=20
> I am currently building the LTTng 2.6.1 against the linux kernel =
3.2.65.
> When building lttng-modules, I get the below error:
>=20
> It seems the proper definition of "page->index" can not be found in =
the right header file.
> I also patch the Makefile by following the link =
(https://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html =
<https://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.html>) =
which has similar problem, but it doesn=E2=80=99t work.
>=20
> Anybody can help me?
>=20
> Thanks~
>=20
> =3D=3D=3D
> Log data follows:
> | DEBUG: Executing shell function do_compile
> | NOTE: make -j 2 -e MAKEFLAGS=3D =
KERNEL_SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/k=
ernel-source =
KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/=
kernel-source KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-openswitch-linux-gcc  =
LD=3Dx86_64-openswitch-linux-ld.bfd  AR=3Dx86_64-openswitch-linux-ar  =
O=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-bui=
ld-artifacts
> | =
LTTNG_KERNELDIR=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/we=
dge/kernel-source make -C =
/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source =
M=3D/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/=
lttng-modules/2.6.1-r0/git modules
> | make[1]: Entering directory =
`/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source=
'
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/Makefile:250: CONFIG_KALLSYMS_ALL is =
disabled, therefore probe "writeback" is disabled. Rebuild your kernel =
with this configuration option enabled in order to trace this subsystem.
> |   CC [M]  =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o
> | In file included from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/define_trace.h:136:0,
> |                  from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/ext3.=
h:902,
> |                  from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/lttng-probe-ext3.c:49:
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h: In function =
'__event_probe__ext3__page_op':
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:24: error: =
dereferencing pointer to incomplete type
> |    tp_assign(index, page->index)
> |                         ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(index, page->index)
> |    ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:22: error: =
dereferencing pointer to incomplete type
> |    tp_assign(ino, page->mapping->host->i_ino)
> |                       ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(ino, page->mapping->host->i_ino)
> |    ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:22: error: =
dereferencing pointer to incomplete type
> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
> |                       ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'
> |  LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(dev, page->mapping->host->i_sb->s_dev)
> |    ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h: In function =
'__event_probe__ext3_invalidatepage':
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:24: error: =
dereferencing pointer to incomplete type
> |    tp_assign(index, page->index)
> |                         ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(index, page->index)
> |    ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:37: error: =
dereferencing pointer to incomplete type
> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
> |                                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(ino, (unsigned long)page->mapping->host->i_ino)
> |    ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:37: error: =
dereferencing pointer to incomplete type
> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
> |                                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'
> |   _assign              \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro 'PARAMS'
> |    PARAMS(_tstruct), PARAMS(_assign), PARAMS(_print))
> |                      ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'
> |   LTTNG_TRACEPOINT_EVENT_CLASS(map,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'
> |          PARAMS(assign),    \
> |          ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'
> |   LTTNG_TRACEPOINT_EVENT_MAP(name, name,    \
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'
> |     PARAMS(assign),     \
> |     ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'
> |  LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,
> |  ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'
> |   TP_fast_assign(
> |   ^
> | =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:3: note: in =
expansion of macro 'tp_assign'
> |    tp_assign(dev, (unsigned long)page->mapping->host->i_sb->s_dev)
> |    ^
> | make[4]: *** =
[/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o] Error 1
> | make[3]: *** =
[/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes] Error 2
> | make[2]: *** =
[_module_/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git] Error 2
> | make[1]: *** [sub-make] Error 2
> | make[1]: Leaving directory =
`/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source=
'
> | make: *** [default] Error 2
> | ERROR: oe_runmake failed
> | WARNING: exit code 1 from a shell command.
> | ERROR: Function failed: do_compile (log file is located at =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/temp/log.do_compile.22702)
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev =
<https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>
>=20
>=20
>=20
>=20
> --=20
> Jonathan Rajotte Julien
>=20
>=20
>=20
>=20
> --=20
> Jonathan Rajotte Julien
>=20


--Apple-Mail=_9F606E02-2130-4F80-B879-7E275E8E5A70
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E"


--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" class="">Hi Jonathan<div class=""><br class=""></div><div class="">Thanks for helping me. I attach the recipe files that related to the lttng-modules building.<div class="">Also, I use Poky 1.8 distro version.</div><div class=""><br class=""></div><div class="">Junho Suh</div><div class=""></div></div></body></html>
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Disposition: attachment;
	filename=lttng-modules_2.6.1.bb.rtf
Content-Type: text/rtf;
	name="lttng-modules_2.6.1.bb.rtf"
Content-Transfer-Encoding: 7bit

{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 SECTION = "devel"\
SUMMARY = "Linux Trace Toolkit KERNEL MODULE"\
DESCRIPTION = "The lttng-modules 2.0 package contains the kernel tracer modules"\
LICENSE = "LGPLv2.1 & GPLv2 & MIT"\
LIC_FILES_CHKSUM = "file://LICENSE;md5=1412caf5a1aa90d6a48588a4794c0eac \\\
                    file://gpl-2.0.txt;md5=751419260aa954499f7abaabaa882bbe \\\
                    file://lgpl-2.1.txt;md5=243b725d71bb5df4a1e5920b344b86ad"\
\
inherit module\
\
SRCREV = "62080b2248fd8ec4111ffc379d0bc5eaf0a5c16d"\
\
COMPATIBLE_HOST = '(x86_64|i.86|powerpc|aarch64|mips|arm).*-linux'\
\
SRC_URI = "git://git.lttng.org/lttng-modules.git;branch=stable-2.6 \\\
           file://lttng-modules-replace-KERNELDIR-with-KERNEL_SRC.patch \\\
           "\
\
export INSTALL_MOD_DIR="kernel/lttng-modules"\
export KERNEL_SRC="$\{STAGING_KERNEL_DIR\}"\
\
\
S = "$\{WORKDIR\}/git"\
\
do_install_append() \{\
    # Delete empty directories to avoid QA failures if no modules were built\
    find $\{D\}/lib -depth -type d -empty -exec rmdir \{\} \\;\
\}\
\
python do_package_prepend() \{\
    if not os.path.exists(os.path.join(d.getVar('D', True), 'lib/modules')):\
        bb.warn("%s: no modules were created; this may be due to CONFIG_TRACEPOINTS not being enabled in your kernel." % d.getVar('PN', True))\
\}}
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><div><div></div></div></body></html>
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Disposition: attachment;
	filename=lttng-ust_%.bbappend.rtf
Content-Type: text/rtf;
	name="lttng-ust_%.bbappend.rtf"
Content-Transfer-Encoding: 7bit

{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # Copyright (C) 2015 Hewlett Packard Enterprise Development LP\
PR_append = "_openswitch"\
\
FILES_$\{PN\} = "/usr/lib"\
FILES_$\{PN\}-dev += "/usr/bin/lttng-gen-tp"}
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;"><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><div><div></div></div></body></html>
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Disposition: attachment;
	filename=lttng-modules-replace-KERNELDIR-with-KERNEL_SRC.patch
Content-Type: application/octet-stream;
	name="lttng-modules-replace-KERNELDIR-with-KERNEL_SRC.patch"
Content-Transfer-Encoding: 7bit

{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 Upstream-Status: Inappropriate [embedded specific]\
\
lttng-modules: replace KERNELDIR with KERNEL_SRC\
\
Since lttng-modules uses the default way of module.bbclass to\
build and install lttng-modules, we do this replacement for\
it as-is.\
\
Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>\
[sgw - rebased for 2.6.1]\
Signed-off-by: Saul wold <sgw@linux.intel.com>\
\
Index: git/Makefile\
===================================================================\
--- git.orig/Makefile\
+++ git/Makefile\
@@ -68,19 +68,19 @@ obj-m += lib/\
 endif # CONFIG_TRACEPOINTS\
\
 else # KERNELRELEASE\
-   KERNELDIR ?= /lib/modules/$(shell uname -r)/build\
-   PWD := $(shell pwd)\
-   CFLAGS = $(EXTCFLAGS)\
-\
+   KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build\
+   PWD := $(shell pwd)\
+   CFLAGS = $(EXTCFLAGS)\
+\
 default:\
-   LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) modules\
+   LTTNG_KERNELDIR=$(KERNEL_SRC) $(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules\
\
 modules_install:\
-   LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install\
+   LTTNG_KERNELDIR=$(KERNEL_SRC) $(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules_install\
\
 clean:\
-   LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) clean\
+   LTTNG_KERNELDIR=$(KERNEL_SRC) $(MAKE) -C $(KERNEL_SRC) M=$(PWD) clean\
\
 %.i: %.c\
-   LTTNG_KERNELDIR=$(KERNELDIR) $(MAKE) -C $(KERNELDIR) M=$(PWD) $@\
+   LTTNG_KERNELDIR=$(KERNEL_SRC) $(MAKE) -C $(KERNEL_SRC) M=$(PWD) $@\
 endif # KERNELRELEASE\
Index: git/probes/Makefile\
===================================================================\
--- git.orig/probes/Makefile\
+++ git/probes/Makefile\
@@ -267,18 +267,18 @@ endif\
 endif\
\
 else\
-   KERNELDIR ?= /lib/modules/$(shell uname -r)/build\
+   KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build\
    PWD := $(shell pwd)\
    CFLAGS = $(EXTCFLAGS)\
\
 default:\
-   $(MAKE) -C $(KERNELDIR) M=$(PWD) modules\
+   $(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules\
\
 modules_install:\
-   $(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install\
+   $(MAKE) -C $(KERNEL_SRC) M=$(PWD) modules_install\
    /sbin/depmod -a\
\
 clean:\
-   $(MAKE) -C $(KERNELDIR) M=$(PWD) clean\
+   $(MAKE) -C $(KERNEL_SRC) M=$(PWD) clean\
\
 endif}
--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D""><div class=3D""><br class=3D""><div><blockquote=
 type=3D"cite" class=3D""><div class=3D"">On Mar 31, 2016, at 10:50 AM, =
Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.r.julien@gmail.com" =
class=3D"">jonathan.r.julien@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div dir=3D"ltr" =
class=3D"">Hi Junho,<div class=3D""><br class=3D""></div><div =
class=3D"">Also, it looks like you are building via OpenEmbedded/yocto. =
Could you provide us with more information on your environnement =
(oe/yocto version,recipe etc.).</div><div class=3D""><br =
class=3D""></div><div class=3D"">Thanks</div></div><div =
class=3D"gmail_extra"><br class=3D""><div class=3D"gmail_quote">On Wed, =
Mar 30, 2016 at 9:46 PM, Jonathan Rajotte <span dir=3D"ltr" =
class=3D"">&lt;<a href=3D"mailto:jonathan.r.julien@gmail.com" =
target=3D"_blank" class=3D"">jonathan.r.julien@gmail.com</a>&gt;</span> =
wrote:<br class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr" =
class=3D"">Hi Junho,<div class=3D""><br class=3D""></div><div =
class=3D"">Can you reproduce this with the latest 2.7 stable branch of =
lttng-modules or master ?</div><div class=3D""><br class=3D""></div><div =
class=3D"">Also there is a newer release for 2.6 which is v2.6.4 so you =
might want to try this also.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Cheers</div></div><div =
class=3D"gmail_extra"><br class=3D""><div class=3D"gmail_quote"><div =
class=3D""><div class=3D"h5">On Wed, Mar 30, 2016 at 9:38 PM, Junho Suh =
<span dir=3D"ltr" class=3D"">&lt;<a href=3D"mailto:redrattus@gmail.com" =
target=3D"_blank" class=3D"">redrattus@gmail.com</a>&gt;</span> =
wrote:<br class=3D""></div></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div class=3D""><div class=3D"h5"><div =
style=3D"word-wrap:break-word" class=3D"">Hi,<br class=3D""><br =
class=3D"">I am currently building the LTTng 2.6.1 against the linux =
kernel 3.2.65.<br class=3D"">When building lttng-modules, I get the =
below error:<br class=3D""><br class=3D"">It seems the proper definition =
of "page-&gt;index" can not be found in the right header file.<br =
class=3D"">I also patch the Makefile by following the link (<a =
href=3D"https://lists.lttng.org/pipermail/lttng-dev/2013-September/021322.=
html" target=3D"_blank" =
class=3D"">https://lists.lttng.org/pipermail/lttng-dev/2013-September/0213=
22.html</a>) which has similar problem, but it doesn=E2=80=99t work.<br =
class=3D""><br class=3D"">Anybody can help me?<br class=3D""><br =
class=3D"">Thanks~<div class=3D""><br class=3D"">=3D=3D=3D<br =
class=3D"">Log data follows:<br class=3D"">| DEBUG: Executing shell =
function do_compile<br class=3D"">| NOTE: make -j 2 -e MAKEFLAGS=3D =
KERNEL_SRC=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/k=
ernel-source =
KERNEL_PATH=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/=
kernel-source KERNEL_VERSION=3D3.2.65 CC=3Dx86_64-openswitch-linux-gcc =
&nbsp;LD=3Dx86_64-openswitch-linux-ld.bfd =
&nbsp;AR=3Dx86_64-openswitch-linux-ar =
&nbsp;O=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kern=
el-build-artifacts<br class=3D"">| =
LTTNG_KERNELDIR=3D/home/wedge/workspace/ops-build/build/tmp/work-shared/we=
dge/kernel-source make -C =
/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source =
M=3D/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/=
lttng-modules/2.6.1-r0/git modules<br class=3D"">| make[1]: Entering =
directory =
`/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source=
'<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/Makefile:250: CONFIG_KALLSYMS_ALL is =
disabled, therefore probe "writeback" is disabled. Rebuild your kernel =
with this configuration option enabled in order to trace this =
subsystem.<br class=3D"">| &nbsp;&nbsp;CC [M] =
&nbsp;/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linu=
x/lttng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o<br class=3D"">| =
In file included from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/define_trace.h:136:0,<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/ext3.=
h:902,<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;from =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/lttng-probe-ext3.c:49:<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h: In function =
'__event_probe__ext3__page_op':<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:24: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(index, page-&gt;index)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br=
 class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:253:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(index, page-&gt;index)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:22: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(ino, page-&gt;mapping-&gt;host-&gt;i_ino)<br =
class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br =
class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:254:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(ino, page-&gt;mapping-&gt;host-&gt;i_ino)<br =
class=3D"">| &nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:22: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(dev, =
page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br =
class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:240:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(ext3__page_op,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:252:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:255:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(dev, =
page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h: In function =
'__event_probe__ext3_invalidatepage':<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:24: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(index, page-&gt;index)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br=
 class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(map, &nbsp;&nbsp;&nbsp;\<br =
class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'<br =
class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_MAP(name, name, =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'<br =
class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;^<br =
class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:344:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(index, page-&gt;index)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:37: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(ino, (unsigned =
long)page-&gt;mapping-&gt;host-&gt;i_ino)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(map, &nbsp;&nbsp;&nbsp;\<br =
class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'<br =
class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_MAP(name, name, =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'<br =
class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;^<br =
class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:346:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(ino, (unsigned =
long)page-&gt;mapping-&gt;host-&gt;i_ino)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:37: error: =
dereferencing pointer to incomplete type<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(dev, (unsigned =
long)page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:904:2: note: in definition of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS_CODE'<br class=3D"">| &nbsp;&nbsp;_assign =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:154:21: note: in expansion of macro =
'PARAMS'<br class=3D"">| &nbsp;&nbsp;&nbsp;PARAMS(_tstruct), =
PARAMS(_assign), PARAMS(_print))<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:41:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_CLASS'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_CLASS(map, &nbsp;&nbsp;&nbsp;\<br =
class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:45:9: note: in expansion of macro 'PARAMS'<br =
class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:107:2: note: in expansion of macro =
'LTTNG_TRACEPOINT_EVENT_MAP'<br class=3D"">| =
&nbsp;&nbsp;LTTNG_TRACEPOINT_EVENT_MAP(name, name, =
&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/lttng-events.h:111:4: note: in expansion of macro 'PARAMS'<br =
class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;PARAMS(assign), =
&nbsp;&nbsp;&nbsp;&nbsp;\<br class=3D"">| &nbsp;&nbsp;&nbsp;&nbsp;^<br =
class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:330:1: note: in =
expansion of macro 'LTTNG_TRACEPOINT_EVENT'<br class=3D"">| =
&nbsp;LTTNG_TRACEPOINT_EVENT(ext3_invalidatepage,<br class=3D"">| =
&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:343:2: note: in =
expansion of macro 'TP_fast_assign'<br class=3D"">| =
&nbsp;&nbsp;TP_fast_assign(<br class=3D"">| &nbsp;&nbsp;^<br class=3D"">| =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/git/probes/../instrumentation/events/lttng-module/../..=
/../probes/../instrumentation/events/lttng-module/ext3.h:347:3: note: in =
expansion of macro 'tp_assign'<br class=3D"">| =
&nbsp;&nbsp;&nbsp;tp_assign(dev, (unsigned =
long)page-&gt;mapping-&gt;host-&gt;i_sb-&gt;s_dev)<br class=3D"">| =
&nbsp;&nbsp;&nbsp;^<br class=3D"">| make[4]: *** =
[/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes/lttng-probe-ext3.o] Error 1<br class=3D"">|=
 make[3]: *** =
[/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/ltt=
ng-modules/2.6.1-r0/git/probes] Error 2<br class=3D"">| make[2]: *** =
[_module_/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-l=
inux/lttng-modules/2.6.1-r0/git] Error 2<br class=3D"">| make[1]: *** =
[sub-make] Error 2<br class=3D"">| make[1]: Leaving directory =
`/home/wedge/workspace/ops-build/build/tmp/work-shared/wedge/kernel-source=
'<br class=3D"">| make: *** [default] Error 2<br class=3D"">| ERROR: =
oe_runmake failed<br class=3D"">| WARNING: exit code 1 from a shell =
command.<br class=3D"">| ERROR: Function failed: do_compile (log file is =
located at =
/home/wedge/workspace/ops-build/build/tmp/work/wedge-openswitch-linux/lttn=
g-modules/2.6.1-r0/temp/log.do_compile.22702)</div></div><br =
class=3D""></div></div>_______________________________________________<br =
class=3D"">
lttng-dev mailing list<br class=3D"">
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank" =
class=3D"">lttng-dev@lists.lttng.org</a><br class=3D"">
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank" =
class=3D"">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br class=3D"">
<br class=3D""></blockquote></div><span class=3D"HOEnZb"><font =
color=3D"#888888" class=3D""><br class=3D""><br clear=3D"all" =
class=3D""><div class=3D""><br class=3D""></div>-- <br class=3D""><div =
class=3D""><div dir=3D"ltr" class=3D""><div class=3D""><div dir=3D"ltr" =
class=3D"">Jonathan Rajotte Julien<div class=3D""><br =
class=3D""></div></div></div></div></div>
</font></span></div>
</blockquote></div><br class=3D""><br clear=3D"all" class=3D""><div =
class=3D""><br class=3D""></div>-- <br class=3D""><div =
class=3D"gmail_signature"><div dir=3D"ltr" class=3D""><div class=3D""><div=
 dir=3D"ltr" class=3D"">Jonathan Rajotte Julien<div class=3D""><br =
class=3D""></div></div></div></div></div>
</div>
</div></blockquote></div><br class=3D""></div></div></body></html>=

--Apple-Mail=_1900F289-9BB9-4810-B1C9-A151AE3B7F2E--

--Apple-Mail=_9F606E02-2130-4F80-B879-7E275E8E5A70--

--===============4690128004415256290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4690128004415256290==--
