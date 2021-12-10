Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E6BC433EF
	for <lttng-dev@archiver.kernel.org>; Fri, 10 Dec 2021 22:44:13 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4J9mDD19Jxz1t7M;
	Fri, 10 Dec 2021 17:44:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1639176252;
	bh=jC8e6qYzDG4lvCXQvHHw9p2oovrV+2x11o+xSFvAMY0=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BKC6FkZS7wxPBcgoz5X7n42qvqHEOIn35K3tF5QZeFuGXiOQzg2UIthiMeCbbT9CO
	 oRiubEI+nYuOy2EsMqNe+JWzprIWy42h/8b1VBPUaSH9pJLqDxPjH05aThO/zxkXZ/
	 rs3ConTofApVOXuEwe4RlGf6Mml9aUd6xr8hH55g6G6U3GMM7K8AB/Sue5F9583C5n
	 h9MHZC2VtbGJh4lFtJDyk+2nHrZpFuWCWeI6yV+P6eHdw5Tu/j3Jbc7hJeHp+jfxSZ
	 cHLsR3Vm/eY0dCNRvjIncENBhkNgDv5IISV7Xp+aBCMDdFMHQ1YN+LEHrEPCW4/wzL
	 zfN6eyulUZAbw==
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4J9mDC3NPFz1sx1
 for <lttng-dev@lists.lttng.org>; Fri, 10 Dec 2021 17:44:11 -0500 (EST)
Received: by mail-oi1-x22f.google.com with SMTP id n66so15176471oia.9
 for <lttng-dev@lists.lttng.org>; Fri, 10 Dec 2021 14:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SLtZfagmHLO2Lo+fKJSsSRhZFfFSiUDb5zVG12AB07w=;
 b=iAVt0uRdS8nCzvdJ+77upGdKcWmPcdOotIfChj2KiY5z1SDODxUCJZTF4sQhmfo0I+
 ivRbABTeIGJbclCXxkEZwxAFF/kQO8Fw9U+aX3b+JFY+JGfMYBWQ8yj6TP0O8ryrE8jL
 gYT68m6TJM5fXWf28YWzCCRVCG3Nzu16JlqVcunQj2YtmBj4E/il89ZC2J95EHe2DrFh
 BhYZEx9KfQWMhVGQKvdT6ObeRupt0eEZR6QdtMfwujf85UaY+25Qc3yQh8OntgxvO3KK
 eiIqr4ZCukYtACI1R7SOYOmkIpP6BkKg0eh0QyfrI9Tc/Gu1o616F2zXZmbfPGlCypqb
 enkg==
X-Gm-Message-State: AOAM533JyYeKWppCPpcYU+kN3Iv+jGeWclSgjYWsy0L85qdFrEVE0Pf5
 PkMvLY1ioX/M5SxccxPXgJ+hO+pSxjbz/m1d7NU=
X-Google-Smtp-Source: ABdhPJyzx9Sd4+R2VKB9gM3CHCUSqI9bMjs1YQOg9C4oRztJa4gIcrHVWxrfVgs3+aXrPPeZa4sgmw4k3awrXOrU1DM=
X-Received: by 2002:a05:6808:14e:: with SMTP id
 h14mr15056051oie.28.1639176250367; 
 Fri, 10 Dec 2021 14:44:10 -0800 (PST)
MIME-Version: 1.0
References: <CADYdroMJgt=bMGWmxFV8YAKWouBJeL5244_RM1S-D0SDF+tkzg@mail.gmail.com>
 <294104910.2889.1633458501063.JavaMail.zimbra@efficios.com>
In-Reply-To: <294104910.2889.1633458501063.JavaMail.zimbra@efficios.com>
Date: Fri, 10 Dec 2021 23:43:59 +0100
Message-ID: <CADYdroN+AaoceVJy9-k9c=kAY8MdbQ_a=rE-KpPPULW7cpuPyQ@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Feature request: dynamically load from prefix
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Di., 5. Okt. 2021 um 20:28 Uhr schrieb Mathieu Desnoyers
<mathieu.desnoyers@efficios.com>:
>
> ----- On Jul 15, 2021, at 7:21 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Hello,
> >
> > The production rootfs should be untouched, ideally read-only,
> > for development/tests a subdirectory can be mounted (eg. /usr/local).
> > Idea is that the contents of that directory alone (and at most some
> > env variables)
> > should allow enabling development features.
> >
> > For lttng I would have wanted to add a library
> > '/usr/local/lib/libmyservice-tracepoints.so' with runpath
> > '/usr/local/lib' that would activate lttng tracing,
> > pulling in lttng libraries (ust, ust-tracepoint) from /usr/local/lib.
> >
> > There is a caveat though, unless 'libmyservice-tracepoints.so'' is
> > preloaded, the code in lttng/tracepoint.h will run constructor functions
> > to register the tracepoint probes, trying to dlopen the lttng-ust-tracepoint
> > library and fail at that because this is not in the library search paths.
> >
> > At a later time,  'libmyservice-tracepoints.so'' will be loaded, and
> > lttng-ust-tracepoint (along with lttng-ust) can be resolved. but the
> > tracepoints are not registered.
> >
> > So I guess what I would need is to either retrigger the registration
> > of tracepoints
> > (likely complicated with static and weak symbols potentially causing a mess), or
> > redirect the dlopen function.
> > Useful would be either try to find the library in /usr/local/lib or
> > use '/usr/local/lib/libmyservice-tracepoints.so''
> > instead of  lttng-ust-tracepoint (both have (dis)advantages).
> >
> > At any rate, I would welcome some customization macro.
>
> I'm currently working on improvements to the reporting of such scenario.
>
> See:
>
> https://review.lttng.org/c/lttng-ust/+/6480 tracepoints: print debug message when lttng-ust-tracepoint.so is not found
> https://review.lttng.org/c/lttng-ust/+/6484 tracepoints: increase dlopen failure message level from debug to critical
>
> With this in place, it should be easier for a lttng end-user to figure out that
> liblttng-ust-tracepoint.so cannot be found by dlopen() because it is not in the
> system's library search path.
>
> From that point, what is wrong with requesting the user to add the path towards
> liblttng-ust-tracepoint.so to the environment variable LD_LIBRARY_PATH when running
> the application ?

Not feasible if this is a read-only rootfs, service configuration cant
be modified.
the idea is to have some trickery to allow /usr/local mounted to a NFS
or small rw filesystem,
then drop the files (libmyservice-tracepoints.so and
liblttng-ust-tracepoint.so and services) there.
then, the app can be instructed to load
/usr/local/lib/libmyservice-tracepoints.so

/usr/local is not referenced anywhere in the rootfs and should not
affect anything,
if for ex I drop another libc.so.6 there it should not affect anything
normally running.
Ideally liblttng-ust-tracepoint.so could be loaded later and not
pulled in by the tracepoint stubs,
but I understand that this is complicated.

Any good reason not to provide some customization point like
LTTNG_TRACEPOINT_PROBE_DLOPEN
for the stuff you locally include into your build?
Would meet me half-way ;)

Norbert



>
> Thanks,
>
> Mathieu
>
> >
> > For illustration the current hack-around is following
> >
> > Norbert Lange
> >
> > #define TRACEPOINT_DEFINE
> > #define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> >
> > #include <dlfcn.h>
> >
> > static inline void *s_remap_dlopen(const char *localfilename, int
> > flags, unsigned prelen) {
> >    void *md = (dlopen)(localfilename + prelen, flags);
> >    return md ? md : (dlopen)(localfilename, flags);
> > }
> >
> > # ideally this would be LTTNG_TRACEPOINT_PROBE_DLOPEN instead of the dlopen mess
> > #define dlopen(x, y) s_remap_dlopen("/usr/local/lib/" x, y,
> > (unsigned)sizeof("/usr/local/lib/") - 1U)
> >
> > #include "trace_mytracepoints.h"
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
