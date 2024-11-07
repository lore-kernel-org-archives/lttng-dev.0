Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475C6D5AE71
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730966601;
	bh=xj/X9s+k5ALNRwPCk6le3HOINroP4nrEUBbsPKD9G4A=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=FzYHJVm3ZrUFYdcqZGa3GMw8hIuh4pkXi/Tlwwn69T1QFq71P1VCGiVt/N0RxO3M6
	 1+c173vALzw707GxK59GR45Ns8egr6ooe5FTDviebkt331RNvjtbIa840HcNiKTwij
	 ZZ58nyNHU3/txjqf40a+cqd9Ep8+ghSoO7cGWTZhYCCBVtTrkIAFfT9GAor7Nm5bqK
	 +rr+4LXxaML5mIugkB8DbtlGwRVcvct3PIuxua3kGWTDWfDAwszSFzSXPY3l5ckT1H
	 +HAMIOh8VuAn45uwKTTtwyWZLu5o068Y6Ao91+fNaoaZ/UDlCkgXppadIQXBk0aYg3
	 NsaIap+kpIDLg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XkZMF12lVz1d6p;
	Thu,  7 Nov 2024 03:03:21 -0500 (EST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by lists.lttng.org (Postfix) with ESMTPS id 4XkZMB6jVPz1cwN
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 03:03:18 -0500 (EST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9ed7d8c86cso95116866b.2
 for <lttng-dev@lists.lttng.org>; Thu, 07 Nov 2024 00:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730966597; x=1731571397;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxh8OOnbyBPMSlQwzeVL/40fkSzeqgHAAp17RLUAWfQ=;
 b=pmvATylCy+V1MDFDuqfpR8+z08mE1lIKUz2qiopHNwS0pMgAczpEvIvZ9PgRUDN75S
 KBAb8mAyzmXInuQsbCTzgp/wpC+JU7Q4MCXdx8feMcaqqmM71aijkNaz0c2Ptvyd5wHv
 2vV49e1y48DHEG6WrK2GSaJK2evuTW6wl/0pKcjPtVZD1kcO6yJQ6JWU3F09A0IkH/6V
 ff0Zay0Z/Bz7g8ribDjQ1HjU1mLOJB/HVxqtU6Dsf63SrQoXHYWNFmZ4AsUtkZMDp6aB
 HocXMklkeHsPibB+dz35y7bf9O4hGcxr3oTmBvzOEuUjmXObw8o4JhcgAmT+p3nmVtSb
 fglQ==
X-Gm-Message-State: AOJu0YzNAB0fZIc+iRmWSYzh9tyOdPIAo8+AfYHdV+r4usN6FgL4s4wI
 Ao0FkwdrN5QpL6u3G7+y2H2172SUi9Awo6ALk/6m8QzKGhGISllreeZsKmp3otKpG6I/94rb6St
 veTKK/gHZoPn4vQnhUzfzBSnEp2lKD88G
X-Google-Smtp-Source: AGHT+IGZdlNHKQEzOfFWmZdwbs2uJIyknsteLvy5o0vm7rCfTva56pJgMRW8atseG8DRt0abAI8oFbaUrkN0UPiZE9w=
X-Received: by 2002:a17:907:6e9e:b0:a9e:e1a9:8df0 with SMTP id
 a640c23a62f3a-a9ee74d35e7mr2467166b.29.1730966597314; Thu, 07 Nov 2024
 00:03:17 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 7 Nov 2024 09:03:06 +0100
Message-ID: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
Subject: Kernel tracing from inside a Docker container
To: lttng-dev@lists.lttng.org
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
From: Dirk Eibach via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dirk Eibach <dirk.eibach@googlemail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

sorry, Outlook is messing up my plaintext mails, so I am switching to
my gmail account.

> lttng-modules exposes its control ABI through the virtual file /proc/lttng.
>
> Does you container have access to that file ?

The container is running in privileged mode.
root@9348eb19e6f4:/# ls -l /proc/lttng
-rw------- 1 root root 0 Nov  6 16:05 /proc/lttng

> Note that if you give access to that file within the container, then the container
> can observe detailed information about kernel internals (including related to
> other containers).

This is a development-only system, so the security implications are acceptable.

I have observed one more thing. When I start the session daemon with
the -vvv option I get:
root@9348eb19e6f4:/# lttng list --kernel
DBG1 - 07:31:23.811796947 [Client management]: Wait for client
response (in thread_manage_clients() at client.c:2576)
DBG1 - 07:31:23.811867247 [Client management]: Receiving data from
client ... (in thread_manage_clients() at client.c:2604)
DBG1 - 07:31:23.811945247 [Client management]: Processing client
command 'LTTNG_LIST_TRACEPOINTS' (14) (in process_client_msg() at
client.c:1016)
Error: Failed to load kmod library resources
Warning: No kernel tracer available
DBG1 - 07:31:23.812076447 [Client management]: Missing llm header,
creating one. (in process_client_msg() at client.c:2381)
DBG1 - 07:31:23.812085547 [Client management]: Sending response (size:
24, retcode: Kernel tracer not available (33)) (in
thread_manage_clients() at client.c:2683)
DBG1 - 07:31:23.812156547 [Client management]: Accepting client
command ... (in thread_manage_clients() at client.c:2534)
Error: Unable to list kernel events: Kernel tracer not available

Regards
Dirk
