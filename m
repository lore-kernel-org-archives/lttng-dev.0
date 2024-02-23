Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E1C5478C
	for <lttng-dev@archiver.kernel.org>; Fri, 23 Feb 2024 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1708708373;
	bh=VxmnqU8aO4BgjYT8H054f6JIlisLVlhuBalBKtHMU4A=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=U0Lb+HfG5PvVX1XMvJSVilv4U8kD20vy4Mt7EUgiUcwczrLkJUvaReIHS105LVq57
	 dAgZGIOYyy03P10kV0fb60mujI/ET9L2ta/Zlfy/dSIbEoUV5eVcv1GSyWXAf8Ndop
	 MiRCOYnr5hNqH9YOUp3dPCmYxaC7fDD+tAp2Hc8BTv64yOA/gx0QUrQMU4Rj9JGh4f
	 vPYrSebK9lEPqqrUqTNVuEbLxMYTEqDU/0gg2QQBPwVCXuVp/OOZXcqdFfhg5pXFEb
	 +lt7xlV87jleRSlE1LR96Gh6ZxYUz0IU+6DqW0+jepoU3ISv5G54uMrlCW7jRURSeM
	 gtrOhDhHJXZnw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ThGmN4tpDz28qQ;
	Fri, 23 Feb 2024 12:12:52 -0500 (EST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by lists.lttng.org (Postfix) with ESMTPS id 4ThGmM3pXYz28qN
 for <lttng-dev@lists.lttng.org>; Fri, 23 Feb 2024 12:12:51 -0500 (EST)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68facd7ea4bso2153276d6.0
 for <lttng-dev@lists.lttng.org>; Fri, 23 Feb 2024 09:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708370; x=1709313170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXCiSOazfM9UUsgzhAu8QK0JWGc1jQKsRm/PEVTVlb0=;
 b=QdSzhztioCfKNwpItUREesLnhvgx9oXrCTtYAYk4sIXRmwWxjnesgU2O+2IcLeMnOy
 oj7P0Swad2qb+SOxgsHZk6AqQ0WM8AhJZ+qnRE404kjJLG6xUhvksNwpH0nZ2nb+cAQr
 uMUnTCdZSU/hp31qAKaCNG/Zv6Iq/dNGy16aFnxxze+eeqXgdzMqCkme4be7mkbE2NQ7
 4cBQHbRiwdyzTL0Zkf6kyvvE//kC2pcLgZdSRCf3v4aqADIgnMs/wrRfrTgaEQnZM3pa
 td498VKpXBUz4r0CjzSFLdyVO4pezBG5VCjtF0RnDX/VAbtdL41qQD0D2/O1DTY0rTuq
 PiRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOweRUF9X8emFjS+rooKXVfW3DwjgtlDISg5dBwZmlOpvCXMw+m2mai1iM9p4w4/iw1I/dS7pNoZzV8XZvm686faUbKqNHmJSe
X-Gm-Message-State: AOJu0Yz+Bve9lGWXYbOMx1lx+ODbm4hjaWHX8AECwNoYTTMTjhYT2ZD+
 15/L0nRujg5PG31YgxgJvXtzqLPwRh8xWHLAcaNmh5kCxwWbPgqTM3bQGwwTUsQ=
X-Google-Smtp-Source: AGHT+IGsp7MUtcj4A5A3apd96BUQmUetKWTJGe0ybnKpAGIHfZbdKHOa+b7IDTEUgMlGGrA1x/wggQ==
X-Received: by 2002:a0c:e28c:0:b0:68f:2a2b:c6e0 with SMTP id
 r12-20020a0ce28c000000b0068f2a2bc6e0mr345056qvl.64.1708708370598; 
 Fri, 23 Feb 2024 09:12:50 -0800 (PST)
Received: from [192.168.202.90] (modemcable170.15-70-69.static.videotron.ca.
 [69.70.15.170]) by smtp.googlemail.com with ESMTPSA id
 oh2-20020a056214438200b0068fdc55ec7dsm724285qvb.68.2024.02.23.09.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:12:50 -0800 (PST)
Message-ID: <ee3dbbfa-2ef1-4481-b67b-80dcd3c7010d@opersys.com>
Date: Fri, 23 Feb 2024 12:12:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <tencent_5CD40341EC9384E9B7CC127EA5CF2655B408@qq.com>
 <20240217104924.GB10393@redhat.com>
 <20240219112926.77ac16f8@gandalf.local.home>
 <20240219170038.GA710@redhat.com>
 <20240219122825.31579a1e@gandalf.local.home>
 <776b842b-b19f-44bf-bc34-ac756fce7466@efficios.com>
 <20240223092630.49b9d367@gandalf.local.home>
 <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
In-Reply-To: <c9427e40-10b1-49eb-9baa-dde1364e8fe5@efficios.com>
Subject: Re: [lttng-dev] [PATCH] coredump debugging: add a tracepoint to
 report the coredumping
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
From: Karim Yaghmour via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: wenyang.linux@foxmail.com, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 lttng-dev <lttng-dev@lists.lttng.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mel Gorman <mgorman@techsingularity.net>, Ingo Molnar <mingo@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


On 2/23/24 11:54, Mathieu Desnoyers wrote:
...
> So this sched_process_exit placement was actually decided
> by Karim Yaghmour back in the LTT days (2001). I don't think
> he will mind us moving it around some 23 years later. ;)

Gee ... the shadows are longer than I thought :)

It's all yours. You guys have been doing a fantastic job and I'm happy 
to be on the consumer side of it all these days :D

Cheers,

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
