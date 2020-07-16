Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22855C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:20:34 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA29420739
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="l9M2f19K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29420739
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6zxr2B96z1Y9c;
	Thu, 16 Jul 2020 12:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594916432;
	bh=jMRtPnbx8UDucvyJBvT6JiMh4koJvFW2RbJ8LuIzg68=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=l9M2f19K3a541tXzcvPgWQp0hcWN7EwcOXTFdZAJ7ogvS/m/FLo00lu6P7fjDXUYo
	 p6lsbw4+7OQQ4DvS2rgBEsDn9pJA8ELBd3CeL6ntajwhCL2TRPiziU8d/aarCr3ZsD
	 jSUEGhAHraAfnY8qcH4qTHB76ExXHgDQZ19BqN43kYhoFWu/A2+aeTdStvU4iw08Ul
	 ko6tq/L6R3tG7CuE9pffficg+T0hGyT4ba117GfjUorsITD/6pS++BWkYZNo5XI2Xp
	 /lQHMwFb7qnu+GqnyW61cbgrGN5GbjbHg5wgGuIKAJQtNYQwiFI/vRIh1nE9eDK0Tm
	 6QOcxaLFgnAJA==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6zxp32Pfz1YM5
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jul 2020 12:20:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id D4A281DA59D;
 Thu, 16 Jul 2020 20:50:21 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id FBwbCzYCKoEE; Thu, 16 Jul 2020 20:50:16 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id 35AF61DAF54;
 Thu, 16 Jul 2020 20:50:16 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 20:50:16 +0430
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
Message-ID: <29db598e77d0c2f04dabd6881aae097e@ut.ac.ir>
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
Message-ID: <20200716162016.FTuyII6yWu4Jc0gYct3NfGe2bxr-qd3HTi0EK2wYlD8@z>

<p>Hi Michel,</p>
<p>Thanks for the detailed answer! DBI tools are really interesting but 
I want to do this during normal execution and on multiple programs 
running simultaneously. I mean this is not supposed to 
be&nbsp;conventional tracing with multiple re-executions. I want to 
extract some information about the execution-state at runtime and inform 
the lower levels in the software stack to make smarter choices. 
Fortunately, there are only a few functions that need to be traced. But 
any reduction in the wasted cycles is helpful, specially if it is caused 
by privilege level transitions.</p>
<p>Regards.</p>
<p>&nbsp;</p>
<p>On 2020-07-16 05:36, Michel Dagenais wrote:</p>
<blockquote><!-- html ignored --><!-- head ignored --><!-- meta ignored 
-->
<div class="pre"><br />
<blockquote>Without recompiling, how would that be 
implemented?</blockquote>
<br /> As you mentioned, this is possible when "jump patching" 5 bytes 
instructions. Fast tracepoints in GDB and in kprobe do it. Kprobe goes 
further and patches sequences of instructions (because the target 
instruction is less than 5 bytes) if there is no incoming branch into 
the middle of the sequence. You can go even further, for instance using 
3 bytes jumps to a trampoline installed in alignment nops. If you 
combine different strategies like this, you can eventually reach almost 
100% success rate for "jump patching" tracepoints. This gets quite hairy 
though. However, the short story is that there is currently no tool as 
far as I know that does that easily and reliably in user space.<br /><br 
/><a href="https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.2746" 
target="_blank" rel="noopener 
noreferrer">https://onlinelibrary.wiley.com/doi/abs/10.1002/spe.2746</a><br 
/><a href="https://dl.acm.org/doi/pdf/10.1145/3062341.3062344" 
target="_blank" rel="noopener 
noreferrer">https://dl.acm.org/doi/pdf/10.1145/3062341.3062344</a><br 
/><br /> If you can afford a more invasive tool, that requires a lot of 
memory and stops your application for quite some time, you can look at 
approaches like dyninst that decompile the binary, insert 
instrumentation code and reassemble the code.<br /><br /><a 
href="https://dyninst.org/" target="_blank" rel="noopener 
noreferrer">https://dyninst.org/</a><br /><br />
<blockquote>You would need to insert a jump on top of code, and still be 
able to<br /> preserve that code. What a trap does, is to insert a int3, 
that will<br /> trap into the kernel, it would then emulate the code 
that the int3 was<br /> on, and also call some code that can trace the 
current state.<br /><br /> To do it in user land, you would need to find 
way to replace the code<br /> at the location you want to trace, with a 
jump to the tracing<br /> infrastructure, that will also be able to 
emulate the code that the<br /> jump was inserted on top of. As on x86, 
that jump will need to be 5<br /> bytes long (covering 5 bytes of text 
to emulate), where as a int3 is a<br /> single byte.<br /><br /> Thus, 
you either recompile and insert nops where you want to place your<br /> 
jumps, or you trap using int3 that can do the work from within the<br /> 
kernel.<br /><br /> -- Steve<br /> 
_______________________________________________<br /> lttng-dev mailing 
list<br /><a 
href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br 
/><a href="https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" 
target="_blank" rel="noopener 
noreferrer">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a></blockquote>
</div>
</blockquote>
<p>&nbsp;</p>
<div id="_rc_sig">&nbsp;</div>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
