Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687FED43367
	for <lttng-dev@archiver.kernel.org>; Thu,  7 Nov 2024 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1730989750;
	bh=nz593zUgAPPWIwoAI8HH6pgvm2mhA51kVI4Fa8s9F9E=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=gmMaLp+KTR10Wa1dn4UKdqiHMJmYMjwIlWrLgSkZPRzrzWMTJhBNc7geGNOB1oJMj
	 iDJYomD0qfh3rX7V54ds92SlP81LZlDsuA+U3jJ6zeRQnytXvVb0M+vlIsJvsplLqp
	 p6A12VZ7xeJ58zhRuNLDBp2sibZVLeynN/CooYAdEx5t4IrcKZxEx3OJqD1Dtx5xx/
	 eVyGe2ZlzEKujur8lyB/te3RHh9Z0dbip/EFc0cWRirNSr7k7JGKwFsxg4L6RO5Op7
	 Xp/jmkAlFZdjUwTVoi9xbGnRRxp0Agj2DWAzVUlB7IRfwvgfhaMiwV52k1xjqlcpJ2
	 JdtIma8UyNEhg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4XkkwP46qnz1hyg;
	Thu,  7 Nov 2024 09:29:09 -0500 (EST)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4XkkwL02SDz1hc5
 for <lttng-dev@lists.lttng.org>; Thu,  7 Nov 2024 09:29:05 -0500 (EST)
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net
 [96.127.217.162])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4XkkwK0RhVzxC7;
 Thu,  7 Nov 2024 09:29:05 -0500 (EST)
Message-ID: <7f55ec8e-7af3-4af0-9ac9-f7ab4e00345f@efficios.com>
Date: Thu, 7 Nov 2024 09:27:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel tracing from inside a Docker container
To: Dirk Eibach <dirk.eibach@googlemail.com>, lttng-dev@lists.lttng.org
References: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANVMifJSWE9GNhcdMkVqrAxKsNwrbEVuL1Wd+4YzO9FrbeabFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2024-11-07 03:03, Dirk Eibach via lttng-dev wrote:
> Hi,
> 
> sorry, Outlook is messing up my plaintext mails, so I am switching to
> my gmail account.
> 
>> lttng-modules exposes its control ABI through the virtual file /proc/lttng.
>>
>> Does you container have access to that file ?
> 
> The container is running in privileged mode.
> root@9348eb19e6f4:/# ls -l /proc/lttng
> -rw------- 1 root root 0 Nov  6 16:05 /proc/lttng
> 
>> Note that if you give access to that file within the container, then the container
>> can observe detailed information about kernel internals (including related to
>> other containers).
> 
> This is a development-only system, so the security implications are acceptable.
> 
> I have observed one more thing. When I start the session daemon with
> the -vvv option I get:
> root@9348eb19e6f4:/# lttng list --kernel
> DBG1 - 07:31:23.811796947 [Client management]: Wait for client
> response (in thread_manage_clients() at client.c:2576)
> DBG1 - 07:31:23.811867247 [Client management]: Receiving data from
> client ... (in thread_manage_clients() at client.c:2604)
> DBG1 - 07:31:23.811945247 [Client management]: Processing client
> command 'LTTNG_LIST_TRACEPOINTS' (14) (in process_client_msg() at
> client.c:1016)
> Error: Failed to load kmod library resources
> Warning: No kernel tracer available

I suspect that you have two choices here:

1) You modprobe all LTTng modules from your top level namespace (host
    system) before starting lttng-sessiond within the container, or

2) You ensure that the container has the ability to load kernel
    modules, and you make sure the lttng-modules .ko are available
    in the container's under /lib/modules/$(uname -r)/ directory.
    (and run depmod -a), then launch lttng-sessiond as root.

Thanks,

Mathieu

> DBG1 - 07:31:23.812076447 [Client management]: Missing llm header,
> creating one. (in process_client_msg() at client.c:2381)
> DBG1 - 07:31:23.812085547 [Client management]: Sending response (size:
> 24, retcode: Kernel tracer not available (33)) (in
> thread_manage_clients() at client.c:2683)
> DBG1 - 07:31:23.812156547 [Client management]: Accepting client
> command ... (in thread_manage_clients() at client.c:2534)
> Error: Unable to list kernel events: Kernel tracer not available
> 
> Regards
> Dirk

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

