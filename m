Return-Path: <SRS0=Sd6M=CQ=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE0C43461
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Sep 2020 12:34:51 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA238206E6
	for <lttng-dev@archiver.kernel.org>; Mon,  7 Sep 2020 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="n9gLaY7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA238206E6
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BlSQw6RnHz8tq;
	Mon,  7 Sep 2020 08:34:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1599482089;
	bh=5jocrjcWxMwjWxBTUW77EFb+VJP7TuLzo8vdQ1i0xaE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=n9gLaY7VbMp9Z8GY/Tas1PbjHhCXKTKi+diIu1KIje8GeGAoYekjV/QzFu069zBQs
	 EvTX47X+XbdGtwqFgYYcOpNgQAnuL6f8alg5aScchazJXqQUVymJRIQN0l1+aNIQOX
	 wx3Sp70lXNFhjlevbawXINvOb5LFvv6p0rE92IKPQQrC+9+YUeSlIpCwEiKdNkO/ka
	 0aSN9z2DjViSXr4y52KNj0cu6iU+kpqYURYN5YvEGUfS9AGxIJapuKPy201vjuf5Y6
	 CSaG+xLOynYE5B3dXsbAU0XDsKCf/kmx2RcLtomeIPgY+0IVe1xrNpU8DC/kOkiV8k
	 QcXz9VkJUBF4A==
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by lists.lttng.org (Postfix) with ESMTPS id 4Bl3PK0K1sz8R4
 for <lttng-dev@lists.lttng.org>; Sun,  6 Sep 2020 16:47:00 -0400 (EDT)
Received: by mail-ej1-x629.google.com with SMTP id q13so15356468ejo.9
 for <lttng-dev@lists.lttng.org>; Sun, 06 Sep 2020 13:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=YgdkcxCgvLIpwtyAYrfiNbsAHz5P2WYQZs2h2VEKpBc=;
 b=uUAqlUd2wdelXXFeliEhzY9me/CJE1ZsdjKRd8fTftGiG8SfdzTnyUF/olEQFMSQg2
 DzYQK0axfs3FWI8W8I62aHpHwj/NKJk9HqTlpWCJJGz/jj7Rp0D6VGg57ey+OkTE3Stl
 upQz2ZJguIeLikXiRVaK+yKu62MwClytjWZiI3WqlEGFbK1kYk15cIfPrvysGs6udsPC
 Kr5y6NZm9j3WZjuHqhrpTMAHOHbc5tNueiVv0EalZlHCslUDAqD2B2pmwo32F7CA9j33
 qoJZ4E/p8mNUd114ydcOyyBd7Mfsi2dhhT2m6NwXGWupQXohTZRw4XaEhoGbU1YSidj7
 QmoA==
X-Gm-Message-State: AOAM531fA9AwOlgpKC1w4cHAK12WiyRIbM6Il8iJod1kGWlEQNWoOrs3
 ilkwH94T4m7FlU+wp+RdWM8mjJBysaHJLgYYGv5L4APN27YjiA==
X-Google-Smtp-Source: ABdhPJx551AYPYB/34vmBH5ImRAKqPVv2xlDoZwmUzQJr9RwhTl+iH3tIPrv6/hgxe8KAhrGD5ydPznVWRXghgx8O/w=
X-Received: by 2002:a17:906:a845:: with SMTP id
 dx5mr17775073ejb.543.1599425219405; 
 Sun, 06 Sep 2020 13:46:59 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 6 Sep 2020 13:46:48 -0700
Message-ID: <CAM-pDOyr2VN94eWJahkRX47rTp=YSOwvyZL5iVO2bETaaLx+1Q@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Mon, 07 Sep 2020 08:34:47 -0400
Subject: [lttng-dev] babeltrace2: reading metadata + events from a single
 CTF file
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
From: Dave Bort via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Dave Bort <dbort@dbort.com>
Content-Type: multipart/mixed; boundary="===============1052907132345986367=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============1052907132345986367==
Content-Type: multipart/alternative; boundary="0000000000000c2dee05aeab3430"

--0000000000000c2dee05aeab3430
Content-Type: text/plain; charset="UTF-8"

Hello! I'm adding CTF-compatible tracing to a custom/experimental OS and
have a question:

Can babeltrace2 read from a single CTF output file that contains both the
metadata stream and the binary trace streams?

My little trace system would like to bundle everything related to a trace
into a single file, making it easier to pass around (since there's not much
filesystem/network support yet). The CTF spec provides a way to embed the
metadata stream in the same bitstream as the data streams, but
https://babeltrace.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/ says
that the `metadata` file needs to be separate. I see that LTTng manages
trace output as a collection of files, with a separate `metadata` file.

I'd rather avoid writing a custom tool to find and extract the metadata
stream from the full stream before passing the data on to babeltrace2 or
TraceCompass, but so far it looks like I may need to.

Would it be appropriate to add support for this
to babeltrace2-source.ctf.fs? Or would this warrant a new source.ctf
plugin? If I'm going to write some new code to handle this situation, I may
as well try to add it to the project.

Thank you! I'm really looking forward to benefiting from the
CTF/babeltrace/LTTng/TraceCompass work you've all done over the years. :)

--Dave Bort

--0000000000000c2dee05aeab3430
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello! I&#39;m adding CTF-compatible tracing to a custom/e=
xperimental OS=C2=A0and have a question:<div><br></div><div>Can babeltrace2=
 read from a single CTF output file that contains both the metadata stream =
and the binary trace streams?</div><div><br></div><div>My little trace syst=
em would like to bundle everything related to a trace into a single file, m=
aking it easier to pass around (since there&#39;s not much filesystem/netwo=
rk support yet). The CTF spec provides a way to embed the metadata stream i=
n the same bitstream as the data streams, but <a href=3D"https://babeltrace=
.org/docs/v2.0/man7/babeltrace2-source.ctf.fs.7/">https://babeltrace.org/do=
cs/v2.0/man7/babeltrace2-source.ctf.fs.7/</a> says that the `metadata` file=
 needs to be separate. I see that LTTng manages trace output as a collectio=
n of files,=C2=A0with a separate `metadata` file.</div><div><br></div><div>=
I&#39;d rather avoid writing a custom tool to find and extract the metadata=
 stream from the full stream before passing the data on to babeltrace2 or T=
raceCompass, but so far it looks like I may need to.</div><div><br></div><d=
iv>Would it be appropriate=C2=A0to add support for this to=C2=A0babeltrace2=
-source.ctf.fs? Or would this warrant a new source.ctf plugin? If I&#39;m g=
oing to write some new code to handle this situation, I may as well try to =
add it to the project.<br><br>Thank you! I&#39;m really looking forward to =
benefiting from the CTF/babeltrace/LTTng/TraceCompass work you&#39;ve all d=
one over the years. :)<br><br>--Dave Bort</div><div></div><div></div></div>

--0000000000000c2dee05aeab3430--

--===============1052907132345986367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1052907132345986367==--
