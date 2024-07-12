Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF82CC3DA45
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Jul 2024 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1720810976;
	bh=lOI9ucK1TX15IBUm6SFxwARaFQpl7e36MsWgjfzVgQg=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=rUaFgwSXqNevsD5bvPLuQraCKnAsbkVyDp0auIx0w/w31XVtHKHJCE0PXOabG4Lqk
	 BEgRjoy36Mmiw3M6U3nvudTXy5qkbFRKk+GglH4eqfjOIhEN291eGLPhzxRKs2Z0ko
	 5OTzm3Wkjf8SRmOINEFtneMlpw1KI0OYD4T/8iXaqhqK/hCGBvOeF8ffsZz6iCREdU
	 0tv0gHz2nKVxjOy5dtsFdYvGA/BC4X1mRFiufZnqcZKypJqMaEJpJn7pOc9OaUEi/5
	 m42yXGtrTTCFoh+Wdr3NOq3Me+UJ9app/n6fvUk1bmAWITlP5MO6mig0KiD3wR9aCs
	 fQ1Fpgmq3Nstg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WLLZm185vz11Ls;
	Fri, 12 Jul 2024 15:02:56 -0400 (EDT)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by lists.lttng.org (Postfix) with ESMTPS id 4WLLMj5CC8z10cH
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 14:53:21 -0400 (EDT)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so1577678a12.1
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2024 11:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720810400; x=1721415200;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ks4EbphDZNjnCjvJ03PqxcnEBikPxPBGzUqe5tl67ts=;
 b=YKOKN1mn7Xj4lSAiZcjN8Z4i+4L8DL7DVgOSe9Qo6RiM0WSOwbvYwZu7+y/pY39tJW
 oqGYae0IN9o5pYBXT/cXBGu4daQinXuJxdVo3N5DvEY5I+MrBqVD+cPlwEjhDAoEWQEP
 Xe16m6w+vHajiB3sm3vcVp8DlruCgdC+Sx3A8r1VOUtURG2eECgMXw1s5fdTVdv5ogR/
 wVUU0MFbN0MEIugqf2yUqMdht5+XRtX8dUotHHCpfjL49Xrv4x9jHKACYt+haKs4kaAT
 15EPWTwwQdQHMvgazK+u88I7ieawVtsXaHl6W3h+uQPA8M8va6yznQ7TzR8vY9/mjeTP
 idfg==
X-Gm-Message-State: AOJu0YzKeXtbCww0iVMRDF6VdESjouDWbGMTWslLq1zD+zx12NB1M5WU
 D7M2g6/1jLRmxVDAJbJV6lcHuP0qrsuEV137DdGtgT02nJGaBBPZzlGrCpO3H8bAVwpXdOZF00w
 0S1S6tBgsCFrT6HL9o6rfNXvkXXZ3L+3o
X-Google-Smtp-Source: AGHT+IE7nrD5a8Es5w8r4tydCRJ3DRzrePMUrUnSIAmWrJl3tDcG72khjUND7LU+NrAriQJ0In7GQAjvbBnHaZbFv+M=
X-Received: by 2002:a05:6a20:a107:b0:1c2:9084:fcf with SMTP id
 adf61e73a8af0-1c29822dafamr13822142637.14.1720810400298; Fri, 12 Jul 2024
 11:53:20 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jul 2024 14:53:09 -0400
Message-ID: <CAHD10Uhn1kCe7TE7taFQ8ACFJ2CLAKRXp2damYN8xi1SUFdmPA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Fri, 12 Jul 2024 15:02:55 -0400
Subject: [lttng-dev] Error: Unable to list kernel events: Kernel tracer not
 available
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
From: =?utf-8?q?Fran=C3=A7ois_Belias_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Fran=C3=A7ois_Belias?= <beliasossim@gmail.com>
Content-Type: multipart/mixed; boundary="===============3729493997935609368=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3729493997935609368==
Content-Type: multipart/alternative; boundary="000000000000a2c0c9061d116441"

--000000000000a2c0c9061d116441
Content-Type: text/plain; charset="UTF-8"

Hello,

When I run the command `sudo lttng list -k`, I get the following error:

```
Error: Unable to list kernel events: Kernel tracer not available.
```

I am trying to build LTTng-modules from the source. I followed the steps
from this website: [LTTng Documentation](
https://lttng.org/docs/v2.13/#doc-building-from-source), but I still
encounter this error. Can someone help me resolve this issue?

Thanks.

--000000000000a2c0c9061d116441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>When I run the command `sudo lttng list -k`,=
 I get the following error: <br><br>```<br>Error: Unable to list kernel eve=
nts: Kernel tracer not available.<br>```<br><br>I am trying to build LTTng-=
modules from the source. I followed the steps from this website: [LTTng Doc=
umentation](<a href=3D"https://lttng.org/docs/v2.13/#doc-building-from-sour=
ce">https://lttng.org/docs/v2.13/#doc-building-from-source</a>), but I stil=
l encounter this error. Can someone help me resolve this issue?<br><br>Than=
ks.<br><div></div></div>

--000000000000a2c0c9061d116441--

--===============3729493997935609368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3729493997935609368==--
