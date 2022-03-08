Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D622C433FE
	for <lttng-dev@archiver.kernel.org>; Tue,  8 Mar 2022 08:10:46 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KCSgm5snGz96x;
	Tue,  8 Mar 2022 03:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646727045;
	bh=9s5eC5akM1gtawgpYuGbs9x+rQLi9DhDb1TXqAHp5HU=;
	h=Date:To:CC:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lXIBxVsIm6aMZbovbT65Emlyj2LoSKG6eCchv57MfPKOXUlcgY9xpS20OAQDb9q0z
	 7+uGnyYjIfdF/D05lCGrzW2QQClQ9qTgj0p0RaD4Q3Pm5NwxFtevBJ7h9Ts6nj00MR
	 +ChUDATtg/CuOOfRWTP9uNCjlASUDxJrJQVIjhTwRQvjxur93oS8G/Kt6idzXSQlfq
	 Iifgxfr02y5nER+Yc8WU3o8pXHcEgGF7rs/JM9wyd8pqefy64bmg2vP02jutbotUeH
	 CaFAwG9JmkeJaz92O9DszEIgHmu5CJfbyUzXwz3PUmaZnUi2Zr/7CclJ3TLrSrJ219
	 eEDXXnuy/sgmQ==
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by lists.lttng.org (Postfix) with ESMTPS id 4KCSgl2W4Vz9Jh
 for <lttng-dev@lists.lttng.org>; Tue,  8 Mar 2022 03:10:43 -0500 (EST)
Date: Tue, 8 Mar 2022 09:10:35 +0100
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
CC: lttng-dev <lttng-dev@lists.lttng.org>, kernel <kernel@axis.com>
Message-ID: <20220308081035.GA12065@axis.com>
References: <20220225151202.4148809-1-vincent.whitchurch@axis.com>
 <1019241870.115039.1646155163638.JavaMail.zimbra@efficios.com>
 <20220302092730.GA26479@axis.com>
 <921962800.125936.1646674669086.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <921962800.125936.1646674669086.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: consumer-stream:
 use-after-free of metadata bucket
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
From: Vincent Whitchurch via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, Mar 07, 2022 at 06:37:49PM +0100, J=E9r=E9mie Galarneau wrote:
> I had a chance to look into this and came up with the following fix:
> https://review.lttng.org/c/lttng-tools/+/7478/4
> =

> Would you have a chance to try it on your end before I merge it?

I've tested the patch stack in patch set #5 and it does fix the problem
for me too.  Please feel free to add this if you like:

 Tested-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

(By the way, I noticed that patch(1) gets confused by the reproduction
 patch which is part of the commit message.  This probably shouldn't
 matter much though, I only noticed it when I tried to revert the patch
 with git show | patch -p1 -R.)

> Thanks for the great bug report!

Thank you for the fix!
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
