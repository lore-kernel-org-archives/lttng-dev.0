Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02EC678D5
	for <lttng-dev@archiver.kernel.org>; Tue,  7 Mar 2023 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1678215132;
	bh=ptIh+0pQHIq8MwUCWwgNyS6pCnkukL7YQ/xBOvHjOZU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=L7yTah1QF3GzkcECEnUrFzRilkFQD8QtjuVW/OZQs1P7d50Or4p2V2ztnLZQVt5qd
	 gZNBVLHhBXwmOwnVbPiemdluQYD0VsIutQTi4Qfi6Anr58v3tkLtuUECT2HqnHCQq8
	 pKs0XYVkly7PEyRHHrjEOftLukWyxrqZDu4U07xOhasJsdY6f034opjmS/Uoy7rz6u
	 +5hqrs7WP3zgXAzo3yzz2ddlNVq2wUHxWJsAwuf93zvsFQg7CI8J/FZ5lFsXw7iE8E
	 rLD8wlWFsYwjma1XFXODpn3DE75+fWfYiPVjYEmR0U2evWkr300md/ENcFjZjtxReO
	 5NK8zHbalzpPQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PWPgv4Hnfz2791;
	Tue,  7 Mar 2023 13:52:11 -0500 (EST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4PVRYv2f7Dz26wh
 for <lttng-dev@lists.lttng.org>; Mon,  6 Mar 2023 00:13:39 -0500 (EST)
Received: by mail-ed1-f42.google.com with SMTP id u9so33611533edd.2
 for <lttng-dev@lists.lttng.org>; Sun, 05 Mar 2023 21:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0oi1sAacD/4/qbW1qGnPQmCL9SeelTx2GXdl4DlJc6E=;
 b=avIigFOyZNHo/EevzJ463+G+ypGAgdPDsl1JDmuFpLUmaUV7I4MbcEdF3Kb1/FIJS6
 cxs6NcrJPuTAe5tHszbTu5ztmnsS4r+mjOOsAW2FOmhijNYsIqUpFzl85SIOCErR0swi
 M4FkzPNv/QICI04If6UN1XR0miWFsaNa92h/+ih+EhH98uNnA/WBgc/GZWlBGWKW3dBX
 zWZtNftt65YnrdRt3jahd0iAqPk1hZNzVIr4+ySqjDqqGq1IRa2ZDX3xfESPUuNoKRd8
 VQXqpVa77TmDWohDujtwrXk2jBjs2OpyOdssMwwqBIvBPKj2DA4dMzJ7KeTBy3yTi6Fo
 rrmw==
X-Gm-Message-State: AO0yUKVuJF9Jr/rfFu+3fKJli7elT+dlgbQ8qZOICaodvrL4ctgNFcft
 tqPyRH2pOUNChsWHqZ1Wb6Kkvpd3yyGwyKg9h8epn/xFjXiWIQ==
X-Google-Smtp-Source: AK7set8Q2uA1ZWfOpnxbI3RdjChMvInfwOdfNQlmECnyzKQ3ObZE/zmbuOQB0XTiNjtbYiyjgvlTHZhPotlCy9VvypU=
X-Received: by 2002:a50:f689:0:b0:4be:f5a0:a805 with SMTP id
 d9-20020a50f689000000b004bef5a0a805mr5092808edn.0.1678079557680; Sun, 05 Mar
 2023 21:12:37 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 6 Mar 2023 13:12:25 +0800
Message-ID: <CAL_9pdTicspLuNH8UJ6=sSXuhHKLQOcq7GQC-NA0nmqSYENDzA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Tue, 07 Mar 2023 13:52:09 -0500
Subject: [lttng-dev] how to disable local file writing in relayd?
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
Content-Type: multipart/mixed; boundary="===============2278927006371289396=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2278927006371289396==
Content-Type: multipart/alternative; boundary="000000000000f0c30d05f63457a3"

--000000000000f0c30d05f63457a3
Content-Type: text/plain; charset="UTF-8"

 Can I disable local-file-writing in lttng-relayd to avoid the disk space
overhead, only using it as a live viewer?

--000000000000f0c30d05f63457a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0Can I disable local-file-writing in lttng-relayd to =
avoid the disk space overhead, only using it as a live viewer?<br></div>

--000000000000f0c30d05f63457a3--

--===============2278927006371289396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2278927006371289396==--
