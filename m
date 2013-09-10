From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: [RFC PATCH lttng-ust] Make lttng-ust aware of
 shared object base addresses (issue #474)
Date: Tue, 10 Sep 2013 17:30:52 +0200
Message-ID: <522F3B2C.8040602__13008.8104786866$1378827124$gmane$org@mentor.com>
References: <1950303.PcKNxt9HMm@atv-pwoegere-l3.atv.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030100080604040005020200"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VJPuA-0001Qb-F0
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 11:31:09 -0400
In-Reply-To: <1950303.PcKNxt9HMm@atv-pwoegere-l3.atv.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--------------030100080604040005020200
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi Mathieu,

I recently created a high-level document to explain the prototype to my
colleagues. Maybe it is also useful to have that here on the mailinglist
(attached pdf).

Best,
Paul

On 08/27/2013 11:55 AM, Woegerer, Paul wrote:
> ...sorry, KMail was sending my draft without asking me first...
> 
> Hello,
> 
> To allow graphical trace viewers to provide features like address-to-symbol resolution or source lookup (address-to-lineinfo), information about the shared object base address mappings are required. These mappings are inherently time based and potentially change during the application runtime (dlopen, dlcose, dlopen, ...). It's even possible that at a later point in the program execution the same shared object gets mapped to a different base address (I saw that on ARM or PPC)
> 
> The patch set below provides an initial (prof-of-concept) implementation (based on the previous discussion on https://bugs.lttng.org/issues/474). It's a starting point for further discussions that will hopefully help me to provide an implementation that is good enough for upstream inclusion.
> 
> Applying the patch provides the following additional events for userspace tracing:
> 
> *) ust_baddr:push with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)
> *) ust_baddr:pop with TP_ARGS(void *, baddr)
> 
> Tracepoints 'ust_baddr:push' and 'ust_baddr:pop' are emitted for every runtime object that makes use of tracing (i.e emits tracepoints/includes tracepoint.h). This is also true for shared objects that get loaded during application run time. Loading a shared object via dlopen will, for example, result in emitting:
> [14:22:07.841547445] ust_baddr:push: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000, sopath = "/path/to/plugin1.so", size = 21968, mtime = 1377519722 }
> ..likewise sometime later a corresponding dlclose in the program will result in emitting:
> [14:22:07.841867307] ust_baddr:pop: { cpu_id = 4 }, { baddr = 0x7F8D13DFD000 }
> 
> *) ust_baddr:init with TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime)
> 
> In contrast, ust_baddr:init tracepoints are only emitted when a userspace application gets a "session enabled" sent by the sessiond (necessary if tracing starts in the middle of an already running application). In this case all the currently loaded shared objects are iterated and the base address mappings are recored as ust_baddr:init events with the same payload structure as ust_baddr:push. E.g.
> 
> [15:20:32.763114409]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAC083000, sopath = "/lib64/libc-2.17.so", size = 1992089, mtime = 1359709982 }
> [15:20:32.763118346]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAEAF0000, sopath = "/lib64/ld-2.17.so", size = 163493, mtime = 1359709980 }
> [15:20:32.763125921]  ust_baddr:init: { cpu_id = 1 }, { baddr = 0x7F5BAAE7C000, sopath = "/other/currently/loaded/shared-object.so.0.0.0", size = 58359, mtime = 1377516019 }
> ... and so on for all other currently loaded shared objects
> 
> I have attached sample traces to demonstrate how this looks in practice.
> 
> 
> The known deficiencies of the current implementation are:
> 
> *) Currently there is no way to disable the mechanism. I don't like the idea of using an environment variable for that (doesn't allow to enable for already running applications). Having this controllable via lttng commands would be preferable. But maybe it's not a real issue. The events a comparably low-frequency.
> 
> *) For ust_baddr:init I had to hook into lttng_session_enable/ust_listener_thread. Ideally this hook should be provided as API functionality, controllable via lttng commands. For example:
> 
>    lttng on-session-enable shared_obj_state_dumper.so
> 
> The requirement of dumping state information on session_enable is generic enough that other instrumentations could also benefit from it (e.g. stack dump for liblttng-ust-cyg-profile/liblttng-ust-cyg-profile-fast).
> 
> --
> Looking forward to your comments,
> Paul
> 
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> From 3fb50c1e8503963980f68223b4b810e792dfee66 Mon Sep 17 00:00:00 2001
> From: Paul Woegerer <paul_woegerer@mentor.com>
> Date: Thu, 22 Aug 2013 14:43:40 +0200
> Subject: [PATCH 1/2] Basic support for base address tracing
> 
> ---
>  Makefile.am                          |  1 +
>  configure.ac                         |  1 +
>  include/lttng/tracepoint.h           | 50 ++++++++++++++++++++++++
>  liblttng-ust-baddr/Makefile.am       | 17 ++++++++
>  liblttng-ust-baddr/lttng-ust-baddr.c | 74 +++++++++++++++++++++++++++++++++++
>  liblttng-ust-baddr/ust_baddr.h       | 76 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 219 insertions(+)
>  create mode 100644 liblttng-ust-baddr/Makefile.am
>  create mode 100644 liblttng-ust-baddr/lttng-ust-baddr.c
>  create mode 100644 liblttng-ust-baddr/ust_baddr.h
> 
> diff --git a/Makefile.am b/Makefile.am
> index dc88c46..f9fcbf3 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -4,6 +4,7 @@ SUBDIRS = . include snprintf libringbuffer liblttng-ust-comm \
>  		liblttng-ust \
>  		liblttng-ust-ctl \
>  		liblttng-ust-fork \
> +		liblttng-ust-baddr \
>  		liblttng-ust-libc-wrapper \
>  		liblttng-ust-cyg-profile \
>  		tools \
> diff --git a/configure.ac b/configure.ac
> index 94f8182..a29ac48 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -282,6 +282,7 @@ AC_CONFIG_FILES([
>  	liblttng-ust/Makefile
>  	liblttng-ust-ctl/Makefile
>  	liblttng-ust-fork/Makefile
> +	liblttng-ust-baddr/Makefile
>  	liblttng-ust-java/Makefile
>  	liblttng-ust-libc-wrapper/Makefile
>  	liblttng-ust-cyg-profile/Makefile
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index b3b01cc..462ab52 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -219,6 +219,21 @@ struct tracepoint_dlopen {
>  
>  extern struct tracepoint_dlopen tracepoint_dlopen;
>  
> +#ifndef LTTNG_UST_BADDR_PROVIDER
> +/*
> + * shared object base address handling (callbacks). Hidden visibility:
> + * shared across objects in a module/main executable.
> + */
> +struct baddr_dlopen {
> +	void *liblttngust_handle;
> +
> +	int (*push_baddr)(void *ctor_addr);
> +	int (*pop_baddr)(void *ctor_addr);
> +};
> +
> +extern struct baddr_dlopen baddr_dlopen;
> +#endif
> +
>  #if defined(TRACEPOINT_DEFINE) || defined(TRACEPOINT_CREATE_PROBES)
>  
>  /*
> @@ -232,6 +247,10 @@ int __tracepoint_ptrs_registered
>  	__attribute__((weak, visibility("hidden")));
>  struct tracepoint_dlopen tracepoint_dlopen
>  	__attribute__((weak, visibility("hidden")));
> +#ifndef LTTNG_UST_BADDR_PROVIDER
> +struct baddr_dlopen baddr_dlopen
> +	__attribute__((weak, visibility("hidden")));
> +#endif
>  
>  #ifndef _LGPL_SOURCE
>  static inline void lttng_ust_notrace
> @@ -383,6 +402,24 @@ __tracepoints__ptrs_init(void)
>  				__stop___tracepoints_ptrs -
>  				__start___tracepoints_ptrs);
>  	}
> +#ifndef LTTNG_UST_BADDR_PROVIDER
> +	if (!baddr_dlopen.liblttngust_handle)
> +		baddr_dlopen.liblttngust_handle =
> +			dlopen("liblttng-ust-baddr.so.0", RTLD_NOW | RTLD_GLOBAL);
> +	if (!baddr_dlopen.liblttngust_handle)
> +		return;
> +	baddr_dlopen.push_baddr =
> +		URCU_FORCE_CAST(int (*)(void *),
> +				dlsym(baddr_dlopen.liblttngust_handle,
> +					"push_baddr"));
> +	baddr_dlopen.pop_baddr =
> +		URCU_FORCE_CAST(int (*)(void *),
> +				dlsym(baddr_dlopen.liblttngust_handle,
> +					"pop_baddr"));
> +	if (baddr_dlopen.push_baddr)
> +		baddr_dlopen.push_baddr(
> +				URCU_FORCE_CAST(void *, &__tracepoints__ptrs_init));
> +#endif
>  }
>  
>  static void lttng_ust_notrace __attribute__((destructor))
> @@ -394,6 +431,19 @@ __tracepoints__ptrs_destroy(void)
>  
>  	if (--__tracepoint_ptrs_registered)
>  		return;
> +#ifndef LTTNG_UST_BADDR_PROVIDER
> +	if (baddr_dlopen.pop_baddr)
> +		baddr_dlopen.pop_baddr(
> +				URCU_FORCE_CAST(void *, &__tracepoints__ptrs_init));
> +	if (baddr_dlopen.liblttngust_handle) {
> +		ret = dlclose(baddr_dlopen.liblttngust_handle);
> +		if (ret) {
> +			fprintf(stderr, "Error (%d) in dlclose\n", ret);
> +			abort();
> +		}
> +		memset(&baddr_dlopen, 0, sizeof(baddr_dlopen));
> +	}
> +#endif
>  	if (tracepoint_dlopen.tracepoint_unregister_lib)
>  		tracepoint_dlopen.tracepoint_unregister_lib(__start___tracepoints_ptrs);
>  	if (tracepoint_dlopen.liblttngust_handle && !__tracepoint_registered) {
> diff --git a/liblttng-ust-baddr/Makefile.am b/liblttng-ust-baddr/Makefile.am
> new file mode 100644
> index 0000000..6fdfda1
> --- /dev/null
> +++ b/liblttng-ust-baddr/Makefile.am
> @@ -0,0 +1,17 @@
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> +AM_CFLAGS = -fno-strict-aliasing
> +
> +lib_LTLIBRARIES = liblttng-ust-baddr.la
> +liblttng_ust_baddr_la_SOURCES = \
> +	lttng-ust-baddr.c \
> +	ust_baddr.h
> +liblttng_ust_baddr_la_LIBADD = \
> +	-L$(top_builddir)/liblttng-ust/.libs \
> +	-llttng-ust
> +
> +if LTTNG_UST_BUILD_WITH_LIBDL
> +liblttng_ust_baddr_la_LIBADD += -ldl
> +endif
> +if LTTNG_UST_BUILD_WITH_LIBC_DL
> +liblttng_ust_baddr_la_LIBADD += -lc
> +endif
> diff --git a/liblttng-ust-baddr/lttng-ust-baddr.c b/liblttng-ust-baddr/lttng-ust-baddr.c
> new file mode 100644
> index 0000000..bcfc9df
> --- /dev/null
> +++ b/liblttng-ust-baddr/lttng-ust-baddr.c
> @@ -0,0 +1,74 @@
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> + */
> +
> +#define _GNU_SOURCE
> +#include <dlfcn.h>
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include "usterr.h"
> +
> +#define TRACEPOINT_DEFINE
> +#define TRACEPOINT_CREATE_PROBES
> +#include "ust_baddr.h"
> +
> +int push_baddr(void *ctor_addr)
> +{
> +	Dl_info info = { 0 };
> +	if (!dladdr(ctor_addr, &info))
> +	{
> +		ERR("dladdr failed for addr %p", ctor_addr);
> +		return 0;
> +	}
> +
> +	char resolved_path[PATH_MAX];
> +	if (!realpath(info.dli_fname, resolved_path))
> +	{
> +		ERR("could no resolve path %s", info.dli_fname);
> +		return 0;
> +	}
> +
> +	struct stat sostat;
> +	if (stat(resolved_path, &sostat))
> +	{
> +		ERR("could no access file status for %s", resolved_path);
> +		return 0;
> +	}
> +
> +	tracepoint(ust_baddr, push, info.dli_fbase, resolved_path, sostat.st_size, sostat.st_mtime);
> +	return 0;
> +}
> +
> +int pop_baddr(void *ctor_addr)
> +{
> +	Dl_info info = { 0 };
> +	if (!dladdr(ctor_addr, &info))
> +	{
> +		ERR("dladdr failed for addr %p", ctor_addr);
> +		return 0;
> +	}
> +
> +	tracepoint(ust_baddr, pop, info.dli_fbase);
> +	return 0;
> +}
> diff --git a/liblttng-ust-baddr/ust_baddr.h b/liblttng-ust-baddr/ust_baddr.h
> new file mode 100644
> index 0000000..635c678
> --- /dev/null
> +++ b/liblttng-ust-baddr/ust_baddr.h
> @@ -0,0 +1,76 @@
> +#undef TRACEPOINT_PROVIDER
> +#define TRACEPOINT_PROVIDER ust_baddr
> +
> +#if !defined(_TRACEPOINT_UST_BADDR_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
> +#define _TRACEPOINT_UST_BADDR_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * Copyright (C) 2013  Paul Woegerer <paul_woegerer@mentor.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + */
> +
> +#include <stdint.h>
> +#include <unistd.h>
> +
> +#define LTTNG_UST_BADDR_PROVIDER
> +#include <lttng/tracepoint.h>
> +
> +TRACEPOINT_EVENT(ust_baddr, init,
> +	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +		ctf_string(sopath, sopath)
> +		ctf_integer(int64_t, size, size)
> +		ctf_integer(int64_t, mtime, mtime)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_baddr, push,
> +	TP_ARGS(void *, baddr, const char*, sopath, int64_t, size, int64_t, mtime),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +		ctf_string(sopath, sopath)
> +		ctf_integer(int64_t, size, size)
> +		ctf_integer(int64_t, mtime, mtime)
> +	)
> +)
> +
> +TRACEPOINT_EVENT(ust_baddr, pop,
> +	TP_ARGS(void *, baddr),
> +	TP_FIELDS(
> +		ctf_integer_hex(void *, baddr, baddr)
> +	)
> +)
> +
> +#endif /* _TRACEPOINT_UST_BADDR_H */
> +
> +#undef TRACEPOINT_INCLUDE
> +#define TRACEPOINT_INCLUDE "./ust_baddr.h"
> +
> +/* This part must be outside ifdef protection */
> +#include <lttng/tracepoint-event.h>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division

--------------030100080604040005020200
Content-Type: application/pdf; name="base_address_recording_prototype.pdf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="base_address_recording_prototype.pdf"

JVBERi0xLjQKJeLjz9MKNSAwIG9iaiA8PC9UeXBlL1hPYmplY3QvQ29sb3JTcGFjZS9EZXZp
Y2VHcmF5L1N1YnR5cGUvSW1hZ2UvQml0c1BlckNvbXBvbmVudCA4L1dpZHRoIDY3NC9MZW5n
dGggMzk5L0hlaWdodCA1NzgvRmlsdGVyL0ZsYXRlRGVjb2RlPj5zdHJlYW0KeJztwQEBAAAA
gqD/q21IQAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA8GoMESsRCmVuZHN0cmVhbQplbmRvYmoKNiAwIG9iaiA8PC9UeXBlL1hPYmplY3Qv
Q29sb3JTcGFjZS9EZXZpY2VSR0IvU01hc2sgNSAwIFIvU3VidHlwZS9JbWFnZS9CaXRzUGVy
Q29tcG9uZW50IDgvV2lkdGggNjc0L0xlbmd0aCAyMzcxOS9IZWlnaHQgNTc4L0ZpbHRlci9G
bGF0ZURlY29kZT4+c3RyZWFtCnic7d0NeBTVof/xoIEASQggGhQUCFQEaYP0thILKFTkRRAS
a+FaEMu14OVFKBKsVluQgvcqhOr9C1GupfQKJQQQxGKrVCtYQA0SQQqCIkTeQhJC3sh78j9k
ZBx3ZyebZHdnzpnv59mHZ5idOTM758z57WR2ZmprAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAACAX/Ly8uxeBQAAgiKsTkPfctoiGl3snDlzIiMjA76UMEv+TyMv22s2
sMvyNQwADufylG/KCpDyFmyv2cAui5QHICl7U952QUr5hk7m5E3kKE5IeQCQiP8pf+TIkTFj
xkRFRUVHR48dO/aLL74wTmzxrrGcmpqaKVOmtG/ffv78+bVmHelHH310xx13tGrV6qqrrnr4
4YeLi4v1cj788MPbbrstMjKyT58+f/7zn/1cc4tiTY+drT+mn5uuoZP5miaA26SiomLOnDlx
cXERERE9evR4+umnq6qq9HdPnDhx3333xcTEiE/905/+9PTp0/7MaPGW/1u13s/ovUEKCwsn
TpwoSouNjZ09e/bFixf1CV577bXBgweLD9K8efMbbrjhkUceKSoq8nNBe/fuvf3228XGFBOI
LeAr5YPUaAEgGPzMypMnT1599dXGWOzYseOZM2f8eVcvR0TAAw88IIZ/8YtfaHHg3WGKFDCW
M2vWLO3drKws0XWHeal3zS2K9S7H+oP4v+kaOpmvaQK4TUQaekz25JNPam/l5eVdf/31xrd6
9uxZUlJS74wWb/m/Va0/o+kGGT58uHFiEeXau6tXr/beGuL7gD8LOn78uHFjiq8Kxo9gPRyQ
CgKAYPDugkx7pBkzZojhf/u3f/uiTr9+/cR/xUh/3tXKqaysHDduXJghCGrNOsz+/ft/+umn
4vhLTCb+e80112jvaoEiSj527Jg4MIyPj7foMP0v1qMQ6w9isZR6t3DjpgngNtGS6P333y8v
L09PTxfDnTt31t6aN2+e+O+IESO++uorcQwrjrXFf5999tl6Z7R4y//GY/0ZTTfI97///YMH
DxYUFEydOlX8V3xF0d4VX07Ef1988UVxNF1WVvbuu++K/7Zt29afBWkreeutt4q4996Y1sMB
qSAACAbPUPeiTfad73xHDO/YsUP77z/+8Q/x3+7du/vzrlaOlh2///3vvZduHN67d6/238LC
QvHfK664Qvtv7969xX/fe+897b/vvPOORYfpf7EehVh/EIulWPBnMl/TBHCbXHfddeKtxMTE
devWVVRUGN/q1auXeEukm/ZfceitJVe9M1q85X/jsf6Mphvkww8/1P575swZ8d/mzZsbp/no
o49efvnladOm3XTTTeLdZs2a+bMg7RuC+Mai/Xf79u3ercjXcEAqCACCwc+sjIiICKs7H6r9
V+vNWrRo4c+7YQba6XjTRWjD4qjQ9N3WrVuLYf0cqziOa1DK+yrWoxDrD2KxFAv+TOZrmgBu
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
CqASETxnnnlGf5q897sBT3mNxV1xNPoT50//7nfes/fq1cvPT+f/lE0RFhbWlNnXrFkjSli7
dm2g1scDKQ8ArhXiY3kj0zvcaqyP5f1P1Sbmb2gk1klKSgpS+aS82rgISwFUIoInZOflfTE+
rUann5d/6+GHmzdvHh4eHh8fv2PHjtq64NaI4T179iQkJERGRl577bWrV6/W5hVvLVy4sG/f
vsYpdZs2bfIoUCgoKBAhGxMTM3bs2MLCQospTUfqi8jLyxs1alR0dPTo0aPPnz+vv5uSkhIX
FydmFLN7fPzi4uJ27dqdOnWqbdu2JSUl9W6uRiDl1cYpXQVQiQie/I0bg/0be394POhE/439
0CuvXL58eVVVVXp6eo/LN+DVU7VXr14bNmwoLS195ZVXOnTooL8rZrlw4UKt2bG8iFrvAmfN
mrV//35Rztq1a5OTky2mNB2pL2X69OnPP/98UVGRiPVp06bp786YMUOkufYNwWN91q9fP7Lu
MbvDhw8XZfq5uRqElFcbAaEAKhHB88318jfe6P1uyFLew4EePbS1mpCQkJiYuH37duNxrnd2
V1RU6CPFQHZ2tq8phw4d6l1gly5dKisra+su+hMH3RZTmo7Ul9K1a1ftEF4c1Hfu3Nmf9Rk3
blxq3XUEK1asGD9+vD8bp6FIebUREAqgEhE839z7Ljy82usvxrakfHVxsViZSyl/xRXZX301
aNCgFi1aREZGZmRkaBPoWZmbm7tw4cKkpKRu3boZU17/y4B3qp47d867wIiICP3P++ItiylN
R+pLEeVUV1fX1n1b0A/bjevgsT6lpaVRUVH6oqOjo8WYRmwxa6S82ggIBVCJCCr9PvYFb73l
8ZYtKe99H3uRfStXruzYsaP2Xz0rBwwYMH/+/G3bth06dMiY8npRvn5951Fgp06dKioq/JnS
en3E8XtRUVFt3deP2NjYetdn8+bNQ4YM0f87ePDgLVu2mK5GU5DyauMiLAVQiQiqb55J9/jj
Hm/ZkvLGZ9L17t07LS2tsrLSeFJbDJw9e1YMxMTEiAPq/Pz8yZMnm6a8PqXOtMCpU6dmZmaW
lZWlpqYmJCRYTGk6Ul/ilClTVq1aVVxcnJKSMmnSJO/18Uj5CRMmrFu3Tv/vmjVrJk6c2Igt
Zo2UBwA3y9+y5Zvny3/7V3A2pHxNzYFu3b5+vvzWrbt3746Pjw8PDzf+QH3cuHGtW7cWAxs3
buzZs6c4Ehepapry+pQ60wLz8vLGjBkTFRXVr1+/gwcPWkxpOlJfYk5OzsiRIyMjI4cNGyaG
vdfHOFxeXt69e3fjfXtKS0vj4uICficfUl5tXISlACoRQVVTVravbVstWIt37TK+FfqUL9qx
Q1uTzPbta7hzXSCQ8mrjlK4CqEQE2/EpU7RsPfbtn3mHPuW/uO8+bU3EKgXu87kaKa82AkIB
VCKCreTjj7/+pf2VV5YZevUQp3zpZ59l1D1ZXqzMxczMQH9KlyLl1UZAKIBKRAgcHTFCO4gW
R9P6yBCn/Odjx359i5677w7053MvUl5tBIQCqESEQPGePdrhvPGSulCmfMHf/qYtXayGWJng
fEo3IuXVxkVYCqASERpfTpqk5ez+Ll2q6u7hFrKUF4sTC9WW/uXPfx7MT+k6UqR8oJ4rZHqp
RYjt2rWrb9++rVq16t+//+HDh+1aDQDwUHHmTGb79lrUfp6UVFtTE6KUr6n5PDHx65/WX3VV
5blzQf6g7uKqlA9egf678cYbX3/99YsXLy5evHjAgAHBXhwXYSmASkTI5G/erP/d/uSvfhWa
lNefJi8WfeH114P9Gd3GxpS3foRf7bcPvfft29e7d++77rpLf5yf6exHjhy5+eabr7766jfe
eEOfV3sKYb0Fmj58UOfrEYdpaWliloEDBxqfR+A90ltJSYkorRHbrUE4pasAKhGhlPXII19n
bljY7kceCXbKn01J0Rf31S9/GYIP6DY2prz1I/xqvx3KDzzwQHFx8bZt2/TH+ZnOLmL6ueee
E02re/fu+rzeTyE0LdD04YM6X484FOWIwpctWzZ58mSLkd6ysrL69evXiO3WIASEAqhEhFJN
VdXn99yjJ+/W0aODl/KnfvMbfUFioWLRofmMrmJjyls/wq/226F87NgxMXDx4sXrr7/eYnaR
v+e+fU7H9Kl/pgWaPnzQm8cjDrUtkJeXZ3xygfdIb4sWLdJvkBg8BIQCqESEWHVJyeEf/UjP
3w3fu/GWuzsENuWri4qOjR+vL+LwgAHeT8RDQNiY8taP8Kv9dihrz+Orrq5u2bKlxezh4eFV
3/42aPoUQtMCTR8+qPP1iEPtnsMezxn0Hulh//79c+bM8XtTNR4BoQAqEaEnMvfI8OF6Cm+J
Dr97ULtApXzx7t2f3nSTXvjRu+8m4oPH9l/f+XqEX05OjjFM33vvvdq6c9kiZC1mv+aaa0Qc
Gyfw9bXBu0CLhw/W+n7E4cmTJ2vrvgPofxMwHWmUlZX10EMPlZWVWW6YwOAiLAVQibBFTXn5
B2PG6Fn8UbOwZ7u26j/8qqakfMWZM5fupqvd4K7udWLq1BrfHS+azsaU9/VIQfFfEb6zZ882
humtt95aVFS0efPmRx991GL2e++998UXXxQJbjwvry/RukDThw/qfD3icPr06YWFhUuWLJk5
c6bFSN2uXbtGjBhREogvruJbxAdN4PF1CAA8iJje8OCDe5qH66G868pmi+Na/fjH7Rua8qWH
DmXNnPlxq1Z6UR9HRua9+qqNn84lbEx500f4aZHdrl27FStWGMNU5O9NN92UmJio//rddPYj
R4706dMnNjZWHHTr8+pLtC7Q9OGDOl+POFy6dKmYRcxYUFBgMVIXFxcXZtDorVdbV3evLFmy
Zu7cDZMmvTZ+/JbERPESA+K/YqR46yVL3NFIFlxJB7uImBZ9xZOzJq6MbaGns/Za17753Jsj
R9zRrvc9vlN+x46SvXvP/Pd/H0pI8Jj96OjR5ceP2/35XCFkKV/z7ccWq8E0poN9MX5ldnbO
yy8fGz9+b4cOHjuO56tDh73Dh3/829/u+/vf9xls2LCBlJcI5+VhFy3lf/nbaT3vuWr8rdHr
24Z79zPvhzdLbxv+QueI/+rWav53WouXGNj43e/s6NIlw3Dkrr8O/fCHFy4fhSEEQpDyJ06c
EFOePn26USvoaCFN+ZoasWt8PmbM3ubN6wl3r5eYRcyo71ncnVgupDzsYkx57fXT/m1SO7bY
fUWzBvdCERFf/OQnBX/7m92fyXWCmvJnz5794x//OHfu3OTkZCVTPmTyN2/+1y23eO84H7Rs
+cFNNx2bMOHEtGknH3tMvMTAsZ/97NAPfrAvOtp7+n99//v5W7aQ8nIh5WEX75TXXt8f0X5K
36jfd47Y3vIK63D/5LrrRAeV+8c/Vubl2f1pXCpIKX/+/Pm0tLR58+bNrUPKN1rZF1/oT4TU
bwJ5eMCAs0uXHt669eWXXnrnnXfM56yuLtm37+ySJd5nxPb07//HRYtIeVmQ8rCLr5T/VuIP
b3/PgJiHboma8b3Iub1bi5cYeCHxx2vmzfvnX/5i9ydA4FO+qKjo9ddff/zxx+cakPKNk7tq
1cetW3/zk9TWrb+aM6fs88+1d8XGf/nll32mvEHZ0aNZs2cbi/qwRYuD//3fQV59BAZX0sEu
/qS86UvMImZs6PPlbaR1jHavhflqNHHdApjypaWlb7311pNPPjnXCynfUDXl5V8++OA3p7Su
vDJr5szKb98V3/+U14jZT0ybZrxS9fh//EdN3Q18AMCbe1LeIRyb8pWVlTt37lywYIF3vpPy
jVBdXHzkzjv1LD7Yp0/J5Zv7GTU05TXFH374YbdueuFHhg0TiwvQiiMouJIOdglSytdUVn71
6KOZ7dt/ct11p556qra6uvZylp1fv/7QD3+4/4YbLvj+a3/J3r2HBw7cFx29LybmyPDh5V9+
eanMioqT8+Z9Ehv7SadOJx97rKbuduWmU5qO1JO0ietmuhqms5d98cWRu+7a16bNxy1bHoyP
L3jrLX3K7GXLxOwiBbSH8H6zbmaF16uJKX/kyJGMjIzFixf7ync01GOzZv31uuv0FE7v0+dX
s2cnm3n66acbkfLCu2+++Vb//voiDv/oR9xe0sk4Lw+7BCnlTy9ceCnLXngh+/e/FwNnly6t
vZxlWbNnF/ztb2LgwOU7m3n79MYbxQSlhw8X/PWvly7N699fjDyzaJEYPrdiRe4f/iAGLgW0
jylNR+pJ2sR1M10N09nFcvP+/GcR3OIgTowU6a9PeWL69HPLl1/6c2vd8870dTMtvF6kvKMk
P/rolh499PxdNXCgab43MeXFLGLGT2fP1hfE06CcjJSHXYKU8gfq/pwoDlQrs7PFwKc9e9Ze
zrLK3Nya8vJLw1dc4WutxMHspT9yxsfnrFypH6Ec+M53tNmri4ouJWndE8dMpzQdqSdpE9fN
dDV8zV68Z89Xc+Yc7NNHOy37zZRi6Tk5l65Q6NTpW+tmVni9+Iu9o2TNnKknb/bzz1tP3Li/
2NdeTnkxe/ayZfrish55pLFrjeAi5WGXIKX83haX7qRXU1kpXtrvimu/ffbZ+kz0+XXr9rVp
o02T2b79+fR0MfLjli313uxSaIaH+5rSdKS+xCaum+lqmM6e/cILYuDoiBHFu3bpI7UBccyl
LX1vRIRxFtPC68Wv75xDNDa9+k7+6lf1Tt/0lBfDYkH6QvOD/yRcNAIpD7sEKeX3d+2qHbFW
nD176Xi5V6/ahiSpUH3xYv5rrx27/34tqS+V2aWLGK7yuqm495SmI/UlNnHdTFfDdPaPo6K0
KcXLI+UvHcvn5nr8Gd/iM1rjSjqHqDhzZl+7dlptfnHffbV+3BA4ICkvFvTFvfdqyxUrIFaj
ESuPoOJKOtglSCl/8oknMgznvsVAbUOS9PBtt4l3C95+++KBAxl1v082lln4j3+Igc9uv93X
lKYj9SU2cd1MV8N0di2yxWqceeYZj5T/6pe/zHnpJTFwYto003UzFl4v7orjENq3yktf3rp2
rbpwwZ/b/gcm5Wtrq/Lzta+v4vXlpEkNLQ2AqoL1G/vy8qxZs7TfsZ9esMD4O3ZtAuskrTh5
8vMxY/a1bSsOhz8bPFiE9aUyy8pEJooyP46MPHr33RV1iWM6pelIfYlNXDfT1TCdPX/Tpku/
lu/Y8dIFzt9O+bxXX828+urPhgypzMn51rqZFV4v7nDrBEX//GdGs6/vC11Yl9qHDh3661//
KjZvle8fxQUq5QXxfTLj8o31ivfsadynQJBwJR3swvXyCuBpNU5wZNiwb/5WX+fAgQPLli37
9a9/vWbNmqysLNND+wCmvCAWra3D0ZEjG/cpECScl4ddbE9544/N9FdAPlrTOXndjHjyrO1K
Pv5Y/8Fk2RdfaCO1lNeumPvNb36zYcOGM15nzAOb8mVHj+698krtcL6Es8BOQsrDLranPJou
ZCkPX44/9JCW8sfuv18faUx5/er4N954I6fuNI0msCkvfDFunLYmx6dMafTHQcCR8rALKa8A
Ut5eNWVl+9q21bK1ePdufbx3ymsWL168ffv2/Pz82iCkvH7ZZmb79tzf3jlIediFlFcAKW+v
/Nde04L1QI8exvG+Ul7z3HPP7dy5c/fu3SKs09PTP2ggMYuY0eTirJqaA3Fx2vpceP310G0F
WOJKOtiFlFdAE1P+vffeW758eUBv8uoua/v101L1T/37W9zM1tu8efPE14CXm8B0Bzw5b562
PlmzZgWifQGQGCmvAFLeXtuvvlpL1SXjxjUu5X+3ZMHEOUkNeolZfKW89viGjLqbPAeifSEA
uJIOdiHlFcBf7G1UXVKiXSa/t3nz6osXjW/58xf7d999V4T1nPnTe425ukEvMYuvlK8uLt4b
Hp5R9zyF6tLSUG0JWOG8POxCyiuAlLfRxU8+0Q6ctcceGfnz6zuxBwU85S8t+vJD8cTqBX0T
wA+kPOxCyiuAlLeR/niao6NGebzlz5V0QUr5oyNHamuVv3FjED88/EbKwy6kvAJIeRudW75c
y9MTU6d6vOXPXXGClPLHf/ELba3OpaYG5WOjgUh52IWUVwApb6Ozzz779ROIHn3U4y1/7nAb
pJT/as4cba3OPvdc4D8zGo4r6WAXUl4Bjk35cr/vyuL/lE6jP3DQ+2ny/jytJkgprz9x/vTv
fhfITwtANqS8Ahyb8r169Qr4lE0R1rTHEIhDclHC2rVrjSMtjuX9ue0/x/IuwZV0sAsprwDH
prz/qdrE/A2NxDpJSUnGkRbn5f3BeXmX4Lw87ELKK8AJKb9p06bmzZuHh4fHx8fv2LGjti64
NWJ4z549CQkJkZGR11577erVq7VZxFsLFy7s27evcUqLAoWCggIRsjExMWPHji0sLLSY0nSk
voi8vLxRo0ZFR0ePHj36/Pnz+rspKSlxcXFiRjG7xwcsLi5u167dqVOn2rZtW1JSoo/P37jR
12/s/cFv7F2ClIddSHkFOCHlRTIuX768qqoqPT29x+Xbueup2qtXrw0bNpSWlr7yyisdOnTQ
3xWzXLhwodbsWN60wFmzZu3fv1+Us3bt2uTkZIsprddn+vTpzz//fFFRkYj1adOm6e/OmDFD
pLn2DcFjfdavXz+y7qHtw4cPF2Xq47+5Xv7GGxux3YJ+vfyBA41YKwQcKQ+7kPIKcELKDx06
NDExcfv27cbjXO/srqio0EeKgezsbF9TmhbYpUuXyspKMSDiWxx0W0xpvT5du3bVDuHFQX3n
zp39WZ9x48al1v31e8WKFePHj9fHf3Pvu/DwasOy/BSMlOfedw5EysMupLwCnJDy586dGzRo
UIsWLSIjIzMyMrSRelbm5uYuXLgwKSmpW7duxpTXf5/mnaqmBUZEROh/3hdvWUxpvT6inOrq
6tq6bwv6YbtxHTzWp7S0NCoqSl90dHR0qSE9D373u9qBc8FbbzV0uwUj5bmPvQNxJR3sQsor
wAkprxHZt3Llyo4dO2r/1bNywIAB8+fP37Zt26FDh4wpr8/o69d3HgV26tSpoqLCnymt10cc
vxcVFdXWff2IjY2td302b948ZMgQ/b+DBw/esmWL/t+smTO/vpju8cdN181CMFKeZ9IB0JHy
CnBCyvfu3TstLa2ystJ4UlsMnD17VgzExMSIA+r8/PzJkyebprw+pXWBU6dOzczMLCsrS01N
TUhIsJjSdKS+xClTpqxataq4uDglJWXSpEne6+OR8hMmTFi3bp3+3zVr1kycOFH/b/6WLd88
X96Pq+eMAp/yNTUHunX7+vnyW7c2aGUQPFxJB7uQ8gpwQsrv3r07Pj4+PDzc+AP1cePGtW7d
Wgxs3LixZ8+e4khcpKppyutTWheYl5c3ZsyYqKiofv36HTx40GJK05H6EnNyckaOHBkZGTls
2DD9rvK+Ur68vLx79+7G+/aUlpbGxcXpY2rKyva1basFa/GuXQ3abgFP+aIdO7Q1yWzfvkba
ew2ph/PysAsprwAnpLzLHZ8yRcvWY4Yf5vkj4Cn/xX33aWsiVilwnw9NRcrDLqS8Akh525V8
/PHXv7S/8sqyhmzPwKZ86WefZVxxxaWUb9bsYmZmoD8lGo+Uh11IeQWQ8k5wdMQI7SBaHE37
P1dgU/7zsWO/vkXP3XcH+vOhSUh52IWUVwAp7wTFe/Zoh/MNuqQugClf8Le/aUsXqyFWJjif
Eo3ElXSwCymvAFLeIb6cNEnL2f1dulRdvnGutUClvFicWKi29C9//vNgfkoAMiHlFUDKO0TF
mTOZ7dtrUft5UpI/V9UFJuVraj5PTPz6p/VXXVV57lzQP2rTaKtq91qYr0aQ1o0r6WAXUl4B
pLxz5G/erP/d3vuJ894CkvL60+TFoi+8/nrwP6UiQpnynJeHXUh5BZDyjpL1yCNfZ25YWPay
ZdYTNz3lz6ak6Iv76pe/9F5ETWXlV48+mtm+/SfXXXfqqadq627tq01/fv36Qz/84f4bbrjw
l7/4WsOSvXsPDxy4Lzp6X0zMkeHDy7/88lKZFRUn5837JDb2k06dTj72WE3dwwVMpzQdqSdp
E9fNdDVMZy/74osjd921r02bj1u2PBgfr/1wQq8jMfuRO+/U/gbyzbqZFd5opDzsQsorgJR3
lJqqqs/vuUdP3tPz51tM3MSU3/Pzn+sLEgsVi/ZexOmFCy9l2QsvZP/+92Lg7NKltZezLGv2
bO03ewe6d/e1hp/eeKOYoPTwYe32+If69xcjzyxadOnh9StW5P7hD2LgUkD7mNJ0pJ6kTVw3
09UwnV0sN+/PfxbBXZKRcemHEzfcoE95Yvr0c8uXX7rDwOTJxnUzLbzRSHnYhZRXACnvNNUl
JYd/9CM9f4/97GfVdbfN99bolJ/3xJS3f/ADfRGHBwzw9UQ87Ya34kC1Mjv70hNye/asvZxl
lbm5NeXl2tPrfH0WcTCrPfgmZ+VKfREHvvMdbXbxuS4lad3zAU2nNB2pJ2kT1810NXzNXrxn
z1dz5hzs00e7rcE3U4ql5+SIAXHM/q11Myu80Uh52IWUVwAp70Ai0Y4MH66n8MGbby42+/FV
41J+9KC273Ropxd+9O67LR56u7dFCzFNTWWleImBj+vuJGw8+2x9Jvr8unX72rTJuHzX3PPp
6WLkxy1b6kvPqHvqrq8pTUfqS2ziupmuhuns2S+8cGlDjRhRvGuXPlIbqKmq0pa+NyLCOItp
4Y3GlXSwCymvAFLemcSx5ImpU79JiiuuOPHwwxXffihPQ1O+//Crnuva8qNm36SPWESNj+f0
afZ37aodsYpFXzpe7tWrtiFJKlRfvJj/2mvH7r9fS+pLZdZdtVdVUFDvlKYj9SU2cd1MV8N0
9o+jorQpxcsj5S8dy+fmevwZ3+IzAnIh5RVAyjtZ7h//KA5R9VD+uFWrrJkzSw8d0t71P+V/
/OP2i+Na7bqymV7UhxERu3/zm3pX4OQTT2QYzn2LgdqGJOnh224T7xa8/fbFAwcu/VGiTx9j
mYX/+IcY+Oz2231NaTpSX2IT1810NUxn1yJbrMaZZ57xSPmvfvnLnJdeuvR9ado003UzFt5o
XEkHu5DyCiDlHa78yy+Pjhpl/POveB1KSDj77LO7/vCHl196yVfK977n6hF3tJvbO3Jd++Ye
s2++seuqxYv92QFrysuzZs3Sfsd+esEC4+/YtQmsk7Ti5MnPx4zZ17atOBz+bPBgEda1dY/h
E5koyvw4MvLo3XdXnD7ta0rTkfoSm7hupqthOnv+pk2Xfi3fsaOY3iPl8159NfPqqz8bMqSy
7umE36ybWeGNxnl52IWUVwApL4ULW7f+69/+zSOstUPyt667+oXOEf/VrdX877QWLzHwP50j
0tuGvx/ezHv6tHbhP+3fhh1QLqQ87ELKK4CUl0jBm29+Pnbs3ogI7/i2fu2+otny61r8JKFN
8HZA0+UGsPymcPK6+YOUh11IeQWQ8tKpzMvL/cMfjk2Y8NFVV1mH+9str/h954iHbon6/oj2
7IDyIuVhF1JeAaS8vMQe9EpKyuKfJ4ocn/G9yLm9W4uXGPiPflGjB8R8f3h7dkA1cCUd7ELK
K4CUlxc7IICgopNRACkvL3ZAl+BKOtiFTkYBpLy82AFdgvPysAudjAJIeXmxA7oEKQ+70Mko
gJSXFzugS5DysAudjAJIeXmxA7oEKQ+70MkogJSXFzugS3AlHexCJ6MAUl5e7IAAgopORgGk
vLzYAV2CK+lgFzoZBZDy8mIHdAnOy8MudDIKIOXlxQ7oEqQ87EInowBSXl7sgC5BysMudDIK
IOXlxQ7oEqQ87EInowBSXl7sgC7BlXSwC52MAkh5ebEDAggqOhkFkPLyYgd0Ca6kg13oZBRA
ysuLHdAlOC8Pu9DJKICUlxc7oEuQ8rALnYwCSHl5sQO6BCkPu9DJKICUlxc7oEuQ8rALnYwC
SHl5sQO6BFfSwS50Mgog5eXFDgggqOhkFEDKy4sd0CW4kg52oZNRACkvL3ZAl+C8POxCJ6MA
Ul5e7IAuQcrDLnQyCiDl5cUO6BKkPOxCJ6MAUl5e7IAuQcrDLnQyCiDl5cUO6BJcSQe70Mko
gJSXFzsggKCik1EAKS8vdkCX4Eo62IVORgGkvLzYAV2C8/KwC52MAkh5ebEDugQpD7vQySiA
lJcXO6BLkPKwC52MAkh5ebEDugQpD7vQySiAlJcXO6BLcCUd7EInowBSXl7sgACCik5GAaS8
vNgBXYIr6WAXOhkFkPLyYgd0Cc7Lwy50Mgog5eXFDugSpDzsQiejAFJeXuyALkHKwy50Mgog
5eXFDugSpDzsQiejAFJeXuyALsGVdLALnYwCSHl5sQMCCCo6GQWQ8vJiB3QJrqSDXehkFEDK
y4sd0CU4Lw+7yNjJhIWFBbacQBXYCLt27erbt2+rVq369+9/+PDhxhVCystLxh0QjUDKwy4y
djIBD2UbU/7GG298/fXXL168uHjx4gEDBjSuEFJeXjLugGgEUh52CXYnYwxQ47FzSkpKXFxc
8+bNN23apI0UA+K/4eHh8fHxO3bssJ593759vXv3vuuuu86fP28x+5EjR26++earr776jTfe
0OdduHChOHyut8CCgoKkpKSYmJixY8cWFhZ6fK49e/YkJCRERkZee+21q1ev1stJS0sTswwc
ODA7O9tipLeSkhJRmvXG9IWUlxcp7xKkPOxiV8rPmDGjuLhYi2ZtpBhYvnx5VVVVenp6jx49
rGd/4IEHxOzbtm2bNm2axewipp977jmxkt27d9fnFZNduHCh3gJnzZq1f//+0tLStWvXJicn
e3yuXr16bdiwQbz7yiuvdOjQwViOKHzZsmWTJ0+2GOktKyurX79+1hvTF1JeXqS8S3AlHexi
V8obD3W1gaFDhyYmJm7fvl0c1dY7+7Fjx8TAxYsXr7/+eovZRf6eO3fOY328F21aYJcuXSor
K8WA+OYQFxfn6wNWVFQYy9ESMy8vr2PHjhYjvS1atEj/s0ZDkfLyIuUBBJVdKe89UsTxoEGD
WrRoERkZmZGRYT27OIgWA9XV1S1btrSYPTw8XGS0x/rU1NT4U2BERETYZaJYj8+Vm5u7cOHC
pKSkbt26GcspLy+vrftioP+NwnSkh/3798+ZM8f0LX+Q8vIi5V2CK+lgl5ClfE5OjnXKa0Ta
rly50nggbDr7e++9V1t3LluErMXs11xzjYhj0/Wp/XbKexfYqVMncZzu63MNGDBg/vz527Zt
O3TokLGckydP1tZ9B9D/JmA60igrK+uhhx4qKyvztax6kfLyIuVdgvPysEuwOxnt93UiPWfP
nm2d8r17905LS6usrPQ4WW86+6233lpUVLR58+ZHH33UYvZ77733xRdfFAluPC/vvWjTAqdO
nZqZmSnCNzU1NSEhweNzxcTEZGRk5OfnT5482VjO9OnTCwsLlyxZMnPmTIuRul27do0YMcJ4
lqERSHl5kfIuQcrDLsHuZLTMbdeu3YoVK6xTfvfu3fHx8eHh4d4/vPeeXeTvTTfdlJiYqP/6
3XT2I0eO9OnTJzY2Vhx0WyzatMC8vLwxY8ZERUX169fv4MGDHp9r48aNPXv2FMf7KSkpxnKW
Ll0qZhEzFhQUWIzUxcXFhRkY39LPLNSLlJcXKe8SpDzsQicTQKbX3Tf6YvxDhw69+eabIoI9
flrgjZSXFzugS5DysAudTAAFNuUPHDiQkpLyxBNPvPrqq1lZWRaH9qS8vNgBXYIr6WAXOhnH
0lJ+bp2nnnoqPT39zJkzplOS8vJiBwQQVHQyjmVMec2CBQu2bt2ak5PjMSUpLy92QJfgSjrY
hU7GsbxTXrNo0aK33347Pz9fn5KUlxc7oEtwXh52oZNxLF8pr3n22Wd37txZVFRUS8rLjB3Q
JUh52KXpncznn3++fPlyX2GE4ElOTl62bNlHH3306aefkvKSIuVdgpSHXUh5eZHyCiDlXYKU
h13oZByLv9i7ATugS3AlHexCJ+NY/PrODdgBAQRVyDoZ/+/XCg1X0rkBKe8SXEkHu4Sgk8nK
ykpNTT19+nQIPo5KuCuOG5DyLsF5edglqJ1Mdnb26tWrtZwi5RuKO9y6ASnvEqQ87BKkTiY/
P3/9+vXz5s3T/9pMyjcUT6txA1LeJUh52CXgnUxxcfHWrVsff/xxj9+MkfINxZNn3YCUdwlS
HnYJYCdTVlb29ttvP/nkk6ZXfpHywUPKy4uUdwmupINdAtLJVFVViYEFCxZY3MKFlA8eUl5e
pDyAoGpiJ7Nz5869e/cuXrzYIt8RGqS8jEh5l+BKOtiFlFcGKS8jUt4lOC8Pu2RmZoq2t3jp
wofm3d+gl5hFzChmr+Uv9nbjL/byIuVdgpSHXbSAaDRjQPDrO7uQ8vIi5V2ClIddzp8/v883
rWVaTCBm9yiQK+lCj5SXFynvEqQ8nKnRLZO74oQSKS8vUt4luJIOztTElskdbkODlJcXKQ9A
dg16Wk15eXmw10c9pLy8SHmX4Eo6OFMAW6af92vt1atXQBYXKGFhYU2Zfc2aNaKEtWvXBmp9
TJHy8iLlXYLz8nCm0LfMJqaq0yTWSUpKCupSSHl5kfIuQcrDmYLaMjdt2tS8efPw8PD4+Pgd
O3bU1kW8Rgzn5eWNGjUqOjp69OjR+i/5xVtpaWkxMTEDBw7Mzs6ut0ChoKBAhKyYZezYsYWF
hRZTmo7Uv3X4Wp+UlJS4uDgxo5jdY32Ki4vbtWt36tSptm3blpSUBG7LeSLl5UXKuwQpD2cK
assUybh8+fKqqqr09PQePXpoI/VUnT59+vPPP19UVCRidNq0afq7DzzwwIULF5YtWzZ58mR/
Cpw1a9b+/ftLS0vXrl2bnJxsMWXj1mfGjBkizbVvCB7rs379+pEjR4qB4cOHizIDsMl8IOXl
Rcq7BCkPZwpqyxw6dGhiYuL27duNx7l6qnbt2lU7ZBYH0Z07d9bf1SJJjOzYsaM/BXbp0qWy
srK27gZ94qDbYsrGrY/+JwXvcw3jxo1LTU0VAytWrBg/fnwDN08DkPLyIuVdgivp4ExBbZnn
zp0bNGhQixYtIiMjMzIytJF6VkZERFRXV9fWpbN+mCze1X6EbxxpXaAoRz8RIN6ymLJx66Mv
3SPlS0tLo6Ki9EVHR0eLMU3aXr6R8vIi5QGoTWTfypUr9QNzPSvF8XJRUZEYyM3NjY2N1d89
efKkNvL666/3p8BOnTpVVFT4M2Xj1kef0SPlN2/ePGTIEP2/gwcP3rJli8V2aApSXl6kvEtw
JR2cKagts3fv3mlpaZWVlcaT2mLg7NmzYmDKlCmrVq0qLi5OSUmZNGmS9q5I0unTpxcWFi5Z
smTmzJn+FDh16tTMzMyysrLU1NSEhASLKU1H6tnta330pXuk/IQJE9atW6f/d82aNRMnTmz8
xrJEysuLlHcJzsvDmYLaMnfv3h0fHx8eHm78gfq4ceNat24tBnJyckaOHBkZGTls2DAxrL0r
knTp0qVRUVFjxowpKCjwp8C8vDwxsZilX79+Bw8etJjSdKSe3b7WR1+6cbi8vLx79+7GO/yU
lpbGxcUF6Z4/pLy8SHmXIOXhTE5rmYpdTR8opLy8SHmXcFpfCmic1jJJeVOkvLxIeZdwWl8K
aGiZUiDl5UXKuwRX0sGZaJlSIOXlRcoDAKyR8vIi5V2CK+ngTLRMKZDy8iLlXYKzn3AmWqYU
SHl5kfIuQV8KZ6JlSoGUlxcp7xL0pXAmWqYUSHl5kfIuQV8KZ6JlSoGUlxcp7xJcrwRnomVK
gZSXFykPALBGysuLlHcJrleCM9EypUDKy4uUdwnOfsKZaJlSIOXlRcq7BH0pnImWKQVSXl6k
vEvQl8KZaJlSIOXlRcq7BH0pnImWKQVSXl6kvEtwvRKciZYpBVJeXqQ8rJWXl3sMBLxkAA5H
ysuLlHeJhl6vFBYWpg306tXLYyBQmljgmjVrxEquXbs2UOsDW3AlnRRIeXmR8i7R0LOfesp7
DwRKEwtMrJOUlBSo9YEtOC8vBVJeXqS8MnJzcz/wTetLLSYQsxtL0yI4zIs2MiUlJS4urnnz
5ps2bdKXfscdd8TGxr744ove8S0mExOHh4fHx8fv2LHDWLIYzsvLGzVqVHR09OjRo8+fP6+v
QFpaWkxMzMCBA7Ozsz0KLC4ubteu3alTp9q2bVtSUhL4rYlQIeWlQMrLi5RXhrYbNprHbmhx
LC8GZsyYIXJWy25t5NSpUxcuXHjhwoUHH3zQO+XFZMuXL6+qqkpPT+/Ro4dHgdOnT3/++eeL
iorEl4dp06bp7z7wwAOiwGXLlk2ePNmjwPXr148cOVIMDB8+XJTZ5I0H25DyUiDl5UXKK0Pb
DTds2LCvgcQsDU15/eBaH9mpU6dz586JgWPHjnmn/NChQxMTE7dv32487tYn69q1q3YILw7q
O3furL+rrZIY2bFjR48Cx40bl5qaKgZWrFgxfvz4Rm4yOAApLwVSXl6kvDICuxtap7z3ZOJo
vbKysrbul/PeKS++AAwaNKhFixaRkZEZGRke80ZERFRXV4sBcbCv/3FAvKv9CN84UlNaWhoV
FaX/zT86OlqMaeinhkNwJZ0USHl5kfLKsDflb7jhBu1Y/vjx475+VieyeOXKlfqBuT6ZOH4v
KiqqrTu5Hxsbq7978uRJbeT1119vLGfz5s1DhgzR/zt48OAtW7Y07DMDaAhSXl6kvDKClPLi
OPrs2bPGAdOUf+SRRxYtWlRQUDBlypRmzZp5LKJ3795paWniYN94Kl8vUMyyatWq4uLilJSU
SZMm6SVPnz69sLBwyZIlM2fONJY2YcKEdevW6f9ds2bNxIkTG/qp4RBcSScFUl5epLwygpTy
48aNa926tXHANOXFEfftt9/eoUOHZcuWtWnTxmMRu3fvjo+PDw8PN/4sXy8wJydn5MiRkZGR
w4YNE8N6yUuXLo2KihozZoz48qAXVV5e3r17d+MddUpLS+Pi4rjHjqQ4Ly8FUl5epLwynLAb
VlRUrFy58s4772x6UQG/PB/ORMpLwQndCxqHlFeGvbvh5MmT27Vr16JFiwEDBgRkjyblXYKU
lwIpLy9SXhnshpARKS8Fuhd5kfLKYDeEjLiSTgp0L/JyTsrz66kmYjcEECR0L/JyTsoH/JFn
TdTE88Khf2IauyFkxJV0UqB7kZdzUl6xX1uF/olp7IaQEeflpUD3Ii9bUj7gTyjzLlAoKCgQ
IStmGTt2bGFhocWUpiP1bx2+1sf7uWw6W56Yxm4IGZHyUqB7kZctKR/wJ5SZFjhr1qz9+/eX
lpauXbs2OTnZYsrGrY/3c9l0tjwxjd0QMiLlpUD3Ii9bUj7gTygzLbBLly7a81NEfIuDbosp
G7c+3s9l09nyxDR2Q8iIlJcC3Yu8bEn5wD6hzFeBohz9RIB4y2LKxq2PvnSPlLfriWnshpAR
V9JJIWTdS01NTUMXAWs2/vouUE8o81Vgp06dKioq/Jmyceujz+iR8nY9MY2UBxAkIeheTpw4
IaY8ffp0o1YQPtmS8oF9QpmvAqdOnZqZmVlWVpaampqQkGAxpelIPbt9rY++dI+Ut+uJaaQ8
ZMSVdFIIavciev7Vq1fPnTs3OTmZlA84W1I+gE8osygwLy9PTCxm6dev38GDBy2mNB2pZ7ev
9dGXbhy28YlppDxkxHl5KQSpe8nPz1+/fv28efPm1iHlg8E518tbU+xq+mAg5SEjUl4KAe9e
ioqKtm7d+vjjj881IOWDgZRXBikPGZHyUghg91JWVvb2228/+eSTc72Q8sEgS8qjXqQ8ZETK
SyEg3UtVVZWIjAULFnjnOykfPKS8MrTdcP369R80kJiFlIdduJJOCk1M+SNHjmRkZCxevNhX
viN4xNeqpqS8xbcy2GLFihUvNQopD8AXUl5epLxKkpOTP/zww31mttYxfUuj36IfCCWupJMC
f7GXF3+xdwnOfsKZaJlS4Nd38iLlXYK+FM5Ey5QCV9LJi5R3CfpSOBMtUwrcFceZ/LntPynv
EvSlcCZaphS4w60zHTp06M033xSbt6qqytc0pLxLcL0SnImWKQWeVuNMBw4cSElJeeKJJ159
9dWsrCzTQ3tSHgBgjSfPOpOW8tr5jqeeeio9Pf3MmTMe05DyLsH1SnAmWqYUuLWmMxlTXrNg
wYKtW7fqD1arJeVdg7OfcCZaphRIeWfyTnnNokWL3n777fz8/FpS3jXoS+FMtEwpkPLO5Cvl
Nc8+++zOnTvfeecdUt4N6EvhTLRMKTQx5d97773ly5f7vGsngiY5OVl8DRBVsHjpwofm3d+g
l5iFlJcIfSmciZYpBVJeUnrKNxopLwuuV4Iz0TKlwF/sncmfv9h/8MEHogo2bNhg8RwTU2IW
MWNmZqbdnxIAEFykvDP58+s76s4luF4JzkTLlAJJ4Uz+XElH3bkEZz/hTLRMKZAUzuTPXXGo
O5egL4Uz0TKlQFI4kz93uKXuXIK+FM5Ey5SCY5OivLw8SCVLwZ+n1Ti27hBY9KVwJlqmFByb
FL169QpSyY0TFhbWlNnXrFkjSli7dq2f0/tz23/H1h0Ci+uV4Ey0TCk4NimamKpOk1gnKSkp
gGU6tu4AAA7hhKTYtGlT8+bNw8PD4+Pjd+zYUVsX8RoxnJeXN2rUqOjo6NGjR58/f16bRbyV
lpYWExMzcODA7OzsegsUCgoKRMiKWcaOHVtYWGgxpelI/VuHr/VJSUmJi4sTM4rZPdanuLi4
Xbt2p06datu2bUlJSdO3mMYJdYcQ4HolOBMtUwpOSAqRjMuXL6+qqkpPT+/Ro4c2Uk/V6dOn
P//880VFRSJGp02bpr/7wAMPXLhwYdmyZZMnT/anwFmzZu3fv7+0tHTt2rXJyckWUzZufWbM
mCHSXPuG4LE+69evHzlypBgYPny4KLPpW0zjhLpDCHD2E85Ey5SCE5Ji6NChiYmJ27dvNx7n
6qnatWtX7ZBZHER37txZf1dbtBjZsWNHfwrs0qVLZWWlGBDxLQ66LaZs3Prof1LwPtcwbty4
1NRUMbBixYrx48c3cPP45IS6QwjQl8KZaJlScEJSnDt3btCgQS1atIiMjMzIyNBG6lkZERFR
XV1dW5fO+mGyeFf7Eb5xpHWBohz9RIB4y2LKxq2PvnSPlC8tLY2KitIXHR0dLcY0aXtd5oS6
QwjQl8KZaJlScE5SiOxbuXKlfmCuZ6U4Xi4qKhIDubm5sbGx+rsnT57URl5//fX+FNipU6eK
igp/pmzc+ugzeqT85s2bhwwZov938ODBW7ZssdgO/nNO3SGo6EvhTLRMKTghKXr37p2WllZZ
WWk8qS0Gzp49KwamTJmyatWq4uLilJSUSZMmae+KJJ0+fXphYeGSJUtmzpzpT4FTp07NzMws
KytLTU1NSEiwmNJ0pJ7dvtZHX7pHyk+YMGHdunX6f9esWTNx4sTGbywDJ9QdQoDrleBMtEwp
OCEpdu/eHR8fHx4ebvyB+rhx41q3bi0GcnJyRo4cGRkZOWzYMP0u7iJJly5dGhUVNWbMmIKC
An8KzMvLExOLWfr163fw4EGLKU1H6tnta330pRuHy8vLu3fvbrzDT2lpaVxcXEDu+eOEugMA
OJmkSaHY1fSNI2ndoaG4XgnORMuUgqRJQcrXSlt3aCjOfsKZaJlSICnkRd25BH0pnImWKQWS
Ql7UnUvQl8KZaJlSICnkRd25BH0pnImWKQWSQl7UnUtwvRKciZYpBZJCXtQdAMAaSSEv6s4l
uF4JzkTLlAJJIS/qziU4+wlnomVKgaSQF3XnEvSlcCZaphRICnlRdy5BXwpnomVKgaSQF3Xn
EvSlcCZaphRICnlRdy7B9UpwJlqmFEgKeVF3AABrJIW8qDuX4HolOBMtUwokhbyoO5fg7Cec
iZYpBZJCXtSdS9CXwplomVIgKeRF3bkEfSmciZYpBZJCXtSdS9CXwplomVIgKeRF3bkE1yvB
mWiZUiAp5EXdAQCskRTyou5cguuV4Ey0TCmQFPKi7lyCs59wJlqmFEgKeVF3LkFfCmeiZUqB
pJAXdecS9KVwJlqmFEgKeVF3LkFfCmeiZUqBpJAXdecSXK8EZ6JlSoGkkBd1BwCwRlLIi7pz
Ca5XgjPRMqVAUsiLunMJzn7CmWiZUiAp5EXduQR9KZyJlikFkkJe1J1L0JfCmWiZUiAp5EXd
uQR9KZyJlikFkkJe1J1LcL0SnImWKQWSQl7UHQDAGkkhL+rOJbheCc5Ey5QCSSEv6s4lOPsJ
Z6JlSoGkkBd15xL0pXAmWqYUSAp5UXcuQV8KZ6JlSoGkkBd15xL0pXAmWqYUSAp5UXcuwfVK
cCZaphRICnlRdwAAaySFvKg7l+B6JTgTLVMKJIW8qDuX4OwnnImWKQWSQl7UnUvQl8KZaJlS
ICnkRd25BH0pnImWKQWSQl7UnUvQl8KZaJlSICnkRd25BNcrwZlomVIgKeRF3QEArJEU8qLu
XILrleBMtEwpkBTyou5cgrOfcCZaphRICnlRdy5BXwpnomVKgaSQF3XnEvSlcCZaphRICnlR
dy5BXwpnomVKgaSQF3XnElyvBGeiZUqBpJAXdQcAsEZSyIu6cwmuV4Iz0TKlQFLIi7pzCc5+
wplomVIgKeRF3bkEfSmciZYpBZJCXtSdS9CXwplomVIgKeRF3bkEfSmciZYpBZJCXtSdS3C9
EpyJlikFkkJe1B0AwBpJIS/qziW4XgnORMuUAkkhL+rOJTj7CWeiZUqBpJAXdecS9KVwJlqm
FEgKeVF3LkFfCmeiZUqBpJAXdecS9KVwJlqmFEgKeVF3LsH1SnAmWqYUSAp5UXcAAGskhbyo
O5fgeiU4Ey1TCiSFvKg7l+DvonAmzstLgaSQF3UHwEakvBRICnlRdwBsRMpLgaSQF3UHwEak
vBRICnlRdwBsxC9GpEBSyIu6AwBYIynkRd0BsBFX0klBS4pGIylsRMoDsBHn5aVAystLq7v1
69d/0EBiFuoOQBOR8kBQ8Q0NgI1IeSCozp8/v68+2m5o+paY3e5PAEBipDxgOy51ARAkdC8A
AABAkHCpC4AgoXsBbMef1AAECd0LAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAoJL/D6rZTPUKZW5kc3RyZWFtCmVuZG9iago5IDAg
b2JqIDw8L0xlbmd0aCA5MTgvRmlsdGVyL0ZsYXRlRGVjb2RlPj5zdHJlYW0KeJyNVk1v4zYQ
vetXDPa0BTaMvj9ya5sumqJFN42APRSFQUu0zIQiHZKym3/fGUnZypvFytDBEqk3fPNm5snP
wU91EEJRxVC3wS91cB88ByELkyKDUxDDb7j5GEQh/BH8/U8IbZCWUKQp9EGWp+OdGu/SkoV0
j9uL22l/H3wOdBABXbYL0oJV+TeDXCVlydKcsOM7Xz+/htshKbowGLK//oiBS6h3eAStRkAn
xznLC6j74P3vda072HIngLetFc6BFY2xrcTlgzXe+JeD+KF+pPRf46EE0Vch86pgUT6G/Hmw
VmgPD577wd0ssfG3sUXC8mjEPgzbXnovWvAGlPe6u2rFEXouFRJS0nkGn4Qe2e2Mhb/EUYrT
9a10zeCcNJpdQDXNWDxRvRVOdvoSinHEipmiOArLFeyNeXKw50cBWyE0yBaTljuJ3KUGvxcz
/8F52Fnei5OxT7jOPXArYHD4IqVAb8r+oESPeO4xBzC7s4pcQC8s2VTPL8U7EyKB6gxRsQyy
MmNhOYJ+xVQguoEHMWoILRc9/pDcQguiaAVvb6gzhMR83fye89z6dXZZHrJJu897jIfyAUe9
tPN2oKRRiJUgSZWyKlsE+gBcKWimTlMva/gsy1kaL/Cw0iZREbGwWAD44aBkM5VnlsEBh3dn
UryDHh95tzovWcqypS688aOue+yMFsz2UTT+grJnac6qdIqALSU9NiapyfWqolFRsKJaRlhD
xGgzyTkCS6m9Wxu5KA5ZdUZ2alIi6tawZcjyJRSnabOlubiRWl7Se0nCyL4RWu+lA2fUMBYR
+8ecHI4hOU0nPFjZ0uCZwWIV/cYZqXdm0w79ARChpH/BMTY9bXpj1Je0nyFN4vHApAjJkPHU
CCcsrqDp4Vr2XQS3Bu6/xzKKcRYnS/pTL3zvDtzQdcJRUXv+RK43Ggh5D/CmoebbKkEpGPQR
O0HJWyx2p4OTUOrM3dK3xyPpDFdDVk4K37UCtXnBg1Cu8SC3N4Nq0eXog3CUU+Hgx093sBt0
Q2pykucDNEZ7a5TixOko+UynMX2PLekYfES/E/9ycrszWtlbWlUCRf76WZjiGH01j9uV0OMZ
KzGSpGJJuYizwTH1YiyqsMyZFXycFCxe8njDYEVbasCI5encfwKt43mQdrR6ajYiQkUdaQE1
nO3nT4B+ddnNnCtWoyM3lg0IbYZuP7XCVPf/zXSCN1SxmRz9abkP/gNtv19ZCmVuZHN0cmVh
bQplbmRvYmoKMSAwIG9iajw8L1BhcmVudCAxMCAwIFIvQ29udGVudHMgOSAwIFIvVHlwZS9Q
YWdlL1Jlc291cmNlczw8L1hPYmplY3Q8PC9pbWcxIDYgMCBSL2ltZzAgNSAwIFI+Pi9Qcm9j
U2V0IFsvUERGIC9UZXh0IC9JbWFnZUIgL0ltYWdlQyAvSW1hZ2VJXS9Gb250PDwvRjEgMiAw
IFIvRjIgMyAwIFIvRjMgNCAwIFIvRjQgNyAwIFIvRjUgOCAwIFI+Pj4+L01lZGlhQm94WzAg
MCA2MTIgNzkyXT4+CmVuZG9iagoxMSAwIG9iajw8L0NbMCAwIDFdL0JvcmRlclswIDAgMF0v
QlM8PC9XIDAvUy9TPj4vQTw8L1VSSShodHRwOi8vdXN0X2JhZGRyaW5pdCkvUy9VUkk+Pi9T
dWJ0eXBlL0xpbmsvUmVjdFsxMTQuODMgNDgzLjIzIDE5MC41IDQ5NS4xNV0+PgplbmRvYmoK
MTIgMCBvYmo8PC9DWzAgMCAxXS9Cb3JkZXJbMCAwIDBdL0JTPDwvVyAwL1MvUz4+L0E8PC9V
UkkoaHR0cDovL3VzdF9iYWRkcmluaXQpL1MvVVJJPj4vU3VidHlwZS9MaW5rL1JlY3RbMTE0
LjgzIDQ1Ny4wNSAxODQuOTEgNDY4Ljk3XT4+CmVuZG9iagoxMyAwIG9iajw8L0NbMCAwIDFd
L0JvcmRlclswIDAgMF0vQlM8PC9XIDAvUy9TPj4vQTw8L1VSSShodHRwOi8vbGlzdHMubHR0
bmcub3JnL3BpcGVybWFpbC9sdHRuZy1kZXYvMjAxMy1BdWd1c3QvMDIxMjY0Lmh0bWwpL1Mv
VVJJPj4vU3VidHlwZS9MaW5rL1JlY3RbNDggMzI4Ljc2IDMzMS4yNyAzNDAuMzVdPj4KZW5k
b2JqCjE0IDAgb2JqIDw8L0xlbmd0aCAxMzYyL0ZpbHRlci9GbGF0ZURlY29kZT4+c3RyZWFt
CniclVfbbts4EH3XVwySlwRIaFHUxco+ddsE7aLttl0D+1AHAS3RlhrZVEU6aXex/5JP3SEp
yXKbxCqMQJyIM3Pmdkh99X6feT4kaQCz3LuceR+9r55PfJZEcO8F8Ae+/OJRH955n699yL1w
CkkYwtqL4tCuKrsKp8Q3a3w9WLr3hfe3t/EomF+z8sKEpDHQMPRbK3bZmTGKdsNg2W4ovCWi
MT+0kviEpRCmPqEx2mnFaUoohTglEUNhSoII4ikJk07IvDghYdC/i0kU91pOcBZxYytSEgTQ
aqUB8ZPOohNwo/PmxA6W1drDmFn87b9iRtJ0BzsOSMo62PHQSdw5cQDadw5aq9UK1mIPO45M
ETqtiKS9QbPuQVupA2FV9gA6zNghkyssE7YFhdkSK2lqQE2FEob7IpitvRNeKQkLsRHLUsOy
kWvA5/xEkBUBpXl2C/l2XcNSNlCVi0rrzep8q/R59n11XjdyWVZi8tSL8yVXen5KTmdfTI9a
QMEjgMKAxHQIak+DQbq3G1MACRphzO59LeUtBOfBBfyluS4zyDRi5ZsccrMoN2CxTXTDM1HL
cqNJcQjQFNMeEebAXFlzwOu6KjP0IDegJWyVgLez2WYFO8MKdCHMmwYOeGDU1bZ3AgVXxmy5
yaptLoBDI1QtMl3eiYEHwMzelTk6KATHx9AN/dlNMGXEj4Z+eHXPv6sR8ScBoalVMZU84Cf2
yZQNdQ6WHD1EKfJVn2Hxja/rSlwcUMQ+x3hYSKZW8zjHvt0ImH168fLyw59v3s9uXl1evXl/
2ZqhHe88by+gJHHAj7sCHGmh9M2waY5am/4om1EakSS2Nu9kmeMAyfnJ/HRMeNE0IIkr17+j
9iMrJKHd//DwMOiW+QmYKM6wq5byDI4QA5QKMl5VIj+C+elvo8xHMUkCa/6/A32AZY1Y0PXa
Jc8KkEscCnT6dA+DabCu8dWvTytLUpPpgWPyiBHI5EbzcqMMq3U0MWIQIpoS5pLbcYoZc65B
81uBuWyEnfohC8xPbNTPDe78FIxm3Ygan7nlq0asSqWFEZEJjL4lmBEY/ZjQxA1rw9fiXja3
BA7Uivq+yddAd4Yea66xaDzPHZctZVXJ+xJZbiEKflfioCK0n7N7cGzt5SJEHoqo6401HjPI
qgf0aGo6cKAH4k5gNvkS8zRMr8td09KzKU8jMtlgGAuOTI0BIZ+qMxNfcQaq/EfYlFd4QO3G
mgT4F5rRpjQ0jGYc+wEe+DscKFa9GJLI3JT63T/K7fb+NH6sDLu9bYh4iN4sDOCLequK0aTj
MowU7GZgLfNy2Z9X5VqYSVSFbTa5+IIny0R8E9lW80UlDtF1azzqR2Fs+TAjKR0qtvVbCLxQ
7M0HzsSoEu6Gy0XhdpbquSpGUzKNTBU7OFauhjKLB3V7RLb7x9RxF+qgjrL+xTKGMWGOcvlC
brUZupXQkFVSiXzEjQqv8wEexv1YW7KDHYE9eiuyjIQ0iUXYZhr7BHdxwPuCyzFylamdasti
SGFti1hgI0g8hE27TnaxPgfOx7PfHbg1LxuocZif6k3bMVBi8+Ki4dWhk0TZMPAS1uJ3dg9j
YmlsLukG0/Pz8fi5x/DS3p6SrwQeNJVLd3utcaDVxQg7YWhIw9j57C7Vubi7hs+frl7Chxez
l6+hv2pfwztzBPUy8HsT+o9zvjc+wgxQqdRWwHGYhP2FZG9uDAyGDGeYjzH8Jko6uRrK3efi
j+toj/OeyDaa8V1/FlrXFxP8iFBaERsMkc1qUpfYFWtM5KRPwyTwKTt/sV1hsBM/oEEckkKv
qzYG8w380fsf0C3nZgplbmRzdHJlYW0KZW5kb2JqCjE1IDAgb2JqPDwvUGFyZW50IDEwIDAg
Ui9Db250ZW50cyAxNCAwIFIvVHlwZS9QYWdlL1Jlc291cmNlczw8L1Byb2NTZXQgWy9QREYg
L1RleHQgL0ltYWdlQiAvSW1hZ2VDIC9JbWFnZUldL0ZvbnQ8PC9GMSAyIDAgUi9GMiAzIDAg
Ui9GMyA0IDAgUi9GNCA3IDAgUj4+Pj4vTWVkaWFCb3hbMCAwIDYxMiA3OTJdL0Fubm90c1sx
MSAwIFIgMTIgMCBSIDEzIDAgUl0+PgplbmRvYmoKMTcgMCBvYmo8PC9QYXJlbnQgMTYgMCBS
L0Rlc3RbMSAwIFIvWFlaIDAgNzQ0IDBdL1RpdGxlKExUVG5nIGJhc2UgYWRkcmVzcyByZWNv
cmRpbmcgcHJvdG90eXBlKT4+CmVuZG9iagoxNiAwIG9iajw8L1R5cGUvT3V0bGluZXMvQ291
bnQgMS9MYXN0IDE3IDAgUi9GaXJzdCAxNyAwIFI+PgplbmRvYmoKMiAwIG9iajw8L0Jhc2VG
b250L0hlbHZldGljYS1Cb2xkL1R5cGUvRm9udC9FbmNvZGluZy9XaW5BbnNpRW5jb2Rpbmcv
U3VidHlwZS9UeXBlMT4+CmVuZG9iago4IDAgb2JqPDwvQmFzZUZvbnQvQ291cmllci1PYmxp
cXVlL1R5cGUvRm9udC9FbmNvZGluZy9XaW5BbnNpRW5jb2RpbmcvU3VidHlwZS9UeXBlMT4+
CmVuZG9iago3IDAgb2JqPDwvQmFzZUZvbnQvSGVsdmV0aWNhLU9ibGlxdWUvVHlwZS9Gb250
L0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxPj4KZW5kb2JqCjQgMCBv
Ymo8PC9CYXNlRm9udC9IZWx2ZXRpY2EtQm9sZE9ibGlxdWUvVHlwZS9Gb250L0VuY29kaW5n
L1dpbkFuc2lFbmNvZGluZy9TdWJ0eXBlL1R5cGUxPj4KZW5kb2JqCjMgMCBvYmo8PC9CYXNl
Rm9udC9IZWx2ZXRpY2EvVHlwZS9Gb250L0VuY29kaW5nL1dpbkFuc2lFbmNvZGluZy9TdWJ0
eXBlL1R5cGUxPj4KZW5kb2JqCjEwIDAgb2JqPDwvVHlwZS9QYWdlcy9Db3VudCAyL0tpZHNb
MSAwIFIgMTUgMCBSXT4+CmVuZG9iagoxOCAwIG9iajw8L1R5cGUvQ2F0YWxvZy9PdXRsaW5l
cyAxNiAwIFIvUGFnZU1vZGUvVXNlT3V0bGluZXMvUGFnZXMgMTAgMCBSPj4KZW5kb2JqCjE5
IDAgb2JqPDwvUHJvZHVjZXIoaVRleHQgMi4wLjggXChieSBsb3dhZ2llLmNvbVwpKS9Nb2RE
YXRlKEQ6MjAxMzA5MTAxMDIwMjUtMDUnMDAnKS9DcmVhdGlvbkRhdGUoRDoyMDEzMDkxMDEw
MjAyNS0wNScwMCcpPj4KZW5kb2JqCnhyZWYKMCAyMAowMDAwMDAwMDAwIDY1NTM1IGYgCjAw
MDAwMjU0NDMgMDAwMDAgbiAKMDAwMDAyNzk1NyAwMDAwMCBuIAowMDAwMDI4MzM2IDAwMDAw
IG4gCjAwMDAwMjgyMzcgMDAwMDAgbiAKMDAwMDAwMDAxNSAwMDAwMCBuIAowMDAwMDAwNTcw
IDAwMDAwIG4gCjAwMDAwMjgxNDIgMDAwMDAgbiAKMDAwMDAyODA0OSAwMDAwMCBuIAowMDAw
MDI0NDU4IDAwMDAwIG4gCjAwMDAwMjg0MjMgMDAwMDAgbiAKMDAwMDAyNTY3MCAwMDAwMCBu
IAowMDAwMDI1ODEyIDAwMDAwIG4gCjAwMDAwMjU5NTUgMDAwMDAgbiAKMDAwMDAyNjE0MCAw
MDAwMCBuIAowMDAwMDI3NTcxIDAwMDAwIG4gCjAwMDAwMjc4OTAgMDAwMDAgbiAKMDAwMDAy
Nzc4NiAwMDAwMCBuIAowMDAwMDI4NDgxIDAwMDAwIG4gCjAwMDAwMjg1NjQgMDAwMDAgbiAK
dHJhaWxlcgo8PC9Sb290IDE4IDAgUi9JRCBbPDk5MGRjMGIwMTFhZDM5ZjZkNWNhMDUzNmNm
MGY5ZDUzPjwzNjNiNTc1OWEyMTkyZTc1ZWJjOWZlN2VhOWE4YWQ4Nz5dL0luZm8gMTkgMCBS
L1NpemUgMjA+PgpzdGFydHhyZWYKMjg2OTYKJSVFT0YK
--------------030100080604040005020200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030100080604040005020200--
