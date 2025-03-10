Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D61CC282DE
	for <lttng-dev@archiver.kernel.org>; Mon, 10 Mar 2025 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1741615957;
	bh=vnnjbR8uVWoNuDR1m40M+tHslEorxdn5+v+1d9jnsI4=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=C0JXQkGiCj78CUlRChVc25E1P23L/eZmDETrHq7lQDY149/gxTHNNLui2aE/9YxEm
	 iNnxafIIOcnlmR1UM71brWBwT6KUISveZrexhuliGV/0oHdirTA/bUeRcR513KEAbO
	 vmGmcaLvV2ZRZdNvWf+l7ln/EbkxpmwpFdWwemKqFutc8JMKqXqVdNoiJpKOE/5/9j
	 ALQve5UK7kTokpqgxz53E1zYd9x/0a3rIoWK8+q24Sib2CI3nKxQH3Wa1VWCSdHN7S
	 2qCJkSyOpfTSuaW74gFgSz8EkxQMvCOCAnR5IKMU0yVIe1LCO2X4xTDmCgKtlEXZx/
	 rqwelUV9UEpqQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZBJkX5DVkz1lBN;
	Mon, 10 Mar 2025 10:12:36 -0400 (EDT)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZBJkW6CtWz1lBL
 for <lttng-dev@lists.lttng.org>; Mon, 10 Mar 2025 10:12:35 -0400 (EDT)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5fc6fe05460so2582042eaf.1
 for <lttng-dev@lists.lttng.org>; Mon, 10 Mar 2025 07:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741615955; x=1742220755;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6EmYXx1p92sPMsZhBjOLtZxKpitE15MBRJMit7RooiY=;
 b=w4mEDwb6Q4oKar+NI/kOsSiB6f29eAfOzozDN27tKf8+mWgcFbgAA/9a4GK3u96eho
 Pzev/Qg5NEsYsJglPINy/n7SVKvJjNC5klgXC/vEehh3kCiebpr8DWDqxrzlqp4RKSrj
 YsVC2W1JpZI5Y17QJTr0CGg2h65Lk9xV46Q+5GFXYNBdvjprZ+/hO5Z/8uqkghVD6fsk
 n2q2F7hrXV5zBu84eK2bS9ZvY7QXQwDhKhey4EZGhgSjYIicwzjK0djIO+BE7myxQPM8
 Tlq7GUJ/kqRiUM7LYiuHwPfPvQT8iSzJGPNYTIv4IctsgIIyM76fCTKnAOF6UVSiW7+5
 ZInw==
X-Gm-Message-State: AOJu0YxCpDRliwLzr0d/zwky9UxEv5ulZLTm2EjrNZY7XkGiLh1j6je+
 5fzKwqIwcNYKHDltT/LKtM+58ZJ6QuXmWU9xJIyhZjEoiA8hg4xY2Br8D035qcPCYECZMpOXVjW
 1OMOPlj+9SEnha8ngngkZ++3maOk9594xa7M=
X-Gm-Gg: ASbGnctDQe5hS4vKtGQHVEyDPC6QzT1J4b0gsgIiLZyIG86TnIKoKaUBpjxEaY44/w+
 02tpsk98P7gRkZ9VmOD9STXBcrCtZBfk8GRdLuSLtFe/fEqejUkMTR6Mj8xDb97WKLcj9eJl5FC
 3gz5Kg4+HOL+8uJtC30lcr1r0/qRiiKop7cFE2EgXPbMJqV5kQ+fSYCsF9EUJg
X-Google-Smtp-Source: AGHT+IEV67t6WK8eeE6JIVLXESqPgl8eY7WtBBKlRCPaen+jrjzSJ7bwiVAHayqbCIW4ox/wCuwX6vRCAzbvr56V6p0=
X-Received: by 2002:a05:6808:3a1a:b0:3f7:e553:56c6 with SMTP id
 5614622812f47-3f7e5535bb4mr3083030b6e.37.1741615954874; Mon, 10 Mar 2025
 07:12:34 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 10:12:23 -0400
X-Gm-Features: AQ5f1Jqb_a180d0cWSoiz0d7Kjf0xnwzyv732uehErx7H9sW-mMY2uYpOW4Lpsg
Message-ID: <CANTRYLg9VSJMeJ1XHcBCtUfiaGiyyigCoLcAdrX8r-CM+xeDEQ@mail.gmail.com>
Subject: Github Action Runners creating world-writable shared memory section:
 lttng-ust-wait-n
To: lttng-dev@lists.lttng.org
Content-Type: multipart/alternative; boundary="000000000000535b6d062ffd90a0"
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
From: bill robertson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: bill robertson <billrobertson42@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--000000000000535b6d062ffd90a0
Content-Type: text/plain; charset="UTF-8"

GHA runners appear to use lttng-ust for some sort of IPC between runners on
the same machine.

$ ll /dev/shm/

-rw-rw-rw- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8
-rw-r----- 1 gha-runner-8 gha-runner-8  4096 Feb 20 04:03 lttng-ust-wait-8-558
-rw-r----- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8-559
-rw-r----- 1 gha-runner-6 gha-runner-6  4096 Feb 20 04:03 lttng-ust-wait-8-560
-rw-r----- 1 gha-runner-5 gha-runner-5  4096 Feb 20 04:03 lttng-ust-wait-8-561
-rw-r----- 1 gha-runner-4 gha-runner-4  4096 Feb 20 04:03 lttng-ust-wait-8-562
-rw-r----- 1 gha-runner-3 gha-runner-3  4096 Feb 20 04:03 lttng-ust-wait-8-563
-rw-r----- 1 gha-runner-2 gha-runner-2  4096 Feb 20 04:03 lttng-ust-wait-8-564
-rw-r----- 1 gha-runner-1 gha-runner-1  4096 Feb 20 04:03 lttng-ust-wait-8-565


I assume that this is their code, and not some configuration issue on the
host machine, but if this may not be the case, can someone explain what can
be done or point me to information on the subject?

Otherwise, is there some sort of environment variable or other setting that
lttng will reference when creating this shared memory section such that it
is not world-writable? All of the runners run under user accounts that are
in a common group.

Thanks!
Bill

--000000000000535b6d062ffd90a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>GHA runners appear to use lttng-ust for some sort of =
IPC between runners on the same machine.</div><div><pre class=3D"gmail-notr=
anslate"><code class=3D"gmail-notranslate">$ ll /dev/shm/

-rw-rw-rw- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8
-rw-r----- 1 gha-runner-8 gha-runner-8  4096 Feb 20 04:03 lttng-ust-wait-8-=
558
-rw-r----- 1 gha-runner-7 gha-runner-7  4096 Feb 20 04:03 lttng-ust-wait-8-=
559
-rw-r----- 1 gha-runner-6 gha-runner-6  4096 Feb 20 04:03 lttng-ust-wait-8-=
560
-rw-r----- 1 gha-runner-5 gha-runner-5  4096 Feb 20 04:03 lttng-ust-wait-8-=
561
-rw-r----- 1 gha-runner-4 gha-runner-4  4096 Feb 20 04:03 lttng-ust-wait-8-=
562
-rw-r----- 1 gha-runner-3 gha-runner-3  4096 Feb 20 04:03 lttng-ust-wait-8-=
563
-rw-r----- 1 gha-runner-2 gha-runner-2  4096 Feb 20 04:03 lttng-ust-wait-8-=
564
-rw-r----- 1 gha-runner-1 gha-runner-1  4096 Feb 20 04:03 lttng-ust-wait-8-=
565</code></pre><br></div><div>I assume that this is their code, and not so=
me configuration issue on the host machine, but if this may not be the case=
, can someone explain what can be done or point me to information on the su=
bject?</div><div><br></div><div>Otherwise, is there some sort of environmen=
t variable or other setting that lttng will reference when creating this sh=
ared memory section such that it is not world-writable? All of the runners =
run under user accounts that are in a common group.</div><div><br></div><di=
v>Thanks!</div><div>Bill</div></div>

--000000000000535b6d062ffd90a0--
