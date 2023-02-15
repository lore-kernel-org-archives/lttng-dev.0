Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880EC636CC
	for <lttng-dev@archiver.kernel.org>; Wed, 15 Feb 2023 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1676476643;
	bh=tgW/xt/iCBfi/99D0G+QoRuL+2eZXYPi+wY9y05JeQ4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=KOhDR+OhsU8duxPZiDEf0Q//Ov+Md7wVqPgWPo5Zj1LgN/HKqHdcmx36Tf+YiPkDY
	 bxAuUmeAbM+hR8fcwo7t/DlvZV1UN2lXPg6BoHHaCXatWleOtzFcnI79U2v7k503HX
	 DVHHh/O2IvVu0J0XEVSiToiv5y2e475O16GXzI82OTrDnbjqB2GvCy2LkVcH558qE9
	 24BRleVXrUo8f9kjzTrEJe7UnOayG56nrLdWkUtc0jdD8FJfBNittJJhEyRgbsXSoA
	 uSYmXSACoTE9TT1LZnLJwl2Pbtlb/hFPLeHx2C0hcrXs44Mgg9dvKjoTE1dGzorjt/
	 LML4fyq91VxKQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PH2lR1zrtz1dvD;
	Wed, 15 Feb 2023 10:57:23 -0500 (EST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by lists.lttng.org (Postfix) with ESMTPS id 4PGskP3zGRz1dcN
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 04:10:52 -0500 (EST)
Received: by mail-ed1-f42.google.com with SMTP id w3so13985716edc.2
 for <lttng-dev@lists.lttng.org>; Wed, 15 Feb 2023 01:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6kNSD/tfVgEEUmoQTghdTXq6uYJrSdbH4C5n4D5CBQk=;
 b=LUmMnUmtxmuMipJD/vrDU3bI3b7pdONyrcjwHuLXLBObjN/3zkm+iys1AYZgVSA0Ky
 rxqOPdiGD6e40PmzHc7OjxrtmKiBybrTy5lPe9X3+xsbBl5ymPwvHQ8w6GwHiB3SRLIL
 VAvOznNCNkpnTeyA5yFTCu5s1zhuH+906XOI1Z03NK0EkYxXDha0nXfxdg/dt1InCfC8
 qz+ZkSJsSbeKCIatpd0wq64rJDq28SkOUEeZBzFoCK+ZByipMGl+L5N5eVwlMhVRiRE2
 8laysiVdttvP2smAbkdtNUckF4upYz30M/KqrVQ0HtnjzjyveWx9HrcmSOVJ7UfRQbce
 PqMQ==
X-Gm-Message-State: AO0yUKUB9F/Xvu12+nF7ERe/mx5OqknDZa9vawx/RGSfvkcxNQ9p9x4W
 cJVKwG6kvC0KYQl17uaHHzFaJ6kek+2wBTC1AlG2nq76
X-Google-Smtp-Source: AK7set+X8eGd5/T3+eLmlEhc8HyK2pYwvIisRZPyajUOTqUytC58RQc+Kfoy2atzudBCbbfglNmR7q89ZnrwR62TyfE=
X-Received: by 2002:a50:c307:0:b0:49d:ec5d:28b1 with SMTP id
 a7-20020a50c307000000b0049dec5d28b1mr650233edb.7.1676452190935; Wed, 15 Feb
 2023 01:09:50 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 15 Feb 2023 10:09:47 +0100
Message-ID: <CAJw2uSD1OacdHRbppqUk4tmDM7JXoTo1z2tF6eLUmcWke+a6aA@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Wed, 15 Feb 2023 10:57:22 -0500
Subject: [lttng-dev] Filtering tracing by process name or PID/TID
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
From: Rengar Stinkt via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Rengar Stinkt <rengarop2611@gmail.com>
Content-Type: multipart/mixed; boundary="===============3600794106510377160=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3600794106510377160==
Content-Type: multipart/alternative; boundary="00000000000052df7605f4b9718c"

--00000000000052df7605f4b9718c
Content-Type: text/plain; charset="UTF-8"

Dear community,

I only recently started working with lttng tracing due to work related
projects, so I am very new to this. I have done some research before
posting this but I can't seem to find an answer.
I am running several CPU load tests for specific processes on different
devices using lttng and TraceCompass for visualization. I am running into
the issue that 99.9% of traced processes are not of value to me and the
tracing files get extremely big and hard to work with (filtering with
TraceCompass is very slow).
Now I thought of filtering the processes before tracing and I found
filtering by PID and TID. The issue with this is that the PIDs and TIDs are
unique on each device but change between devices.
I then found the command "htop -d 0.1 -u **String**" to see currently
running processes with a certain name.
Now if I run this it shows me the running process IF they are running. I
have time triggered and event triggered processes. There are many
inconvenient workarounds to make it work, like triggering the events and
finding out the PID and then manually copying all of the IDs and pasting
them into "lttng track --kernel --pid=""". But I am trying to find a way to
either filter by name right away, avoiding relying on PIDs or at least to
have an automated process of doing it. But I am unfamiliar with running
code in the PuTTY terminal that we are using, so I am trying to avoid this
(for now). If this is the only option though, I will have to look into it.
Is there any way to filter by name right away like in the mentioned htop
command?

Thank you so much in advance.
Dom

--00000000000052df7605f4b9718c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Dear community,</div><div dir=3D"auto">=
=C2=A0</div><div dir=3D"auto">I only recently started working with lttng tr=
acing due to work related projects, so I am very new to this. I have done s=
ome research before posting this but I can&#39;t seem to find an answer.</d=
iv><div dir=3D"auto">I am running several CPU load tests for specific proce=
sses on different devices using lttng and TraceCompass for visualization. I=
 am running into the issue that 99.9% of traced processes are not of value =
to me and the tracing files get extremely big and hard to work with (filter=
ing with TraceCompass is very slow).</div><div dir=3D"auto">Now I thought o=
f filtering the processes before tracing and I found filtering by PID and T=
ID. The issue with this is that the PIDs and TIDs are unique on each device=
 but change between devices.</div><div dir=3D"auto">I then found the comman=
d &quot;htop -d 0.1 -u **String**&quot; to see currently running processes =
with a certain name.</div><div dir=3D"auto">Now if I run this it shows me t=
he running process IF they are running. I have time triggered and event tri=
ggered processes. There are many inconvenient workarounds to make it work, =
like triggering the events and finding out the PID and then manually copyin=
g all of the IDs and pasting them into &quot;lttng track --kernel --pid=3D&=
quot;&quot;&quot;. But I am trying to find a way to either filter by name r=
ight away, avoiding relying on PIDs or at least to have an automated proces=
s of doing it. But I am unfamiliar with running code in the PuTTY terminal =
that we are using, so I am trying to avoid this (for now). If this is the o=
nly option though, I will have to look into it.</div><div dir=3D"auto">Is t=
here any way to filter by name right away like in the mentioned htop comman=
d?</div><div dir=3D"auto">=C2=A0</div><div dir=3D"auto">Thank you so much i=
n advance.</div><div dir=3D"auto">Dom</div></div>

--00000000000052df7605f4b9718c--

--===============3600794106510377160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3600794106510377160==--
