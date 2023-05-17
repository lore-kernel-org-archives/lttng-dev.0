Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D18C7EE24
	for <lttng-dev@archiver.kernel.org>; Wed, 17 May 2023 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1684289536;
	bh=2xwuFZmdDxLyLjd40vuah8HbxBWI9gKLeLbEqOG502E=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=UpDcWG6e4D7p9xDbsjB4EkTwUEN5AOcvwBA/DxOFwW7f8326ankGnhrX1R34kHKyv
	 /L6bpZS1DfCndgXU5VgT80Fn9ZxxbCUMVZGyBmNmQjK7V0cVv3vlGdkuSUgwGs46Hs
	 rx6+a746AB+CvdWvVtykvVSBcqGh22kHDTLpZ0Z7OKY/fM3euWrMW8XVDBjDwbf3qQ
	 wLv0lzf1xbhGvNMLuuBggBvNcMFmMEiuldrUOGZiINfV1/3hXFERIPupTr3ymZDDes
	 bd8XrCZmBy2p9HX/+5QySjEXQVwFphv2D9cSlWiGNhJiZZZJXWNanm3LyPk9zpe1WY
	 DGP08fk4R/5Mw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QLc7M4DrRz1F3T;
	Tue, 16 May 2023 22:12:15 -0400 (EDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by lists.lttng.org (Postfix) with ESMTPS id 4QLc7L4XN6z1F3S
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 22:12:14 -0400 (EDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-50bc570b4a3so369946a12.1
 for <lttng-dev@lists.lttng.org>; Tue, 16 May 2023 19:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684289473; x=1686881473;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5izfVDlJA7Yh28NZb9b0Wcjh+z9AM/iWF7phWLTbfA=;
 b=RS5khkcjpnJgW1LvT1RXaM5X2eLUF0opG1xKyYGUzt3ZKDni0m3IKL1m161N5kUdkp
 fHTm4EPtKRwRi0Gg9P0JnSsfZE+UtWtXylEaeLpR6R6Pb40W0ehv9sdyj5xiK//nfe9N
 o8VbZLR8ZQBPFnIm6x0/Wl57Rv/iPiawNEucXgcB3Cc1MOfSXVSSh4FrPERmQTZepMfK
 CnmD0M+hRH2sPvcne2DkgvLfW0TlOrWZfglmbj0qIstYI8K9UWfQokTqYsVVTUrXbHcv
 GKeraKJIqAF08vemIIy2eoD5z6nk4OWbQBbug/0YjMsc4yNL05gCf+4EmOUZfg3BlmDw
 5qXg==
X-Gm-Message-State: AC+VfDz6N3UItQ/R4e+ddDoo3epg4okPPNdmFDx4ykCd3gDxdKrrZ5ba
 /rlq+sbjJWmKe7szTecV8QJtFWZxkx1UNzo9FwKiFdfNUTo=
X-Google-Smtp-Source: ACHHUZ4v869b56QRVF3tKV7slpaOlN2dLi2ztultGENNXXr7pqlkLBg8bc5KQVsHfwnsfWXavWNhqu1ErkzizIdZ/VI=
X-Received: by 2002:a17:907:6095:b0:96a:fd8a:f840 with SMTP id
 ht21-20020a170907609500b0096afd8af840mr10772884ejc.49.1684289473018; Tue, 16
 May 2023 19:11:13 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 May 2023 22:11:01 -0400
Message-ID: <CAFZh4h8C5ZVHGWsBW2iaVYi56t=SsmuiSGZPLf0KpQO9LwfeMQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Trying to understand use of lttng enable-event --kernel
 --userspace-probe=
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I'm trying to figure out how to use uprobes with lttng.

I can't use a normal uprobe for a line number just using the address I
want to probe obtained from objdump?  As in:

echo 'p /usr/local/bin/my_app:0x2c3a8' >>
/sys/kernel/debug/tracing/uprobe_events

... which isn't a function entry, it's just a line of code I want to probe on.

This link says it has to be elf or sdt:
https://lttng.org/man/1/lttng-enable-event/v2.11/#doc-opt--userspace-probe

So can I not probe on just a line of code by specifying an address???

It doesn't look like these methods above will do what I'm wanting to
do.  I've tried to find examples of using enable-event --kernel
--userspace-probe= but there doesn't appear to be many.

Thanks,

Brian
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
