Return-Path: <SRS0=9+xD=ML=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714C2C07E9D
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jul 2021 13:40:43 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F5261026
	for <lttng-dev@archiver.kernel.org>; Mon, 19 Jul 2021 13:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F5261026
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4GT2zX6t0nz147G;
	Mon, 19 Jul 2021 09:40:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1626702041;
	bh=GmQNuxai5hDuo1SPT5TGbbUnMHlXU5HnE8zu3+bwm54=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=oYvv1kNQFlATeaZTHw/vtXIxODYc0oIiongGE461iMiITwfvgWcIYn176fNzuhxRw
	 YfV8L4Z/uXNbE6YLRjYGx9ICkIqiZdvzNaPSUjKkrxUBh84mKR6Lh6MUe/QJwmTdwv
	 jVzF6PaZavZXR6PfQG0jfz2OGMGHG7xvOHBu6c7kiNXbjgQjebDWVTeejgZmROC/J7
	 3nWS+W5Ut6zyn53YRihEGNB3uf8Zrpb6OhlV8X2V0EW7hyWKCaZZEXah/JfRTiiSjt
	 PuhHJ6ofPSy45HckTAw/F5OTJ2pln+U/3OCJcwRfYJ8+ZhVQIyJoeqfqw+YFNdIxYb
	 cNMd7P9WYaTDQ==
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by lists.lttng.org (Postfix) with ESMTPS id 4GT2zW2FRyz13tV
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jul 2021 09:40:39 -0400 (EDT)
Received: by mail-oi1-x234.google.com with SMTP id r80so6956162oie.13
 for <lttng-dev@lists.lttng.org>; Mon, 19 Jul 2021 06:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BVXeLEY+I0lm5BzZHMe19vu+/8kTOJpiYobqX2xg4XY=;
 b=RSyLuArKbhvUKU8TAj+c7KhSgwGTc9dRvjYfz44NXK+hN+GNDfNaiO6QlY5cEu8mkk
 K8bVN+1YLH2YDponhMFeM95HT5Izpj7fQXBO5b7vX0hR7z6+9sRvqzCwNaJObYlc5uRv
 je0oFFyfLVVasDtSljt2hMzObZ8V/55oKT5XLmrEY3YgmuOSqkRRyfg+JyTymzFDrBqw
 ccFlPL2mQm6DLffpwKG7IuMxDMAuj3gRzHPHg/I+czkCirw+S/xQVqDdGK9P3YJ9Q95x
 m258l8TIj0QeDiUo+Xhod08OGVR7NRx7NfT1/kEAC/RNTzQJAQmCrmkN7DUrkV/pecmn
 nNKA==
X-Gm-Message-State: AOAM533o4WaHDLZTJ2O5OtJU0yYPSUajlucOWq0rJjLIw8+CW+aEDCxJ
 vAZDw6Pk8xMvyw/aQdHdKs+g6wNX5o6tL/GDwYhvmDnv+qo=
X-Google-Smtp-Source: ABdhPJwaqjqB6ZlYE0N1+efsTdllsBh0CX/FSa1u7+otGki9eKBX/u80+Dw7PfpjNZveeE83S+Vgyoob7ZhC9tRgn7w=
X-Received: by 2002:a05:6808:5d8:: with SMTP id
 d24mr17484136oij.74.1626702038283; 
 Mon, 19 Jul 2021 06:40:38 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 19 Jul 2021 09:40:06 -0400
Message-ID: <CAA+-46pxTLb0trHLGhLwwdf2N5YJQ90mdGtdxm0hn+Gcx=NMoQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: [lttng-dev] quick question about setting up lttng on Redhat
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
From: Evan Galea via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Evan Galea <evanjamesgalea@gmail.com>
Content-Type: multipart/mixed; boundary="===============5502310632797708638=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5502310632797708638==
Content-Type: multipart/alternative; boundary="00000000000025b7aa05c77a15f5"

--00000000000025b7aa05c77a15f5
Content-Type: text/plain; charset="UTF-8"

Hello there

We have been considering setting up Redhat on my system and have learned
that Lttng packages are supported. I was hoping to quickly learn the answer
to two questions:

1: As Redhat is based on Fedora, Do I just use the instructions for Fedora?
I know it's probably a stupid question but I just want to make sure I'm
doing everything correctly.

2: Are there any differences between Lttng on Redhat and Lttng on Ubuntu or
are they simply the same? Again just need to make absolutely sure as I
don't want to do anything without first knowing

Thank you for your time and sorry if the answers to these questions are
somewhere I didn't look.

Evan Galea

--00000000000025b7aa05c77a15f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello there<div><br></div><div>We have been considering se=
tting up Redhat on my system and have learned that Lttng packages are suppo=
rted. I was hoping to quickly learn the answer to two questions:</div><div>=
<br></div><div>1: As Redhat is based on Fedora, Do I just use the instructi=
ons for Fedora? I know it&#39;s probably a stupid question but I just want =
to make sure I&#39;m doing everything correctly.</div><div><br></div><div>2=
: Are there any differences between Lttng on Redhat and Lttng on Ubuntu or =
are they simply the same? Again just need to make absolutely sure as I don&=
#39;t want to do anything without first knowing</div><div><br></div><div>Th=
ank you for your time and sorry if the answers to these questions are somew=
here I didn&#39;t look.</div><div><br></div><div>Evan Galea</div></div>

--00000000000025b7aa05c77a15f5--

--===============5502310632797708638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5502310632797708638==--
