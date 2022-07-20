Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF313C43334
	for <lttng-dev@archiver.kernel.org>; Wed, 20 Jul 2022 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1658347214;
	bh=Zg/TFjxJGz69adDeMwaDrC6yyqw0a5MhdJ8loJ1tkW4=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oqXepRTiJsiD9KnQBom6XTYVbOnXYB2kq9DijA0pSWovhYuhvGpJsxXPmRZAIvwGJ
	 6IQ6qMpgPx4TSVNV4DfOvZVN6Slvr62Zm9MFr9yo8EJFj3WyHVEOaWN6CYnOkxwO9/
	 1jWOcHMDG/ok9MvKVXZNiGFN5uaZO5R61fgYgJY9ldAaq6B+K5xrGPoG8FgLVOmBY3
	 QGPm/3r16VAZE5NryJB4sGoEkr2A8dAnDN5X2zSVh5sWpy8wcnCE/Cw5RfpEZEF8Oc
	 iF9nF/gKBe6wIAPGgp7LuXBV5T3BNEzbXAtO2d5l4u7FHTNUv50YJcPobznejyjjgf
	 tiH3YqI3nMjBQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Lp64Y5cQWzQCD;
	Wed, 20 Jul 2022 16:00:13 -0400 (EDT)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by lists.lttng.org (Postfix) with ESMTPS id 4Lp64X4YcVzQCC
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jul 2022 16:00:12 -0400 (EDT)
Received: by mail-vk1-xa30.google.com with SMTP id o10so2310406vkl.3
 for <lttng-dev@lists.lttng.org>; Wed, 20 Jul 2022 13:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z+9HnkSs0d3NSoz5LBZ3SPAhZmqlSBX1N5g2o1rw+Ic=;
 b=hXkWZie8Sm4V8Tb2wQE0MB0K33W2bFSmDSXRd2gbgBH5anzwqafbciOKwEm2wP0+RB
 wdk2++jHsLAkTLOhq1tkTOiYOwJAkabBMPxySy6fgXzoBlY/4VoJHLZjhJvEMObCO/07
 bOQHlLNi+Zg3rWJzt05UUhB9F/0SvRRxSTLzJqcXJE0k/eeSXugxVMEcwBKOB3INh+jc
 y/Rr0sdu5YDXoPH6Ar/Tcg/6kssAeM0MOJ8XlcvJiaw/3CTOWQpixINRZPgXvIv7kBNs
 i3IboP5a6DSu2Ud5NqKqsQ1cFY+nbN0jxFk/UJ9UbtKzXzfv4LmdJY2zKLGRtBLKi0mp
 iTrw==
X-Gm-Message-State: AJIora9AsKcssrFhFXdAvwrFeN8017Fcoy4y9IioYihDDH4dXFd8nsiw
 feV51paYLGMt79C3m84POl2wpP3qSaP6PKcWl40=
X-Google-Smtp-Source: AGRyM1ufMUr3fVQ4UxyAVGMQ0KpW6QPwbNmvs6oj1BLfldpEPR8KTyW8ducPR3wRtz0ELWLcwAAdTH4l2AMtZh9OYj4=
X-Received: by 2002:a1f:948f:0:b0:374:b54b:d917 with SMTP id
 w137-20020a1f948f000000b00374b54bd917mr14580260vkd.14.1658347211749; Wed, 20
 Jul 2022 13:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220718215955.124991-1-nolange79@gmail.com>
 <1399876011.74159.1658259573115.JavaMail.zimbra@efficios.com>
In-Reply-To: <1399876011.74159.1658259573115.JavaMail.zimbra@efficios.com>
Date: Wed, 20 Jul 2022 22:00:00 +0200
Message-ID: <CADYdroOM93P9HyxZQAuEhZZNFWXoDobh3XTwCdCO0j0BG5rANQ@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [PATCH 1/2] lttng_ust_init_thread: initialise
 cached context values
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
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

Am Di., 19. Juli 2022 um 21:39 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On Jul 18, 2022, at 5:59 PM, Norbert Lange via lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Modify all relevant *_alloc_tls functions so that they take an
> > argument for 'init'. Setting this to 'true' will read
> > the actual context value and store it into a thread local
> > cache.
> >
> > The function 'lttng_ust_init_thread' will use this to
> > precalculate context values. Tracepoints can then avoid
> > systemcalls.
>
> Rather than integrating two unrelated things within "alloc_tls"
> functions, I would prefer that we split things like this, e.g.:
>
> keep lttng_cgroup_ns_alloc_tls() as is.
>
> Introduce lttng_ust_cgroup_init_thread() which would
> call (void)get_cgroup_ns().
>
> Likewise for all other contexts.
>
> Thoughts ?

is this just a matter of the function name? The "things" are
related as they both prepare the same thread local cache.

ie.
rename lttng_cgroup_ns_alloc_tls(bool init) to
lttng_ust_cgroup_init_thread(bool initcache)?

Don't care much either way,I  just usually try to limit symbols.

Regards,
Norbert
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
