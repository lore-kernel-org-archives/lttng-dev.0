Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDDEC4167B
	for <lttng-dev@archiver.kernel.org>; Tue, 28 Nov 2023 03:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1701142030;
	bh=KzIX8SGPcHixHP24EnTGTAWVD1sEtD2pel85QNvddYE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=d9xndbEttw9Yyt6eEmxxEBOvARmu7Btg9eoXj9VIGzn+S4aSGdHSaY09b7x93vD+u
	 /AA3Mu1xk5LeHKRKBXLAQo7aD39l0izMhMu3ObA84hyA9F3rhhNznLbEGGJRjc6eQy
	 W71G/fwSJjJVLQObjNfDA5LCSNwaSD4aqcrmffqZCLxIifidQpVyxaIymFIM5SPy/v
	 nMEfvp5gMKj12ed/2re9aWfc3FkTfXx//szk98IQFExCDzPqMJ0MUPzYeqRDZwTL8d
	 Wf9hz3FJAg5ZHk1EJVJvkA87RxLt471OnPuDSJ9kLeL0KAxIFA0e9QJCrlR2wi1bkq
	 KKiwv44S/+fLQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4SfSYp2Dy2zMwy;
	Mon, 27 Nov 2023 22:27:10 -0500 (EST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by lists.lttng.org (Postfix) with ESMTPS id 4SfSYn2FPnzN6t
 for <lttng-dev@lists.lttng.org>; Mon, 27 Nov 2023 22:27:08 -0500 (EST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso676040066b.2
 for <lttng-dev@lists.lttng.org>; Mon, 27 Nov 2023 19:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701142027; x=1701746827;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gKSMWjrkPoq7VRmyOk/ve8I7QJ908QrDXtvQvwpoGcY=;
 b=tLOG/Sw9y31UR/GV66jjmYItXcrF0yelMLICJ5xJchcwxi2ZVQhmMpGMTWkzWTtl9n
 d7CzWEyYBsOpFpDApjxXzwGbtuSTtuDK8NBSguJ/0ZCDJo2nrbBlQg3ri6lEn3dCzs/y
 SJpZ0UYXOZ/Fr8hfucZoQaQQp6U17GWq/kXbk57hqyIfzwR/dmMYl1+hh5wWSs2I08Ko
 aBNWk3irKj4Aj6qQ8xRJPK8FH29uUe+/RJfoQ0qqDHfArNr2t/wEckgVCnOuqEbMgeJ1
 0YMH7l/Wu3bQg2StBwUY6ihpQLY3sHa+MDv0EoRNvzNCAZMszX4qeFflCLrRRjdQbVEA
 MQrg==
X-Gm-Message-State: AOJu0YzSAMUJXDuX0eSk50QwqB0rIlsZaWhlrRpR3OIxzh6BVNR5r8c0
 9WSNjI1pa0pXZnox3B7BaBSEvuQxaX1sY928B8t2x09m
X-Google-Smtp-Source: AGHT+IFRBf33ilB76pRr0mQdxADynYdAoXge9eR6oOaROdyYcct7GeXz+DZJWYGTe15AAKHTP/6IaEfk80y7Pj2Vzx4=
X-Received: by 2002:a17:906:5ad8:b0:a01:e916:714c with SMTP id
 x24-20020a1709065ad800b00a01e916714cmr10368788ejs.61.1701142027086; Mon, 27
 Nov 2023 19:27:07 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 27 Nov 2023 22:26:55 -0500
Message-ID: <CACJEY877LAEbOY92+vFy2AdYdctw-Z7dVozTm_LF-u-Fzy4c0w@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Any particular reason that the
 LTTNG_UST_TRACEPOINT_EVENT args and fields are limited to max 10?
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
From: Yonghong Yan via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yonghong Yan <yanyh15@gmail.com>
Content-Type: multipart/mixed; boundary="===============1600258812986932558=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1600258812986932558==
Content-Type: multipart/alternative; boundary="0000000000003caff5060b2dfe61"

--0000000000003caff5060b2dfe61
Content-Type: text/plain; charset="UTF-8"

I have a situation where I need to record more than 10 fields. If you can
extend it to support more, but not introduce overhead of handling such rare
cases, that will be great.

Thanks
Yonghong

--0000000000003caff5060b2dfe61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>I have a situation whe=
re I need to record more than 10 fields. If you can extend it to support mo=
re, but not introduce overhead of handling such rare cases, that will be gr=
eat.=C2=A0</div><div><br></div><div>Thanks</div><div>Yonghong=C2=A0</div><d=
iv dir=3D"ltr"><div dir=3D"ltr"><p style=3D"font-size:12.8px"></p></div><di=
v dir=3D"ltr"></div></div></div></div></div></div></div></div></div></div>

--0000000000003caff5060b2dfe61--

--===============1600258812986932558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1600258812986932558==--
