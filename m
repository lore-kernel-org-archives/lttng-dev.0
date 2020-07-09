Return-Path: <SRS0=4dcy=AU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92916C433DF
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 11:19:48 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157342076A
	for <lttng-dev@archiver.kernel.org>; Thu,  9 Jul 2020 11:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="d9UescWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157342076A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4B2Yc16r9Pz1Ccy;
	Thu,  9 Jul 2020 07:19:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1594293586;
	bh=Zp2HdLzZaYTyfhU8vbHglIYPq8Xkp92E2P8SOqqzV7o=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=d9UescWVF2n5937dNvyO6xAsdnj09VJNgG7kMPdpW2O0eNMyo7w/6ci/AIgXBNjrU
	 bkwiUkAEdS8C4Z8EdSojM/qQAXRs4dK8gKHB3Qudj1CjqVEaSXdre/SnSuepvuqJa4
	 PLdffxxX3BZULMlplOwfTIzv0+4CtBmJLXv3Lv6xGMiTiKc6ywRX3jQP6wcbyfaimv
	 dMueYDbjnnmdnCjYugB3A+WC7Pm1gD/eg+2D73LIS1jZcHqFwhMFxvwf0J0Fs8r0KO
	 o4shteFc67cuHMjZF5i/T4bb3AyWMn/2tDrufY7XGRnbFpw0DUc6qrCpK9ozFZRo4S
	 CcZDBPn5PR0jA==
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by lists.lttng.org (Postfix) with ESMTPS id 4B2Ybz0Xr9z1CPR
 for <lttng-dev@lists.lttng.org>; Thu,  9 Jul 2020 07:19:42 -0400 (EDT)
Received: by mail-oi1-x229.google.com with SMTP id t198so1569698oie.7
 for <lttng-dev@lists.lttng.org>; Thu, 09 Jul 2020 04:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Zsr7+M7+85z1c5jn9RNdlXLXj5ynNTrzK0jQxJ1s8nA=;
 b=slH17ujTIHX1bmEFDnZjrA2SiqCgjhT+Dx9Ai3vspaisBs3IgUHPdeCyUw1MasBhcN
 1wbgtc6Ybz5GiM9DyrBzzZhB0wuh0cNZ/9EyS6JsW+QmoLqu2YUfSQ6f4HjN++YZEk0J
 p3G0SsGPEYL3Wkg7VIBI96NfARO1pwFTxVD9XdX+Q4v/EQvtlRUJOzSvaN0GANIVjJ3G
 OPROE7b0b9BqgZrErSZ5rAqfhKZ1GwBc740iM8Y+W5ELmKq+Jdte5A6uSLSipTv4BxbG
 +SBRW/DHorcYkATFZXBJIt5SGINNUrIVs+yL5Vuow3YJAUn04+7D9rrOkvdx2gqvUZNg
 MCLg==
X-Gm-Message-State: AOAM531aPwoA7ghndhul6tIaC8ac1wlmdWKXMqtlRlHUcKMs0EPRXxH+
 V8wkQUSxoYGuvtK7b7gyz690MD4ztagD5S1Jp52H4ZQ8t24=
X-Google-Smtp-Source: ABdhPJw/BTYzcDDpt36U5WA7E3lBts5QLuBleeUN0qL3zcLZ71EM9IpufhpJphfVcVQ11ThAE8fTJnipY4WmKl2agDc=
X-Received: by 2002:aca:30c8:: with SMTP id
 w191mr10069575oiw.120.1594293581962; 
 Thu, 09 Jul 2020 04:19:41 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 9 Jul 2020 14:19:25 +0300
Message-ID: <CABhb4uu6dxo_5pVUTXaz3qkGS41Ame77Bp5ePWT42cJ2PANFvA@mail.gmail.com>
To: lttng-dev <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Payload of syscall_entry_execve
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
From: Valentin Grigorev via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Valentin Grigorev <valentin.grigorev@jetbrains.com>
Content-Type: multipart/mixed; boundary="===============0238892498087045081=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200709111925.-Ta69xFOFLSnoZix_4os9WfUYn8U1nCLQt7k3EgcoEI@z>

--===============0238892498087045081==
Content-Type: multipart/alternative; boundary="0000000000009f003405aa0066a8"

--0000000000009f003405aa0066a8
Content-Type: text/plain; charset="UTF-8"

Hello!

Currently, I'm developing a process monitor on the base of LTTng, and I
face the challenge of accessing command-line arguments passed to execve
syscall.
I'm using LTTng live session and Babeltrace 2 C API to analyze events in
online mode.

syscall_entry_execve event has 3 payload fields: filename, argv, and envp.
The first one is a normal C-string, the second and the third
semantically are `char *const *`,
but provided by LTTng as simple unsigned integers (the corresponding fields
in Babaltrace2 event payload have type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,
while I expect BT_FIELD_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand,
these integers are argv and envp pointers casted to uint64_t. But in the
majority of
cases, events produced by LTTng are analyzed by another process and often
even offline, so these pointers became completely unuseful.

Could you say, if there are some configuration parameters that enable to
pass argv and envp content in syscall_entry_execve payload? Or some other
ways to get this
information from LTTng.

P.S. I consider getting this information from /proc/pid/cmdline, but it is
not looking like a clean solution.

Best regards.
Valentin Grigorev

--0000000000009f003405aa0066a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hello!</div><div><br></div=
><div>Currently, I&#39;m developing a process monitor on the base of LTTng,=
 and I face the challenge of accessing command-line arguments passed to exe=
cve syscall.=C2=A0</div><div>I&#39;m using LTTng live session and Babeltrac=
e 2 C API to analyze events in online mode.</div><div><br></div><div>syscal=
l_entry_execve=C2=A0event has 3 payload fields: filename, argv, and envp. T=
he first one is a normal C-string, the second and the third semantically=C2=
=A0are `char *const *`,=C2=A0</div><div>but provided by LTTng as simple uns=
igned integers (the corresponding fields in Babaltrace2 event payload have =
type BT_FIELD_CLASS_TYPE_UNSIGNED_INTEGER,</div><div>while I expect BT_FIEL=
D_CLASS_TYPE_DYNAMIC_ARRAY). As far as I understand, these integers are arg=
v and envp pointers casted to uint64_t. But in the majority of</div><div>ca=
ses, events produced by LTTng are analyzed by another process and often eve=
n offline, so these pointers became completely unuseful.</div><div><br></di=
v><div>Could you say, if there are some configuration parameters=C2=A0that =
enable to pass argv and envp content in syscall_entry_execve payload? Or so=
me other ways to get this</div><div>information from LTTng.</div><div><br><=
/div><div>P.S. I consider getting this information from /proc/pid/cmdline, =
but it is not looking like a clean solution.</div><div><br></div><div>Best =
regards.</div><div>Valentin Grigorev<br></div></div></div></div></div></div=
></div></div>

--0000000000009f003405aa0066a8--

--===============0238892498087045081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0238892498087045081==--
