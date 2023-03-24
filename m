Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E284DC6FD20
	for <lttng-dev@archiver.kernel.org>; Fri, 24 Mar 2023 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679657758;
	bh=hD4Z4xHuMuqRd1DsyCNEDfGfENQjpk4RzdMvnAWor1g=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Jb+2pVBGIbNzHJiF0bCbd2+qtJOVTMcB6KjKxgfz9QhtwGEink6+SaPJZCKtHU93s
	 CeEZyqw1iyOGggI6K6GnTZbGUc+T9L47Mk4ma3NAT6KBN8PHuSHSSQMHgJd6wiXsA6
	 9+Joio435whm5vhmnLdXZQ7m9sez8XaqDL7YSqSH1HVdEKuwlTTjLXvcz8fEZpdZbR
	 lxxvsjatUBscnZa7VGbOje5kTzULroiApUPMpZsyBk/tCqSBpXYUA6dsmgGsQ/EM+C
	 +CEbHTUOSbeWkv8j2ZlZjldtadyOlnC8jDD5l5G2sY35RGASYCEBmTwpWIdzWmzFhM
	 /i9oadClBmD+Q==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PjgBj5MHGz2JP4;
	Fri, 24 Mar 2023 07:35:57 -0400 (EDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by lists.lttng.org (Postfix) with ESMTPS id 4PjgBg5n6Mz2JP2
 for <lttng-dev@lists.lttng.org>; Fri, 24 Mar 2023 07:35:55 -0400 (EDT)
Received: by mail-ed1-f50.google.com with SMTP id eg48so6617885edb.13
 for <lttng-dev@lists.lttng.org>; Fri, 24 Mar 2023 04:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679657694;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ws4fbMoGp0apCQ+1Z11qt4Ges249LOdhdlp/zx7Z62I=;
 b=V/bmcjLnKaQnmzDqKqySlQ4bLWaYd5XtG89QnHBz2zfsqQ/XO3OvOq9HbD4tUnTOhj
 qL4iPVA/d0W8WKwUYlD4to02fKk+bJ7vg1B+hwv8LAGGqIOBbCscxdvFAVXICa8ckLcn
 Nfx+ytmk8s0HIp9yjU3jWmqkwaOnMK+GCKgmKmwS9OplG+4Y32LbWCM7tR+8y73fNPqn
 fxvpLlmuZgb+UUiPjnVSkJVvo9PvhsO575MKTkYQZpmfnR52oUVZSxDndnDVeTOYRkcY
 8PNGWWu1FwoDdvphFLj0/fFK0S2ChTEHghrzEEoHSMRM5swJoGVRlNL1YK6/4BrtaPfY
 r/6w==
X-Gm-Message-State: AAQBX9eTvPpO2WxfRW9NhNyPKxZiuxMvDbp7a3HaloHzRnZcmBvaEm9+
 HX/IiSTRvWqhn1z3aDPyab5x2zwShz9ulBWa+V+LukOgrouaBg==
X-Google-Smtp-Source: AKy350bKSyqBYg01yBwFZLvVgv3Lzt+jW1a/36RYkmcl4cjKpjvKVPX4y5D3tHdnthzkCRkepNLsmIrdDuh9pRxrdzU=
X-Received: by 2002:a50:d69a:0:b0:4fb:2593:844 with SMTP id
 r26-20020a50d69a000000b004fb25930844mr1296499edi.2.1679657694327; Fri, 24 Mar
 2023 04:34:54 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 24 Mar 2023 19:34:43 +0800
Message-ID: <CAL_9pdT9tDgj3e2YNsWFn6YkOAVWbcoUKXaE+YveJiFrOeu+NQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] Nano clock value overflows the signed 64-bit integer
 range on the babeltrace2 client side when per-process per-user trace file
 were transfer using lttng live protocol
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
From: Yuan Bin via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Yuan Bin <elf.ggle@gmail.com>
Content-Type: multipart/mixed; boundary="===============6170092338617673548=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6170092338617673548==
Content-Type: multipart/alternative; boundary="00000000000036f77005f7a3c81b"

--00000000000036f77005f7a3c81b
Content-Type: text/plain; charset="UTF-8"

I launched a program producing traces to the lttng consumerd and lttng
relayd, also launching a babeltrace command as lttng live consumer to show
the tracing real-timely.

It works well when the channel is set to per user mode. But when it is
changed to per process per user without no other changes, the babeltrace2
client crashing showing a overflow error:

The last error message of babeltrace2 exception stack shows :

"Cannot convert cycle to nanoseconds from origin for given clock class:
value overflows the signed 64-bit integer range: cc-addr=****,
cc-name="monotonic", cc-freq=1000000000, ....."

What's the difference resulting this crash ? How to solve it since the
perprocess per user mode is perfered for me.

version info:
babeltrace2: 2.0.4
lttng comands: 2.12.12

--00000000000036f77005f7a3c81b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(51,153,102)"><span style=3D"color=
:rgb(0,0,0)"><span style=3D"color:rgb(34,34,34)">I launched a program produ=
cing traces to the lttng consumerd and lttng relayd, also launching a babel=
trace command=C2=A0as lttng live consumer to show the tracing real-timely.=
=C2=A0</span><br><br><span style=3D"color:rgb(34,34,34)">It works well when=
 the channel is set to per user mode. But when it is changed to per process=
 per user without no other changes, the babeltrace2 client crashing showing=
 a overflow error:</span><br><br><span style=3D"color:rgb(34,34,34)">The la=
st error message of babeltrace2 exception stack shows :</span><br><br><span=
 style=3D"color:rgb(34,34,34)">&quot;Cannot convert cycle to nanoseconds fr=
om origin for given clock class: value overflows the signed 64-bit integer =
range: cc-addr=3D****, cc-name=3D&quot;monotonic&quot;, cc-freq=3D100000000=
0, .....&quot;</span><br><br><span style=3D"color:rgb(34,34,34)">What&#39;s=
 the difference resulting this crash ? How to solve it since the perprocess=
 per user mode is perfered for me.</span><br><br><span style=3D"color:rgb(3=
4,34,34)">version info:</span><br><span style=3D"color:rgb(34,34,34)">babel=
trace2: 2.0.4</span><br><span style=3D"color:rgb(34,34,34)">lttng comands: =
2.12.12</span></span></span><br><br></div>

--00000000000036f77005f7a3c81b--

--===============6170092338617673548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6170092338617673548==--
