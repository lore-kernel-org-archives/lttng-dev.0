Return-Path: <SRS0=5Vrj=EW=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A263BC4742C
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Nov 2020 14:17:25 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD31D206A1
	for <lttng-dev@archiver.kernel.org>; Mon, 16 Nov 2020 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="ZyqrvRMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD31D206A1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4CZWNy5BMgz1JFr;
	Mon, 16 Nov 2020 09:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1605536243;
	bh=b0OxWGmeb9UJxugOVjO37SsUy4s/PQv5O79lgHljdyg=;
	h=Date:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZyqrvRMQbb+nxlXxTgQU9luBYQz81RNqTue28rvCCSCiEH9ShPwNITBn4YKolnv5h
	 KVA4ZCvyC1eN4XX7gOiaYueGnBrg2FXao4HFrFa9xmA+tNgTgZjewFveSC/rkDIZ7j
	 XZzS4i4o6qXatICDz7L6sb9toQs+ieOP16d/4uBZzDon1KpoD/Pogsixvuld4Lamc/
	 LAs7uML7tp8PAwaVn1QCm/BlYmTWvYd7SFCZAvp7sMWgPWZjEa7vOvuf43/5zdj3eb
	 3VngfbPyfXMGRFvfQedO9GB87Ag4mvx+SSxt1WSIZbrDZ3ZV8EsrIb8vkNoRs6dJnh
	 9fii+airm+60g==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4CZWNw6sxwz1JQX
 for <lttng-dev@lists.lttng.org>; Mon, 16 Nov 2020 09:17:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8EDAF2BCDE0
 for <lttng-dev@lists.lttng.org>; Mon, 16 Nov 2020 09:17:14 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 22iN_HsxoGaz; Mon, 16 Nov 2020 09:17:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id BBFD32BCFC4;
 Mon, 16 Nov 2020 09:17:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BBFD32BCFC4
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 0baur2gTYt0T; Mon, 16 Nov 2020 09:17:13 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id B13D32BCFC3;
 Mon, 16 Nov 2020 09:17:13 -0500 (EST)
Date: Mon, 16 Nov 2020 09:17:13 -0500 (EST)
To: wangshuo <wangshuo47@huawei.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Hushiyuan <hushiyuan@huawei.com>
Message-ID: <1143342448.45804.1605536233606.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201116122446.30900-1-wangshuo47@huawei.com>
References: <20201116122446.30900-1-wangshuo47@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: README: fix typo in README.md
Thread-Index: vVSasg8SQW7Bq8xYNrEpN+KHW5jO5g==
Subject: Re: [lttng-dev] [PATCH] README: fix typo in README.md
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
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

----- On Nov 16, 2020, at 7:24 AM, wangshuo wangshuo47@huawei.com wrote:

> Dear Mathieu,
> 
> This mail may work.

Merged into liburcu master, stable-0.12, stable-0.11, thanks!

Mathieu

> 
> Thank you,
> Shuo
> 
> Signed-off-by: Shuo Wang <wangshuo47@huawei.com>
> ---
> README.md | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index 2d6dcaa..dd7ebd1 100644
> --- a/README.md
> +++ b/README.md
> @@ -388,7 +388,7 @@ For always-on debugging self-checks:
> 	./configure --enable-rcu-debug
> 
> For fine grained enabling of debugging self-checks, build
> -urserspace-rcu with DEBUG_RCU defined and compile dependent
> +userspace-rcu with DEBUG_RCU defined and compile dependent
> applications with DEBUG_RCU defined when necessary.
> 
> Warning: Enabling this feature result in a performance penalty.
> --
> 2.23.0
> 
>> Hi,
>> 
>> This fix does not apply with "git am", probably due to the fact that the email
>> is not
>> formatted as plain text without alteration by your email client. I recommend
>> using
>> git send-email to send patches. Can you try sending it again in the proper
>> format
>> expected by git am ?
>> 
>> You will likely find useful information about why your email client changed the
>> patch formatting here:
>> 
>> [ https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html |
>> https://www.kernel.org/doc/html/v5.9/process/submitting-patches.html ]
>> [ https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients
>> | https://www.kernel.org/doc/html/v5.9/process/email-clients.html#email-clients
>> ]
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> ----- On Nov 13, 2020, at 4:28 AM, wangshuo (AF) <wangshuo47 at huawei.com>
>> wrote:
>> 
>> > README: fix typo in README.md
>> 
>> > Signed-off-by: Shuo Wang < [ mailto:wangshuo47 at huawei.com |
>> > wangshuo47 at huawei.com ] >
>> 
>> > ---
>> 
>> > README.md | 2 +-
>> 
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> > diff --git a/README.md b/README.md
>> 
>> > index 2d6dcaa..dd7ebd1 100644
>> 
>> > --- a/README.md
>> 
>> > +++ b/README.md
>> 
>> > @@ -388,7 +388,7 @@ For always-on debugging self-checks:
>> 
>> > ./configure --enable-rcu-debug
>> 
>> > For fine grained enabling of debugging self-checks, build
>> 
>> > -urserspace-rcu with DEBUG_RCU defined and compile dependent
>> 
>> > +userspace-rcu with DEBUG_RCU defined and compile dependent
>> 
>> > applications with DEBUG_RCU defined when necessary.
>> 
>> > Warning: Enabling this feature result in a performance penalty.
>> 
>> > --
>> 
> > > 2.23.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
