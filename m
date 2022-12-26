Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC7CC4167B
	for <lttng-dev@archiver.kernel.org>; Mon, 26 Dec 2022 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1672050211;
	bh=fzU95GXrAQyii7JTIY/WsNPRLaHpKjgdn0dsVQA8OJw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0aINOZTOAvZQcXvJlJ8DpPDlrRkVH9TvEW91YlkqStnY6AujiH8S3p3DD63qbJ5C6
	 p0bTB/B+pA3vH46tq2HOr34Jc23L1vsWrIx/yIJZ6uaBM43A/9MFJ3bRt0ZabG1E+v
	 t9mcOcqwsRjiTG8csByHZIvJO2AfaC3QaE6R1fVP03NwJ4ucoyacMonSaCG8Neg0PY
	 Ayu2IDHr1B7t4VmGQ1ijjogghcLyh9cYdFGLvqeT+2/uCzdA7BKlXRwbeaHTmBNhBn
	 vkkvYVsT+iQ7PEj3+E/CKE3zQvKZEnugzYxhHOhbgD66W7UOv7YYuHMHqzOtPzfLaA
	 KJcxUZIVYDIQA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4NgYlk6ZyXz1HZD;
	Mon, 26 Dec 2022 05:23:30 -0500 (EST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4NgYlj2c7tz1HZ7
 for <lttng-dev@lists.lttng.org>; Mon, 26 Dec 2022 05:23:29 -0500 (EST)
Received: by mail-vs1-f41.google.com with SMTP id h26so9944831vsr.5
 for <lttng-dev@lists.lttng.org>; Mon, 26 Dec 2022 02:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FUEzpwkfLZCajvlR9XXrbRyOkTb/VK6cTZPrB80T2Jk=;
 b=Xt1Yhzy7C3ek6+BOIR3QmxexwzYS3lvZOqIwuudtNrgiyfg31JmPGcd+goSA2DFW0C
 vzTT3rfk+mH6Atj2Bpf+KEZoGGklKf9Q84Zz7Q6a1GkDlaXTgYvJBOqu7hbw3uufYa2S
 IaQErYMDSkMPA6TyldHJKHbJhOzMKOjoOx4mEDIq9c37XJtSwq3w+HPDxr1pYeocRvT7
 0UH9F+UyFiWTzF0JNHVogPDJuZFPzWdO4I96QdWXkZ2U6JxfdzHkMzmJWQuMk9EP1xIy
 cbf+6CNxXfvvn3h/jN9zHhu79XEva7HFPlzDO9lvTItnC0VUaJfxuDoab/T3UPDYa8q0
 EnGw==
X-Gm-Message-State: AFqh2kr+6GOZ+/g3kN5r93JE8LB4W/xHykPBbQPN/VDYclu75XXRsk2r
 eJFk2bD8SF6WYDe4qcJHCy0O3lox8Ag68FL827i6vdBUjl7nZQ==
X-Google-Smtp-Source: AMrXdXsxiAymRplCyJvuc0blV/xzToLClSq13faKUJLiTOZvhfnsaEPz5Aj8lQv+TQlXH6WqCafqLq4E0NSTQotlpMg=
X-Received: by 2002:a05:6102:2389:b0:3b1:352b:b22a with SMTP id
 v9-20020a056102238900b003b1352bb22amr2062054vsr.40.1672050148381; Mon, 26 Dec
 2022 02:22:28 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 26 Dec 2022 15:52:17 +0530
Message-ID: <CAGWKocYTK=vVyh3DjHHoKWj_Fua_Qjc+7ruG1R6d=Y2ki7uraQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
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
Content-Type: multipart/mixed; boundary="===============6070017915337489397=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6070017915337489397==
Content-Type: multipart/alternative; boundary="0000000000002416de05f0b88372"

--0000000000002416de05f0b88372
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

--0000000000002416de05f0b88372
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am entirely new to the lttng-tool=
s and frankly not aware of anything. But, one of our company&#39;s customer=
 reported=C2=A0this issue, so I tried reproducing. I was able to reproduce=
=C2=A0it with the version of lttng-tool (2.12.4 - (Ta) Meilleure) installed=
 on my Ubuntu 16.04 (<a href=3D"https://lttng.org/docs/v2.12/#doc-ubuntu-pp=
a" target=3D"_blank">https://lttng.org/docs/v2.12/#doc-ubuntu-ppa</a>).</di=
v><div><br></div><div>Issue is, if I try to snapshot a session with an outp=
ut filename containing a &quot;.&quot;, it fails. Steps I followed are give=
n below :</div><div><br></div><div><b>&quot;</b></div><div>root@MVIN00032:~=
# lttng create flightrecorder --snapshot<br>Snapshot session flightrecorder=
 created.<br>Default snapshot output set to /home/shubham/lttng-traces/flig=
htrecorder-20221223-153147<br>Every channel enabled for this session will b=
e set to mmap output and default to overwrite mode.<br><br>root@MVIN00032:~=
# lttng enable-event -k -a<br>All Kernel events are enabled in channel chan=
nel0<br><br>root@MVIN00032:~# lttng start<br>Tracing started for session fl=
ightrecorder<br><br>root@MVIN00032:~# lttng -vvv snapshot record -s flightr=
ecorder -n=C2=A0<b>record.dump</b><br>DEBUG1 - 15:32:15.173476719 [7159/715=
9]: LSM cmd type : 28 (in send_session_msg() at lttng-ctl.c:128)<br><b>Erro=
r: Create directory failed</b><br>DEBUG1 - 15:32:15.197542565 [7159/7159]: =
Clean exit (in clean_exit() at lttng.c:152)<br><br>root@MVIN00032:~# lttng =
-vvv snapshot record -s flightrecorder -n=C2=A0<b>record_dump</b><br>DEBUG1=
 - 15:32:24.013450964 [7442/7442]: LSM cmd type : 28 (in send_session_msg()=
 at lttng-ctl.c:128)<br><b>Snapshot recorded successfully for session fligh=
trecorder</b><br><br>root@MVIN00032:~# lttng stop<br>Waiting for data avail=
ability<br>Tracing stopped for session flightrecorder<br><br>root@MVIN00032=
:~# lttng destroy<br>Session flightrecorder destroyed=C2=A0<b>&quot;</b><br=
></div><div>---------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------</div><div><br></div><div>I tried the same with=C2=A0lttng=
-tools v2.9.5 (as one of my company&#39;s product uses this version) under =
runqemu session, which worked fine for &#39;record.dump&#39; &amp; with ltt=
ng-tools v2.11.5 (another product uses this version) failed with the same e=
rror. So, maybe in between=C2=A0these versions an issue was introduced.</di=
v><div><br></div><div>I am not sure whether this is the correct location to=
 send this mail, but I didn&#39;t find any solution on the Internet and I a=
m not aware of lttng at all. I was able to reproduce the issue with help fr=
om the internet, so thought to report it via this mailing list.</div><div><=
br></div><div>Thanks,</div><div>Shubham</div></div>

--0000000000002416de05f0b88372--

--===============6070017915337489397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6070017915337489397==--
