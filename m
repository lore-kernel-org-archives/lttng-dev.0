Return-Path: <SRS0=zCFp=LJ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C6C48BE5
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Jun 2021 15:14:32 +0000 (UTC)
Received: from lists.lttng.org (unknown [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD29D61584
	for <lttng-dev@archiver.kernel.org>; Tue, 15 Jun 2021 15:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD29D61584
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4G4BgM6y7zzGfC;
	Tue, 15 Jun 2021 11:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1623770064;
	bh=h4LKJcUsI2h5LiHmHFDgRaBuxFg/ifB2Nxv8Ffq4kJs=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=i9a2iFT00rMT2ihNfj7ak4TDxhs3Yte1+HZ4j30/ELrHNOo/+7Zt+cK3kbjhyHS+M
	 KPrHwC0D+26WxL1SWT8BpQFVljcyarj9RJst/xe48l+DStP9WJbwlf8ncJdpTK9eOE
	 gO0h6mY0bIPww0zyZ8b1Kd/BQRePqCMKGDetAPynyi6pexECNIsbjLcBs6FIWw8KOI
	 tw5UFWPlgYjv3Qo4ruwwQNgt0vgIGOcC5YyoiPcKNY/q4AA62cFUt1KgXUGvFRX5tf
	 FUkRmOZFf+wHnbGExVPCChoLSMKmXnPzPN9Odk5j2bdeTUHKJO38mHw5LfT1gfIYQ9
	 AMiH0k9qRhq8Q==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4G4BgL0zqdzGDC
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 11:14:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id A313B33FF39
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 11:14:15 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id cWMF0wZyPD82 for <lttng-dev@lists.lttng.org>;
 Tue, 15 Jun 2021 11:14:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 413B833FF9D
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 11:14:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 413B833FF9D
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id ZEkV46prbGCm for <lttng-dev@lists.lttng.org>;
 Tue, 15 Jun 2021 11:14:13 -0400 (EDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com
 [209.85.219.179])
 by mail.efficios.com (Postfix) with ESMTPSA id 394A533FDF9
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 11:14:13 -0400 (EDT)
Received: by mail-yb1-f179.google.com with SMTP id g38so21017344ybi.12
 for <lttng-dev@lists.lttng.org>; Tue, 15 Jun 2021 08:14:13 -0700 (PDT)
X-Gm-Message-State: AOAM532KuAxSfFKPCv9qgWHO/kucueOf7hE2Gkrjo5Xdfyatck1gYT+o
 txHWxCPKbPqStWw9Izvm4Po7O9kTBy3qfYq0pCo=
X-Google-Smtp-Source: ABdhPJyMWTqnrzfFV3c0Q/5LqrwUC6Uj7rGr6lqFq8mM6d5Zy83hWvcGP844TqovthM/qkfjXeCAgmRIOzr5vj05AtQ=
X-Received: by 2002:a25:8b0d:: with SMTP id i13mr33259329ybl.398.1623770048527; 
 Tue, 15 Jun 2021 08:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <1119833442.5505.1623700847146.JavaMail.zimbra@efficios.com>
In-Reply-To: <1119833442.5505.1623700847146.JavaMail.zimbra@efficios.com>
Date: Tue, 15 Jun 2021 11:13:41 -0400
X-Gmail-Original-Message-ID: <CAB4xu_1H-4gdandyRx+F0nb1g+sLKatx=oJdzQspM+3hJXoYhA@mail.gmail.com>
Message-ID: <CAB4xu_1H-4gdandyRx+F0nb1g+sLKatx=oJdzQspM+3hJXoYhA@mail.gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Philippe Proulx <pproulx@efficios.com>,
 Jeremie Galarneau <jgalar@efficios.com>, 
 rostedt <rostedt@goodmis.org>, lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [lttng-dev] Usage example of libbabeltrace (babeltrace2) to
 read CTF traces from a GUI
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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
Reply-To: Philippe Proulx <pproulx@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Mon, Jun 14, 2021 at 4:01 PM Mathieu Desnoyers via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi Philippe, Hi Jeremie,
>
> Steven is interested to use libbabeltrace as a CTF trace reader in the KernelShark
> project. It's a GUI which shows Linux kernel traces.
>
> He notices that most of the documented usage examples of the libbabeltrace API
> focus on use-cases where a custom trace format is converted into CTF.
>
> I know that the babeltrace2 program is the main user of libbabeltrace at this
> point, and that it reads CTF as source.
>
> For using libbabeltrace as CTF reader for a GUI, what would be the best examples
> to look at as starting point ? Perhaps the babeltrace2 binary, or just adapt a
> smaller example program and change the custom trace format source to "ctf.fs" ?
> Or anything else ?

Hello,

Unfortunately, the Babeltrace 2 C API documentation [1] doesn't offer a
graph building example at the moment.

Therefore, indeed, the "best" example would be the babeltrace2(1) CLI
(see `src/cli`), although I understand that it's a very generic example
which can be overwhelming to explore.

However, note that instead of instantiating an existing sink component
class (as found in a plugin), you'll want to make your own sink
component class to get access to each event message while also
controlling the graph operations. Using
bt_graph_add_simple_sink_component() [2] would be a good start.

I can cook a minimal working example in the following days.

Phil

[1]: https://babeltrace.org/docs/v2.0/libbabeltrace2/
[2]: https://babeltrace.org/docs/v2.0/libbabeltrace2/group__api-graph.html#gaa8432f03a967d01b764fb1bc959c8e89

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
