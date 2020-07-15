Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E655AC433E2
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:09 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DA72065F
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="TsmW4oXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DA72065F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6vfh6rqkz1XfL;
	Thu, 16 Jul 2020 09:07:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594904829;
	bh=1s8LsmFVdtV+UqEQvBRPDaYYvLiFrueigAoO7qm0eDg=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TsmW4oXjfurr9YDLDBjmR6hJyUBNI/JVr3YT0k/72ici9etZlbJd4hEoKlE+AKI35
	 i+10LEXkh0vGt40hIvJZgysGCzMo4e/dlt09ITszkSok4tv/kTHyMjiiL4Uz4vEDP7
	 TX5eUMfQghB2+1XL7LP759c/yJjNVtusibtjcRzjBahlYizjhso2S+LRJ9PbW7MPWP
	 y0XZRxW8a6ZtRP9AkAZ4/WQhf8NpZwl/GR7Nb8qubfvqiGv5Aunshk2AfKsnr0jQVT
	 MN8VXyytHnRAgvkFy5Y8uUpspQSM6ko4RhlESO7+UDmxZTfFNvhlDRNj/QfbtCQDEn
	 v1gp3p6ebrCpg==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6X6H0bYqz1XvG
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 18:26:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id 333C21DADD1;
 Thu, 16 Jul 2020 02:56:00 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id XRKwxLQuqr2s; Thu, 16 Jul 2020 02:55:59 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id 2B3F31DADD0;
 Thu, 16 Jul 2020 02:55:59 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 02:55:59 +0430
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20200715174858.4698803c@oasis.local.home>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
Message-ID: <46b174cf30872f07a08f97be1d7eb514@ut.ac.ir>
X-Sender: ahmadkhorrami@ut.ac.ir
User-Agent: Roundcube Webmail/1.3.6
X-Mailman-Approved-At: Thu, 16 Jul 2020 09:07:01 -0400
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
Cc: linux-trace-users-owner@vger.kernel.org,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200715222559.BguzAr1zC-5n1Eq2uHpARdrgL2-qa8vzkFXLBLqUDA8@z>

So, the only barrier to the user-level implementation is the problem 
with instruction sizes. That's an enlightening point. Thanks for the 
detailed answer!
Thanks everybody specially Steven and Mathieu.

Regards.

On 2020-07-16 02:18, Steven Rostedt wrote:

> On Thu, 16 Jul 2020 02:09:50 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
> 
>> Hi Steven and Mathieu,
>> Firstly, many thanks! This method seems to be the most efficient 
>> method.
>> But, IIUC, what you suggest requires source code compilation. I need 
>> an
>> efficient dynamic method that, given the function address, captures 
>> its
>> occurrence and stores some information from the execution context. Is
>> there anything better than Uprobes perhaps with no trap into the 
>> kernel?
>> Why do we need traps?
>> Regards.
> 
> Without recompiling, how would that be implemented?
> 
> You would need to insert a jump on top of code, and still be able to
> preserve that code. What a trap does, is to insert a int3, that will
> trap into the kernel, it would then emulate the code that the int3 was
> on, and also call some code that can trace the current state.
> 
> To do it in user land, you would need to find way to replace the code
> at the location you want to trace, with a jump to the tracing
> infrastructure, that will also be able to emulate the code that the
> jump was inserted on top of. As on x86, that jump will need to be 5
> bytes long (covering 5 bytes of text to emulate), where as a int3 is a
> single byte.
> 
> Thus, you either recompile and insert nops where you want to place your
> jumps, or you trap using int3 that can do the work from within the
> kernel.
> 
> -- Steve
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
