Return-Path: <SRS0=Lz2h=KU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5968C2B9F8
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:47:18 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED276140F
	for <lttng-dev@archiver.kernel.org>; Tue, 25 May 2021 13:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED276140F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FqFkX4cpGz1wJx;
	Tue, 25 May 2021 09:47:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621950437;
	bh=ZnPK7/VL8dq7ZU5MMopah4z2W9BAgs0N0rvckVH8lkM=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=zjC/AYPjKFvVyTB5B92w/f5VGWftycrKFM2dz89SPdox0wFbw4GZpV1GtV9BoOCqm
	 YCc2zzyQUTS/YOTZPOZH+jU5XooHFBBc8dCmz/k09ZBJotTZQW6Hsp/GyhnuLVw/s/
	 2UFwG+lNJJYwCs8MLsoHed85qco79/PS+Zd8eyDDMbk8uLDlb3uqVTNXciJyLFoRzj
	 5G8EFPbQlsGpeyn+Bq4ozFMZisycCXxB2fJLsIebwa5RMD3gHEZN623JdMfzR5S8DA
	 ZBUv5hThEz0yzUycdoBIND4TftBhEKYqPyOBxIF3FB/nqf4g6ODHgHmSPNYpnLZjru
	 F8Lw0zY8RCBbA==
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by lists.lttng.org (Postfix) with ESMTPS id 4FqFkW1KJtz1w7q
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 09:47:15 -0400 (EDT)
Received: by mail-ot1-x331.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so28609477otc.12
 for <lttng-dev@lists.lttng.org>; Tue, 25 May 2021 06:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=UG19oS6yHQeF3AOFpm7mwkV7O55em0u1/yA031WjHTk=;
 b=R7FKKMpKVPmzvOMGs/jwDyPHEUfvk7i8a+0nGT7Gp+7i88L32ETbxgGOhH9WkCoA4Q
 PqBpKOOecYsn/49EW7Q/wI3wbnQ93lzzNuag6ceHbncQqi2Q+VeoPcjUtx9jKVsAlKhn
 ma+GSQAx7nVjZhZoIziVtZGkIhUFraox79N3kPE9X6RqBWiaQUPHE5d8RJ8muV1k9WmN
 qhsPiIS/MSsZCK3kRzDvaw+0JlxjVAlEBOXReF1Ole5e4cim8Ix98I+P3s2iB0pjETgh
 4olcGJJA6v17advd6X5Umj338WUoZ5U5oHPqpXgnzEbuf9hJhJRA5QkY046+wh5GqpjU
 Lpgg==
X-Gm-Message-State: AOAM530i+3WQNgxxujTY7yB8/o4O6dmcX0VHIDWvFgBAgcM/bhrkP86C
 y2aCM+kVCAtOS1Zu3DNqrFtzHIlfpxLzQMOy8gqTcRIupd1ipg==
X-Google-Smtp-Source: ABdhPJyfIv20Z8CvhiK2kmFsp7QjRFuzVtkF58eXwrrPb1wqq7/0fWD4O6jHLUkEeUxb9nCoK9N/XK/M0olPMWjoswE=
X-Received: by 2002:a05:6830:51:: with SMTP id
 d17mr23326265otp.75.1621950434293; 
 Tue, 25 May 2021 06:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210525134422.620425-1-nolange79@gmail.com>
In-Reply-To: <20210525134422.620425-1-nolange79@gmail.com>
Date: Tue, 25 May 2021 15:47:03 +0200
Message-ID: <CADYdroN-MQo2SsAL8msYddNnUXr1A0uR9eEasp8W-FV4bMM7Lw@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH lttng-ust] Improve tracef/tracelog to use
 the stack for small strings
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Di., 25. Mai 2021 um 15:44 Uhr schrieb Norbert Lange <nolange79@gmail.com>:
>
> Support two common cases, one being that the resulting message is
> small enough to fit into a on-stack buffer.
> The seconds being the common 'printf("%s", "Message")' scheme.
>
> Unfortunately, iterating a va_list is destructive,
> so it has to be copied before calling vprintf.
>
> The implementation was moved to a separate file,
> used by both tracef.c and tracelog.c.
>
> Signed-off-by: Norbert Lange <nolange79@gmail.com>
> ---
>  src/common/tracer.h                           |  2 +
>  src/lib/lttng-ust-tracepoint/tracef.c         | 32 ++-----
>  .../lttng-ust-tracepoint/tracelog-internal.h  | 83 +++++++++++++++++++
>  src/lib/lttng-ust-tracepoint/tracelog.c       | 40 ++-------
>  4 files changed, 102 insertions(+), 55 deletions(-)
>  create mode 100644 src/lib/lttng-ust-tracepoint/tracelog-internal.h
>
> diff --git a/src/common/tracer.h b/src/common/tracer.h
> index 2affd6ab..8e18c9b5 100644
> --- a/src/common/tracer.h
> +++ b/src/common/tracer.h
> @@ -26,6 +26,8 @@
>  #define LTTNG_RFLAG_EXTENDED           RING_BUFFER_RFLAG_END
>  #define LTTNG_RFLAG_END                        (LTTNG_RFLAG_EXTENDED << 1)
>
> +#define LTTNG_TRACE_PRINTF_BUFSIZE     512
> +
>  /*
>   * LTTng client type enumeration. Used by the consumer to map the
>   * callbacks from its own address space.
> diff --git a/src/lib/lttng-ust-tracepoint/tracef.c b/src/lib/lttng-ust-tracepoint/tracef.c
> index c05c7811..92911e1d 100644
> --- a/src/lib/lttng-ust-tracepoint/tracef.c
> +++ b/src/lib/lttng-ust-tracepoint/tracef.c
> @@ -7,6 +7,7 @@
>  #define _LGPL_SOURCE
>  #include <stdio.h>
>  #include "common/macros.h"
> +#include "common/tracer.h"
>
>  /* The tracepoint definition is public, but the provider definition is hidden. */
>  #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
> @@ -15,39 +16,22 @@
>  #define LTTNG_UST_TRACEPOINT_DEFINE
>  #include "lttng-ust-tracef-provider.h"
>
> -static inline
> -void lttng_ust___vtracef(const char *fmt, va_list ap)
> -       __attribute__((always_inline, format(printf, 1, 0)));
> -static inline
> -void lttng_ust___vtracef(const char *fmt, va_list ap)
> -{
> -       char *msg;
> -       const int len = vasprintf(&msg, fmt, ap);
> -
> -       /* len does not include the final \0 */
> -       if (len < 0)
> -               goto end;
> -       lttng_ust_tracepoint_cb_lttng_ust_tracef___event(msg, len,
> -               LTTNG_UST_CALLER_IP());
> -       free(msg);
> -end:
> -       return;
> -}
> +#include "tracelog-internal.h"
>
>  void lttng_ust__vtracef(const char *fmt, va_list ap)
>         __attribute__((format(printf, 1, 0)));
>  void lttng_ust__vtracef(const char *fmt, va_list ap)
>  {
> -       lttng_ust___vtracef(fmt, ap);
> +       LTTNG_UST_TRACELOG_VALIST(fmt, ap,
> +               lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
> +               msg, len, LTTNG_UST_CALLER_IP());
>  }
>
>  void lttng_ust__tracef(const char *fmt, ...)
>         __attribute__((format(printf, 1, 2)));
>  void lttng_ust__tracef(const char *fmt, ...)
>  {
> -       va_list ap;
> -
> -       va_start(ap, fmt);
> -       lttng_ust___vtracef(fmt, ap);
> -       va_end(ap);
> +       LTTNG_UST_TRACELOG_VARARG(fmt,
> +               lttng_ust_tracepoint_cb_lttng_ust_tracef___event,
> +               msg, len, LTTNG_UST_CALLER_IP());
>  }
> diff --git a/src/lib/lttng-ust-tracepoint/tracelog-internal.h b/src/lib/lttng-ust-tracepoint/tracelog-internal.h
> new file mode 100644
> index 00000000..291ff27c
> --- /dev/null
> +++ b/src/lib/lttng-ust-tracepoint/tracelog-internal.h
> @@ -0,0 +1,83 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (C) 2013-2014 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + * Copyright (C) 2021 Norbert Lange <nolange79@gmail.com>
> + *
> + * Shared helper macro for tracelog and tracef
> + */
> +
> +#define LTTNG_UST_TRACELOG_VARARG(fmt, callback, ...) \
> +       va_list ap; \
> +       char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +       int len; \
> +       char *msg = local_buf; \
> +       size_t buflen = sizeof(local_buf); \
> +       char *alloc_buff = NULL; \
> +\
> +       if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +               va_start(ap, fmt); \
> +               msg = va_arg(ap, char *); \
> +               va_end(ap); \
> +               len = strlen(msg); \
> +       } else \
> +               for(;;) { \
> +                       va_start(ap, fmt); \
> +                       len = vsnprintf(msg, buflen, fmt, ap); \
> +                       va_end(ap); \
> +\
> +                       if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
> +                               buflen = (size_t)len + 1U; \
> +                               len = -1; \
> +                               alloc_buff = (char *)malloc(buflen); \
> +                               msg = alloc_buff; \
> +                               if (!alloc_buff) \
> +                                       break; \
> +                       } else \
> +                               break; \
> +               } \
> +\
> +       /* len does not include the final \0 */ \
> +       if (caa_likely(len >= 0)) { \
> +               callback(__VA_ARGS__); \
> +       } \
> +       /* Dont call a potentially instrumented forbidden free needlessly. */ \
> +       if (caa_unlikely(alloc_buff)) \
> +               free(alloc_buff);
> +
> +#define LTTNG_UST_TRACELOG_VALIST(fmt, ap, callback, ...) \
> +       char local_buf[LTTNG_TRACE_PRINTF_BUFSIZE]; \
> +       int len; \
> +       char *msg = local_buf; \
> +       size_t buflen = sizeof(local_buf); \
> +       char *alloc_buff = NULL; \
> +\
> +       if (caa_unlikely(fmt[0] == '%' && fmt[1] == 's' && fmt[2] == '\0')) { \
> +               msg = va_arg(ap, char *); \
> +               len = strlen(msg); \
> +       } else \
> +               for(;;) { \
> +                       va_list ap2; \
> +\
> +                       va_copy(ap2, ap); \
> +                       len = vsnprintf(msg, buflen, fmt, ap2); \
> +                       va_end(ap2); \
> +\
> +                       if (caa_unlikely(len >= (int)sizeof(local_buf) && !alloc_buff)) { \
> +                               buflen = (size_t)len + 1U; \
> +                               len = -1; \
> +                               alloc_buff = (char *)malloc(buflen); \
> +                               msg = alloc_buff; \
> +                               if (!alloc_buff) \
> +                                       break; \
> +                       } else \
> +                               break; \
> +               } \
> +\
> +       /* len does not include the final \0 */ \
> +       if (caa_likely(len >= 0)) { \
> +               callback(__VA_ARGS__); \
> +       } \
> +       /* Dont call a potentially instrumented forbidden free needlessly. */ \
> +       if (caa_unlikely(alloc_buff)) \
> +               free(alloc_buff);
> diff --git a/src/lib/lttng-ust-tracepoint/tracelog.c b/src/lib/lttng-ust-tracepoint/tracelog.c
> index 8147d7a3..bd38032c 100644
> --- a/src/lib/lttng-ust-tracepoint/tracelog.c
> +++ b/src/lib/lttng-ust-tracepoint/tracelog.c
> @@ -7,6 +7,7 @@
>  #define _LGPL_SOURCE
>  #include <stdio.h>
>  #include "common/macros.h"
> +#include "common/tracer.h"
>
>  /* The tracepoint definition is public, but the provider definition is hidden. */
>  #define LTTNG_UST_TRACEPOINT_PROVIDER_HIDDEN_DEFINITION
> @@ -15,32 +16,9 @@
>  #define LTTNG_UST_TRACEPOINT_DEFINE
>  #include "lttng-ust-tracelog-provider.h"
>
> +#include "tracelog-internal.h"
> +
>  #define LTTNG_UST_TRACELOG_CB(level) \
> -       static inline \
> -       void lttng_ust___vtracelog_##level(const char *file, \
> -                       int line, const char *func, \
> -                       const char *fmt, va_list ap) \
> -               __attribute__((always_inline, format(printf, 4, 0))); \
> -       \
> -       static inline \
> -       void lttng_ust___vtracelog_##level(const char *file, \
> -                       int line, const char *func, \
> -                       const char *fmt, va_list ap) \
> -       { \
> -               char *msg; \
> -               const int len = vasprintf(&msg, fmt, ap); \
> -               \
> -               /* len does not include the final \0 */ \
> -               if (len < 0) \
> -                       goto end; \
> -               lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level(file, \
> -                       line, func, msg, len, \
> -                       LTTNG_UST_CALLER_IP()); \
> -               free(msg); \
> -       end: \
> -               return; \
> -       } \
> -       \
>         void lttng_ust__vtracelog_##level(const char *file, \
>                         int line, const char *func, \
>                         const char *fmt, va_list ap) \
> @@ -53,7 +31,9 @@
>                         int line, const char *func, \
>                         const char *fmt, va_list ap) \
>         { \
> -               lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> +               LTTNG_UST_TRACELOG_VALIST(fmt, ap, \
> +                       lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
> +                       file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
>         } \
>         \
>         void lttng_ust__tracelog_##level(const char *file, \
> @@ -68,11 +48,9 @@
>                         int line, const char *func, \
>                         const char *fmt, ...) \
>         { \
> -               va_list ap; \
> -               \
> -               va_start(ap, fmt); \
> -               lttng_ust___vtracelog_##level(file, line, func, fmt, ap); \
> -               va_end(ap); \
> +               LTTNG_UST_TRACELOG_VARARG(fmt, \
> +                       lttng_ust_tracepoint_cb_lttng_ust_tracelog___##level, \
> +                       file, line, func, msg, len, LTTNG_UST_CALLER_IP()); \
>         }
>
>  LTTNG_UST_TRACELOG_CB(LTTNG_UST_TRACEPOINT_LOGLEVEL_EMERG)
> --
> 2.30.2
>

This is to be applied on top of:
https://review.lttng.org/c/lttng-ust/+/5927 Move tracef/tracelog
symbols to liblttng-ust-tracepoint.so

So consider this a WIP for feedback.

Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
