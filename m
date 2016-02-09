From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] liburcu: Support for NIOS2 architecture
Date: Tue, 9 Feb 2016 18:35:09 +0000 (UTC)
Message-ID: <1412263139.15225.1455042909201.JavaMail.zimbra__11017.3651636162$1455042974$gmane$org@efficios.com>
References: <1455036920-7595-1-git-send-email-marex@denx.de>
 <1400098469.15181.1455042158356.JavaMail.zimbra@efficios.com>
 <201602091931.10859.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aTD8A-0007ql-Fu
 for lttng-dev@lists.lttng.org; Tue, 09 Feb 2016 13:35:23 -0500
In-Reply-To: <201602091931.10859.marex@denx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marek Vasut <marex@denx.de>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Feb 9, 2016, at 1:31 PM, Marek Vasut marex@denx.de wrote:

> On Tuesday, February 09, 2016 at 07:22:38 PM, Mathieu Desnoyers wrote:
>> ----- On Feb 9, 2016, at 11:55 AM, Marek Vasut marex@denx.de wrote:
>> > Add support for the Altera NIOS2 CPU archirecture. The atomic operations
>> > are handled by the GCC. The memory barriers on this systems are entirely
>> > trivial too, since the CPU does not support SMP at all.
>> > 
>> > Signed-off-by: Marek Vasut <marex@denx.de>
>> > ---
>> > LICENSE              |  1 +
>> > README.md            |  1 +
>> > configure.ac         |  1 +
>> > urcu/arch/nios2.h    | 40 ++++++++++++++++++++++++++++++++++++++++
>> > urcu/uatomic/nios2.h | 32 ++++++++++++++++++++++++++++++++
>> > 5 files changed, 75 insertions(+)
>> > create mode 100644 urcu/arch/nios2.h
>> > create mode 100644 urcu/uatomic/nios2.h
>> > 
>> > diff --git a/LICENSE b/LICENSE
>> > index 3147094..a06fdcc 100644
>> > --- a/LICENSE
>> > +++ b/LICENSE
>> > @@ -45,6 +45,7 @@ compiler.h
>> > arch/s390.h
>> > uatomic/alpha.h
>> > uatomic/mips.h
>> > +uatomic/nios2.h
>> > uatomic/s390.h
>> > system.h
>> > 
>> > diff --git a/README.md b/README.md
>> > index f6b290f..6fe9c1e 100644
>> > --- a/README.md
>> > +++ b/README.md
>> > 
>> > @@ -43,6 +43,7 @@ Currently, the following architectures are supported:
>> >   - S390, S390x
>> >   - ARM 32/64
>> >   - MIPS
>> > 
>> > +  - NIOS2
>> > 
>> >   - Alpha
>> >   - ia64
>> >   - Sparcv9 32/64
>> > 
>> > diff --git a/configure.ac b/configure.ac
>> > index 39a7777..71a7d71 100644
>> > --- a/configure.ac
>> > +++ b/configure.ac
>> > @@ -124,6 +124,7 @@ AS_CASE([$host_cpu],
>> > 
>> > 	[arm*], [ARCHTYPE="arm"],
>> > 	[aarch64], [ARCHTYPE="aarch64"],
>> > 	[mips*], [ARCHTYPE="mips"],
>> > 
>> > +	[nios2*], [ARCHTYPE="nios2"],
>> > 
>> > 	[tile*], [ARCHTYPE="tile"],
>> > 	[hppa*], [ARCHTYPE="hppa"],
>> > 	[ARCHTYPE="unknown"]
>> > 
>> > diff --git a/urcu/arch/nios2.h b/urcu/arch/nios2.h
>> > new file mode 100644
>> > index 0000000..030d1bc
>> > --- /dev/null
>> > +++ b/urcu/arch/nios2.h
>> > @@ -0,0 +1,40 @@
>> > +#ifndef _URCU_ARCH_NIOS2_H
>> > +#define _URCU_ARCH_NIOS2_H
>> > +
>> > +/*
>> > + * arch_mips.h: trivial definitions for the NIOS2 architecture.
>> 
>> mips -> nops2
> 
> Oops :-) Now it's clear where I started. Fixed, nice catch.

of course, I meant "nios2" here (not nops2). It's a nice typo though ;)

Thanks,

Mathieu

> 
>> > + *
>> > + * Copyright (c) 2016 Marek Vasut <marex@denx.de>
>> > + *
>> > + * This library is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU Lesser General Public
>> > + * License as published by the Free Software Foundation; either
>> > + * version 2.1 of the License, or (at your option) any later version.
>> > + *
>> > + * This library is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> > + * Lesser General Public License for more details.
>> > + *
>> > + * You should have received a copy of the GNU Lesser General Public
>> > + * License along with this library; if not, write to the Free Software
>> > + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
>> > 02110-1301 USA + */
>> > +
>> > +#include <urcu/compiler.h>
>> > +#include <urcu/config.h>
>> > +#include <urcu/syscall-compat.h>
>> > +
>> > +#ifdef __cplusplus
>> > +extern "C" {
>> > +#endif
>> > +
>> > +#define cmm_mb()	__asm__ __volatile__ ("":::"memory")
>> 
>> please change for:
>> 
>> #define cmm_mb()	cmm_barrier()
>> 
>> to re-use the cmm_barrier macro from urcu/compiler.h
> 
> Nice!
> 
>> The rest looks good, can you prepare an updated patch ?
> 
> Done, thanks!

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
