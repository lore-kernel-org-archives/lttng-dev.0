Return-Path: <SRS0=9aER=A3=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6BC433E3
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:49:52 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218C72078C
	for <lttng-dev@archiver.kernel.org>; Thu, 16 Jul 2020 01:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="GGRS6I2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218C72078C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B6cdB2xh4z1XmC;
	Wed, 15 Jul 2020 21:49:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594864191;
	bh=6qClj7FDsNdhIqLGNeyu+WeRfv7MM3l4JkEBoYcNwx4=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GGRS6I2L6rixnaFDJnXHArj9p1mZE9f0br653QDyb9p5w9Hlu0fW9IaXMjPRPizwn
	 2bWxcBL6r2aRHvqQdU77dkFBjeXelELZR4oO/keUEhrDtEdQ89Zn1q9KZ95Y9EolPx
	 SUbA0SrQ+8cXtI5Sg7jSPKsaCvUnKxMmi5wDJqxA2X8Qb91UqJuvNSD/iT55zoKztJ
	 VUJSXj8u8Ec6DnANY2DR6VDFcEvdJlo8CZCoMfQ9KXg2wMzQpuy3TlcLmy8GFECiyg
	 hY76byyjCZN2Ry5TyXvbclxwIs1ya1lZg+aF6VaSvs1kIUPRfGuKiPAwN0vbZIJgkT
	 LPCaq97upcR3Q==
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by lists.lttng.org (Postfix) with ESMTPS id 4B6cd91L2kz1XZN
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2020 21:49:48 -0400 (EDT)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-NZGckounOVaCjCtky7ZpgA-1; Wed, 15 Jul 2020 21:49:38 -0400
X-MC-Unique: NZGckounOVaCjCtky7ZpgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF7C1B18BC0;
 Thu, 16 Jul 2020 01:49:36 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.phx2.redhat.com [10.3.112.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2890378471;
 Thu, 16 Jul 2020 01:49:35 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94)
 (envelope-from <fche@redhat.com>)
 id 1jvt1g-00054r-R5; Wed, 15 Jul 2020 21:49:32 -0400
Date: Wed, 15 Jul 2020 21:49:32 -0400
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 ahmadkhorrami <ahmadkhorrami@ut.ac.ir>,
 linux-trace-users-owner@vger.kernel.org,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 lttng-dev <lttng-dev@lists.lttng.org>, Namhyung Kim <namhyung@kernel.org>
Message-ID: <20200716014932.GB10566@redhat.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
 <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
 <20200715174858.4698803c@oasis.local.home>
 <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <489547987.230950.1594861561764.JavaMail.zimbra@polymtl.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
From: "Frank Ch. Eigler via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Frank Ch. Eigler" <fche@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200716014932.T45MquSq2iQwj40iNe3ZoSw6zn_A8VwBTwoLu19ZKXw@z>

Hi -

> If you can afford a more invasive tool, that requires a lot of
> memory and stops your application for quite some time, you can look
> at approaches like dyninst that decompile the binary, insert
> instrumentation code and reassemble the code.

> https://dyninst.org/

For the record, systemtap includes a backend that uses dyninst as a
pure userspace backend.


% cat foo.c
#include <stdio.h>

int foo() {
  printf("foo\n");
  return 1;
}

int main() {
  foo();
}

% gcc -g foo.c

% stap --runtime=dyninst -e '
   probe process.function("*").{call,return} { println(pp()) }
' -c a.out

foo
process("/home/fche/a.out").function("main@/home/fche/foo.c:8").call
process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").call
process("/home/fche/a.out").function("foo@/home/fche/foo.c:3").return
process("/home/fche/a.out").function("main@/home/fche/foo.c:8").return


- FChE

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
