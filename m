Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E520FC00140
	for <lttng-dev@archiver.kernel.org>; Fri, 12 Aug 2022 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1660312940;
	bh=Q/gzTU6XYvUl41b2NzTQMzZiKAmgFJvlYJPDFGSqaOY=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=H8J5JGqsrqUekPEtrH+QHpIO86/NHImNZNNcabu3i4gqI9B63QiZMkcJjMJX+ie2E
	 V7EDgRN1zZ4lL+5qom7W1DbbNrx4yXajh602Nn4YAB/9weypJ3naVbnkjyTsJSz4zL
	 zqkWfWMgmh5Udh9TorIcU8JV22w6YuXGUmbsIMWoDUShvIIYXkeX2Mp5TozZ6Ecbm3
	 Wu6T+AIBWi6LRAaPcn3nZksXW3VuVID0jNtYaCoeGiB0wfJrxGY7b4PU++TeXE/19N
	 gOLhwHo9u0EQ6uAyWQV+AKsFu3c3xSU+Hl7ubGiwAMFo8qoruUslrbP6Gsr/5MnAer
	 /0c1ycqyzEOhw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4M45300c57z1Dqc;
	Fri, 12 Aug 2022 10:02:20 -0400 (EDT)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by lists.lttng.org (Postfix) with ESMTPS id 4M445K0Y0jz1F41
 for <lttng-dev@lists.lttng.org>; Fri, 12 Aug 2022 09:19:16 -0400 (EDT)
Received: by mail-ej1-x635.google.com with SMTP id tl27so2013853ejc.1
 for <lttng-dev@lists.lttng.org>; Fri, 12 Aug 2022 06:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc;
 bh=uUeyxk09EOAsrdPpoER/Jp04DnBYVpd5fvUbJyIbF2w=;
 b=Am4aUHEMWcvJ/l4tLValt6gMuJq7yeMa64mhxXwS1xe4xOPOMCqcS3Hd759oM8aOwm
 xy3LKZbctZ/hwC2TBdlbcaK7Nklsduw0C3tQneMQPeHGrMty7S27ugbxE7bFvUPI7ZXS
 cq/VPpsFaLVOty2xgDpccFX1A+cj6nHUEgVyo5abrF3iZltMghdnoV0TApxn11ASf4MO
 wucyFSIKnqdzalmt3QBf1iunxbQsZPvHHz0vly2vGR9FuaPwON3wa7pO1GKcZGcZaPv9
 fXPZCPXkcnh4SjlQVTLqdbhaot8BImE09j84bF4vZrp7F++AQtXoMubLK+aKBzGCmQoo
 5Wng==
X-Gm-Message-State: ACgBeo18haB6hgTtlHWtqOPFS3apiZqROQcPWQZV/ER3yVYqfnMc4FU9
 zyZOYibddlMC3YnPaqCMBcM0jubp9YLjBWnmOOC0H+7eQz0=
X-Google-Smtp-Source: AA6agR6b4sw9hSRzH3lUqsikwy/zOMYKHTH+O1M/rQu8sSdxPIJeAru0RSJWaoXxb1bPxsp/Jjf59BNMlZsfWP1J+8k=
X-Received: by 2002:a17:906:93f0:b0:730:6d25:8a1e with SMTP id
 yl16-20020a17090693f000b007306d258a1emr2652769ejb.431.1660310355783; Fri, 12
 Aug 2022 06:19:15 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Aug 2022 15:19:04 +0200
Message-ID: <CACXehJBBkAm-7U2fwOd-qaGE5OgbsAZEci5v57XkmUp=7vtKNA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Fri, 12 Aug 2022 10:02:17 -0400
Subject: [lttng-dev] C API message iterator example for libbabeltrace2
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
From: Maksim Khmelevskiy via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Maksim Khmelevskiy <mk.void.mail@gmail.com>
Content-Type: multipart/mixed; boundary="===============1638832728001520186=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1638832728001520186==
Content-Type: multipart/alternative; boundary="000000000000f936e405e60b20a9"

--000000000000f936e405e60b20a9
Content-Type: text/plain; charset="UTF-8"

Hi,

there is a nice py message iterator example
<https://babeltrace.org/docs/v2.0/python/bt2/examples.html> but for C API
only plugins are covered with examples,
do you think it would make sense to create an example of a standalone
application which simply uses `source.ctf.fs` as source and iterates over
all messages? It would be nice hint for those who want to see an example of
graph creation with all the code in one file.
I'm interested in that example because I want to transform CTF file into
list of C structures representing messages.

Thank you!

--000000000000f936e405e60b20a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div>there is a nice <a href=3D"https://babelt=
race.org/docs/v2.0/python/bt2/examples.html">py message iterator example</a=
>=C2=A0but for C API only plugins are covered with examples,</div><div>do y=
ou think it would make sense to create an example of a standalone applicati=
on which simply uses `source.ctf.fs` as source and iterates over all messag=
es? It would be nice hint for those who want to see an example of graph cre=
ation with all the code in one file.</div><div>I&#39;m interested in that e=
xample because I want to transform CTF file into list of C structures repre=
senting messages.</div><div><br></div><div>Thank you!</div></div></div>

--000000000000f936e405e60b20a9--

--===============1638832728001520186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1638832728001520186==--
