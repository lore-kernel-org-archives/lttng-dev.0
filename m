Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A782AD43370
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730995265;
	bh=gIyHoEgiT/JJVlesSv5UqS68t/Ga+IAZtGCMTpOrxcY=;
	h=References:In-Reply-To:Date:Subject:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=hyRB/NGlUogXO/l/RTUT1uMlStsBFNETsa30l9aoGLqfLD+k4H4H+VWDCISdrnZi2
	 GoK6+O212EJQzmqgXIvq/tQsORdSMEkZy5WzYmMN2KFRbzgQs+n5a5HqSC95aXePlQ
	 gCtdJINrHISiXMeAzmLiZMAm+R+i30Rudu8TCB0f2u4LJX1t5Ky73Y9J0zBmCAr9uv
	 p3iUmhog2HDoOU0I71xoyl27k2zKmWgJhQJ74vaQTqQUIN6oUP4RcT/ScbcuS9Jsg/
	 sN9MVCO3Jqpuk/6Pr5oPh92xEM9b0JDCIBG5bXDd6qgrGyoDtFnwcIu6xM+dpYFA5x
	 iCE3ng7j6B0Yg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XkmyT4WTCz1xv2;
	Thu,  7 Nov 2024 11:01:05 -0500 (EST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by lists.lttng.org (Postfix) with ESMTPS id 4XkmyS52Vpz1xv1
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 11:01:04 -0500 (EST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso172241566b.3
 for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2024 08:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730995263; x=1731600063;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBtx2Vcq1sRCj+h5lS3E/HOPQbk8nrC5GznzuWw+S6Q=;
 b=BpqWaD7tpNa/MgVYuDiCkgOsUmuiXXIOylfX9S7Me7xhM/qyjli2+t4khRzHNEFhSD
 /k5PdY+LWgUbiD5F5UCWVHOac3dMPLBKL6KoRqaaZ4IYmqcIXgKDLxcPgjMiEjA11HRG
 14J1kyVG94Go6CVKMLrIrURIm86mA9mdYJGlfMCui/5rUj54f/MXqYWOJJ8aT0e+EtdK
 kP5X7gIqZXu34JghY+B1hikY7AzGPI/OXnuhUJfbDSjpd/F8PNU+1cN3utIFEmaJxadZ
 DhJ0n+sFKpuEPs5w8YSuM5bWnQbvp2fN9zLuY8v7nHXVHpPT8H1TSbD55NKb2ThcBnG3
 oeOw==
X-Gm-Message-State: AOJu0YzbRwoJZAuWGr0DXdF49prayhgi3alJTENluxSpi38I/lULvudy
 QIJm2KQ+EN3LeXVM22pIupYdrxcvpX23ihCMxLEzcSjDBcZIA8eTofTCNTybz6hEH8gwvYrXLml
 M8SPl2UWKZrLNHyPNWOwLIsBij5pnYY2/
X-Google-Smtp-Source: AGHT+IF/cSY7S1T4cIpCjl7/v49NtwN0TIUk0JFOrcPQzLwlK9freKAXTnwPJRS5cjPNqZeiwGIUkNsWM+Etd/ipvLI=
X-Received: by 2002:a17:907:9713:b0:a9d:e01e:ffa9 with SMTP id
 a640c23a62f3a-a9de5f82589mr4005451766b.33.1730995261439; Thu, 07 Nov 2024
 08:01:01 -0800 (PST)
MIME-Version: 1.0
References: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
 <7f55ec8e-7af3-4af0-9ac9-f7ab4e00345f@efficios.com>
 <CANVMif+RVoKyWu9FY1_9Z3hd_JpcrRuGLue6V3_5X0P2wmUEaA@mail.gmail.com>
In-Reply-To: <CANVMif+RVoKyWu9FY1_9Z3hd_JpcrRuGLue6V3_5X0P2wmUEaA@mail.gmail.com>
Date: Thu, 7 Nov 2024 17:00:50 +0100
Message-ID: <CANVMifJ1YQtTkJVop-CmtaDd2+ggU-2n5D6u8Wu3DhKcFER=7Q@mail.gmail.com>
Subject: Re: Kernel tracing from inside a Docker container
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

Hi,

I guess I found it! The kernel module files have to be present under
/lib/modules inside the container, even when they are already loaded
on the host side.
After putting them there, everything works fine and I finally can
record kernel events.

Thank you so much for your support.

Regards
Dirk

On Thu, Nov 7, 2024 at 3:58=E2=80=AFPM Dirk Eibach <dirk.eibach@googlemail.=
com> wrote:
>
> Hi Mathieu,
>
> > 1) You modprobe all LTTng modules from your top level namespace (host
> >     system) before starting lttng-sessiond within the container, or
>
> since I already did a lttng session on the host/top level namespacer
> the modules are already loaded:
>
> root@9348eb19e6f4:/# lsmod
> Module                  Size  Used by
> lttng_probe_x86_exceptions    16384  0
> lttng_probe_x86_irq_vectors    16384  0
> lttng_probe_workqueue    20480  0
> lttng_probe_vmscan     32768  0
> lttng_probe_udp        16384  0
> lttng_probe_timer      28672  0
> lttng_probe_sunrpc     20480  0
> lttng_probe_statedump    45056  0
> lttng_probe_sock       16384  0
> lttng_probe_skb        16384  0
> lttng_probe_signal     16384  0
> lttng_probe_scsi       20480  0
> lttng_probe_sched      40960  0
> lttng_probe_rcu        16384  0
> lttng_probe_printk     16384  0
> lttng_probe_power      20480  0
> lttng_probe_net        28672  0
> lttng_probe_napi       16384  0
> lttng_probe_module     20480  0
> lttng_probe_kvm        32768  0
> lttng_probe_kmem       28672  0
> lttng_probe_jbd2       28672  0
> lttng_probe_irq        16384  0
> lttng_probe_i2c        20480  0
> lttng_probe_ext4      155648  0
> lttng_probe_compaction    16384  0
> lttng_probe_btrfs      65536  0
> lttng_probe_block      36864  0
> lttng_counter_client_percpu_32_modular    16384  0
> lttng_counter_client_percpu_64_modular    16384  1
> lttng_counter          16384  2
> lttng_counter_client_percpu_64_modular,lttng_counter_client_percpu_32_mod=
ular
> lttng_ring_buffer_event_notifier_client    16384  2
> lttng_ring_buffer_metadata_mmap_client    16384  0
> lttng_ring_buffer_client_mmap_overwrite    20480  0
> lttng_ring_buffer_client_mmap_discard    20480  0
> lttng_ring_buffer_metadata_client    16384  0
> lttng_ring_buffer_client_overwrite    20480  0
> lttng_ring_buffer_client_discard    20480  0
> lttng_tracer         2666496  40
> lttng_probe_udp,lttng_probe_scsi,lttng_probe_sched,lttng_probe_compaction=
,lttng_probe_net,lttng_probe_vmscan,lttng_probe_x86_irq_vectors,lttng_probe=
_power,lttng_probe_rcu,lttng_probe_module,lttng_ring_buffer_client_mmap_ove=
rwrite,lttng_probe_statedump,lttng_ring_buffer_client_discard,lttng_probe_p=
rintk,lttng_probe_x86_exceptions,lttng_probe_ext4,lttng_probe_sock,lttng_co=
unter_client_percpu_64_modular,lttng_probe_irq,lttng_ring_buffer_client_mma=
p_discard,lttng_probe_kvm,lttng_probe_timer,lttng_probe_btrfs,lttng_ring_bu=
ffer_event_notifier_client,lttng_counter_client_percpu_32_modular,lttng_pro=
be_workqueue,lttng_probe_jbd2,lttng_probe_i2c,lttng_probe_signal,lttng_prob=
e_skb,lttng_probe_block,lttng_probe_napi,lttng_ring_buffer_metadata_client,=
lttng_probe_kmem,lttng_ring_buffer_metadata_mmap_client,lttng_ring_buffer_c=
lient_overwrite,lttng_probe_sunrpc
> lttng_statedump        49152  1 lttng_tracer
> lttng_wrapper          16384  7
> lttng_statedump,lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer=
_client_discard,lttng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_pr=
obe_kmem,lttng_ring_buffer_client_overwrite
> lttng_clock            16384  5
> lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_discard,=
lttng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_client=
_overwrite
> lttng_lib_ring_buffer    61440  8
> lttng_ring_buffer_client_mmap_overwrite,lttng_ring_buffer_client_discard,=
lttng_tracer,lttng_ring_buffer_client_mmap_discard,lttng_ring_buffer_event_=
notifier_client,lttng_ring_buffer_metadata_client,lttng_ring_buffer_metadat=
a_mmap_client,lttng_ring_buffer_client_overwrite
>
> Thanks
> Dirk
>
> On Thu, Nov 7, 2024 at 3:29=E2=80=AFPM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2024-11-07 03:03, Dirk Eibach via lttng-dev wrote:
> > > Hi,
> > >
> > > sorry, Outlook is messing up my plaintext mails, so I am switching to
> > > my gmail account.
> > >
> > >> lttng-modules exposes its control ABI through the virtual file /proc=
/lttng.
> > >>
> > >> Does you container have access to that file ?
> > >
> > > The container is running in privileged mode.
> > > root@9348eb19e6f4:/# ls -l /proc/lttng
> > > -rw------- 1 root root 0 Nov  6 16:05 /proc/lttng
> > >
> > >> Note that if you give access to that file within the container, then=
 the container
> > >> can observe detailed information about kernel internals (including r=
elated to
> > >> other containers).
> > >
> > > This is a development-only system, so the security implications are a=
cceptable.
> > >
> > > I have observed one more thing. When I start the session daemon with
> > > the -vvv option I get:
> > > root@9348eb19e6f4:/# lttng list --kernel
> > > DBG1 - 07:31:23.811796947 [Client management]: Wait for client
> > > response (in thread_manage_clients() at client.c:2576)
> > > DBG1 - 07:31:23.811867247 [Client management]: Receiving data from
> > > client ... (in thread_manage_clients() at client.c:2604)
> > > DBG1 - 07:31:23.811945247 [Client management]: Processing client
> > > command 'LTTNG_LIST_TRACEPOINTS' (14) (in process_client_msg() at
> > > client.c:1016)
> > > Error: Failed to load kmod library resources
> > > Warning: No kernel tracer available
> >
> > I suspect that you have two choices here:
> >
> > 1) You modprobe all LTTng modules from your top level namespace (host
> >     system) before starting lttng-sessiond within the container, or
> >
> > 2) You ensure that the container has the ability to load kernel
> >     modules, and you make sure the lttng-modules .ko are available
> >     in the container's under /lib/modules/$(uname -r)/ directory.
> >     (and run depmod -a), then launch lttng-sessiond as root.
> >
> > Thanks,
> >
> > Mathieu
> >
> > > DBG1 - 07:31:23.812076447 [Client management]: Missing llm header,
> > > creating one. (in process_client_msg() at client.c:2381)
> > > DBG1 - 07:31:23.812085547 [Client management]: Sending response (size=
:
> > > 24, retcode: Kernel tracer not available (33)) (in
> > > thread_manage_clients() at client.c:2683)
> > > DBG1 - 07:31:23.812156547 [Client management]: Accepting client
> > > command ... (in thread_manage_clients() at client.c:2534)
> > > Error: Unable to list kernel events: Kernel tracer not available
> > >
> > > Regards
> > > Dirk
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
> >
