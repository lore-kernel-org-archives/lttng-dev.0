Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61A8E63FF9
	for <lttng-dev@archiver.kernel.org>; Sun,  5 Apr 2026 01:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fpDhN5njKz1L76
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1775350948;
	b=DuU3KDgZb7jQEeJgTMqVOaB8b9ZLDuvsBb11c8ykaSUsYv0ReMHqH1wVgwFSE+hrClJ8
	 71tj59NAzqUpYyCLad+UczSetr39/bC+vfBHUGPr1lLw8RTc+vUVvdXjcOi07hUfDtLLb
	 MDeL9Ucf+hY7oirHQGc/4sQ1VGOo+GKjWssMqk7hcnkvXDIEwRdfXHixbOLVaFg2hmwlu
	 CrTbuLm2XKpfmWY1++bezHL2MSm9EK9lxNt4dwR80mQzKoma6glUvipa9aN3GxFLpHyXN
	 FFTq2Q+aHMgxMuN+Hb564lPbTgWmjpzXSMS51sZgtUCJYdOTyyS61H/yq1XoFO9yM3A==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1775350948;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=DXEvO/GqQ88VQSid4K/MxiYjdzExXhOh2cQKHDgdxFs=;
	b=CM8gxkSZC91C8DUM7mIcRwXGxHmMwPfAOlJur2Agccgu7v9H2YTDf4PKo+cnFJnCN3co
	 yN/s1PfW3wmEWE/VuLFtDKBnhMfbi6Rp5pD05ifmAYuMN2gJfwz3iFNkUZBwyhLlV3fHS
	 eT4qtsXYafFvJ8DbSDVNtEDqX8/UEFzhLIAOCNWhqbhgdhDRv2Kj2YIeH7IuRcSbZIjmU
	 61T6CY3AInUTgFCHjtN1qBMiiOkQutkF+1bV53cfI2DoXy5Q1gm5tj/E5nEwmu8vokBgR
	 8U+UKqsxhlMLURQunctHdrVvjn6qz4mfP38gd/FPKht/2g9WfqRbdpvyJn+yba9Ye9Q==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fpDhN5njKz1L76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1775350948;
	bh=6PVH0dwBHha5OFCz4Zwqv09DTUH1WVJU+tZpfRKfcWA=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=kkYa3LppIno6WXdTx2AM7futfM66pgBsTNVcWozqWoZ49A2xMTxjOMZipd8FeKY9+
	 06jVqEmWpMpYftlcjaSOov1O1UccpKCu4yMDu76HWSgUpn5OBZVHzZ39DJDCq+Sr5c
	 wcw7b/c4oesu7F1+cuCrFCEtePaExnCMCaGFD/SmkD23rXO4qmo22Tiy79oBY4DPZT
	 KHPQ2NsQjSpNoiBo2ZTcusk/J3GN8Cp4OqGZev9KAQ/azZ43nEw5MlxBR9CC1Kc3/J
	 1pZyBw1hIIp22d/bl0DEbSK88bQ6m496C74xMOJg08BfnQqA9H8M0vFKZTFRdnBNwx
	 rxQhkOjJM1N+A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fpDhN5njKz1L76;
	Sat,  4 Apr 2026 21:02:28 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fpDhN1Sqfz1L6x
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fpDhN1Sqfz1L6x
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by lists.lttng.org (Postfix) with ESMTPS id 4fpDhN1Sqfz1L6x
 for <lttng-dev@lists.lttng.org>; Sat,  4 Apr 2026 21:02:27 -0400 (EDT)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-41576c5c01cso1752912fac.3
 for <lttng-dev@lists.lttng.org>; Sat, 04 Apr 2026 18:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775350942; cv=none;
 d=google.com; s=arc-20240605;
 b=gjFYlUMvH7Eyn8COEps0egTuTAIRI1NtCDoroASwrpctc0yhNTLPp1r2DHBXOqT2Ry
 +ejRai1Ez3c5S/E/dHTx3SUFQ/bwHcPedO8ghHWQX04SdXPGiiAjUq8ICSlbwE3sW1DG
 N2X56YfEwVvFCMZRo3c0RSXpN2qwXTU2aSSoq4bOqryeOeiqapICBByt/1Fk6rGJ35bH
 W5l5bH0+x7sZACcNhYSrkziXaoOXaPjurOUGsgcJoBK+UqA6QxWzmQ5efnAXmGUXMotA
 mL338EmJg+LibQRru8f8eDRQSJiNRWMqMFxOIeafZS1JL8Mzwk6VfjGHeumBb3mxNPdn
 zJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6PVH0dwBHha5OFCz4Zwqv09DTUH1WVJU+tZpfRKfcWA=;
 fh=Vi3MF25LmiCIknQyyhXLxIEZ5vqn+bls1ZIgHxHgtRU=;
 b=S6QaFPu90GvlnTyaXOiL0fXaRq0ACqHGcvVLPbBPa6bdIMewB0K3jfMPwcgiTNmLhy
 QhHUX7d2SgeYem5CEVy+Wn7s8yQmjnPzxK0vjtdD5totvKVtOlZNm7EfiV0vWoQI4Ktl
 nTC64RTdu6QtuAkvCYjwZb9rVPEnbeYtsSsqr3Ke91YI6DSaqyZfxCOobMQmcGkN3x/x
 VDkQ0+//jtkuUgMplcZOkBbgpPdAPfDmoz5OZguQgXPtseEA76dSArdHfPaeQeYQKa6C
 0bNPpQXWWfjkV24zFHyZgXn4f0ThVOrVtHORQ+Tz0jaW0NZABRsXGdCeCjAZNVbBmRwk
 e1rg==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775350942; x=1775955742;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6PVH0dwBHha5OFCz4Zwqv09DTUH1WVJU+tZpfRKfcWA=;
 b=o+dG48itEl47Q89RAJLmMZQ2ugnIfVEWjJrypfFA/t+5DqYKwe+B6h9rz4Arx8VF9k
 1u7NnuxsOAYBDg7r0/VQltDQP9N4rtdRHcHCNPiyz7mQrZDM9SpmyWlCKRSMvE7BQJO4
 RsAv2WI4HaOJIuHd/otfHefxCkNW0GJDNUjnh2jqRFcPpZyFJSNL2+I4rV/X3sBHsuJ7
 4uSaeMN0hxcu3WL+3egoElGrMcTYI0kcMJZrM0yLsxJBQb9Hahq2x4O4C3vhQ+zMpPWa
 AjwmzakmeNk9huW7l6JzAd8yDNSbU+xahedAV3thubms7HoGivj1M9f2D3V2CE4nGyoS
 dUjw==
X-Gm-Message-State: AOJu0YwzaVm4DPY5v04GJZP86efPp0OQw8dcTSsgWLxZPu1tSCoc+baL
 3N7nuVvgzja4hi3Hu3qEnF1rQ1oMiB5bbsmkjb2g6kKzhIfZKK8EDtAFf3FOKT/MVZWmr6Lh05p
 s8sqPIP7zE5KBL/U7M6c0XEiCDuqj7lFkHHmJ+THOYUpcq+1Q78dSU6c=
X-Gm-Gg: AeBDieuOL73V8QPH1EGppJum2obQ53QUwEn41bXOsfCLQGSSb1Kv+fkLVE2KjRhXpBC
 DrsisBxLW6kUcyS8LfDFo/5GG5+riFrb2OwHFAIvmXFg/cgzm5WUhrf+T9H+s+XyOmbOFG1KQoe
 eqFcg8dN948JGkw0nG0PXMqu9lG6sqOruNR104Sw14+cz9lvks/iQ2jhSbtHt9PqxDFsswa9N1c
 sE4wcZyYQITiRbpYudq/mB1F0zSH+qupsELCSwHEYwknSC6+NTTTtx6/3J0CoP+J2J+QEzRBV7k
 5trjGp51di40KHF4XkNK2uv3IBI/IY8ZflEghUnDtkcTiREX
X-Received: by 2002:a05:6870:8313:b0:41c:fdd7:5b4b with SMTP id
 586e51a60fabf-4230fdcf7a4mr4542079fac.21.1775350941857; Sat, 04 Apr 2026
 18:02:21 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 4 Apr 2026 21:02:11 -0400
X-Gm-Features: AQROBzBwgePvh3VlE1LBJ6FiSsMzuHBrJu37U6jMlpBM0kBpdMjn2cxNyHlqMGk
Message-ID: <CAOQX81c_1OGMybWoc3axCVZGk58q9aefxpNS2XTny2K8cy_65w@mail.gmail.com>
Subject: Question about LTTng Kernel Probe Tracking
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="0000000000003dca8e064eac1a48"
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
From: Amir Najafi Zadeh via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Amir Najafi Zadeh <anajafizadeh@cs.stonybrook.edu>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--0000000000003dca8e064eac1a48
Content-Type: text/plain; charset="UTF-8"

Hello all,

I hope you are doing well.

I have a quick question about LTTng tracking when using kernel probes. I
mainly use LTTng to trace file system functions in the Linux kernel, and
for that I use the LTTng kernel probe feature, which works very well.
However, when I tried filtering logs for a specific group ID, I noticed
that filters are not supported for kernel probes.

Then I attempted to use the tracking feature to trace only a specific GID,
but this also did not work. From what I see in my logs, it appears that for
kernel probes all events are captured and recorded, regardless of the
tracking options.

I wanted to know if this is a known limitation, and whether there is any
in-progress work or reason why this is not currently supported.

For reference, here is my code. I am using LTTng 2.13.11 with kernel
6.8.0-101-generic:

```
#!/bin/sh
SESSION_NAME="lttng-gid-test"
OUTPUT_DIR="/tmp/lttng/${SESSION_NAME}"
GROUP_ID=1002

# create the lttng session
lttng create "$SESSION_NAME" -o "$OUTPUT_DIR"

# create the lttng ring buffer channel
lttng enable-channel --session="$SESSION_NAME" --kernel channel0 \
  --subbuf-size=16M \
  --num-subbuf=2

# add pid, tid, proc, and gid for tracing collection
lttng add-context --session="$SESSION_NAME" --channel=channel0
--kernel --type pid
lttng add-context --session="$SESSION_NAME" --channel=channel0
--kernel --type gid

# enable the target probe
lttng enable-event --session="$SESSION_NAME" --channel=channel0
--kernel --probe=ext4_get_inode_loc ext4_get_inode_loc

# disable all tracks
# NOTE: untracking doesn't make a difference
# lttng untrack --session="$SESSION_NAME" --kernel --all --gid
# lttng untrack --session="$SESSION_NAME" --kernel --all --pid
# lttng untrack --session="$SESSION_NAME" --kernel --all --vpid
# lttng untrack --session="$SESSION_NAME" --kernel --all --uid
# lttng untrack --session="$SESSION_NAME" --kernel --all --vuid
# lttng untrack --session="$SESSION_NAME" --kernel --all --vgid

# only enable gid 1002 track
lttng track --kernel --gid=1002

# start lttng
lttng start $SESSION_NAME

```

Thank you for your time and guidance.

Best regards,
Amir
-- 
*Amirhossein Najafizadeh*



*PhD Student, Computer Science Department, Stony Brook University, N.Y.File
systems and Storage Lab (FSL)*
najafizadeh21@gmail.com
https://amirhnajafiz.github.io/

--0000000000003dca8e064eac1a48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p>Hello all,</p>
<p>I hope you are doing well.</p>
<p>I have a quick question about LTTng tracking when using kernel probes. I=
 mainly use LTTng to trace file system functions in the Linux kernel, and f=
or that I use the LTTng kernel probe feature, which works very well. Howeve=
r, when I tried filtering logs for a specific group ID, I noticed that filt=
ers are not supported for kernel probes.</p>
<p>Then I attempted to use the tracking feature to trace only a specific GI=
D, but this also did not work. From what I see in my logs, it appears that =
for kernel probes all events are captured and recorded, regardless of the t=
racking options.</p>
<p>I wanted to know if this is a known limitation, and whether there is any=
 in-progress work or reason why this is not currently supported.</p>
<p>For reference, here is my code. I am using LTTng 2.13.11 with kernel 6.8=
.0-101-generic:</p>
<pre class=3D"gmail-overflow-visible! gmail-px-0!"><div class=3D"gmail-rela=
tive gmail-w-full gmail-mt-4 gmail-mb-1"><div class=3D"gmail-"><div class=
=3D"gmail-relative"><div class=3D"gmail-h-full gmail-min-h-0 gmail-min-w-0"=
><div class=3D"gmail-h-full gmail-min-h-0 gmail-min-w-0"><div class=3D"gmai=
l-border gmail-border-token-border-light gmail-border-radius-3xl gmail-corn=
er-superellipse/1.1 gmail-rounded-3xl"><div class=3D"gmail-h-full gmail-w-f=
ull gmail-border-radius-3xl gmail-bg-token-bg-elevated-secondary gmail-corn=
er-superellipse/1.1 gmail-overflow-clip gmail-rounded-3xl gmail-lxnfua_clip=
PathFallback"><div class=3D"gmail-pointer-events-none gmail-absolute end-1.=
5 gmail-top-1 gmail-z-2 gmail-md:end-2 gmail-md:top-1"></div><div class=3D"=
gmail-w-full gmail-overflow-x-hidden gmail-overflow-y-auto gmail-pe-11 gmai=
l-pt-3"><div class=3D"gmail-relative gmail-z-0 gmail-flex gmail-max-w-full"=
><div id=3D"gmail-code-block-viewer" dir=3D"ltr" class=3D"gmail-q9tKkq_view=
er gmail-cm-editor gmail-z-10 gmail-light:cm-light gmail-dark:cm-light gmai=
l-flex gmail-h-full gmail-w-full gmail-flex-col gmail-items-stretch gmail-=
=CD=BCk gmail-=CD=BCy"><div class=3D"gmail-cm-scroller"><div class=3D"gmail=
-cm-content gmail-q9tKkq_readonly">```
#!/bin/sh<br>SESSION_NAME=3D&quot;lttng-gid-test&quot;<br>OUTPUT_DIR=3D&quo=
t;/tmp/lttng/${SESSION_NAME}&quot;<br>GROUP_ID=3D1002<br><br># create the l=
ttng session<br>lttng create &quot;$SESSION_NAME&quot; -o &quot;$OUTPUT_DIR=
&quot;<br><br># create the lttng ring buffer channel<br>lttng enable-channe=
l --session=3D&quot;$SESSION_NAME&quot; --kernel channel0 \<br>  --subbuf-s=
ize=3D16M \<br>  --num-subbuf=3D2<br><br># add pid, tid, proc, and gid for =
tracing collection<br>lttng add-context --session=3D&quot;$SESSION_NAME&quo=
t; --channel=3Dchannel0 --kernel --type pid<br>lttng add-context --session=
=3D&quot;$SESSION_NAME&quot; --channel=3Dchannel0 --kernel --type gid<br><b=
r># enable the target probe<br>lttng enable-event --session=3D&quot;$SESSIO=
N_NAME&quot; --channel=3Dchannel0 --kernel --probe=3Dext4_get_inode_loc ext=
4_get_inode_loc<br><br># disable all tracks
# NOTE: untracking doesn&#39;t make a difference<br># lttng untrack --sessi=
on=3D&quot;$SESSION_NAME&quot; --kernel --all --gid<br># lttng untrack --se=
ssion=3D&quot;$SESSION_NAME&quot; --kernel --all --pid<br># lttng untrack -=
-session=3D&quot;$SESSION_NAME&quot; --kernel --all --vpid<br># lttng untra=
ck --session=3D&quot;$SESSION_NAME&quot; --kernel --all --uid<br># lttng un=
track --session=3D&quot;$SESSION_NAME&quot; --kernel --all --vuid<br># lttn=
g untrack --session=3D&quot;$SESSION_NAME&quot; --kernel --all --vgid<br><b=
r># only enable gid 1002 track<br>lttng track --kernel --gid=3D1002<br><br>=
# start lttng
lttng start $SESSION_NAME<br></div></div></div></div></div></div></div></di=
v></div><div class=3D"gmail-"><div class=3D"gmail-"></div></div></div></div=
></div></pre>
<p>```<br><br>Thank you for your time and guidance.</p>
<p>Best regards,<br>Amir</p></div><span class=3D"gmail_signature_prefix">--=
 </span><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gm=
ail_signature"><div dir=3D"ltr"><b><font face=3D"garamond, times new roman,=
 serif">Amirhossein Najafizadeh</font></b><div><font face=3D"garamond, time=
s new roman, serif"><b>PhD Student, Computer Science Department, Stony Broo=
k University, N.Y.<br>File systems and Storage Lab (FSL)<br><br></b></font>=
<div><font face=3D"garamond, times new roman, serif"><a href=3D"mailto:naja=
fizadeh21@gmail.com" target=3D"_blank">najafizadeh21@gmail.com</a></font></=
div><div><a href=3D"https://amirhnajafiz.github.io/" target=3D"_blank"><fon=
t face=3D"garamond, times new roman, serif">https://amirhnajafiz.github.io/=
</font></a></div></div></div></div></div>

--0000000000003dca8e064eac1a48--
