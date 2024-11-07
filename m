Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ADAD4336E
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730991550;
	bh=USYGwT0CnhuztTwMvMpty8PeqNibYvC+6hcp6yunrNM=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qtXOcPwSTO+TjjOYm62/6vnnqg3AIRxPN9GWYwqJgWKQQxoLzql0uqr9B1SddP8tB
	 GmOIKpA/IfmqI6o0Y9U20jPPIBzp4821yi5h+0IRoQ0PUh7OmAkhvH7rPwKuOpgOnb
	 wFCr6rGrpAMoHo/jL6z7ACt1/PKGlcVIqVYWvgepoHR3JiRfcabPzSsZvmMdUpI+J5
	 TQwSZjfdoImvHGm7OGb27ThHMisQIUeO5DPsqUyf+gH7+gFhzOT28R0t0iH3RUzWvK
	 01c/DU/SeAzXhtoKNmrEbokVhdakYawt410PaBZ+61PjKIW3IZnQrVrQN+8gbBZGkl
	 2X6YoAeMTJFuA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Xklb22SBwz1hs2;
	Thu,  7 Nov 2024 09:59:10 -0500 (EST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by lists.lttng.org (Postfix) with ESMTPS id 4Xklb05YbWz1hpc
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 09:59:08 -0500 (EST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed49edd41so188398066b.0
 for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2024 06:59:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730991547; x=1731596347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUGyCvt2+9lZYkzNFWaHOwTeWSU6bLTthiHPKVuC/fE=;
 b=WxbVrp/RHTU2Op6ZXrXS9Cb8Q9xLTwMmtiLs1rUhg6jQ3NkjdbJxc6R7eV8f28sPUW
 qmc3U42w4SPoNhxUGvaHAXFW4e+ntU91viaaCaPiYGV8f3HLJ7KkMV4Fl2XKjuP3a7+r
 e+T724kQBFtpgWhvulXSrX/9bzI4Sik/2FJtd8g04TKtiJZrl5U4JD91MSwrYRu9WAtP
 RGpEZm7vZHjNhck2Z4tVUZFTDVkSbYEUPDLnMhr9w9gDUsrrvfTe5DV8mA6PJ2Hf+3y7
 FFQTSZY5wpvNIdD1p82pVPjmNRrdLtpE+9Er+DsxmtuNOlcZ5S/u/fqUC8Dc0hnIhyxg
 tCBg==
X-Gm-Message-State: AOJu0YwwZi7tvnqXppSJHrlD5Qj+jcInfyOS8P5fKL1byUoc7HFX74D3
 4/6COrZPAN7Rw5A99i2+FCF1s4zIY4+6dpzSjNReba0ALtP7HSlbR6+1QUtdUdhpTHKN4wphuVa
 I0QHfIR6mgXnTf9Dv5Y8z4UDohdXMkFPi
X-Google-Smtp-Source: AGHT+IEKn/hFwP3mCdAUYw4tejbNgG709qrfQkWruO/nPuFnhlPNOaZDWJ4ZRergq8eBo2cyohTHs56zqspUFFoN8wQ=
X-Received: by 2002:a17:907:7e89:b0:a9a:26a1:1963 with SMTP id
 a640c23a62f3a-a9de5d6ebbfmr4409691566b.7.1730991547132; Thu, 07 Nov 2024
 06:59:07 -0800 (PST)
MIME-Version: 1.0
References: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
 <7f55ec8e-7af3-4af0-9ac9-f7ab4e00345f@efficios.com>
In-Reply-To: <7f55ec8e-7af3-4af0-9ac9-f7ab4e00345f@efficios.com>
Date: Thu, 7 Nov 2024 15:58:56 +0100
Message-ID: <CANVMif+RVoKyWu9FY1_9Z3hd_JpcrRuGLue6V3_5X0P2wmUEaA@mail.gmail.com>
Subject: Re: Kernel tracing from inside a Docker container
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Dirk Eibach via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dirk Eibach <dirk.eibach@googlemail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mathieu,

> 1) You modprobe all LTTng modules from your top level namespace (host
>     system) before starting lttng-sessiond within the container, or

since I already did a lttng session on the host/top level namespacer
the modules are already loaded:

root@9348eb19e6f4:/# lsmod
Module                  Size  Used by
lttng_probe_x86_exceptions    16384  0
lttng_probe_x86_irq_vectors    16384  0
lttng_probe_workqueue    20480  0
lttng_probe_vmscan     32768  0
lttng_probe_udp        16384  0
lttng_probe_timer      28672  0
lttng_probe_sunrpc     20480  0
lttng_probe_statedump    45056  0
lttng_probe_sock       16384  0
lttng_probe_skb        16384  0
lttng_probe_signal     16384  0
lttng_probe_scsi       20480  0
lttng_probe_sched      40960  0
lttng_probe_rcu        16384  0
lttng_probe_printk     16384  0
lttng_probe_power      20480  0
lttng_probe_net        28672  0
lttng_probe_napi       16384  0
lttng_probe_module     20480  0
lttng_probe_kvm        32768  0
lttng_probe_kmem       28672  0
lttng_probe_jbd2       28672  0
lttng_probe_irq        16384  0
lttng_probe_i2c        20480  0
lttng_probe_ext4      155648  0
lttng_probe_compaction    16384  0
lttng_probe_btrfs      65536  0
lttng_probe_block      36864  0
lttng_counter_client_percpu_32_modular    16384  0
lttng_counter_client_percpu_64_modular    16384  1
lttng_counter          16384  2
lttng_counter_client_percpu_64_modular,lttng_counter_client_percpu_32_modul=
ar
lttng_ring_buffer_event_notifier_client    16384  2
lttng_ring_buffer_metadata_mmap_client    16384  0
lttng_ring_buffer_client_mmap_overwrite    20480  0
lttng_ring_buffer_client_mmap_discard    20480  0
lttng_ring_buffer_metadata_client    16384  0
lttng_ring_buffer_client_overwrite    20480  0
lttng_ring_buffer_client_discard    20480  0
lttng_tracer         2666496  40
lttng_probe_udp,lttng_probe_scsi,lttng_probe_sched,lttng_probe_compaction,l=
ttng_probe_net,lttng_probe_vmscan,lttng_probe_x86_irq_vectors,lttng_probe_p=
ower,lttng_probe_rcu,lttng_probe_module,lttng_ring_buffer_client_mmap_overw=
rite,lttng_probe_statedump,lttng_ring_buffer_client_discard,lttng_probe_pri=
ntk,lttng_probe_x86_exceptions,lttng_probe_ext4,lttng_probe_sock,lttng_coun=
ter_client_percpu_64_modular,lttng_probe_irq,lttng_ring_buffer_client_mmap_=
discard,lttng_probe_kvm,lttng_probe_timer,lttng_probe_btrfs,lttng_ring_buff=
er_event_notifier_client,lttng_counter_client_percpu_32_modular,lttng_probe=
_workqueue,lttng_probe_jbd2,lttng_probe_i2c,lttng_probe_signal,lttng_probe_=
skb,lttng_probe_block,lttng_probe_napi,lttng_ring_buffer_metadata_client,lt=
tng_probe_kmem,lttng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_cli=
ent_overwrite,lttng_probe_sunrpc
lttng_statedump        49152  1 lttng_tracer
lttng_wrapper          16384  7
lttng_statedump,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_c=
lient_discard,lttng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_prob=
e_kmem,lttng_ring_buffer_client_overwrite
lttng_clock            16384  5
lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_discard,lt=
tng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client_o=
verwrite
lttng_lib_ring_buffer    61440  8
lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_discard,lt=
tng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_event_no=
tifier_client,lttng_ring_buffer_metadata_client,lttng_ring_buffer_metadata_=
mmap_client,lttng_ring_buffer_client_overwrite

Thanks
Dirk

On Thu, Nov 7, 2024 at 3:29=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2024-11-07 03:03, Dirk Eibach via lttng-dev wrote:
> > Hi,
> >
> > sorry, Outlook is messing up my plaintext mails, so I am switching to
> > my gmail account.
> >
> >> lttng-modules exposes its control ABI through the virtual file /proc/l=
ttng.
> >>
> >> Does you container have access to that file ?
> >
> > The container is running in privileged mode.
> > root@9348eb19e6f4:/# ls -l /proc/lttng
> > -rw------- 1 root root 0 Nov  6 16:05 /proc/lttng
> >
> >> Note that if you give access to that file within the container, then t=
he container
> >> can observe detailed information about kernel internals (including rel=
ated to
> >> other containers).
> >
> > This is a development-only system, so the security implications are acc=
eptable.
> >
> > I have observed one more thing. When I start the session daemon with
> > the -vvv option I get:
> > root@9348eb19e6f4:/# lttng list --kernel
> > DBG1 - 07:31:23.811796947 [Client management]: Wait for client
> > response (in thread_manage_clients() at client.c:2576)
> > DBG1 - 07:31:23.811867247 [Client management]: Receiving data from
> > client ... (in thread_manage_clients() at client.c:2604)
> > DBG1 - 07:31:23.811945247 [Client management]: Processing client
> > command 'LTTNG_LIST_TRACEPOINTS' (14) (in process_client_msg() at
> > client.c:1016)
> > Error: Failed to load kmod library resources
> > Warning: No kernel tracer available
>
> I suspect that you have two choices here:
>
> 1) You modprobe all LTTng modules from your top level namespace (host
>     system) before starting lttng-sessiond within the container, or
>
> 2) You ensure that the container has the ability to load kernel
>     modules, and you make sure the lttng-modules .ko are available
>     in the container's under /lib/modules/$(uname -r)/ directory.
>     (and run depmod -a), then launch lttng-sessiond as root.
>
> Thanks,
>
> Mathieu
>
> > DBG1 - 07:31:23.812076447 [Client management]: Missing llm header,
> > creating one. (in process_client_msg() at client.c:2381)
> > DBG1 - 07:31:23.812085547 [Client management]: Sending response (size:
> > 24, retcode: Kernel tracer not available (33)) (in
> > thread_manage_clients() at client.c:2683)
> > DBG1 - 07:31:23.812156547 [Client management]: Accepting client
> > command ... (in thread_manage_clients() at client.c:2534)
> > Error: Unable to list kernel events: Kernel tracer not available
> >
> > Regards
> > Dirk
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
