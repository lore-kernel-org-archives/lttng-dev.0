Return-Path: <SRS0=99QA=AN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DB5C433DF
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Jul 2020 14:03:21 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B1C20772
	for <lttng-dev@archiver.kernel.org>; Thu,  2 Jul 2020 14:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="CoZ2GKJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B1C20772
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49yKYz3Mhfz1987;
	Thu,  2 Jul 2020 10:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1593698600;
	bh=wbKvW5JO25pmDr8topYoe5le0ZNxcIXyCTauWcilU7k=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CoZ2GKJy/pImc9L7O9ZMNGtAQO/euMy59Lj28rTVZC1VqJKxiM6lxc3KwKElwfGoo
	 AJS8lMCURpVyvAIqIYfFpeB8pFLO37T03bmTNvSv1N7n6QWrZQ0IpkqDkU0pif3n4o
	 T8V5ahNu2pAa5KU7/KnQDst+RYuFiLun49H7/vQ1wtQIwp4H8TqDBn4EJorq4zhxSe
	 4cmnFpVfgutmf1H25XpEaXct1UUHgsnNCqQM+eEvc/uMw4eDD0mrTLvxa7rS6W+RbS
	 2qtZmf/Tu3kn+uzfWQxr8K7ZWEW+2GSELnnM36+X+rN2OrqAjYLXxsrJoyXTFOpvbW
	 oJeyGVQg2/EKQ==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 49yKYw5k8zz19K8
 for <lttng-dev@lists.lttng.org>; Thu,  2 Jul 2020 10:03:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A1A352D6DEF;
 Thu,  2 Jul 2020 10:03:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id RNvT27T-4v65; Thu,  2 Jul 2020 10:03:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3407F2D701D;
 Thu,  2 Jul 2020 10:03:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3407F2D701D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2izjcD_56AzL; Thu,  2 Jul 2020 10:03:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 2776C2D6EEB;
 Thu,  2 Jul 2020 10:03:10 -0400 (EDT)
Date: Thu, 2 Jul 2020 10:03:10 -0400 (EDT)
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Message-ID: <445531696.20175.1593698590049.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200702124541.GF4207@joraj-alpa>
References: <5efd3314-04ed-4868-a0c9-408434d330f4.zhenyu.ren@aliyun.com>
 <49dab706-ab7e-4156-9163-b8d9105b173d.zhenyu.ren@aliyun.com>
 <65af8a29-4fd7-454c-a060-8f06cb7bc931.zhenyu.ren@aliyun.com>
 <1653271969.18771.1593605240536.JavaMail.zimbra@efficios.com>
 <fb98f7b9-073e-4e02-86aa-03a0c4952c24.zhenyu.ren@aliyun.com>
 <20200702124541.GF4207@joraj-alpa>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77yaIOWbnuWkje+8mg==?= some
 tracepoints not exist in metadata?
Thread-Index: ONJwqJSiH4rTT0921/Bn2+u21F7Geg==
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77ya5Zue5aSN77yaIOWbnuWkje+8miBz?=
 =?utf-8?q?ome_tracepoints_not_exist_in_metadata=3F?=
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200702140310.i44W8YQRT6khMAERpnwlYyaopsulEI8R1y9xTaJEuA0@z>

----- On Jul 2, 2020, at 8:45 AM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> On Thu, Jul 02, 2020 at 08:38:57AM +0800, zhenyu.ren via lttng-dev wrote:
>> Thanks a lot. I will try single quotes but it may take hours get the result.
>> Yesterday, I enabled the verbose option ,and found the following message "UST
>> app reply event failed. Application died (in add_event_ust_registry() at
>> ust-app.c:5405)" and "UST app notify socket unregister 34 (in
>> ust_app_notify_sock_unregister() at ust-app.c:5562)". In fact ,the socket that
>> Lttng-sessiond send reply to my app return an error with EPIPE. It seems that
>> the pipe breaked.So do you have any hint for that?
> 
> From lttng master:
>    ret = ustctl_reply_register_event(sock, event_id, ret_code);
>    if (ret < 0) {
>    	if (ret != -EPIPE && ret != -LTTNG_UST_ERR_EXITING) {
>    		ERR("UST app reply event failed with ret %d", ret);
>    	} else {
>    		DBG3("UST app reply event failed. Application died");
>    	}
>    	/*
>    	 * No need to wipe the create event since the application socket will
>    	 * get close on error hence cleaning up everything by itself.
>    	 */
>    	goto error;
>    }
> 
> EPIPE ifor this socket is considered as an expected scenario.
> 
> This normally indicates a short-lived application or that your application
> crashed while lttng-ust and lttng-tools were performing an event registration.
> Considering that the path leading to the ustctl_reply_register_event call is
> preceded by a call fetching information from the same socket
> (ustctl_recv_register_event), I expect this to be a completely normal scenario
> unless you provide evidence that this application under tracing was acting
> normally and had a long lifetime.

In addition, one thing to consider is that if the application is a daemon
process closing all file descriptors, using fork, clone or daemon, then
helper libraries need to be preloaded with the daemon following instructions
in the man-page lttng-ust(3) under section "Using LTTng-UST with daemons".

Failure to preload those libraries in daemons would trigger the observed
scenario: the application hangs up the UST communication socket
and never reconnects.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
