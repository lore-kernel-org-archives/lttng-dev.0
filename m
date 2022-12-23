Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF38C4332F
	for <lttng-dev@archiver.kernel.org>; Thu, 29 Dec 2022 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1672324286;
	bh=1fUmPVexb0lXJUFGdNkJtgsPp1sY10kaM2CZE5DbUck=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ApFQwXKIMccF/fD21EJxNIXw7nNWFxFAkrhicNXcr6SwRLdEz4xlN4iuYjY2BJ8lZ
	 fiS0SZgUwohst/7JJxNm1jDEMcEnVTxnAZOyKIHJW9OIc3WUrPCveJ69wvX8r5bKOB
	 +xZGSN9+K58/5Ycb/qKeagZyAGB/r5nIhAAvKOl4gAlGeWIzNLJhwuJK4fkpUuVr8s
	 9Pq0rztNyIS+/ZoxCZ7+a/3fiwrS9t/Qtuyuojcb0dUEoynHm8lagCr7J9VaitUnwj
	 qYYcoVwT1BWzqqB5uScB7h1J4Y/ij3dXay+F3mybxBD5RATTm1JGQ70/TtrtmNjZef
	 LL51YalNyRlAg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NjW6P1kJLz1JSt;
	Thu, 29 Dec 2022 09:31:25 -0500 (EST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by lists.lttng.org (Postfix) with ESMTPS id 4NdnxD3rgNz1GH6
 for <lttng-dev@lists.lttng.org>; Fri, 23 Dec 2022 08:25:26 -0500 (EST)
Received: by mail-ed1-f48.google.com with SMTP id r26so1881629edc.5
 for <lttng-dev@lists.lttng.org>; Fri, 23 Dec 2022 05:25:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hE+Jpdi/sO0YTo2wm/QmLXB9PcZGXpoEg4iNGKv39Gk=;
 b=bfa4kslsiA58p2YfNjFi5nWP11JHPSdfcfgu19haJDmOxM+OSoYWFrhlUEZkb5Q3UG
 iUQ4DI3By72WAT4RHdar+9DPOE/ug4yAhyr2S4dCG28rmty7BQ1IUiO2M4rF+o/mdfew
 PBqW9gyr+GChTpotOsRDEeXhq5y97G/rzdL2B6BqdTlGs7C7kFeOzHdhgp/xVgLFB98P
 yHFvnnvlvKGfl47jmLyMK68++2SeHe5X9tuPLSWm7HXqCnC3syvycaxTsdvTX1/tjGaJ
 I5+h0DyKbIhN6BGB+/ovvnVtczqeXCCJTOTRaq/s+p2djuGvf3qiPseIGKOB3tYXVZlO
 FODw==
X-Gm-Message-State: AFqh2kpqj0XCL7I5MvuitTFc34k6g+C1V1/awjwbmyZSqPfKfzkMdqHq
 LJlIED1rZOVrCmBcyfNfCHVH+6VeZIENoBongl13PAqzvNcZeA==
X-Google-Smtp-Source: AMrXdXvuoYWTwLrBMTaAch07ts8QzxKl9i2yfyF9T0Cf9WtJUu6d6gR7SievmrcMie6gZZ4wgcKEjuD3946xnVlna/o=
X-Received: by 2002:a05:6402:481:b0:47f:f170:9b17 with SMTP id
 k1-20020a056402048100b0047ff1709b17mr400369edv.354.1671801864473; Fri, 23 Dec
 2022 05:24:24 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 23 Dec 2022 18:54:12 +0530
Message-ID: <CAGWKocZ1Voz56O8ODGOrWUi56SBLphWQqaAwq_spbcBDmd5uag@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 29 Dec 2022 09:31:23 -0500
Subject: [lttng-dev] Suspected Bug in lttng-tools
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
From: Shubham Kulkarni via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Shubham Kulkarni <shubhambkul16@gmail.com>
Content-Type: multipart/mixed; boundary="===============0387037401866255415=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============0387037401866255415==
Content-Type: multipart/alternative; boundary="0000000000004451f905f07eb4a6"

--0000000000004451f905f07eb4a6
Content-Type: text/plain; charset="UTF-8"

Hi,

I am entirely new to the lttng-tools and frankly not aware of anything.
But, one of our company's customer reported this issue, so I tried
reproducing. I was able to reproduce it with the version of lttng-tool
(2.12.4 - (Ta) Meilleure) installed on my Ubuntu 16.04 (
https://lttng.org/docs/v2.12/#doc-ubuntu-ppa).

Issue is, if I try to snapshot a session with an output filename containing
a ".", it fails. Steps I followed are given below :

*"*
root@MVIN00032:~# lttng create flightrecorder --snapshot
Snapshot session flightrecorder created.
Default snapshot output set to
/home/shubham/lttng-traces/flightrecorder-20221223-153147
Every channel enabled for this session will be set to mmap output and
default to overwrite mode.

root@MVIN00032:~# lttng enable-event -k -a
All Kernel events are enabled in channel channel0

root@MVIN00032:~# lttng start
Tracing started for session flightrecorder

root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n
*record.dump*
DEBUG1 - 15:32:15.173476719 [7159/7159]: LSM cmd type : 28 (in
send_session_msg() at lttng-ctl.c:128)
*Error: Create directory failed*
DEBUG1 - 15:32:15.197542565 [7159/7159]: Clean exit (in clean_exit() at
lttng.c:152)

root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n
*record_dump*
DEBUG1 - 15:32:24.013450964 [7442/7442]: LSM cmd type : 28 (in
send_session_msg() at lttng-ctl.c:128)
*Snapshot recorded successfully for session flightrecorder*

root@MVIN00032:~# lttng stop
Waiting for data availability
Tracing stopped for session flightrecorder

root@MVIN00032:~# lttng destroy
Session flightrecorder destroyed *"*
-----------------------------------------------------------------------------------------------------------------------------------------------------------

I tried the same with lttng-tools v2.9.5 (as one of my company's product
uses this version) under runqemu session, which worked fine for
'record.dump' & with lttng-tools v2.11.5 (another product uses this
version) failed with the same error. So, maybe in between these versions an
issue was introduced.

I am not sure whether this is the correct location to send this mail, but I
didn't find any solution on the Internet and I am not aware of lttng at
all. I was able to reproduce the issue with help from the internet, so
thought to report it via this mailing list.

Thanks,
Shubham

--0000000000004451f905f07eb4a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am entirely new to the lttng-tool=
s and frankly not aware of anything. But, one of our company&#39;s customer=
 reported=C2=A0this issue, so I tried reproducing. I was able to reproduce=
=C2=A0it with the version of lttng-tool (2.12.4 - (Ta) Meilleure) installed=
 on my Ubuntu 16.04 (<a href=3D"https://lttng.org/docs/v2.12/#doc-ubuntu-pp=
a">https://lttng.org/docs/v2.12/#doc-ubuntu-ppa</a>).</div><div><br></div><=
div>Issue is, if I try to snapshot a session with an output filename contai=
ning a &quot;.&quot;, it fails. Steps I followed are given below :</div><di=
v><br></div><div><b>&quot;</b></div><div>root@MVIN00032:~# lttng create fli=
ghtrecorder --snapshot<br>Snapshot session flightrecorder created.<br>Defau=
lt snapshot output set to /home/shubham/lttng-traces/flightrecorder-2022122=
3-153147<br>Every channel enabled for this session will be set to mmap outp=
ut and default to overwrite mode.<br><br>root@MVIN00032:~# lttng enable-eve=
nt -k -a<br>All Kernel events are enabled in channel channel0<br><br>root@M=
VIN00032:~# lttng start<br>Tracing started for session flightrecorder<br><b=
r>root@MVIN00032:~# lttng -vvv snapshot record -s flightrecorder -n <b>reco=
rd.dump</b><br>DEBUG1 - 15:32:15.173476719 [7159/7159]: LSM cmd type : 28 (=
in send_session_msg() at lttng-ctl.c:128)<br><b>Error: Create directory fai=
led</b><br>DEBUG1 - 15:32:15.197542565 [7159/7159]: Clean exit (in clean_ex=
it() at lttng.c:152)<br><br>root@MVIN00032:~# lttng -vvv snapshot record -s=
 flightrecorder -n <b>record_dump</b><br>DEBUG1 - 15:32:24.013450964 [7442/=
7442]: LSM cmd type : 28 (in send_session_msg() at lttng-ctl.c:128)<br><b>S=
napshot recorded successfully for session flightrecorder</b><br><br>root@MV=
IN00032:~# lttng stop<br>Waiting for data availability<br>Tracing stopped f=
or session flightrecorder<br><br>root@MVIN00032:~# lttng destroy <br>Sessio=
n flightrecorder destroyed <b>&quot;</b><br></div><div>--------------------=
---------------------------------------------------------------------------=
------------------------------------------------------------</div><div><br>=
</div><div>I tried the same with=C2=A0lttng-tools v2.9.5 (as one of my comp=
any&#39;s product uses this version) under runqemu session, which worked fi=
ne for &#39;record.dump&#39; &amp; with lttng-tools v2.11.5 (another produc=
t uses this version) failed with the same error. So, maybe in between=C2=A0=
these versions an issue was introduced.</div><div><br></div><div>I am not s=
ure whether this is the correct location to send this mail, but I didn&#39;=
t find any solution on the Internet and I am not aware of lttng at all. I w=
as able to reproduce the issue with help from the internet, so thought to r=
eport it via this mailing list.</div><div><br></div><div>Thanks,</div><div>=
Shubham</div><div><b><br></b></div></div>

--0000000000004451f905f07eb4a6--

--===============0387037401866255415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0387037401866255415==--
