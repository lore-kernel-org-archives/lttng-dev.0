Return-Path: <SRS0=w840=IO=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F152C433E0
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Mar 2021 20:41:41 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78A264F83
	for <lttng-dev@archiver.kernel.org>; Tue, 16 Mar 2021 20:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78A264F83
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4F0QDz0JldzJBC;
	Tue, 16 Mar 2021 16:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1615927299;
	bh=BFtP/rZj42SnQCn2VywNME5+emQKJsdv9MhCNYqSUXM=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=QRsb3eSuKIU1Bp2WkWU63rHeyvcLl1XTO78kpSA+esGMRANeWjBOmLTVySWoRZhEr
	 DAeBPgs06kkS3pgv7Jq0GxGTlIDT76MHjeaAtRH8L0Ib+G+loP8Hl1n0v7j2ayW/fk
	 mzQmMBXp1K/EGZl/5gaE92uPtcC21OEw/weEGXfPj+172QJJ33557Il/ERoKuNhVyB
	 eQ3pbcJrtAcrvAYOOUGQCMrZfhpWvSI71kKzcxmqDHXzR5g51Gl8gKEtrJSzez3VQs
	 feZlXnwlFtX0fg5WabVLWA4DW0eGAEfMX6bp+BWM4VFGjNCxdCTx0iLyUwqX6QbZ6P
	 L2y9UfaBcuSjw==
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by lists.lttng.org (Postfix) with ESMTPS id 4F0QDx1fTBzHrx
 for <lttng-dev@lists.lttng.org>; Tue, 16 Mar 2021 16:41:37 -0400 (EDT)
Received: by mail-ot1-x32c.google.com with SMTP id
 31-20020a9d00220000b02901b64b9b50b1so7582018ota.9
 for <lttng-dev@lists.lttng.org>; Tue, 16 Mar 2021 13:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=2R23isGxvlpl5urq8GpzTUnM94l/xJJCDJx/lNT+ObY=;
 b=m0xlihjqugd0CxVzF21DRcOKwhTdO9Ex9th7XLcCzlaI/8cuGmvJO8K7onc6DrcFMq
 xB3QcQJkBqOmdELIOs5Ela22eHfbSCM7Zvn2WDlZMWQxn5eBjQxABAsID8UQYAqQtTYb
 oouE2be1UCQer3lCgM8EVOaW66I2HD9Ik98LXqWrVTizR0Aptk/2aHhNLLJiZ/OIumAH
 SeFi82vJfm2CvobJ5dy56uxclBT6UMozs5BD9qT8/N0Se4/VUxeeSlylOcp6spqsApj7
 yHeVV5OpMzpNac2EpyN24cIMPeoZhGZumfBjV8qNXWQU/vcM6Xb8Nh63iPd3Kp+P5JZo
 5iNA==
X-Gm-Message-State: AOAM5329JRfZ16OB5E5BjR13iGvvgNMncXA5zYxqptlFOkuIE30YhKAE
 PyFCL3IQtgVyopALj4A8CL7GHAV1D6w0MAzGUcZsIBlt
X-Google-Smtp-Source: ABdhPJxPT2kULWPZ5MQyZ+IG2Ktqe5c7gjNi6ISfadUZgGXE+ylptxqEzj8hXE6mf+GIfOOKvPEFrXu4cmDkyfVD8A8=
X-Received: by 2002:a9d:12c6:: with SMTP id g64mr525417otg.226.1615927296103; 
 Tue, 16 Mar 2021 13:41:36 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Mar 2021 13:41:25 -0700
Message-ID: <CAPj=Wkj51Cg6OT2XOBHJB+zYei30NMML7ek8FGJ+EUsKiyecww@mail.gmail.com>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Subject: [lttng-dev] Statically linking babeltrace and lttng col
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Eqbal via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Eqbal <eqbalzee@gmail.com>
Content-Type: multipart/mixed; boundary="===============2267538925142715081=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2267538925142715081==
Content-Type: multipart/alternative; boundary="000000000000779ad705bdad6440"

--000000000000779ad705bdad6440
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have an application where I want to statically link both babeltrace2
library including the built in plugins as well as lttng ctl library. I
couldn=E2=80=99t find much documentation regarding that. I know you can con=
figure
babeltrace with =E2=80=94enable-built-in-plugins but that seems to just lin=
k the
eventual binary tool with the plugins.

I tried to statically link the individual plugin archives (ctf, text,
utils) using =E2=80=94whole-archive but I am getting an error message sayin=
g some
of the functions have multiple definitions in liblttng-ctl archive. E.g.,

=E2=80=9Cbabeltrace-plugin-ctf.a (libctf_parser_la-lexer.o) : in function
=E2=80=98yyrestart=E2=80=99: lexer.c:1875: multiple definition of =E2=80=98=
yyrestart=E2=80=99
liblttng-ctl.a (libfilter_la-filter-lexer.o):filter-lexer.c:(.text+0x17e5):
first defined here.

Without =E2=80=94whole-archive the build succeeds (I am using cmake) but th=
e
plugins are missing in my app (when trying to use bt_plugin_find with
static).

I am using lttng-tools stable-2.12 and babeltrace2 stable-2.0 from GitHub.

What do I need to do to properly link lttng-ctl, babeltrace2 and the built
in plugins?

Thanks,
Eqbal

--000000000000779ad705bdad6440
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Hi,<div dir=3D"auto"><br></div><div dir=3D"auto"><font style=3D"color:=
rgb(49,49,49)"><span style=3D"word-spacing:1px">I have an application where=
 I want to statically link both babeltrace2 library including the built in =
plugins as well as lttng ctl library. I couldn=E2=80=99t find much document=
ation regarding that. I know you can configure babeltrace with =E2=80=94ena=
ble-built-in-plugins but that seems to just link the eventual binary tool w=
ith the plugins.</span></font></div><div dir=3D"auto"><div style=3D"font-si=
ze:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=3D"auto">=C2=A0</div><div=
 style=3D"font-size:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=3D"auto"=
>I tried to statically link the individual plugin archives (ctf, text, util=
s) using =E2=80=94whole-archive but I am getting an error=C2=A0message sayi=
ng some of the functions have multiple definitions in liblttng-ctl archive.=
 E.g.,=C2=A0</div><div style=3D"font-size:1rem;word-spacing:1px;color:rgb(4=
9,49,49)" dir=3D"auto"><br></div><div style=3D"font-size:1rem;word-spacing:=
1px;color:rgb(49,49,49)" dir=3D"auto">=E2=80=9Cbabeltrace-plugin-ctf.a (lib=
ctf_parser_la-lexer.o) : in function =E2=80=98yyrestart=E2=80=99: lexer.c:1=
875: multiple definition of =E2=80=98yyrestart=E2=80=99 liblttng-ctl.a (lib=
filter_la-filter-lexer.o):filter-lexer.c:(.text+0x17e5): first defined here=
.</div><div style=3D"font-size:1rem;word-spacing:1px;color:rgb(49,49,49)" d=
ir=3D"auto"><br></div><div style=3D"font-size:1rem;word-spacing:1px;color:r=
gb(49,49,49)" dir=3D"auto">Without =E2=80=94whole-archive the build succeed=
s (I am using cmake) but the plugins are missing in my app (when trying to =
use bt_plugin_find with static).</div><div style=3D"font-size:1rem;word-spa=
cing:1px;color:rgb(49,49,49)" dir=3D"auto"><br></div><div style=3D"font-siz=
e:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=3D"auto">I am using lttng-=
tools stable-2.12 and babeltrace2 stable-2.0 from GitHub.</div><div style=
=3D"font-size:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=3D"auto"><br><=
/div><div style=3D"font-size:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=
=3D"auto">What do I need to do to properly link lttng-ctl, babeltrace2 and =
the built in plugins?</div><div style=3D"font-size:1rem;word-spacing:1px;co=
lor:rgb(49,49,49)" dir=3D"auto"><br></div><div style=3D"font-size:1rem;word=
-spacing:1px;color:rgb(49,49,49)" dir=3D"auto">Thanks,</div><div style=3D"f=
ont-size:1rem;word-spacing:1px;color:rgb(49,49,49)" dir=3D"auto">Eqbal</div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div>
</div>

--000000000000779ad705bdad6440--

--===============2267538925142715081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2267538925142715081==--
