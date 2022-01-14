Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1ADC433F5
	for <lttng-dev@archiver.kernel.org>; Fri, 14 Jan 2022 20:42:56 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JbCt725cQzFSH;
	Fri, 14 Jan 2022 15:42:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1642192975;
	bh=aF+ni4eNaXe5UW8q9qNNiqFTEUt/DqOV+zvBx3NC/fM=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GDLkwAe3X+wPJcgCOIg+Jbv2QWyBLfUC5F7uNVLcxjBDOu06HkW62pwVGPNc+CDJg
	 OHOu8NL0kCMfc43YSiLGhDHmmfex35deTvxbvDKdMMfkXYKQtMMe6tdmGlWq6BjI+e
	 iAh9uPnLMGgLePIDjueHfIv0i3qedULY8wzPlr6y+vQLBhImXkyWmk1b2/UBg9F+sI
	 DcBQzligrjFfwn/qZgz+1Quzy4hmJyDKfyw9oF6xbnfWvfGqSCmK3DLOYy8wj1SIqK
	 bzsaKTZwDh2ERqt8ohTDXozludM3Rf3hNf1kUPAXomapb8ER7ZpHGcoyOXLn7R2KCf
	 CZ/Lf0uAPpDqw==
Received: from fukushima.klipix.org (mail.klipix.org
 [IPv6:2a0c:4140:100:400::beef:2])
 by lists.lttng.org (Postfix) with ESMTPS id 4JbCt61T7TzFVX
 for <lttng-dev@lists.lttng.org>; Fri, 14 Jan 2022 15:42:53 -0500 (EST)
Received: from [192.168.1.124] (unknown [192.222.196.137])
 by fukushima.klipix.org (Postfix) with ESMTPSA id 28E204602C5;
 Fri, 14 Jan 2022 21:42:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.1 fukushima.klipix.org 28E204602C5
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 lttng-dev@lists.lttng.org
Cc: David Goulet <dgoulet@ev0ke.net>
References: <20220114201409.24705-1-mathieu.desnoyers@efficios.com>
Message-ID: <4665aa48-67c3-cb2e-fed7-fe09faa83958@klipix.org>
Date: Fri, 14 Jan 2022 15:42:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114201409.24705-1-mathieu.desnoyers@efficios.com>
Content-Language: en-US
Subject: Re: [lttng-dev] [PATCH lttng-ust] Copyright ownership transfer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Julien Desfossez via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Julien Desfossez <ju@klipix.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-01-14 3:14 p.m., Mathieu Desnoyers wrote:
> Apply copyright ownership transfer from David Goulet and Julien Desfossez
> to EfficiOS Inc.
> 
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030087.html
> Link: https://lists.lttng.org/pipermail/lttng-dev/2022-January/030092.html
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: David Goulet <dgoulet@ev0ke.net>
> Cc: Julien Desfossez <ju@klipix.org>
> Change-Id: Ibc6bb52296406e68466d44ae991a7ab70134dd76
> ---
>   include/lttng/ust-ctl.h            | 2 +-
>   include/lttng/ust-error.h          | 3 +--
>   src/common/ustcomm.c               | 2 +-
>   src/common/ustcomm.h               | 3 +--
>   src/common/utils.c                 | 2 +-
>   src/lib/lttng-ust-ctl/ustctl.c     | 2 +-
>   src/lib/lttng-ust/lttng-ust-comm.c | 2 +-
>   src/lib/lttng-ust/strerror.c       | 2 +-
>   8 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/include/lttng/ust-ctl.h b/include/lttng/ust-ctl.h
> index 360bb09a..25e588b3 100644
> --- a/include/lttng/ust-ctl.h
> +++ b/include/lttng/ust-ctl.h
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: GPL-2.0-only
>    *
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/include/lttng/ust-error.h b/include/lttng/ust-error.h
> index 543c894a..49045bab 100644
> --- a/include/lttng/ust-error.h
> +++ b/include/lttng/ust-error.h
> @@ -1,8 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/common/ustcomm.c b/src/common/ustcomm.c
> index 6dfec5ea..252ed4f2 100644
> --- a/src/common/ustcomm.c
> +++ b/src/common/ustcomm.c
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/common/ustcomm.h b/src/common/ustcomm.h
> index 734757c3..d1e9af13 100644
> --- a/src/common/ustcomm.h
> +++ b/src/common/ustcomm.h
> @@ -1,8 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/common/utils.c b/src/common/utils.c
> index 108f76db..0c95b06c 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/lib/lttng-ust-ctl/ustctl.c b/src/lib/lttng-ust-ctl/ustctl.c
> index 8c60bdb2..94d84843 100644
> --- a/src/lib/lttng-ust-ctl/ustctl.c
> +++ b/src/lib/lttng-ust-ctl/ustctl.c
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: GPL-2.0-only
>    *
> - * Copyright (C) 2011 Julien Desfossez <julien.desfossez@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/lib/lttng-ust/lttng-ust-comm.c b/src/lib/lttng-ust/lttng-ust-comm.c
> index d6755079..caba7452 100644
> --- a/src/lib/lttng-ust/lttng-ust-comm.c
> +++ b/src/lib/lttng-ust/lttng-ust-comm.c
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> diff --git a/src/lib/lttng-ust/strerror.c b/src/lib/lttng-ust/strerror.c
> index 1fa7fc3a..5a671a07 100644
> --- a/src/lib/lttng-ust/strerror.c
> +++ b/src/lib/lttng-ust/strerror.c
> @@ -1,7 +1,7 @@
>   /*
>    * SPDX-License-Identifier: LGPL-2.1-only
>    *
> - * Copyright (C) 2011 David Goulet <david.goulet@polymtl.ca>
> + * Copyright (C) 2011 EfficiOS Inc.
>    * Copyright (C) 2011-2013 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>    */
>   
> 

Signed-off-by: Julien Desfossez <ju@klipix.org>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
