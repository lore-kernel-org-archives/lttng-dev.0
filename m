Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DAAC77B7D
	for <lttng-dev@archiver.kernel.org>; Thu, 18 May 2023 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684421158;
	bh=zVLiUoxVAx3ClXhWNwm48B6Zj+kui1GMEcTxbp7ZKkA=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=p02rBU7uhkyQwzRWrwt29NYzGJCo3fxnE6Ql069YlcacI0x3lhCibfuasRGHB02Xg
	 h5nxzGmrWPxznogCgL15fzDhmlQ4INHUrR60/FqArnE/aXlKoTTtdyzBsXUPAQD/EK
	 I0pJA2KPghMHlrx/ta9yqPOw4LHbu+nNiJwzw5GYO0dh9PqyJwjk4RJCrF3AWYkaYj
	 dRKVPIFR3RyEtdhFnXygJ78Mk+Y5gkZtHkjHgctdLJ2jZg+9jiRiEBqXe0hTIBTcgk
	 PzLaUQWU/MK1dmLrOYURDo99AKLNNGjQ3vEUgzD8VzIN9x7aTXcMSWxpLmgZrpDMQx
	 MXp7cVX5WIrGw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QMXpZ2VZKz1GBw;
	Thu, 18 May 2023 10:45:58 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QMXpW3nw2z1GBt
 for <lttng-dev@lists.lttng.org>; Thu, 18 May 2023 10:45:55 -0400 (EDT)
Received: from [172.16.0.117] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QMXpV6fSBz13Cw;
 Thu, 18 May 2023 10:45:54 -0400 (EDT)
Message-ID: <2f8ea79e-9515-854b-d3b0-707baba60b92@efficios.com>
Date: Thu, 18 May 2023 10:46:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Brian Hutchinson <b.hutchman@gmail.com>
Cc: lttng-dev@lists.lttng.org
References: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
 <2d953bd2-6544-3357-1424-fa44731e2bf5@efficios.com>
 <CAFZh4h95d=U6wj6RxR-z3kDMwJD58cC+DLC5O6UNSsKcschr3w@mail.gmail.com>
 <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
In-Reply-To: <CAFZh4h9_aAqHngnaErOmvM8c+iBdSSfMnMgeYHbV_N=vEzEYmw@mail.gmail.com>
Subject: Re: [lttng-dev] Trying to understand use of lttng enable-event
 --kernel --userspace-probe=
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2023-05-18 10:10, Brian Hutchinson wrote:
[...]
> I updated my hello world to have a function I'd like to use the
> --userspace-probe method on with the very original name of
> 'probe_function':
> 
> #include <stdio.h>
> #include <lttng/tracef.h>
> 
> void probe_function(int i);
> 
> int main(int argc, char *argv[])
> {
>     unsigned int i;
>     puts("Hello, World!\nPress Enter to continue...");
>     /*
>      * The following getchar() call only exists for the purpose of this
>      * demonstration, to pause the application in order for you to have
>      * time to list its tracepoints. You don't need it otherwise.
>      */
>     getchar();
> 
>     lttng_ust_tracef("Number %d, string %s", 23, "hi there!");
>     printf("Number %d, string %s", 23, "hi there!");
> 
>     for (i = 0; i < argc; i++) {
>         lttng_ust_tracef("Number %d, argv %s", i, argv[i]);
>         printf("Number %d, argv %s", i, argv[i]);
>     }
> 
>     puts("Quitting now!");
> 
>     probe_function(i);
> 
>     return 0;
> }
> 
> void probe_function(int i) {
> 
>     lttng_ust_tracef("Number %d, string %s", i * i, "i^2");
>     printf("Number %d, string %s", i * i, "i^2");
> 
> }
> 
> ... and I get the same error as before when I try to enable the probe:
> # lttng enable-event --kernel
> --userspace-probe=/usr/local/bin/hello:probe_function
> Error: Missing event name(s).

As the error states, you are missing the event name. See

man 1 lttng-enable-event

        lttng [GENERAL OPTIONS] enable-event --kernel
              [--probe=SOURCE | --function=SOURCE | --syscall |
               --userspace-probe=SOURCE]
              [--filter=EXPR] [--session=SESSION]
              [--channel=CHANNEL] EVENT[,EVENT]...


You will want something like:

lttng enable-event --kernel --userspace-probe=/usr/local/bin/hello:probe_function my_probe_function

Where "my_probe_function" is the event name that will appear in the collected traces.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
