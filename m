Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3893FC7EE22
	for <lttng-dev@archiver.kernel.org>; Thu, 11 May 2023 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1683830649;
	bh=B7/xXIBR0ZIRG09vsm5jA+pPgJxOuec3RDKBU52LYxg=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=KkDQsHumR2uW+WIuStRuPF4VL2LhAo0rT4DFFa51qhpVaYl4xh6Eu25HN1LleQa0Q
	 E+P/wZIIlJCXWaEyzO4H5tSP6mUhFkzQzrSn9NMsd1uIqoYb9WpllCzKUJWqBkSNLN
	 qoYmONHtQQOqyRznVvHLfIQhQbZscCAh1Hej7fmmLZ9/1an+EaXU9n2pW1IkeQeoaX
	 T8zvJhL/rUIuwtLGFUiInGjwKU1wRvRqJeXRENU2h57oA2/ALSLSdNuQ46Bzx7jm1O
	 UjzY2eLgHzIcDeXtM8XJ+RsVXoH3Mt2x4yDhB88WKcKqqcZDaOsBy++XM/mlHZh22P
	 lqDhPAvd94Kxg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4QHLQc74RwzT2k;
	Thu, 11 May 2023 14:44:08 -0400 (EDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by lists.lttng.org (Postfix) with ESMTPS id 4QHLQb3qLHzT2h
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 14:44:07 -0400 (EDT)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-50bc456cc39so13403087a12.1
 for <lttng-dev@lists.lttng.org>; Thu, 11 May 2023 11:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683830586; x=1686422586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSPfUpHuuG6dA/NPUWACgmJEZz/nL5OckymumZFh0FQ=;
 b=CF8WoHeadOsXCJOXanTluCEybgfRs1K3qxWk3yfzOiFfOuSXXKf2Di4ShpK8PZ6LHD
 GD65M46x5/Z/e4OqvH0y26YNzJNhRYJSO5SDMo1nS1DQlbm9H4Ph0S7IRhvxNUIGNX9S
 bMlr3UgqJLioO9oo+I6jmkwaxM7ctPXrG28RHv7lZ0z14SLw4TYiGli1yLKO2IoR4gtU
 FZ+ZWTwPWiTgSs7sLmBVUJhsglfnIFXewckApFeEg3+0gGhMYYc5iib5R//ePnYPR7c7
 C1wP98irFoaPnZVrr9c+F4efZY61T0gE/KCQvZaVMpwWVdCi5AQUzfXl92EqnHfKl93+
 27BQ==
X-Gm-Message-State: AC+VfDyAQq3yVRI6nWDoUIWwVh5M7gdNmgiMe/s0MVQxkMsgK60Imezp
 Doq5iEF5s/n9mNf6UXGuE5AygZOcGMPAfeBzPZNWnurM
X-Google-Smtp-Source: ACHHUZ7M8xwMo/mJlL7ERzdw2BfCAZS3NuAzncGUsvaoYpHck0YQLuTt7+Alfre3Lp2NfZ4PPuq88oUIc/MoNiESDkE=
X-Received: by 2002:a17:906:fe45:b0:92f:33ca:c9a3 with SMTP id
 wz5-20020a170906fe4500b0092f33cac9a3mr19271189ejb.71.1683830586188; Thu, 11
 May 2023 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h-Xsf7HGZ6A57BpuWH7CzogwV6D25vg05dOq30_MfxE0A@mail.gmail.com>
 <CAFZh4h8awEpJgAcygRY=1f7A2qK91b31HBnLBPvvueuRnquOjQ@mail.gmail.com>
 <6ffecb5c-fa2f-9ace-bc50-5b5f49f36d42@efficios.com>
In-Reply-To: <6ffecb5c-fa2f-9ace-bc50-5b5f49f36d42@efficios.com>
Date: Thu, 11 May 2023 14:42:55 -0400
Message-ID: <CAFZh4h9Kwf13j36HYEZbSJUggU3yUc+LKpW_f4jTArsfFJdBvw@mail.gmail.com>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] I'm still getting empty ust traces using tracef
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
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

T24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgMjoxNOKAr1BNIE1pY2hhZWwgSmVhbnNvbiA8bWplYW5z
b25AZWZmaWNpb3MuY29tPiB3cm90ZToKPgo+IE9uIDIwMjMtMDUtMTEgMTI6MzYsIEJyaWFuIEh1
dGNoaW5zb24gdmlhIGx0dG5nLWRldiB3cm90ZToKPiA+IC4uLiBtb3JlIGJhY2tncm91bmQuICBJ
J3ZlIGFsd2F5cyB1c2VkIGx0dCBpbiB0aGUga2VybmVsIHNvIEkgZG9uJ3QKPiA+IGhhdmUgbXVj
aCBleHBlcmllbmNlIHdpdGggdGhlIHVzZXIgc2lkZSBvZiBpdCBhbmQgZXNwZWNpYWxseQo+ID4g
bXVsdGktdGhyZWFkZWQsIG11bHRpLWNvcmUgc28gSSdtIHByb2JhYmx5IG1pc3Npbmcgc29tZSBm
dW5kYW1lbnRhbAo+ID4gY29uY2VwdHMgdGhhdCBJIG5lZWQgdG8gdW5kZXJzdGFuZC4KPiA+Cj4g
PiBSZWdhcmRzLAo+ID4KPiA+IEJyaWFuCj4KPiBIaSwKPgo+IElmIHlvdSBhcmUgc3RhdGljIGxp
bmtpbmcgJ2xpYmx0dG5nLXVzdCcgdGhlbiB0aGUgbGlicmFyeSBjb25zdHJ1Y3RvciB3b24ndCBi
ZQoKQWxsIG9mIHRoZSBmaW5hbCBleGVjdXRhYmxlIGlzIGEgYnVuY2ggb2Ygc3RhdGljYWxseSBs
aW5rZWQgbGlicyAoYWxsCi5hJ3MpIGJ1dCBsdHRuZy11c3QgaXNuJ3Qgc3RhdGljYWxseSBsaW5r
ZWQgKHVzaW5nIC5zby4xLCBub3QgLmEpLgoKSSBjb3VsZG4ndCBidWlsZC9saW5rIHdpdGhvdXQg
bGlua2luZyAtbGx0dG5nLXVzdCBhbmQgLWxkbC4KCj4gZXhlY3V0ZWQgYW5kIHlvdSdsbCBnZXQg
bm8gdHJhY2VzLiBXaGlsZSB0aGlzIHNldHVwIGlzIHVudGVzdGVkIGFuZAo+IHVuc3VwcG9ydGVk
LCB5b3UgY291bGQgY2FsbCB0aGUgVVNUIGNvbnN0cnVjdG9yIGZyb20geW91ciBhcHBsaWNhdGlv
biBlYXJseQo+IGluaXRpYWxpc2F0aW9uIGJ1dCB0aGF0IHdvdWxkIHJlcXVpcmUgcGF0Y2hpbmcg
bHR0bmctdXN0IHRvIGV4cG9ydCB0aGUKPiAnbHR0bmdfdXN0X2N0b3InIHN5bWJvbC4KPgo+IEFu
ZCB0aGUgZmlyc3QgdGhpbmcgdG8gZG8gdG8gc3RhcnQgZGlhZ25vc2luZyBVU1QgdHJhY2luZyBp
c3N1ZXMgaXMgdG8gcnVuCj4geW91ciBhcHBsaWNhdGlvbiB3aXRoIGh0ZSBMVFROR19VU1RfREVC
VUcgZW52aXJvbm1lbnQgdmFyaWFibGUgc2V0LCBzZWUgWzFdCgpUaGFua3MhICBJJ2xsIGNoZWNr
IHRoYXQgcmVmZXJlbmNlIG91dC4KClJlZ2FyZHMsCgpCcmlhbgoKPiBmb3IgZGV0YWlscy4KPgo+
IENoZWVycywKPgo+IE1pY2hhZWwKPgo+IFsxXSBodHRwczovL2x0dG5nLm9yZy9tYW4vMy9sdHRu
Zy11c3QvdjIuMTMvI2RvYy1fZW52aXJvbm1lbnRfdmFyaWFibGVzCj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdAps
dHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4v
bWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
