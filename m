Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30912C6FD1F
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Mar 2023 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679467218;
	bh=TnZwNFNewKyzZtKZnZaO0FKnbShqNZDOYSmaq+EU0aI=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=id/OJeIf1dKqF3i6HiGVIuX9H8n/CGPmrCEjPqC7n2dwQ+TbK5sskZvKeYbP3IHx5
	 F3o0SyYFyG0dZazMLCNa9LGgCAfGGTBQ7UOfX4R+iRIIUf03K50O4MOIFlzbpD/JrC
	 U5qF5Q84cdZZeomy4j6N3ni/6DtZhtk22Ck8+y2GgtWYaHoI/d+LzCL2NhlBJR65dQ
	 9Z8AEnCoktWLqQIj7YUo4Mj73HqJazSgkjIBVfRv2Zq6QSDoSnCLX1dhwO6U2pcG14
	 1z3GLmuYa/0mOT9bY8uK4xw7WxS36F1Es+93dFsRjK+P1P/0b6XqIB5IF6wAVvw3va
	 ix9GWqUxQdEKA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PhJkV0822z2Grd;
	Wed, 22 Mar 2023 02:40:18 -0400 (EDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by lists.lttng.org (Postfix) with ESMTPS id 4PhJkS5z2Jz2HVk
 for <lttng-dev@lists.lttng.org>; Wed, 22 Mar 2023 02:40:16 -0400 (EDT)
Received: by mail-ed1-f46.google.com with SMTP id cy23so68565860edb.12
 for <lttng-dev@lists.lttng.org>; Tue, 21 Mar 2023 23:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679467155;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iwlygwS2jeWdh7JOJdhiJPxRj0faI5Na8tm0h7yv97c=;
 b=aVVLio9XUcJ1PyxlVwwHzlIXHAnyvbnkqNriO/9GiNow838G27LJocu0Jz6Au97h0v
 3uxtmniBET/oYppFDKbZi0+2zIDu4oMJRAwtFDoSrpKqqb6/vBqTfR/w8LuLLHDm7FUT
 L8ATB3Cu8/sEzzrV1imwWd1Od34y+SDOZRK4wQWm50Mb0BuLlegOsngKSQ9gX/gqZRL6
 rbqqwpmFrIDq/isM3fxayNE6TwMOiTjgaOD2IYy11ir23PkqnJNoV3o38fjt7s85V5Nk
 iB3KcBrxMDhLM5k8zFklY7f/TZQXmXgzgOclTanGhO4ANcY3yQBgWGlmAenNolYPufFI
 1ReA==
X-Gm-Message-State: AO0yUKVT18fX4yjCOoanQMSufd7bcVcPE5QBKQKAuBaBNV5FeniKe7BS
 +Ee/3iqCMnB/gVPeJf2UGDwWVc/mBI/t1P0dy2B4aOSoMFM=
X-Google-Smtp-Source: AK7set8vIDgt9yKU5NtWHXPJ6Ub4hp0eaIuGoCUF2nibUDr12qM2VzINqNd9Mn9bYpnn3lvELt/MKkZrdidjyRdGRa4=
X-Received: by 2002:a17:906:d555:b0:931:ecdc:14dd with SMTP id
 cr21-20020a170906d55500b00931ecdc14ddmr2991840ejc.4.1679467155237; Tue, 21
 Mar 2023 23:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
In-Reply-To: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
Date: Wed, 22 Mar 2023 14:39:04 +0800
Message-ID: <CAL_9pdS6dGZ6idu1wAeWrcPrKWdErJ3Rmx5HhdCxNdyy23WAMQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Fwd: how to disable local file writing in relayd?
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
From: Yuan Bin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yuan Bin <elf.ggle@gmail.com>
Content-Type: multipart/mixed; boundary="===============0000074800812862370=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0000074800812862370==
Content-Type: multipart/alternative; boundary="000000000000332f8c05f7776b81"

--000000000000332f8c05f7776b81
Content-Type: text/plain; charset="UTF-8"

 Can I disable local-file-writing in lttng-relayd to avoid the disk space
overhead, only using it as a live viewer?

--000000000000332f8c05f7776b81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><br><br><div dir=3D"ltr">=C2=A0=
Can I disable local-file-writing in lttng-relayd to avoid the disk space ov=
erhead, only using it as a live viewer?<br></div>
</div></div>

--000000000000332f8c05f7776b81--

--===============0000074800812862370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0000074800812862370==--
