Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525FCD43371
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730994172;
	bh=xj/X9s+k5ALNRwPCk6le3HOINroP4nrEUBbsPKD9G4A=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0hy6UuKbDT3bLQfj1E6Eq/W4KST9/vyKeKG++cwTDt1cvLq1iAFBVSgE0bIBVZjCM
	 T25hdwR1WCZl8sdKvB43V6i5UZq7/jPQtbg0vSJDir6gNiEM+5bCcM4R/CB8Ry9YC1
	 UZnKAexywKzTyy0qvaaA2iov0OCpGW2tTS/FIeJ3HJ1HBVBpPYDDpCxCQh3pauIy9l
	 NjqB7qqV6nRl9aGcL46pA6w/sZWkZ3IeFIm3ahxQ93kuyIbR+133A/s+hSGxSOw1zc
	 n5jjfpfWnMe4UfKzodH9/ku9Hc+tMf5/8MNDRnIUrL75YNFvaE3XnYr2M2LXmd7BPQ
	 tZvHLmxC8qbZQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XkmYR589Jz1xnV;
	Thu,  7 Nov 2024 10:42:51 -0500 (EST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 4XkYw02n7mz1cp9
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 02:43:12 -0500 (EST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso96519166b.1
 for <lttng-dev@lists.lttng.org>; Wed, 06 Nov 2024 23:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730965391; x=1731570191;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rxh8OOnbyBPMSlQwzeVL/40fkSzeqgHAAp17RLUAWfQ=;
 b=dGHFTmGuT/4Pd+QsEmx/fBeDL2ezqMrDhsZqkpT++pbd+P6Eck8z0Uc6r/VnwwWOIY
 /VhI37cfzVenPjVJYR8EraO9yDMqYe5DDg3boFFwFaz6+YMPvYh3+S8EKdyRtMbtsT72
 DFMurLEn/XQumWoD53HOwpU0kcjVh4MKy3S6CbN08ZWV3mfUmPMINlflm7vEkQ6qIu10
 CC29uTF9ix+yvI6F/lqLFIrSq1g+kPYOI0ZjuHJ/DVpyrZwRiz9Vbb3cURrPDhTVkENh
 kJKOOF/Sdis7QRkKLh1iqbGNHppcifY6az/A8Hxu77O/Otq0a1r1OnoA6cbMLzYF7dXB
 xsRA==
X-Gm-Message-State: AOJu0YwFKcAH2o/MnjjFJsVt+ry8sGbsqVYx/JjiRijywGvGyh1MznKp
 aNRhwHMl+VF+QXUrouOvLvU+DrNfO8MFEsM0QgpOBFkGa3fLrWSmP+m1nNwUcaRXj/bM4epcu5M
 f6hL9aOntGX0jyflvybRp9YUuj/aLVDv0
X-Google-Smtp-Source: AGHT+IHDZchCwPAM6ngS+QHzlgSg4WZAIG/CNnsaMctYem6l7ulIdPCV0AF5d/TMuefQ4Jt4Rb30rW+jU7Eax/suRTw=
X-Received: by 2002:a17:907:7da2:b0:a9a:6752:ba80 with SMTP id
 a640c23a62f3a-a9de5d6e1dcmr4217728766b.5.1730965390639; Wed, 06 Nov 2024
 23:43:10 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 7 Nov 2024 08:42:59 +0100
Message-ID: <CANVMif+J+UDvBucReVo_Z9HMBM=hbmqbEk0UXa=AbMV-UjmSNw@mail.gmail.com>
Subject: Kernel tracing from inside a Docker container
To: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 07 Nov 2024 10:42:49 -0500
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
