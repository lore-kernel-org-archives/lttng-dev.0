Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC84C0015E
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Aug 2023 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1692077597;
	bh=cwd6HYf426wXrTTmnlASmhaA5kqV93d+cSdxuWrPi5g=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NhZ0GYT/Gil5EahOhaGd+pQSpJsIC/XAGITlGdfxcmt3v4xtEDJOAKYh/jApO+UJN
	 TKM6aMAa6nYku2UhS+B7ZBPY3xZiHFpKGl6Aw7imQZMNTbR5a7o1X7BnsSuulzS3MM
	 cNQFLb8BukOPAlkhapBSWzgYD0MFbbdfJhWOAAnGkwgk6kLfm+9Tq+HU9+R+33hSbl
	 7UITCPQWj+k9yjzijGfx2vPYMw62yvJPiBi2gF8zQTTe6JpbxHDThnGUkmJoYVB8AB
	 dGNacqiDd4rYnKNknPlN22ebX+6IF3YR21u+tGd5N+9w/Um5b0rGToa7BFk4cNLofL
	 z8QSAwu/r219A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4RQ0Km4JPWz2MB4;
	Tue, 15 Aug 2023 01:33:16 -0400 (EDT)
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 4RQ0Kk0w6Zz2Lwc
 for <lttng-dev@lists.lttng.org>; Tue, 15 Aug 2023 01:33:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at kdab.com
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Bala Gundeboina <Bala.Gundeboina@kpit.com>
Date: Tue, 15 Aug 2023 07:24:34 +0200
Message-ID: <2693785.mvXUDI8C0e@agathemoarbauer>
Organization: KDAB
In-Reply-To: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
References: <MA0PR01MB6987563FB945A5A4C90312EE8516A@MA0PR01MB6987.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Subject: Re: [lttng-dev] Discarded events
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
From: Milian Wolff via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Milian Wolff <milian.wolff@kdab.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Sonntag, 13. August 2023 16:58:17 CEST Bala Gundeboina via lttng-dev wrote:
> Hi,
> 
> I am Using LTTng in my project , I am recording a kernel session for long
> duration (eg more than 15minutes) I am enabling all the events for
> recording but some events discarding after stopping the session, if i run
> more than 5 minutes only some events are discarding. I have tried to change
> in the .ltttngrc file also to increase buffer-size.

While not directly related to your question, I strongly encourage you to 
review the list of events and only enable those that are actually required for 
the specific issue you are investigating. Some kernel events are _extremely_ 
high frequency but have often no practical use for many (at least in my 
experience and for my own purposes). Examples for the latter are esp. the 
kmalloc tracepoints.

> lttng destroy
> Destroying session `my-kernel-session`...
> Session `my-kernel-session` destroyed
> Warning: 94424667 events were discarded, please refer to the documentation
> on channel configuration
> 
> actually when i am running below command i am getting below warning i am
> thinking this is the issue because sometimes this warning is not coming
> that i didn't seen discarded events.  how to overcome this problem can you
> provide some detailed lttng-sessiond --daemonize
> Warning: Failed to produce a random seed using getrandom(), falling back to
> pseudo-random device seed generation which will block until its pool is
> initialized: Failed to get true random data using getre
> 
> Thanks & Regards
> Bala Gundeboina
> This message contains information that may be privileged or confidential and
> is the property of the KPIT Technologies Ltd. It is intended only for the
> person to whom it is addressed. If you are not the intended recipient, you
> are not authorized to read, print, retain copy, disseminate, distribute, or
> use this message or any part thereof. If you receive this message in error,
> please notify the sender immediately and delete all copies of this message.
> KPIT Technologies Ltd. does not accept any liability for virus infected
> mails.


-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
