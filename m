Return-Path: <SRS0=E16+=CC=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8026AC433E1
	for <lttng-dev@archiver.kernel.org>; Mon, 24 Aug 2020 21:41:29 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CB820702
	for <lttng-dev@archiver.kernel.org>; Mon, 24 Aug 2020 21:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="y3d3fmUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CB820702
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Bb5D71r2Xz34C;
	Mon, 24 Aug 2020 17:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1598305287;
	bh=pXBUuYEFYOdrDNS8MMyqn2qZe6gx8nfmZpobveDsfV4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=y3d3fmUHYJo4S4b5Er1zuOIEIrkiQ2chRvbqk94dy/uOIfcrAgk82UhGqm/idE0Dk
	 mzIyGv8DHj4TkvdLoFnFuivCyFKhqvjKixFDlpgy9k5KKF1NS6nK1xw0i3RaNV21Ri
	 otFUXDVVjbCZMe81fkWRigmBxhFMaA0tUq+zqEPvwufxve5XBnbyds6SXfw+3bYC39
	 5ZkowCwfwWqa5AaMFAF2knKUGmDwtMVlo4w/JrSWE2+ZSvwgotTBXc0EUgGrxfrOjh
	 RhfzAPm0HdYz6BKmek09rB/a3J1SBG9QUt45Sa4wOvib2XVkc0cW5XXKs04sPZUigW
	 6OrxjXSgz9o0A==
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by lists.lttng.org (Postfix) with ESMTPS id 4Bb4nc0dW7z3JW
 for <lttng-dev@lists.lttng.org>; Mon, 24 Aug 2020 17:21:55 -0400 (EDT)
Received: by mail-qk1-x735.google.com with SMTP id 144so8995676qkl.5
 for <lttng-dev@lists.lttng.org>; Mon, 24 Aug 2020 14:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
 bh=qAk+xSMPtwia1Ekl6u9E6sL26IselUhZoQ7F6WYLxgY=;
 b=gn3uevWf8Js3OqAA/9RL7kLXUMfxws+O3zUNyoao5bvMtVnLR0ECKEyLV7TQ9JYP9Z
 9SKlX+nu25YsgQAgB/wZlq6LnSFYJSCxxF7UzDBldavDMT/Wxu9FJ0prSaet3g1SFgj0
 AkZgAa16E67HJ/C8zazZzSiAxBwNRX+Gw0fHhS0IUii9KrtNjlbIqEKfFsAPsCuUMyin
 HuLAVA6E8ob8klt/gdw+dBKnkCtg+fJ2b3Rbpb2J9rMncRoL6pxyewT+bBow2CXjMDsV
 ErJ8lldfj8aQaVPV4/9GcnlYW3MUP+Ov2maxH3SzJ8yBOYwf2L6+y5EFCPOG7l/747MW
 J0mA==
X-Gm-Message-State: AOAM532hMUTsNkaIHoz4Dl1ELU5VfD9q92V70J66XAk31ctGCmwgbJcP
 n73H+khQFdkGRhESt0wJGyF+knOASycGJbRHNmk=
X-Google-Smtp-Source: ABdhPJwM1HV9DG9+PW8nt7nHyO6CAO8GirhsazimHU0sL/IHS/SJnYCau0Y6Xy56Rz75LRUsE75NMQ==
X-Received: by 2002:a37:b88:: with SMTP id 130mr6652495qkl.222.1598304114943; 
 Mon, 24 Aug 2020 14:21:54 -0700 (PDT)
Received: from [192.168.0.105] (ip46-170-159-186.ct.co.cr. [186.159.170.46])
 by smtp.gmail.com with ESMTPSA id f31sm12557190qte.35.2020.08.24.14.21.54
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2020 14:21:54 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Message-Id: <96422055-7592-4024-897D-35CD4D4211B9@ridgerun.com>
Date: Mon, 24 Aug 2020 15:21:51 -0600
To: lttng-dev@lists.lttng.org
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Mailman-Approved-At: Mon, 24 Aug 2020 17:41:23 -0400
Subject: [lttng-dev] sink.ctf.fs vs bt_ctf_writer
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Michael Gruner via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Gruner <michael.gruner@ridgerun.com>
Content-Type: multipart/mixed; boundary="===============5355058101960621774=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>


--===============5355058101960621774==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_861651EB-4594-4298-9642-9FAE4C33F710"


--Apple-Mail=_861651EB-4594-4298-9642-9FAE4C33F710
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all

I=E2=80=99m integrating CTF support to a third party framework. To do =
so, I decided to go with the Babeltrace 2 API (I love the rewrite BTW). =
So basically I made my custom plug-in and the framework spawns the =
following processing graph:

My Framework ->  SOURCE.MYPLUGIN.MYCOMPONENT -> SINK.CTF.FS

This effectively generates a valid set of CTF traces. However, when =
exploring the Babeltrace2 source I found the existence of a =
bt_ctf_writer, which seems like a convenience object to write CTF =
directly (without the need of the graph). This would=E2=80=99ve been a =
much simpler approach for my use case, so I=E2=80=99m evaluating to =
rewrite using bt_ctf_writer in favor of simplicity and maintainability. =
My questions are:

Should bt_ctf_writer be used?=20
bt_ctf_writer is not documented, is it because is being deprecated?
Seems like sink.ctf.fs performs the trace and metadata write back to =
disk when it receives the end message, whereas with bt_ctf_writer I can =
manually flush them (which is very convenient to me). Is there a way to =
achieve this using the graph?

Thanks!
Michael
www.ridgerun.com <http://www.ridgerun.com/>



--Apple-Mail=_861651EB-4594-4298-9642-9FAE4C33F710
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D"">Hi =
all<div class=3D""><br class=3D""></div><div class=3D"">I=E2=80=99m =
integrating CTF support to a third party framework. To do so, I decided =
to go with the Babeltrace 2 API (I love the rewrite BTW). So basically I =
made my custom plug-in and the framework spawns the following processing =
graph:</div><div class=3D""><br class=3D""></div><div class=3D""><b =
class=3D"">My Framework -&gt; &nbsp;SOURCE.MYPLUGIN.MYCOMPONENT -&gt; =
SINK.CTF.FS</b></div><div class=3D""><br class=3D""></div><div =
class=3D"">This effectively generates a valid set of CTF traces. =
However, when exploring the Babeltrace2 source I found the existence of =
a <b class=3D"">bt_ctf_writer, </b>which seems like a convenience object =
to write CTF directly (without the need of the graph). This would=E2=80=99=
ve been a much simpler approach for my use case, so I=E2=80=99m =
evaluating to rewrite using bt_ctf_writer in favor of simplicity and =
maintainability. My questions are:</div><div class=3D""><br =
class=3D""></div><div class=3D""><ul class=3D"MailOutline"><li =
class=3D"">Should bt_ctf_writer be used?&nbsp;</li><li =
class=3D"">bt_ctf_writer is not documented, is it because is being =
deprecated?</li><li class=3D"">Seems like <b class=3D"">sink.ctf.fs =
</b>performs the trace and metadata write back to disk when it receives =
the end message, whereas with bt_ctf_writer I can manually flush them =
(which is very convenient to me). Is there a way to achieve this using =
the graph?</li></ul><div class=3D""><br class=3D""></div><div =
class=3D"">Thanks!</div></div><div class=3D"">Michael</div><div =
class=3D""><a href=3D"http://www.ridgerun.com" =
class=3D"">www.ridgerun.com</a></div><div class=3D""><br =
class=3D""></div><div class=3D""><br class=3D""></div></body></html>=

--Apple-Mail=_861651EB-4594-4298-9642-9FAE4C33F710--

--===============5355058101960621774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5355058101960621774==--
