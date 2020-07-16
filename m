Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6D1C433E2
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:26:26 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D5420739
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 16:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="CJLuGRXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D5420739
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B704c6tzxz1YCw;
	Thu, 16 Jul 2020 12:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594916785;
	bh=g11ZC8yAvlDKqlIHcB37mPoULIyWUlew4ro013rFbCk=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CJLuGRXUVpv+9bSz5fd7nTEIPjidQoQiJt8eaCdTkmxfsUtP2FB9ov6n32iimwdZK
	 TgqdXf8UJ1YF+VHePlPtuDCrUxIhfKByMW+ulGjTP6irMZz9f8X4VwEhPtTjWOgJqh
	 DeopwK/eDU9nia7tXt+dACq0icVSJWa7XXlzo4LEAFPEfjHhrhFk79H2Nw+lBb/pGS
	 ZcmlAAntcIYmUZg2Hqobw5z4fMWl3y9Tp+bbkWFoG4QXfhOInNVINI59u/ilXuQ8c+
	 xuHlAjmJsDjFbJjDiTUGbxbSMNege/Rfe17VnTYBG9YJ6GRpBpkcozKMMTvvGqMO+/
	 wPIfRkyKjjA2A==
Received: from mail.ut.ac.ir (mail.ut.ac.ir [80.66.177.10])
 by lists.lttng.org (Postfix) with ESMTPS id 4B704b11WLz1YRx
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jul 2020 12:26:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.ut.ac.ir (Postfix) with ESMTP id 0896F1DAF64;
 Thu, 16 Jul 2020 20:56:15 +0430 (+0430)
Received: from mail.ut.ac.ir ([127.0.0.1])
 by localhost (mail.ut.ac.ir [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id fyBNJ0CFXIIt; Thu, 16 Jul 2020 20:56:14 +0430 (+0430)
Received: from mail.ut.ac.ir (mail.ut.ac.ir [194.225.0.10])
 by mail.ut.ac.ir (Postfix) with ESMTP id E5B2D1DAF5B;
 Thu, 16 Jul 2020 20:56:13 +0430 (+0430)
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 20:56:13 +0430
To: "Frank Ch. Eigler" <fche@redhat.com>
In-Reply-To: <20200716014932.GB10566@redhat.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
 <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
 <20200716014932.GB10566@redhat.com>
Message-ID: <7f301943d8e46bb21068c2d8017e7b4f@ut.ac.ir>
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
Cc: linux-trace-users-owner@vger.kernel.org,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, lttng-dev <lttng-dev@lists.lttng.org>,
 Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716162613.XXVvGjBX5mgI6KAx2yFZoJ_14dfh6qa1Cd8MDYlQ99M@z>

Hi Frank,

Thanks for the point!

Regards.


On 2020-07-16 06:19, Frank Ch. Eigler wrote:

> Hi -
> 
>> If you can afford a more invasive tool, that requires a lot of
>> memory and stops your application for quite some time, you can look
>> at approaches like dyninst that decompile the binary, insert
>> instrumentation code and reassemble the code.
> 
>> https://dyninst.org/
> 
> For the record, systemtap includes a backend that uses dyninst as a
> pure userspace backend.
> 
> % cat foo.c
> #include <stdio.h>
> 
> int foo() {
> printf("foo\n");
> return 1;
> }
> 
> int main() {
> foo();
> }
> 
> % gcc -g foo.c
> 
> % stap --runtime=dyninst -e '
> probe process.function("*").{call,return} { println(pp()) }
> ' -c a.out
> 
> foo
> process("/home/fche/a.out").function("main@/home/fche/foo.c:8").call
> process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").call
> process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").return
> process("/home/fche/a.out").function("main@/home/fche/foo.c:8").return
> 
> - FChE
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
