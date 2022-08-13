Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F449C19F2D
	for <lttng-dev@archiver.kernel.org>; Sat, 13 Aug 2022 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660432246;
	bh=yAbPkGu0Af95dfaYpeZygr1TgeQqgPaXFtYZUVEnfqc=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=JvRSb4fYSHkl+4hguVJdGkRUB9b1vbon3mkMNeVrp8vdwHP1DB4haiWEmOlok/Gag
	 Xybv0aBMUSV1goq4plrhwzuG02aTt52dpXZHEj+3pkFp50nWsEbFxV58ZFv81r37z9
	 IUob67RbUg39DvBIoVuK6ejbsniJ9QT+AjueHqL8/IYFAPAo/0To+8CvPxrxY4U/LF
	 whMEZFXyQCgKhYZLVCt3GGdAA7JJjKtUoIm3s2oSofE6QnKugXLENQd368rpvaU+TF
	 7HT5qjcwCXZzpSNYo41kLgilcCxfh2shsT5dq0iD5cck7UOvtQo/aWV88aOr/MMfge
	 eUKV+kOxK7c7Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M4x9K3zlKz1FmR;
	Sat, 13 Aug 2022 19:10:45 -0400 (EDT)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by lists.lttng.org (Postfix) with ESMTPS id 4M4x9J0SZdz1G0c
 for <lttng-dev@lists.lttng.org>; Sat, 13 Aug 2022 19:10:43 -0400 (EDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so7663214ejp.13
 for <lttng-dev@lists.lttng.org>; Sat, 13 Aug 2022 16:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc;
 bh=RdI6qVHlv9RVbsiDPMK86MwzbNb3rhB9uP0gti6S580=;
 b=UPQ5nSTEYgN1kMtsR3pULzT16uAVQ8KzJFMcu4ugEmy9jINPDgMT/kR0Q+ysQrOiJc
 AW0MNRMacm/0AvbYkhGHF5ZuW/cUB9gBIyXsxQs0tRpm9upE1cbcAcdG3It8jAhb4Thw
 jy4MUclOqXKYg4qYZFjnbWGG+4p+EoHY7VYzDcQO3ZaVIvyNBgfBP9r6BbZlu1+gpToy
 jzc70HxMUg8NEalT8dtpwcp7b2KR36iD6xqld/APv4ytYLRiuXr6w4NTypGNM5vTY8Ik
 fwT/NfE6lsZwuS4qJ8Bw2CplZB7B8/djek5OkmskbHVuEUckmj6CgS4IsIMBIOPdoESr
 kBOg==
X-Gm-Message-State: ACgBeo1sJJnzzmt0kBp3nS6NwlPNmuEUfMntnn2BAD+n/HyXpqcj79mi
 /v6+8R430r8cWq1+/GtR3nv7zH/kcV84uK5qX0zRvO55USNlKA==
X-Google-Smtp-Source: AA6agR4qQ13SmmtTXo9dpGannkS1UoNscxY21+2yM6NFmPMaN6Q+sb+80oKKhPSLrW1wzyKlgjMaKUTdTqpzTZJnt8E=
X-Received: by 2002:a17:906:93ef:b0:731:1478:b774 with SMTP id
 yl15-20020a17090693ef00b007311478b774mr6153372ejb.531.1660432242058; Sat, 13
 Aug 2022 16:10:42 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 13 Aug 2022 19:10:30 -0400
Message-ID: <CAJbg=FUXDnq0cSLCzhOAO4W44+monQF4s73t_sT4dAPGWt8fPg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Change to CPU number detection breaks QNX compilation
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
From: Elad Lahav via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Elad Lahav <e2lahav@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello,

I have just downloaded and built the library for QNX/aarch64 and
noticed that the code in compat-smp.h breaks the build. This file
appears to be a (very) recent addition, from this commit:

---
commit 5cfe81b7ddff9543d451746de9965cac58c67182
Author: Michael Jeanson <mjeanson@efficios.com>
Date:   Wed Jul 27 10:44:00 2022 -0400

    fix: sysconf(_SC_NPROCESSORS_CONF) can be less than max cpu id

---

I started working around it, but it got a bit ugly. Is the change not
a Linuxism? Does it make sense on other systems? If QNX is the
exception then I can try to come up with a patch, but if not perhaps
the entire code should be wrapped by #ifdef __linux__?

--Elad
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
