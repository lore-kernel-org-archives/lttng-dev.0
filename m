From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Cleanup: Remove unused
	lttng-types module
Date: Fri, 12 Feb 2016 20:35:49 +0000 (UTC)
Message-ID: <1448071955.18405.1455309349874.JavaMail.zimbra__8987.77671759508$1455309412$gmane$org@efficios.com>
References: <1455308783-8614-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aUKRY-0003aa-78
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 15:35:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1C08B340618
 for <lttng-dev@lists.lttng.org>; Fri, 12 Feb 2016 20:35:51 +0000 (UTC)
In-Reply-To: <1455308783-8614-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged in master, thanks!

Mathieu

----- On Feb 12, 2016, at 3:26 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> lttng-events.h           |  2 --
> probes/Kbuild            |  1 -
> probes/lttng-type-list.h | 33 ------------------------
> probes/lttng-types.c     | 66 ------------------------------------------------
> 4 files changed, 102 deletions(-)
> delete mode 100644 probes/lttng-type-list.h
> delete mode 100644 probes/lttng-types.c
> 
> diff --git a/lttng-events.h b/lttng-events.h
> index 1b4f39c..2eccf86 100644
> --- a/lttng-events.h
> +++ b/lttng-events.h
> @@ -43,7 +43,6 @@ struct lib_ring_buffer_config;
> 
> /* Type description */
> 
> -/* Update the astract_types name table in lttng-types.c along with this enum */
> enum abstract_types {
> 	atype_integer,
> 	atype_enum,
> @@ -53,7 +52,6 @@ enum abstract_types {
> 	NR_ABSTRACT_TYPES,
> };
> 
> -/* Update the string_encodings name table in lttng-types.c along with this enum
> */
> enum lttng_string_encodings {
> 	lttng_encode_none = 0,
> 	lttng_encode_UTF8 = 1,
> diff --git a/probes/Kbuild b/probes/Kbuild
> index 13e7bd8..0be49d7 100644
> --- a/probes/Kbuild
> +++ b/probes/Kbuild
> @@ -3,7 +3,6 @@ MAKEFILEDIR = $(shell dirname $(lastword $(MAKEFILE_LIST)))
> include $(MAKEFILEDIR)/../Makefile.ABI.workarounds
> 
> ccflags-y += -I$(PWD)/probes
> -obj-$(CONFIG_LTTNG) += lttng-types.o
> 
> obj-$(CONFIG_LTTNG) += lttng-probe-sched.o
> obj-$(CONFIG_LTTNG) += lttng-probe-irq.o
> diff --git a/probes/lttng-type-list.h b/probes/lttng-type-list.h
> deleted file mode 100644
> index 564a13f..0000000
> --- a/probes/lttng-type-list.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/*
> - * lttng-type-list.h
> - *
> - * Copyright (C) 2010-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; only
> - * version 2.1 of the License.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -/* Type list, used to create metadata */
> -
> -/* Enumerations */
> -TRACE_EVENT_ENUM(hrtimer_mode,
> -        V(HRTIMER_MODE_ABS),
> -        V(HRTIMER_MODE_REL),
> -        V(HRTIMER_MODE_PINNED),
> -        V(HRTIMER_MODE_ABS_PINNED),
> -        V(HRTIMER_MODE_REL_PINNED),
> -	R(HRTIMER_MODE_UNDEFINED, 0x04, 0x20),	/* Example (to remove) */
> -)
> -
> -TRACE_EVENT_TYPE(hrtimer_mode, enum, unsigned char)
> diff --git a/probes/lttng-types.c b/probes/lttng-types.c
> deleted file mode 100644
> index 0973454..0000000
> --- a/probes/lttng-types.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -/*
> - * probes/lttng-types.c
> - *
> - * LTTng types.
> - *
> - * Copyright (C) 2010-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; only
> - * version 2.1 of the License.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include "../wrapper/vmalloc.h"	/* for wrapper_vmalloc_sync_all() */
> -#include "../lttng-events.h"
> -#include "lttng-types.h"
> -#include <linux/hrtimer.h>
> -#include "../lttng-tracer.h"
> -
> -#define STAGE_EXPORT_ENUMS
> -#include "lttng-types.h"
> -#include "lttng-type-list.h"
> -#undef STAGE_EXPORT_ENUMS
> -
> -struct lttng_enum lttng_enums[] = {
> -#define STAGE_EXPORT_TYPES
> -#include "lttng-types.h"
> -#include "lttng-type-list.h"
> -#undef STAGE_EXPORT_TYPES
> -};
> -
> -static int lttng_types_init(void)
> -{
> -	int ret = 0;
> -
> -	wrapper_vmalloc_sync_all();
> -	/* TODO */
> -	return ret;
> -}
> -
> -module_init(lttng_types_init);
> -
> -static void lttng_types_exit(void)
> -{
> -}
> -
> -module_exit(lttng_types_exit);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers <mathieu.desnoyers@efficios.com>");
> -MODULE_DESCRIPTION("LTTng types");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> --
> 2.7.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
