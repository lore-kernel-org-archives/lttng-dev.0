Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F63C7EE23
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Jun 2023 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1686150619;
	bh=EbY4zxsUeBRc0/qtAqDsqHKbCK2qyn4MoUW9vqskfqA=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=riYQbyCBlaJDb7/T9R6jCyiPafr3+lhQORSr7BCTFmwAANWR047LW2gFvgnqINWYw
	 RWnWa7NtEFt+iAgWCnIUKw/I0gWhnyNsqLsgMuW/VieqT+pSFQ7Vs2aVILUNN4NiHP
	 ecgmm1QaY14KTC81phQop6mpfPbT7XQUD71ACXRGSb/bZr+xShb6q719nzDMfxhnf8
	 SsZDcDI9I+6t8YFe7dyNHkjEzRA8UoMil5NyRpLgsUbZsZCrYDOFJVsrd7plQHzAQG
	 cnRYR9INjk/IhVkRspeOHuscuud0rUKu0nCYzfFHLHMX3SdMI2mmbAWcEy+MQpHXWY
	 buuaaNaf27d6w==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QbrPR0LHYz1XvL;
	Wed,  7 Jun 2023 11:10:19 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4QbrPP5vjmz1XvK
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2023 11:10:17 -0400 (EDT)
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net
 [192.222.143.198])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4QbrPN2ftJz16mt;
 Wed,  7 Jun 2023 11:10:16 -0400 (EDT)
Message-ID: <90f91bb9-e174-7e8e-6922-5a27cc0eede9@efficios.com>
Date: Wed, 7 Jun 2023 11:10:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [lttng-dev] [RELEASE] LTTng UST 2.12.8/2.13.6 and LTTng modules
 2.12.14/2.13.10 tracers
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

Hi,

This is a stable release announcement for the LTTng UST and LTTng modules tracer projects.
Those contain mainly bug fixes and add support for recent distributions and upstream kernels.

What's new in both LTTng-UST 2.12.8 and 2.13.6:

- Fix: use unaligned pointer accesses for lttng_inline_memcpy
     
   lttng_inline_memcpy receives pointers which can be unaligned. This
   causes issues (traps) specifically on arm 32-bit with 8-byte strings
   (including \0).

- Fix: trace events in C constructors/destructors

   Adding a priority (150) to the tracepoint and tracepoint provider
   constructors/destructors ensures that we trace tracepoints located
   within C constructors/destructors with a higher priority value,
   including the default init priority of 65535, when the tracepoint vs
   tracepoint definition vs tracepoint probe provider are in different
   compile units (and in various link order one compared to another).

- Fix: Reevaluate LTTNG_UST_TRACEPOINT_DEFINE each time tracepoint.h is included

   Fix issues with missing symbols in use-cases where tracef.h is included
   before defining LTTNG_UST_TRACEPOINT_DEFINE

- Fix: segmentation fault on filter interpretation in "switch" mode

   Fix a bytecode interpreter crash when building with INTERPRETER_USE_SWITCH
   defined (used mainly for debugging purposes).


What's new specifically in LTTng-UST 2.13.6:

- Fix: `ip` context is expressed as a base-10 field

   The base for UST context field `ip` was changed from 16 (hexadecimal) to
   10 (decimal), most likely an unintentional copy&paste error in 4e48b5d.

- Various fixes to build with -std=c99.

- Fix: trace events in C++ constructors/destructors

   Wrap constructor and destructor functions to invoke them as functions with
   the constructor/destructor GNU C attributes, which ensures that those
   constructors/destructors are ordered before/after C++
   constructors/destructors.


What's new in LTTng modules 2.12.14 and 2.13.10:

- fix: kallsyms wrapper on CONFIG_PPC64_ELF_ABI_V1

   Work-around PPC64 ELF ABI v1 function descriptor issues when using kallsyms.

- Add support for RHEL 9.0 and 9.1.


What's new specifically in LTTng modules 2.12.14:

- Various tracepoint instrumentation fixes to support kernel v5.18.


What's new specifically in LTTng modules 2.13.10:

- Various tracepoint instrumentation fixes to support kernel v6.3.


Feedback is welcome!

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
