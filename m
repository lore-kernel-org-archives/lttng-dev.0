From: Junho Suh <redrattus@gmail.com>
Subject: Re: Building lttng-modules against linux 3.2.65
Date: Thu, 31 Mar 2016 13:44:53 +0900
Message-ID: <4B8B1283-FE08-4DB6-AF55-1E285882B059__6429.1181545288$1459399521$gmane$org@gmail.com>
References: <FB820BF5-3F00-4E08-870A-906953D29BBC@gmail.com>
 <CAF4oYfGJYtX30BhiR98eT-7dUinYX1Fsd5+fUjrHJhR8CkT17w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/mixed; boundary="===============2806272189378189107=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pf0-f181.google.com (mail-pf0-f181.google.com
 [209.85.192.181])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 33E3BA0644
 for <lttng-dev@lists.lttng.org>; Thu, 31 Mar 2016 04:45:00 +0000 (UTC)
Received: by mail-pf0-f181.google.com with SMTP id e128so38740005pfe.3
 for <lttng-dev@lists.lttng.org>; Wed, 30 Mar 2016 21:44:59 -0700 (PDT)
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
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============2806272189378189107==
Content-Type: multipart/alternative; boundary="Apple-Mail=_C069000D-478A-4C20-9937-3482CD942D74"


--Apple-Mail=_C069000D-478A-4C20-9937-3482CD942D74
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Jonathan,

I am still encountering the similar problem, but log detail is some =
different.
Would you try the build with this linux version and lttng-modules 2.7.x? =
Here is a repo that I use

git@github.com:JunhoSuh/linux-3.2.65-1-deb7u2.git=20

Thanks~

> On Mar 31, 2016, at 10:46 AM, Jonathan Rajotte =
<jonathan.r.julien@gmail.com> wrote:
>=20
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


--Apple-Mail=_C069000D-478A-4C20-9937-3482CD942D74
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hi Jonathan,<div class=3D""><br class=3D""></div><div =
class=3D"">I am still encountering the similar problem, but log detail =
is some different.</div><div class=3D"">Would you try the build with =
this linux version and lttng-modules 2.7.x? Here is a repo that I =
use</div><div class=3D""><br class=3D""></div><div =
class=3D"">git@github.com:JunhoSuh/linux-3.2.65-1-deb7u2.git&nbsp;</div><d=
iv class=3D""><br class=3D""></div><div class=3D"">Thanks~</div><div =
class=3D""><br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Mar 31, 2016, at 10:46 AM, Jonathan Rajotte &lt;<a =
href=3D"mailto:jonathan.r.julien@gmail.com" =
class=3D"">jonathan.r.julien@gmail.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div dir=3D"ltr" =
class=3D"">Hi Junho,<div class=3D""><br class=3D""></div><div =
class=3D"">Can you reproduce this with the latest 2.7 stable branch of =
lttng-modules or master ?</div><div class=3D""><br class=3D""></div><div =
class=3D"">Also there is a newer release for 2.6 which is v2.6.4 so you =
might want to try this also.</div><div class=3D""><br =
class=3D""></div><div class=3D"">Cheers</div></div><div =
class=3D"gmail_extra"><br class=3D""><div class=3D"gmail_quote">On Wed, =
Mar 30, 2016 at 9:38 PM, Junho Suh <span dir=3D"ltr" class=3D"">&lt;<a =
href=3D"mailto:redrattus@gmail.com" target=3D"_blank" =
class=3D"">redrattus@gmail.com</a>&gt;</span> wrote:<br =
class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
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
class=3D"">_______________________________________________<br class=3D"">
lttng-dev mailing list<br class=3D"">
<a href=3D"mailto:lttng-dev@lists.lttng.org" =
class=3D"">lttng-dev@lists.lttng.org</a><br class=3D"">
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank" =
class=3D"">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br class=3D"">
<br class=3D""></blockquote></div><br class=3D""><br clear=3D"all" =
class=3D""><div class=3D""><br class=3D""></div>-- <br class=3D""><div =
class=3D"gmail_signature"><div dir=3D"ltr" class=3D""><div class=3D""><div=
 dir=3D"ltr" class=3D"">Jonathan Rajotte Julien<div class=3D""><br =
class=3D""></div></div></div></div></div>
</div>
</div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_C069000D-478A-4C20-9937-3482CD942D74--

--===============2806272189378189107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2806272189378189107==--
