Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB98FC48297
	for <lttng-dev@archiver.kernel.org>; Tue,  6 Feb 2024 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1707248022;
	bh=aPikmqt0THClVHeJvwuJxXNRfpA5qN0AHtCWMRbFsAM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=wDSvsSKwKIaEkaED68tRRMBOH+X5MnKy7qxJuyKuOOEnJ35ciRC2WSlddQlrv0cZh
	 BhkTT7aB0IKwE81iv5MgZV2pzQee/P6oxiF+fOrJOZqhjHN5nWg4+iOyl4lhZeqGaB
	 3lRP++LCGYviiAwWAOKr3RPdvCkNnLM73oZesmNAoJT+qmvBPJmLFQst9sFpvSx4Cz
	 mG2gGKiWRcKVVCeeV97ezELz0W5WSWYHinQsZUJmI9wdCYQjlhS6HKDlNYcVdYhcI/
	 Ie6vv9CjNNS/+AfEQDYuBWtzqH/Rr/a1W7zgyFJEQJqTl5+EJ0eSFI6vqZR2rokgRU
	 Q4k/e0SkpeFZQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4TTthk1h25z1vZw;
	Tue,  6 Feb 2024 14:33:42 -0500 (EST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by lists.lttng.org (Postfix) with ESMTPS id 4TTthh06b0z1vpV
 for <lttng-dev@lists.lttng.org>; Tue,  6 Feb 2024 14:33:39 -0500 (EST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so7657950a12.1
 for <lttng-dev@lists.lttng.org>; Tue, 06 Feb 2024 11:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707248018; x=1707852818;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SzND75kiR3m2KLeciD8S1X16uhXgClzFpdfNlhnktmU=;
 b=qD3I75MBHC+ZaeHo4AW86b8JIyhoozpDGNvU+RDC4iZgITaMi+620lICBmn7V+B9vT
 XQa6BNc+84GMnTphqIRF2REb4He+nEytH0bTU+RBZwAp8OC4396Qx0pWViiL/Grcavsd
 xpw6aLQp/dw6C31ITeyhMBJZbhpIcNH2EH1vbSucb+n4d0xiccE3VVZl7DgIUsSG7hqr
 nqvhPt8b5E5lOzc9JUS20jQhjiyCJulFNhgcs4wATTKEqwCYNIuYBuX1GZmFMbqPmQ1D
 bcylA9YLZKbA6WoPOqsG1sHUczX+RZIvsNTTlygtEuP1t4SaLtyeCX9zjlqgliESazvh
 5UFg==
X-Gm-Message-State: AOJu0YwMChghQZpmke/1SOR0Q+E+CPlhbxnuZnTtTkvEvmg0NsooVdy0
 ZmQPwj0SbkarXsmcB3AZ4WIeBZ18BKAvyeTOJAh7qfBi3tF1Vmu/va1rOumZxE6HKX7O07kkxRg
 +vRAKFBgMkWAEBI3PbNgu4mFi4MFYc4jPQtpy/9O2
X-Google-Smtp-Source: AGHT+IHPV8JFgCa1waIeJwlJU1W/gHZXsh1ANRCxGZb6fcXn6fxxIXW6SOp1MKxz2+GlgpXCwM1PaAT94btQyEL2r24=
X-Received: by 2002:a17:906:41:b0:a37:1e9a:c549 with SMTP id
 1-20020a170906004100b00a371e9ac549mr2365113ejg.49.1707248018176; Tue, 06 Feb
 2024 11:33:38 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 6 Feb 2024 14:32:58 -0500
Message-ID: <CAMxxxdO7w__AjLhnuoxjv5TghuEoLNbBS_7N-UiUdv8YykwAPw@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Hooking up callbacks to LTTng USDT Events
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
From: Adel Belkhiri via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Adel Belkhiri <adel.belkhiri@gmail.com>
Content-Type: multipart/mixed; boundary="===============1153336621569622395=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1153336621569622395==
Content-Type: multipart/alternative; boundary="000000000000aabd610610bba77b"

--000000000000aabd610610bba77b
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Hope you're all good. I'm working on something where I need to set up
routines or callbacks for specific LTTng USDT events (sticking to user
space, not kernel). The plan is to catch these events as they happen to
spot performance issues.

If anyone's done something like this or has pointers on how to pull it off,
I'd really appreciate your advice.

Thanks!

--000000000000aabd610610bba77b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"border:0px solid rgb(217,217,227);box-sizing:b=
order-box;margin:0px 0px 1.25em;color:rgb(55,65,81);font-family:S=C3=B6hne,=
ui-sans-serif,system-ui,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Ca=
ntarell,&quot;Noto Sans&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&=
quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symb=
ol&quot;,&quot;Noto Color Emoji&quot;;font-size:16px">Hi everyone,<br></p><=
p style=3D"border:0px solid rgb(217,217,227);box-sizing:border-box;margin:1=
.25em 0px;color:rgb(55,65,81);font-family:S=C3=B6hne,ui-sans-serif,system-u=
i,-apple-system,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto San=
s&quot;,sans-serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji=
&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Co=
lor Emoji&quot;;font-size:16px">Hope you&#39;re all good. I&#39;m working o=
n something where I need to set up routines or callbacks for specific LTTng=
 USDT events (sticking to user space, not kernel). The plan is to catch the=
se events as they happen to spot performance issues.</p><p style=3D"border:=
0px solid rgb(217,217,227);box-sizing:border-box;margin:1.25em 0px;color:rg=
b(55,65,81);font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-system,&q=
uot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-serif=
,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;Segoe=
 UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;fo=
nt-size:16px">If anyone&#39;s done something like this or has pointers on h=
ow to pull it off, I&#39;d really appreciate your advice.</p><p style=3D"bo=
rder:0px solid rgb(217,217,227);box-sizing:border-box;margin:1.25em 0px;col=
or:rgb(55,65,81);font-family:S=C3=B6hne,ui-sans-serif,system-ui,-apple-syst=
em,&quot;Segoe UI&quot;,Roboto,Ubuntu,Cantarell,&quot;Noto Sans&quot;,sans-=
serif,&quot;Helvetica Neue&quot;,Arial,&quot;Apple Color Emoji&quot;,&quot;=
Segoe UI Emoji&quot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quo=
t;;font-size:16px">Thanks!</p></div>

--000000000000aabd610610bba77b--

--===============1153336621569622395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1153336621569622395==--
