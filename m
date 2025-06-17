Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117F1C71157
	for <lttng-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8By35gHz227x
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750169978;
	b=qUYECaDhkEr36R0nF1u8dGIuEkm0vx5akVbeYZQogxnxCMoU8bvZsvu7ly7MQ+bz0EPW
	 oEgSC/E6mRAXzwJzoDxtV+ySOX13RbYb4ZR8s32CuCa+nMMzhSGtuLcUMOZsjKbfRQNUK
	 9+VWI7HPKISLKeIow5yO9W1mWVw6ZcVmQ3NE885DIcLf50OQWLGIkiYc3Sbv3w/0v+Cnt
	 DvqO7irV+pyOmyLpKHXU7TE+SJ/hMDmcNebbR1OZ24z3nEHvLr1fIUm67SmSjxl6RHg6K
	 J7CWvFJW13bVna0c3UdJaX3qeM6ahP/Pmr+6XkS2mBFeKbYGHpYXltx1MePrjwPa98w==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750169978;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=a56wrbWI+ICLMM+fNz3qAQBeG+et5jY359IYaQ4fjUw=;
	b=WuyTBzibnN+vTnbxilVo74llUZpfaieSX5yu+IkOJaOxuoT6WzU55nOa9kuU1yWL7ASF
	 a8ChW2PzkvzxWflHFLsjyrt8raAkIrggOso91UCkOYEKOZ7L80mfdYTG3MyfZyaXAcvvD
	 +0USPReXGi+RbmVQFZtesLZqvbN3cLW6u49hRNf2EQGQt6Wf2l3WSBOUpc2pMu+0PqhJI
	 K0yyvoJgcUrdFcqgXaEjABbxJXLbwxhX9CzaM4g4HbiKHZ80rC3q/JYRuOGiXAvXrOtqe
	 Af2UyKUY7agCeKPJZu98jlkGP+UcXDoitrEwW4+OxNLSBdb6Bgo2Z/P47dtrr+bzQMg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8By35gHz227x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750169978;
	bh=a56wrbWI+ICLMM+fNz3qAQBeG+et5jY359IYaQ4fjUw=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rrnw9mrxPOzeSlMAzGnJGPk90aY8Csqa03qkVXBAgg5aiXfGJ1JG1DTCCMxAMWqhN
	 qGA8nbheH58w9EiSxI20ijZ1bBhrEQq0F3zLzGbGHmn5oGRlqhDC4Vd8sDkrBz4dtB
	 EJPmqTk4BlezVOeBGlVEYDJvPAY5zQgXXy5vNXH1qrskiXBXNLTJzjzW9GdHz2VeQ1
	 65vYcbKhJEovdV8eqQ7izhKzGrAo12RCMlja15Ab/O63SMIXvxYNDIbdV4A26jBQrx
	 fDqMAc98ISoS++8lf4COX/qh0dXsYbZwYGhdmRcSVE2sdvO49jEbt5MrJ2SMJEPqGw
	 YzgOOaTh3D6Wg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bM8By35gHz227x;
	Tue, 17 Jun 2025 10:19:38 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bM8Bw325Cz22Q9
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bM8Bw325Cz22Q9
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4bM8Bw325Cz22Q9
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 10:19:36 -0400 (EDT)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-32ae3e94e57so51119971fa.1
 for <lttng-dev@lists.lttng.org>; Tue, 17 Jun 2025 07:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169975; x=1750774775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j5B8oXuMWBwpeiWXHl9012xJnK6v8JuxW9c5APRFmMM=;
 b=QxxpY6Fvo4T1bGGWsLqcwV1HY5ipZnF9NDHOpBopdwng7uJArMiVKs1cwA/i3x5I05
 k7HlQ0Udxf2RqWiBycvw7KYZuxjHFfthSwLdxr3bZK5dE5MDJL0kL23xmnDE5NmJlnhS
 Pq299ur/3zMlIlfGInZkH71ASnD5R/jiWSJ3CDXxxaP43Or2mNZ+PahWbmflwebrXgkB
 9yxKaJlrjSFBk/8VvPTBMA2lGfLF3vxFoxotnROWE5Oh4MvvB60VKjylZM+LyM4FIbB0
 WZRNGzTjyIqv3k4ciHfr5/jIC05dDP+uGPR5JI+XiKAkIe3WiG704ROf8mtn0dnb9dFS
 JocQ==
X-Gm-Message-State: AOJu0YwfDT8VdwL0euZzT/rF2bKt5F/oRd3/Eu7nemxpI9qvKUy5akFi
 3J5WM84ZnWieGgetnqma0+U0QHYRX1+VIDqLBYCmC2U/4dZLqEdvdlZD39RNjtOXIdUNJ72+UdZ
 G3t+Qz4Q1NLCawt8fYTl3DPoBz7ORlFg=
X-Gm-Gg: ASbGncsOaP+n8EL/n4fWpO84+IJDkq+ZnpVe+RTIF65n8L3Rld56XPbto0xgxLaFMtP
 3i5w3dtBD+g2UQSU1YU/1NVS+4DJZd/nGS/m4RKFV7h6QGvXB+Bot+lT2CqGjUGFwa53ovPjFEm
 vLHVrqcmBHublNvknx6HpAXWtzSMlsZCgpyeZXEBhyVZk=
X-Google-Smtp-Source: AGHT+IEoVC04mr0LjWmzRQBcaQj00RALHEuiuN82oCqornCoLPLEl4cXuVqI+Sg6xVS4t8y9Zjfk00LhFaIgymv75No=
X-Received: by 2002:a05:651c:b0e:b0:32a:6c63:935 with SMTP id
 38308e7fff4ca-32b4a43374fmr32983481fa.4.1750169974610; Tue, 17 Jun 2025
 07:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADYdroMJgt=bMGWmxFV8YAKWouBJeL5244_RM1S-D0SDF+tkzg@mail.gmail.com>
 <294104910.2889.1633458501063.JavaMail.zimbra@efficios.com>
 <CADYdroN+AaoceVJy9-k9c=kAY8MdbQ_a=rE-KpPPULW7cpuPyQ@mail.gmail.com>
In-Reply-To: <CADYdroN+AaoceVJy9-k9c=kAY8MdbQ_a=rE-KpPPULW7cpuPyQ@mail.gmail.com>
Date: Tue, 17 Jun 2025 16:19:23 +0200
X-Gm-Features: AX0GCFtibFPYCRN1aGtOc-4Wui2rIoXT10RAOkhCfXmWQRPCWSetZ9zwcCdilC0
Message-ID: <CADYdroNTqyCnaNBS7RbMKGw-xZ+_YH3nsEr0k-VSjH5DaqntiQ@mail.gmail.com>
Subject: Re: [lttng-dev] Feature request: dynamically load from prefix
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Am Fr., 10. Dez. 2021 um 23:43 Uhr schrieb Norbert Lange <nolange79@gmail.com>:
>
> Am Di., 5. Okt. 2021 um 20:28 Uhr schrieb Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com>:
> >
> > ----- On Jul 15, 2021, at 7:21 AM, lttng-dev lttng-dev@lists.lttng.org wrote:
> >
> > > Hello,
> > >
> > > The production rootfs should be untouched, ideally read-only,
> > > for development/tests a subdirectory can be mounted (eg. /usr/local).
> > > Idea is that the contents of that directory alone (and at most some
> > > env variables)
> > > should allow enabling development features.
> > >
> > > For lttng I would have wanted to add a library
> > > '/usr/local/lib/libmyservice-tracepoints.so' with runpath
> > > '/usr/local/lib' that would activate lttng tracing,
> > > pulling in lttng libraries (ust, ust-tracepoint) from /usr/local/lib.
> > >
> > > There is a caveat though, unless 'libmyservice-tracepoints.so'' is
> > > preloaded, the code in lttng/tracepoint.h will run constructor functions
> > > to register the tracepoint probes, trying to dlopen the lttng-ust-tracepoint
> > > library and fail at that because this is not in the library search paths.
> > >
> > > At a later time,  'libmyservice-tracepoints.so'' will be loaded, and
> > > lttng-ust-tracepoint (along with lttng-ust) can be resolved. but the
> > > tracepoints are not registered.
> > >
> > > So I guess what I would need is to either retrigger the registration
> > > of tracepoints
> > > (likely complicated with static and weak symbols potentially causing a mess), or
> > > redirect the dlopen function.
> > > Useful would be either try to find the library in /usr/local/lib or
> > > use '/usr/local/lib/libmyservice-tracepoints.so''
> > > instead of  lttng-ust-tracepoint (both have (dis)advantages).
> > >
> > > At any rate, I would welcome some customization macro.
> >
> > I'm currently working on improvements to the reporting of such scenario.
> >
> > See:
> >
> > https://review.lttng.org/c/lttng-ust/+/6480 tracepoints: print debug message when lttng-ust-tracepoint.so is not found
> > https://review.lttng.org/c/lttng-ust/+/6484 tracepoints: increase dlopen failure message level from debug to critical
> >
> > With this in place, it should be easier for a lttng end-user to figure out that
> > liblttng-ust-tracepoint.so cannot be found by dlopen() because it is not in the
> > system's library search path.
> >
> > From that point, what is wrong with requesting the user to add the path towards
> > liblttng-ust-tracepoint.so to the environment variable LD_LIBRARY_PATH when running
> > the application ?
>
> Not feasible if this is a read-only rootfs, service configuration cant
> be modified.
> the idea is to have some trickery to allow /usr/local mounted to a NFS
> or small rw filesystem,
> then drop the files (libmyservice-tracepoints.so and
> liblttng-ust-tracepoint.so and services) there.
> then, the app can be instructed to load
> /usr/local/lib/libmyservice-tracepoints.so
>
> /usr/local is not referenced anywhere in the rootfs and should not
> affect anything,
> if for ex I drop another libc.so.6 there it should not affect anything
> normally running.
> Ideally liblttng-ust-tracepoint.so could be loaded later and not
> pulled in by the tracepoint stubs,
> but I understand that this is complicated.
>
> Any good reason not to provide some customization point like
> LTTNG_TRACEPOINT_PROBE_DLOPEN
> for the stuff you locally include into your build?
> Would meet me half-way ;)
>
> Norbert
>
>
>
> >
> > Thanks,
> >
> > Mathieu
> >
> > >
> > > For illustration the current hack-around is following
> > >
> > > Norbert Lange
> > >
> > > #define TRACEPOINT_DEFINE
> > > #define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> > >
> > > #include <dlfcn.h>
> > >
> > > static inline void *s_remap_dlopen(const char *localfilename, int
> > > flags, unsigned prelen) {
> > >    void *md = (dlopen)(localfilename + prelen, flags);
> > >    return md ? md : (dlopen)(localfilename, flags);
> > > }
> > >
> > > # ideally this would be LTTNG_TRACEPOINT_PROBE_DLOPEN instead of the dlopen mess
> > > #define dlopen(x, y) s_remap_dlopen("/usr/local/lib/" x, y,
> > > (unsigned)sizeof("/usr/local/lib/") - 1U)
> > >
> > > #include "trace_mytracepoints.h"
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com

Well, still no joy with lttng-ust-2.14.0-rc2.

I would like either some MACRO like the above, or some way to make
sure I can run code before lttng_ust__tracepoints__init is executed.
Probably using a constructor with priority LTTNG_UST_CONSTRUCTOR_PRIO
- 1 should suffice?
