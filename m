Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662FC433DF
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:34:38 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA3C20739
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="FTHU5r/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA3C20739
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B70G372Skz1Y9m;
	Thu, 16 Jul 2020 12:34:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594917276;
	bh=vtcQrcKKGj29aN42793JSpQB/UeMFGXF/Aki6gIFHu8=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FTHU5r/foWc+dkF7ltbFb5JTpI0QtjaDQvXMlnxqV1EJFs2Tk1PdY+u8tdA1G7BAl
	 sCcu12CrgbO9WmEAbMP3+8nHBns4yeBDc1NP169hv9CupjQI2kToKQd3B/nSqIm8mi
	 9wIDPH2kL1GMXBpCiBxv/s5Bt1msGo6d8voJazzU3Bt16ggVTFUsfwiGhqDjYxot3m
	 LdRTEBUblBKqzImWSsatreuUDqAv/CdBI71+FIcGp0z49yoQWVl0KLk/8ujkIcvqB3
	 wS4vCanEFKYg4z+zLqCQ5uKF8A8YkOaUrEpqGcfARmcRYxY3eWVU5rgXNeqoV8VNxt
	 /2eZd68xScODQ==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B70G168Zhz1YG8
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jul 2020 12:34:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id 683691DAF6B;
 Thu, 16 Jul 2020 21:04:24 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id tBJ0s9Rs1eq8; Thu, 16 Jul 2020 21:04:22 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id 2451F1DA59D;
 Thu, 16 Jul 2020 21:04:22 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 21:04:22 +0430
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-users-owner@vger.kernel.org, linux-trace-users
 <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>,
 Namhyung Kim <namhyung@kernel.org>
In-Reply-To: <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
 <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
Message-ID: <b0e85dc62211e2d0c908ba395a9fcb5a@ut.ac.ir>
X-Sender: ahmadkhorrami@ut.ac.ir
User-Agent: Roundcube Webmail/1.3.6
Subject: Re: [lttng-dev] Capturing User-Level Function Calls/Returns
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: ahmadkhorrami via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716163422.pjXuUqTzeZneKR-Xw4Ioghu8jgyejhmZhUzNDezQ8iA@z>

Hi Michel,

Thanks for the detailed answer! DBI tools are really interesting but I 
want to do this during normal execution and on multiple programs running 
simultaneously. I mean this is not supposed to be conventional tracing 
with multiple re-executions. I want to extract some information about 
the execution-state at runtime and inform the lower levels in the 
software stack to make smarter choices. Fortunately, there are only a 
few functions that need to be traced. But any reduction in the wasted 
cycles is helpful, specially if it is caused by privilege level 
transitions.

Regards.


On 2020-07-16 05:36, Michel Dagenais wrote:

>> Without recompiling, how would that be implemented?
> 
> As you mentioned, this is possible when "jump patching" 5 bytes 
> instructions. Fast tracepoints in GDB and in kprobe do it. Kprobe goes 
> further and patches sequences of instructions (because the target 
> instruction is less than 5 bytes) if there is no incoming branch into 
> the middle of the sequence. You can go even further, for instance using 
> 3 bytes jumps to a trampoline installed in alignment nops. If you 
> combine different strategies like this, you can eventually reach almost 
> 100% success rate for "jump patching" tracepoints. This gets quite 
> hairy though. However, the short story is that there is currently no 
> tool as far as I know that does that easily and reliably in user space.
> 
> https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.2746
> https://dl.acm.org/doi/pdf/10.1145/3062341.3062344
> 
> If you can afford a more invasive tool, that requires a lot of memory 
> and stops your application for quite some time, you can look at 
> approaches like dyninst that decompile the binary, insert 
> instrumentation code and reassemble the code.
> 
> https://dyninst.org/
> 
>> You would need to insert a jump on top of code, and still be able to
>> preserve that code. What a trap does, is to insert a int3, that will
>> trap into the kernel, it would then emulate the code that the int3 was
>> on, and also call some code that can trace the current state.
>> 
>> To do it in user land, you would need to find way to replace the code
>> at the location you want to trace, with a jump to the tracing
>> infrastructure, that will also be able to emulate the code that the
>> jump was inserted on top of. As on x86, that jump will need to be 5
>> bytes long (covering 5 bytes of text to emulate), where as a int3 is a
>> single byte.
>> 
>> Thus, you either recompile and insert nops where you want to place 
>> your
>> jumps, or you trap using int3 that can do the work from within the
>> kernel.
>> 
>> -- Steve
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
