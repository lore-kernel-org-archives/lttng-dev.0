Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AE4C433F5
	for <lttng-dev@archiver.kernel.org>; Wed, 13 Apr 2022 20:44:45 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Kdvj8717Mz50V;
	Wed, 13 Apr 2022 16:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1649882685;
	bh=y211z59E0RsmPwPwLFdMphsgLEmp7gVGgNBXkerDk3Y=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=r9XN+Wvw/aBTe147QS97FomPlQxglUTU8kE9jG6J3uvR89Me+cxrQmkwC/WTghrVE
	 SvnxzOkasf6Jm/sHCL/MhK1Exs8IaUW/AWrIYxr+2FMjxPpc2N85a6WrfKkRMoADLv
	 P9+dRCLnV9jYRg5QjgALWbT95A4iye804JTW7pbGCUD2CSG1PAd26GDYuf8mrEEh6q
	 TjduUarWWYd/YD2knikRJG6tOKEcQFHNsu5aUGwQaq5ySB5YgViKZU632xJiqHHpCo
	 nQ9WuXTjcRiIshYwi51R41nEBuTZY8jjNeRXkKAoz4dq0Oa/6VlyX9n1wpmg6xUIDa
	 HUSN+kINgex3A==
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by lists.lttng.org (Postfix) with ESMTPS id 4Kdvj73kPQz4Yt
 for <lttng-dev@lists.lttng.org>; Wed, 13 Apr 2022 16:44:43 -0400 (EDT)
Received: by mail-qt1-f174.google.com with SMTP id ay4so2237380qtb.11
 for <lttng-dev@lists.lttng.org>; Wed, 13 Apr 2022 13:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=qZ8VUEH+umA1mG47WV7GNIgSGaCrUAJLmm1ZK8h2WG4=;
 b=5YzTvnXNAwwP8XjVNVwaZ2W6mEa7VO89KJIO6mwX43zMGBskdl254zbt3Rm5PsoKkV
 mwNDS4C1Ndai9YWyBv4dgfNFd24DcEo6QxKzBpjAoHJlT0ehRNvwfLNNDP2tspBXBqdo
 vsdf11eDWJphJ/a7OV9eBCk+0WC7QyjCgfh6fyZpnhGB2cstC6h3H12XYAZKR+vUfRER
 int1T7cEj8VmyF2FTLXPEaFAs9KL2rThvbzTTq+mNTeRup1hRLi7lLFnSqOMavc3r1eh
 Q2x9Rqkn/RDSEsiaFrjHy1KM9czCrRn7z2LqY7RcSjOGMbt3gWJWASdioM7cRbkLT2Ir
 ZOSg==
X-Gm-Message-State: AOAM5321UaYon2MlT3XaQEfeYf/7PcJ9gH02iky76nXAZNBsVg7Xyy3J
 uYf2tth7nuiBstqE4MgSCfnK+CB/inPljw==
X-Google-Smtp-Source: ABdhPJyW7i2n6f3H8VuoRuH+xwzNrRwyy7Rnk4TyZnpjEeGk1w2M7mzpd3VqpF55lAkfSzkZPEYgzw==
X-Received: by 2002:ac8:1487:0:b0:2ef:ca47:89c1 with SMTP id
 l7-20020ac81487000000b002efca4789c1mr8644717qtj.646.1649882682235; 
 Wed, 13 Apr 2022 13:44:42 -0700 (PDT)
Received: from gmail.com (192-222-180-24.qc.cable.ebox.net. [192.222.180.24])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a05620a211500b0069bf630f3b4sm8562348qkl.125.2022.04.13.13.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Apr 2022 13:44:41 -0700 (PDT)
Date: Wed, 13 Apr 2022 16:44:40 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Message-ID: <Ylc2OCHxPC93anyQ@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.11 - (Ta) Meilleure
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the eleventh bug-fix release of LTTng-tools 2.12 - (Ta)
Meilleure. This release addresses a number of issues listed below.

2022-04-13 lttng-tools 2.12.11 (International Day of Pink)
	* Fix: notification: assert on len > 0 for dropped notification message
	* Fix: sessiond: cmd_enable_channel: negative error code used

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.11.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.11.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
