Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21492C433EF
	for <lttng-dev@archiver.kernel.org>; Tue,  4 Jan 2022 15:22:02 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JSxDT0Z8lz4Tp;
	Tue,  4 Jan 2022 10:22:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1641309721;
	bh=5CB8xXKaosG5t6BqZdqMjLf+LObyVL7oCuoSD9ugBcs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=sMOCyOJDlCWlNGNS7kUT5ox+0GIM3nqWIhRQUkjShBPO1Ru3XMOl7frTxpBnBDJyX
	 z0jQYzAJDl9idC9oeal1LQdxbnQl3HSt5U29DjfAMMkvF68wy6dnQyI6kNZOEguH+Q
	 iAX0NpKP21YRh4aAlb6PGtcKQeK98bvpaollMmRwM3PDRbp+fVQHcuEk0t2XhWOcAq
	 Urd6FrP/JIb/CXkfE2rq9Hafeth+C5F0VpwZtPcAD7jlZWX2Iva1LEsCisX8Po0g1M
	 QfgBfqL7rvHAXsTxkqt/qzyUyLP8gemWYe5+6C6YoqHGts99kKxXconOHwwov+IqGx
	 Pe/ZQDQiXnt6A==
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by lists.lttng.org (Postfix) with ESMTPS id 4JJ6TG70dqz1xTg
 for <lttng-dev@lists.lttng.org>; Tue, 21 Dec 2021 01:47:30 -0500 (EST)
Received: by mail-lj1-x22a.google.com with SMTP id v15so19914967ljc.0
 for <lttng-dev@lists.lttng.org>; Mon, 20 Dec 2021 22:47:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=6XL/J92k99LvBLSE/KMI4hXn7Z/wCNvYETpnsXLfZfU=;
 b=WdHv/I6HS4w/sUmy6tsZMzZtc/E3hqOiVk8CTuU9ORvtFiba47BtHB63dfgeVdLsjw
 C8ffj4D6sVNxin+F56fI125P5qvpGtY434gu1wIhzV3allUCmLmFnYjuM6R3+gfgk3SP
 lXpEwQf2WTdhiFNnt6emEG/D9U1BfqXrNRJ+l3q1BahMtuvl2pT6PgYeNN/GJ8HGbPMy
 lKKwRO/bg1/1HBAKCFKDrvGYwkhhO9FaKTiuda6pJH6BSiihIvkesYCzPrm6HsKfBlHl
 pVsjlD/NvtDFUINiiDDkHUcf4hAH1zT2YYA6sI540qkO8/Z1YBtQsPTQZx060hsVlPW7
 Yq+Q==
X-Gm-Message-State: AOAM531Q5MDs4jdVhyvYfD0C0AhoNQemeS5E2vpOWOcYQyPBAIsnPXp1
 1fnauayYNgJ3zQhScAx6TP2ZsHFUEk6a54D+hqT4lLMe52M=
X-Google-Smtp-Source: ABdhPJxtOY7QaJxEMrHtTvy7eyjvgJ9pIMqynjnNlkvQbFcjVJuWf48gog1buH3Ogqs8CLy2Xyy3W4kiBmHdHNKRIts=
X-Received: by 2002:a2e:a48e:: with SMTP id h14mr1455631lji.211.1640069249017; 
 Mon, 20 Dec 2021 22:47:29 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 21 Dec 2021 12:17:12 +0530
Message-ID: <CABAcCUNcS1yaP7-mLijXmecOczr9vQkOukhW4Q-YgKc6Vz-bZw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Tue, 04 Jan 2022 10:21:59 -0500
Subject: [lttng-dev] Running trace-rotate and session-rotate together
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Subrata Paul via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Subrata Paul <subrata.turs@gmail.com>
Content-Type: multipart/mixed; boundary="===============6623980178563204554=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6623980178563204554==
Content-Type: multipart/alternative; boundary="000000000000feac7405d3a260c6"

--000000000000feac7405d3a260c6
Content-Type: text/plain; charset="UTF-8"

Hi,

1. In the lttng-enable-rotation manpage it is mentioned that we should not
use trace rotate when automatic session rotate is enabled. Can you please
tell me why?
```
Important
           You may only use the enable-rotation command when:
           *   The selected recording session was created in normal mode or
in network streaming mode
               (see lttng-create(1)).
           *   No channel was created with a configured trace file count or
size limit (see the
               --tracefile-size and --tracefile-count options of the
lttng-enable-channel(1) command).
```

2. When automatic session rotate is running, is there any race condition in
writing the current ring buffers and archiving the current trace chunk?


--------------------------------------------------------------
Regards,
Subrata Paul

--000000000000feac7405d3a260c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>1=
. In the lttng-enable-rotation manpage it is mentioned that we should not u=
se trace rotate when automatic session rotate is enabled. Can you please te=
ll me why?</div><div>```</div><div><div>Important</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0You may only use the enable-rotation command whe=
n:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0The sel=
ected recording session was created in normal mode or in network streaming =
mode</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(see =
lttng-create(1)).</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=
=A0 =C2=A0No channel was created with a configured trace file count or size=
 limit (see the</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0--tracefile-size and --tracefile-count options of the lttng-enable-ch=
annel(1) command).</div></div><div>```</div><div><br></div><div>2. When aut=
omatic session rotate is running, is there any race condition in writing th=
e current ring buffers and archiving the current trace chunk?</div><div><br=
></div><div><br clear=3D"all"><div><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div><table style=3D"max-width:600px;direction:ltr">
			<tbody><tr><td>=20
			 <table style=3D"max-width:440px;padding-bottom:10px;margin-bottom:8px" =
border=3D"0" cellpadding=3D"0" cellspacing=3D"0"> <tbody><tr> <td> <table b=
order=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"display:inline-fle=
x"> <tbody><tr> <td valign=3D"top" style=3D"vertical-align:top"><font face=
=3D"tahoma, sans-serif">---------------------------------------------------=
-----------<br>Regards,<br>Subrata Paul</font></td><td valign=3D"top" style=
=3D"vertical-align:top;padding-left:12px"></td></tr></tbody></table></td></=
tr></tbody></table></td></tr></tbody></table>
	</div></div></div></div></div></div></div></div>

--000000000000feac7405d3a260c6--

--===============6623980178563204554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6623980178563204554==--
