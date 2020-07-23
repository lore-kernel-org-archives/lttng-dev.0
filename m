Return-Path: <SRS0=Ztta=BC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=BAYES_00,BITCOIN_SPAM_04,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE3C433E1
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:01:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E554B207BB
	for <lttng-dev@archiver.kernel.org>; Thu, 23 Jul 2020 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="NdSHIcEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E554B207BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BCDWZ3BqKz1fsc;
	Thu, 23 Jul 2020 10:00:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595512858;
	bh=7yqEt2pYaUP5DVAtuL+Q0ASDixpo18qq5iGEV+OE0Xc=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NdSHIcElnBPpAvcbPRM/0lQXkegx2I9cyR3xJHKKiymgeQH5A7tg7/2f8FYFZiZYf
	 WbpCNOYLQby0ZtQ0ln5gevRooxYvJOpbHhAzEwp6XQyQ0LlfCJBPcYW9tj2NoM2RW2
	 sO1/SmkSSDGTA45r3+k/PWMQ9vqhFVz8B5SadiELCfdmb4dBlXpuO+yu0gM6yhQSFt
	 MQJbcSVlIKTr7wHTw7NGPnu+ueUnq3mxs+cARGnCsyBnHNhIW9QJO16YYR4IypAK1S
	 7pK3h3o5gWldQHFtq/6aFa8eqhFMa2tubrXH+g2qg4kmxCVFkjk6Zb6Zc8ufV2VZ6B
	 379N3oFGTTgsg==
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 by lists.lttng.org (Postfix) with ESMTPS id 4BCDWX3N9tz1fy5
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 10:00:56 -0400 (EDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j1so2884147ybh.10
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 07:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F68M4Mqy1NnoyqjxQncPXfatyxAFjip8rJ+9yxmZAOI=;
 b=KDJceWtvUn7l3E6uvIEWQyoqGgXOtGPnHTucuvbIZICpaKzmb7Xn+s0WlGkhpOTxA0
 Yv5OzTOEnhg1jSOND+gu1oTSHsEe6U0K9k33AUWOri6854HWoxCxJKb/0XH+gRFT2njq
 FIoKZKCrlgpVOBpryFZKqGsNEp+Qf78wqajJmuTacEKaxuT4jI047tRAygGOfTJxlnDs
 N3nL3jYeDfCAoo385xIAHsZzcZQoOtmkNSk2I1C2FVDGTyG59F1AyO3t/6dHf+Pyq/4X
 61zUBvNW8hiX7bibJReKVTM3oi9krlAwPcjmNAKMVVK+UkD0MDDEDM621fp83V03RDCh
 gSEw==
X-Gm-Message-State: AOAM530Axjz6mlEZ4w9thC3c1/kDbCJ+921gC9VW/NdURYZ6b9+sjg17
 9eH93TOXayOpc1tbcubP1SADt6OrcI0yHnPulz4SipJiOgZ5BA==
X-Google-Smtp-Source: ABdhPJwpZJuxA8npUQDysJ4ilj2/wsBzgOw9TYxP8GMUe4Rc2lvUmJ6krLbyoCAndMgRSKmyaPhv6J63YZ0K5H0CntQ=
X-Received: by 2002:a25:7ec7:: with SMTP id z190mr7184690ybc.471.1595512855574; 
 Thu, 23 Jul 2020 07:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <08013efdc19d412b8c1535498ee7b828@HIMDWSMB06.ad.harman.com>
 <CAB4xu_2-vTRj-yu__CCDY-FwTYCVD5dS4TB6bAERnROotek1rA@mail.gmail.com>
 <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
In-Reply-To: <7cb6526a78a9468e969a0fe36f42c6d7@HIMDWSMB06.ad.harman.com>
Date: Thu, 23 Jul 2020 10:00:29 -0400
Message-ID: <CAB4xu_1p0AYHhb1GASzOM9e-pdWmSkeTfZq2tQoyacso1MCUNA@mail.gmail.com>
To: "Kim, Seongab" <Seongab.Kim@harman.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] [EXTERNAL] Re: babeltrace cannot open the trace but
 Trace Compass can open
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
Message-ID: <20200723140029.rH6cY-XjkdOyurR5gjZWZmCZLk0BQQw1KX2zXiFfvZU@z>

On Thu, Jul 23, 2020 at 5:09 AM Kim, Seongab <Seongab.Kim@harman.com> wrote:
>
> Hello Phil,
>
> > -----Original Message-----
> > From: Philippe Proulx <eeppeliteloop@gmail.com>
> > Sent: Wednesday, July 22, 2020 5:06 PM
> > To: Kim, Seongab <Seongab.Kim@harman.com>
> > Cc: lttng-dev@lists.lttng.org
> > Subject: [EXTERNAL] Re: [lttng-dev] babeltrace cannot open the trace but
> > Trace Compass can open
> >
> > Thank you for the bug report.
> >
> > Can I kindly ask you to create an official issue for this?
> >
> > Go to
> > <https://clicktime.symantec.com/38qgEsYhBTfCNnYpLPoAn647Vc?u=https%
> > 3A%2F%2Fbugs.lttng.org%2Fprojects%2Fbabeltrace%2Fissues%2Fnew>.
> >
> > I'd also like you to attach the offending CTF trace so that I can analyze it if it
> > doesn't contain sensitive data and is somewhat small.
>
> I created an account in Redmine, but I'm still waiting for the account activation mail. I tried to click the resend mail link two times without success.
> Also the trace is big (1.4 GB) and it contains sensitive data.
>
> > If it's not possible, do:
> >
> >     $ babeltrace2 -o ctf-metadata /mnt/ssd/work/skim/traces/kernel | grep -
> > A10 '^clock {'
> >
> > and copy the output to the Redmine issue's description.
>
> Here is the result.
>
> skim@d54030999178:~/ssd_work/traces$ babeltrace2 -o ctf-metadata ./kernel | grep -A10 '^clock {'
> clock {
>         name = "monotonic";
>         uuid = "e00bcef2-1ef1-4f02-a241-8561834511fd";
>         description = "Monotonic Clock";
>         freq = 1000000000; /* Frequency, in Hz */
>         /* clock value offset from Epoch is: offset * (1/freq) */
>         offset = -48;

Thanks, this is enough for us.

When your account gets activated, could you copy this into the new
issue's description?

This way you can receive notifications when the issue gets updated.

Thank you,

Phil

> };
>
> typealias integer {
>         size = 27; align = 1; signed = false;
>
> >
> > BR,
> >
> > Phil
>
> Best regards,
> Seongab
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
