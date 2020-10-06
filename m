Return-Path: <SRS0=IW+h=DN=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E4C41604
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Oct 2020 14:45:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46546208B8
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Oct 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="0KBHaZNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46546208B8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4C5KyN0chjzRXD;
	Tue,  6 Oct 2020 10:45:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1601995532;
	bh=Uhjs7bkNBw2sEmEQxSOpP1/R4Mszvz+HReUUUEYhI1Q=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0KBHaZNN0wuKpYaDeBLXN6GTSnqGS19gsnWmdAO6lhe0UfuBYZx70AmMcrvV72NLe
	 kUyNQcf3oBSMuXBceI7v3uXQXrqcDdsvFeiW36/Jng31BpHE1/hFm5ATzSR/au4LM5
	 hGjIglUPo0sF2vxz2KEkrsYj3YUDRdwCsHzvsSyHuHFZXzx8hMLN0h8pXklJVRQk4a
	 vkFTWjpRPraxgSpCB5sWXezMN62l5yW1p7vy1lL2NcY0zLAvvjrI7GG5JjO4Ofop4e
	 U+9qAFfNS4nKxkx2ab6QzzqvLJEw0JN3ZbRl7BIkM2p/T+I3FSzHAkWo7NJmW5hf2P
	 tM3QqUPQABCew==
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by lists.lttng.org (Postfix) with ESMTPS id 4C5KyL05CtzSHv
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2020 10:45:29 -0400 (EDT)
Received: by mail-yb1-xb2a.google.com with SMTP id x20so9159604ybs.8
 for <lttng-dev@lists.lttng.org>; Tue, 06 Oct 2020 07:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/fNoqAtnGdJysfUe7o0ztPkrfhWuAQ/8JKWvt0cddHw=;
 b=Y9vNU3er5YApr5H+N6SSYxG+N3pfp5POyw59qVw6/H0Bhk7aNaiGbP4ltTcNakWNqr
 OIik3QGq1mDvVhcqBlV/dV2E1RAmjG5+Y8t7Rgv/Dq5T4KjlbJxnJOxafk7HE7v0umXh
 QpBgsrByLI8MBBvnpr8Ey8XkSZ7qB6Up4sjd68a/aj17vcXNARTgclMiJ3lqKjGSsS0m
 OQ0BnyWNwtNukfgaryxcUacc+x9cjoQ85SDz7ZoeVJDEYaV+TD1Ynjq+T4PqcRzYZUlT
 LaZZIBXFRFLjc9HQ21ubNrw734KTIQ6unXDy1N3YJoO2RoB1jbZe0uvTSUJmRaAq0OXP
 hz7g==
X-Gm-Message-State: AOAM531q1KLRQH1eRy42z4J5c1mEaB7Bl3L59dA3GSCLDw0OJZ1qk3rn
 gxizbxMHLmC4sfzHdTsn9j/nciYVw7PLOzSVapw=
X-Google-Smtp-Source: ABdhPJyw8TUr2McoNL+VQ/3M0eW2cYL+fsyi1YzQvwIY2zrn2O4R1axbIE525lrOQN+a0NDnkwPQ8GHh9wItljPKDTI=
X-Received: by 2002:a25:f803:: with SMTP id u3mr7253900ybd.118.1601995529154; 
 Tue, 06 Oct 2020 07:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <1601988739.4352.32.camel@flir.com>
In-Reply-To: <1601988739.4352.32.camel@flir.com>
Date: Tue, 6 Oct 2020 10:45:02 -0400
Message-ID: <CAB4xu_2A_7RXxG_mJ7fdzSHAP2CrH96yKW0Lkf=DZwf24X8JMA@mail.gmail.com>
To: "Owen, Mark (US)" <Mark.Owen@flir.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [barectf] Filter trace messages based on log level
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Tue, Oct 6, 2020 at 9:16 AM Owen, Mark (US) via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi,
>
> Thank you for your work on barectf!

Thank you for writing, Mark.

I always appreciate getting feedback regarding barectf.

>
> I'm considering using it with our embedded MCUs that run on bare metal
> in conjunction with other devices running embedded Linux. The barectf
> platform back end would primarily be async serial that would be
> consumed by a device running embedded Linux.

barectf seems like a good fit indeed.

>
> Our current home brew trace implementation is limited to a logging a
> log level and a message string. I see great potential in being able to
> use the CTF format to output much more information when events occur
> than just a level and a string. My primary concern with barectf is
> that our current trace implementation allows us to filter out packets
> based on log level. I believe this will be necessary for us not to
> exceed our bandwidth limitation (the serial port may also need to be
> shared for telemetry and command messaging).
>
> My question is, do you think barectf is a good fit for filtering
> packets based on a logging level? If so, where would you suggest
> implementing said filtering (e.g. extending the platform API or use a
> custom API in the specific platform implementation)?
>
> I see that the platform API supports enabling or disabling tracing but
> I am looking for something more granular. Is this something that make
> sense to be implemented in the platform implementation? My initial
> thought is that we would probably need to extend our barectf platform,
> back end implementation to include methods for setting the logging
> filter level.

barectf doesn't directly support dynamic event record filtering
currently.

The current role of a barectf platform is to write closed CTF packets to
some back end (async serial in your case), so this is not where you
would deal with event record filtering at the moment.

Here are two suggestions:

1. Wrap the generated barectf tracing functions at your application
   level to augment them with logging-level-based filtering.

   You can probably do this with preprocessor macros.

2. We can add some dynamic event record filtering feature to the
   upstream barectf project.

   I don't have the details, but, for each tracing function, a callback
   function (part of the platform, maybe) would be called to accept or
   reject the event record.

   EfficiOS offers development services which can help here;
   see <https://www.efficios.com/contact/>.

Hope this helps!

Philippe

>
> Before I moved forward I wanted to get your input. Any guidance you
> could provide here would be very helpful.
>
> Thank you,
>
> Mark Owen

>
>
>
> ________________________________
>
> Notice to recipient: This email is meant for only the intended recipient of the transmission, and may be a communication privileged by law, subject to export control restrictions or that otherwise contains proprietary information. If you receive this email by mistake, please notify us immediately by replying to this message and then destroy it and do not review, disclose, copy or distribute it. Thank you in advance for your cooperation.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
