From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v2] Add missing SPDX license
 identifiers to uprobes
Date: Thu, 8 Nov 2018 18:51:39 -0500 (EST)
Message-ID: <1220127651.2919.1541721099527.JavaMail.zimbra__5420.39036886326$1541720989$gmane$org@efficios.com>
References: <20181108233745.7046-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rg6h0qJtzqyT
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 18:51:39 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E71E4236625
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 18:51:39 -0500 (EST)
In-Reply-To: <20181108233745.7046-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- On Nov 8, 2018, at 6:37 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> probes/lttng-uprobes.c | 16 ++--------------
> wrapper/uprobes.h      | 22 +++++-----------------
> 2 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/probes/lttng-uprobes.c b/probes/lttng-uprobes.c
> index bcdbbd8..64d8237 100644
> --- a/probes/lttng-uprobes.c
> +++ b/probes/lttng-uprobes.c
> @@ -1,4 +1,5 @@
> -/*
> +/* SPDX-License-Identifier: (GPL-2.0 OR LGPL-2.1)
> + *
>  * probes/lttng-uprobes.c
>  *
>  * LTTng uprobes integration module.
> @@ -6,19 +7,6 @@
>  * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com>
>  * Copyright (C) 2009-2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  *
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
>  */
> 
> #include <linux/fdtable.h>
> diff --git a/wrapper/uprobes.h b/wrapper/uprobes.h
> index e38a541..6ea9df1 100644
> --- a/wrapper/uprobes.h
> +++ b/wrapper/uprobes.h
> @@ -1,7 +1,5 @@
> -#ifndef _LTTNG_WRAPPER_UPROBES_H
> -#define _LTTNG_WRAPPER_UPROBES_H
> -
> -/*
> +/* SPDX-License-Identifier: (GPL-2.0 or LGPL-2.1)
> + *
>  * wrapper/uprobes.h
>  *
>  * wrapper around uprobes. Using KALLSYMS to get its address when
> @@ -11,21 +9,11 @@
>  * Copyright (C) 2013 Yannick Brosseau <yannick.brosseau@gmail.com>
>  * Copyright (C) 2017 Francis Deslauriers <francis.deslauriers@efficios.com>
>  *
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
>  */
> 
> +#ifndef _LTTNG_WRAPPER_UPROBES_H
> +#define _LTTNG_WRAPPER_UPROBES_H
> +
> #include <linux/version.h>
> 
> #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,5,0))
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
