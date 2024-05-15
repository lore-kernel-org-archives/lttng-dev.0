Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB1BC25B75
	for <lttng-dev@archiver.kernel.org>; Wed, 15 May 2024 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1715811880;
	bh=SQ4yt/iXuK4SYBnxzi6sDHA/Rf37NTmpJB8MrK3EmMU=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CfaF46P5TVfyrG8vZqwo+Yei7Z4VPJEXNVdQePmt7Mt7aS4zczIG2AqEb6EvV4Dye
	 LEmIgqG2z7/7Kl/Ndh/wvzV4NjYDaol0VrAIDHVpxuOCtGPNda8DTYyKeoFaujY5nX
	 6BxTVhUj7IsR7kqHPBH/JA5wOSge7QR4kJNx1sDvhsvg/BHUFPEpgwzHl7MbDTXA5L
	 jIY0eHHkIiWN2i0ieR4SQiH4ZPFMm5lrsWGw1lxo/UkV/NYoGkxdMTugSEVdGqX0il
	 zwrLeRYsFrgE2m8aIy1CNVNMSWadgNoWyOW45jtJA3cmRQMnaCHfKTj3SwYltGgBY2
	 53RiGoeyrY+Xw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4VfnpJ1xl9z2nkp;
	Wed, 15 May 2024 18:24:40 -0400 (EDT)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by lists.lttng.org (Postfix) with ESMTPS id 4VfnpG4yycz2nkX
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2024 18:24:38 -0400 (EDT)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-62050e00cfdso66610807b3.3
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2024 15:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715811878; x=1716416678;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Zm1iVSMlBaQcaAYPUKhpbjWkyoRoA2hrYs/ivjcxZs=;
 b=VBh/UWonqIt+YNNZGhDV15uJlHKxZeRu2u+yLWStPGKweW49exzwiTkscUiA4OItVP
 5BMa37PBzK9pU7iqnpk3vjLwKKky5XEnc9uzO2lBbJzRMDFF0n2V9YywV9ayu4P8CzXq
 drk+UupMMhPyzTMEnBzRtMlGJ8t93QrrdQtdvdf1hAhofgmJXiv/WuoT+NGCilEaPCC1
 9O5z5yXA66GSZF5Oj0GZc2u7H7bhD/iQ0tcG0yIwqz/WE8I4JL4YPfvGXnyhbpAYFpsd
 imq7TVAioLQcAy0x34iPYjgK8iZnmHLfjBxN6CCdHYQqAVxgxAOEAOwV0mUDX63tsmmC
 OU7w==
X-Gm-Message-State: AOJu0YwWhLpsIerh6AHvExDwlfBESliGjJ3BHgGJO9h/wZACSULejBR5
 +CpK5gq1sC8ffsR8ZPjZHBRMComtaKTyimWehE8L0smxDoNDqwm7H3wzU75kBLqg+6896nvJuv7
 AS7VDpsg0IpADA52EZ9kPF+OD1PQiWzr2kD40i/5hAou9Np9AGq/a4Q==
X-Google-Smtp-Source: AGHT+IHHp1iW3ZBDk4i9I3oS49XX5HtlSwlf6C8vB+KHolpowMRb6YzM3T4aQtrDa1mpHxUU4lQGaoUrVLd8SpCVY/A=
X-Received: by 2002:a05:690c:6f8d:b0:61a:da7e:1f66 with SMTP id
 00721157ae682-622aff75ff2mr195741427b3.2.1715811877454; Wed, 15 May 2024
 15:24:37 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 May 2024 15:24:26 -0700
Message-ID: <CAA1MA5d-ah6bqoN8=_5PwTe-6h_2B0GsHzt=cVuwJANyiMDhGg@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Capturing snapshot on kernel panic
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
From: Damien Berget via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Damien Berget <damien.berget@flyzipline.com>
Content-Type: multipart/mixed; boundary="===============1453802629387778688=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1453802629387778688==
Content-Type: multipart/alternative; boundary="000000000000751f3f0618859516"

--000000000000751f3f0618859516
Content-Type: text/plain; charset="UTF-8"

Good day,
we have been using LTTng successfully to capture snapshots on user defined
tracepoints and it did provide invaluable to debug our issues. Thanks to
all the contributors of this project!

We'd like to know if it would be possible to trigger on a kernel panic? I
might be dubiously possible as you would still need to have the file-system
working to write the results but I should ask.

Looking at available kernel syscall, the "reboot" one seems like a good
candidate, however I was not able to capture a snapshot on it. I have
tested the setup below with "--name=chdir" syscall and it works, "cd" to a
directory will create a trace. But no dice with reboot.

Would you have any suggestions?
Thanks for your help,
Cheers
Damien

============================

# Prep output dir
mkdir /application/trace/
rm -rf /application/trace/*

# Create session
sudo lttng destroy snapshot-trace-session
sudo lttng create snapshot-trace-session --snapshot
--output="/application/trace/"
sudo lttng enable-channel --kernel --num-subbuf=8 channelk
sudo lttng enable-channel --userspace --num-subbuf=8 channelu

# Configure session
sudo lttng enable-event --kernel --syscall --all --channel channelk
sudo lttng enable-event --kernel --tracepoint "sched*" --channel channelk
sudo lttng enable-event --userspace --all --channel channelu
sudo lttng add-context -u -t vtid -t procname
sudo lttng remove-trigger trig_reboot
sudo lttng add-trigger --name=trig_reboot \
        --condition=event-rule-matches --type=kernel:syscall:entry \
        --name=reboot\
        --action=snapshot-session snapshot-trace-session \
        --rate-policy=once-after:1

# start & list info
sudo lttng start
sudo lttng list snapshot-trace-session
sudo lttng list-triggers

#======== test it...
sudo reboot

#======= reconnect and Nothing :(
$ ls -alu /application/trace/
drwxr-xr-x    2 u  u       4096 May 15  2024 .
drwxr-xr-x   10 u  u       4096 May 15  2024 ..

--000000000000751f3f0618859516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good day,<br>we have been using LTTng successfully=C2=A0to=
 capture snapshots on user defined tracepoints and it did provide invaluabl=
e to debug our issues. Thanks to all the contributors of this project!<br><=
br>We&#39;d like to know if it would be possible to trigger on a kernel pan=
ic? I might be dubiously possible as you would still need to have the file-=
system working to write the results but I should ask.<br><br>Looking at ava=
ilable kernel syscall, the &quot;reboot&quot; one seems like a good candida=
te, however I was not able to capture a snapshot on it. I have tested the s=
etup below with &quot;--name=3Dchdir&quot; syscall and it works,=C2=A0&quot=
;cd&quot; to a directory will=C2=A0create a trace. But no dice with reboot.=
<br><br>Would you have any suggestions?<br>Thanks for your help,<br>Cheers<=
div>Damien<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br># Prep output dir<br>mkdir /application/=
trace/<br>rm -rf /application/trace/*<br><br># Create session<br>sudo lttng=
 destroy snapshot-trace-session<br>sudo lttng create snapshot-trace-session=
 --snapshot --output=3D&quot;/application/trace/&quot;<br>sudo lttng enable=
-channel --kernel --num-subbuf=3D8 channelk<br>sudo lttng enable-channel --=
userspace --num-subbuf=3D8 channelu</div><div>
<br># Configure session<br>sudo lttng enable-event --kernel --syscall --all=
 --channel channelk<br>sudo lttng enable-event --kernel --tracepoint &quot;=
sched*&quot; --channel channelk<br>sudo lttng enable-event --userspace --al=
l --channel channelu<br>sudo lttng add-context -u -t vtid -t procname<br>su=
do lttng remove-trigger trig_reboot<br>sudo lttng add-trigger --name=3Dtrig=
_reboot \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 --condition=3Devent-rule-matches -=
-type=3Dkernel:syscall:entry \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 --name=3Drebo=
ot\<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 --action=3Dsnapshot-session snapshot-tra=
ce-session \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 --rate-policy=3Donce-after:1<br=
><br># start &amp; list info<br>sudo lttng start<br>sudo lttng list snapsho=
t-trace-session<br>sudo lttng list-triggers</div><div><br>#=3D=3D=3D=3D=3D=
=3D=3D=3D test it...<br>sudo reboot =C2=A0 =C2=A0<br><br></div><div>#=3D=3D=
=3D=3D=3D=3D=3D reconnect and=C2=A0Nothing :(<br>$ ls -alu /application/tra=
ce/<br>drwxr-xr-x =C2=A0 =C2=A02 u =C2=A0u =C2=A0 =C2=A0 =C2=A0 4096 May 15=
 =C2=A02024 .<br>drwxr-xr-x =C2=A0 10 u =C2=A0u =C2=A0 =C2=A0 =C2=A0 4096 M=
ay 15 =C2=A02024 ..<div dir=3D"ltr" class=3D"gmail_signature" data-smartmai=
l=3D"gmail_signature"><div dir=3D"ltr"><div style=3D"color:rgb(34,34,34)"><=
br></div></div></div></div></div>

--000000000000751f3f0618859516--

--===============1453802629387778688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1453802629387778688==--
