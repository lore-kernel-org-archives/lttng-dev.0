Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5550FC74A5B
	for <lttng-dev@archiver.kernel.org>; Fri, 17 Mar 2023 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1679072230;
	bh=0rdEJ/v3AeaQl9Xha0qIB4s3EwcS7B3pj0PBcvd52Bg=;
	h=Date:To:References:In-Reply-To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=LoWcfq0QFFF09ZgvGPE0RXgmVuaV9Ahf29XMH02FH+Y2d2SL6VQQ0IJF9Hvd7gXlV
	 gs/p5ysLFrx38wyPdRLxTg/lWHVNO/AhblWop2zMJOWaV6xvWA/Ghfnv6FchN3OYij
	 HzAIvS2S56AVL297p8g5OrUl1kqYDjJDBpLLwUzwJ2bpboJquI/M4ESI8suX3tXHzg
	 phpnqGzI9XWSIZUeh5KGJu7jobUOG3sTAH3Ti1Lmc6Q2gbSCna17KBvqWwyqyFYkWU
	 dIKFThFJxv8LOobtDY/zpIHeOsHr2ZwfKrGb3xy80nYXrHZSnsFvYfMkmAluZ0QCPO
	 3XJYcyA/Zlzyw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4PdVfY3zW4z2CkX;
	Fri, 17 Mar 2023 12:57:09 -0400 (EDT)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by lists.lttng.org (Postfix) with ESMTPS id 4PdVfX24p4z2CVj
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 12:57:07 -0400 (EDT)
Received: from [IPV6:2a01:e0a:255:1000:c6b:7f65:8d93:a979] (unknown
 [IPv6:2a01:e0a:255:1000:c6b:7f65:8d93:a979])
 (Authenticated sender: duncan.sands@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id E44FA780333
 for <lttng-dev@lists.lttng.org>; Fri, 17 Mar 2023 17:57:05 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------bY548UJVgry2IfshkFVQC41Y"
Message-ID: <18a76290-44f2-1969-3c13-3986237f0d41@free.fr>
Date: Fri, 17 Mar 2023 17:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: lttng-dev@lists.lttng.org
References: <9C7806BF-FD55-45EE-B234-A8274145E19F@sury.org>
In-Reply-To: <9C7806BF-FD55-45EE-B234-A8274145E19F@sury.org>
Subject: Re: [lttng-dev] userspace-rcu and ThreadSanitizer
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
From: Duncan Sands via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Duncan Sands <baldrick@free.fr>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

This is a multi-part message in MIME format.
--------------bY548UJVgry2IfshkFVQC41Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ondřej,

> I have two questions:
> 
> 1. I've tried to help TSAN by replacing the custom atomics with __atomic gcc
>    primitives - that seems to work pretty well.  Note that using C11 stdatomics
>    is frankly not possible here because it would require wrapping everything into
>    _Atomic().

I'm using the attached patch which does much the same.

Ciao, Duncan.
--------------bY548UJVgry2IfshkFVQC41Y
Content-Type: text/x-patch; charset=UTF-8; name="pacify_tsan.diff"
Content-Disposition: attachment; filename="pacify_tsan.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0V4dGVybmFsL1VzZXJzcGFjZVJDVS91c2Vyc3BhY2UtcmN1L2luY2x1
ZGUvdXJjdS9zeXN0ZW0uaCBiL0V4dGVybmFsL1VzZXJzcGFjZVJDVS91c2Vyc3BhY2UtcmN1
L2luY2x1ZGUvdXJjdS9zeXN0ZW0uaAppbmRleCBmYWFlMzkwNTU0Li44Mjg5OGQxZGJlIDEw
MDY0NAotLS0gYS9FeHRlcm5hbC9Vc2Vyc3BhY2VSQ1UvdXNlcnNwYWNlLXJjdS9pbmNsdWRl
L3VyY3Uvc3lzdGVtLmgKKysrIGIvRXh0ZXJuYWwvVXNlcnNwYWNlUkNVL3VzZXJzcGFjZS1y
Y3UvaW5jbHVkZS91cmN1L3N5c3RlbS5oCkBAIC0yNiwzNCArMjYsNDUgQEAKICAqIElkZW50
aWZ5IGEgc2hhcmVkIGxvYWQuIEEgY21tX3NtcF9ybWMoKSBvciBjbW1fc21wX21jKCkgc2hv
dWxkIGNvbWUKICAqIGJlZm9yZSB0aGUgbG9hZC4KICAqLwotI2RlZmluZSBfQ01NX0xPQURf
U0hBUkVEKHApCSAgICAgICBDTU1fQUNDRVNTX09OQ0UocCkKKyNkZWZpbmUgX0NNTV9MT0FE
X1NIQVJFRChwKQkJCQkJXAorCV9fZXh0ZW5zaW9uX18JCQkJCQlcCisJKHsJCQkJCQkJXAor
CQlfX3R5cGVvZl9fKHApIHY7CQkJCVwKKwkJX19hdG9taWNfbG9hZCgmcCwgJnYsIF9fQVRP
TUlDX1JFTEFYRUQpOwlcCisJCXY7CQkJCQkJXAorCX0pCiAKIC8qCiAgKiBMb2FkIGEgZGF0
YSBmcm9tIHNoYXJlZCBtZW1vcnksIGRvaW5nIGEgY2FjaGUgZmx1c2ggaWYgcmVxdWlyZWQu
CiAgKi8KLSNkZWZpbmUgQ01NX0xPQURfU0hBUkVEKHApCQkJXAotCV9fZXh0ZW5zaW9uX18J
CQlcCi0JKHsJCQkJXAotCQljbW1fc21wX3JtYygpOwkJXAotCQlfQ01NX0xPQURfU0hBUkVE
KHApOwlcCisjZGVmaW5lIENNTV9MT0FEX1NIQVJFRChwKQkJCQkJXAorCV9fZXh0ZW5zaW9u
X18JCQkJCQlcCisJKHsJCQkJCQkJXAorCQlfX3R5cGVvZl9fKHApIHY7CQkJCVwKKwkJX19h
dG9taWNfbG9hZCgmcCwgJnYsIF9fQVRPTUlDX0FDUVVJUkUpOwlcCisJCXY7CQkJCQkJXAog
CX0pCiAKIC8qCiAgKiBJZGVudGlmeSBhIHNoYXJlZCBzdG9yZS4gQSBjbW1fc21wX3dtYygp
IG9yIGNtbV9zbXBfbWMoKSBzaG91bGQKICAqIGZvbGxvdyB0aGUgc3RvcmUuCiAgKi8KLSNk
ZWZpbmUgX0NNTV9TVE9SRV9TSEFSRUQoeCwgdikJX19leHRlbnNpb25fXyAoeyBDTU1fQUND
RVNTX09OQ0UoeCkgPSAodik7IH0pCisjZGVmaW5lIF9DTU1fU1RPUkVfU0hBUkVEKHgsIHYp
CQkJCQlcCisJX19leHRlbnNpb25fXwkJCQkJCVwKKwkoewkJCQkJCQlcCisJCV9fdHlwZW9m
X18oeCkgdyA9IHY7CQkJCVwKKwkJX19hdG9taWNfc3RvcmUoJngsICZ3LCBfX0FUT01JQ19S
RUxBWEVEKTsJXAorCX0pCiAKIC8qCiAgKiBTdG9yZSB2IGludG8geCwgd2hlcmUgeCBpcyBs
b2NhdGVkIGluIHNoYXJlZCBtZW1vcnkuIFBlcmZvcm1zIHRoZQogICogcmVxdWlyZWQgY2Fj
aGUgZmx1c2ggYWZ0ZXIgd3JpdGluZy4gUmV0dXJucyB2LgogICovCi0jZGVmaW5lIENNTV9T
VE9SRV9TSEFSRUQoeCwgdikJCQkJCQlcCi0JX19leHRlbnNpb25fXwkJCQkJCQlcCi0JKHsJ
CQkJCQkJCVwKLQkJX190eXBlb2ZfXyh4KSBfdiA9IF9DTU1fU1RPUkVfU0hBUkVEKHgsIHYp
OwkJXAotCQljbW1fc21wX3dtYygpOwkJCQkJCVwKLQkJX3YgPSBfdjsJLyogV29yayBhcm91
bmQgY2xhbmcgInVudXNlZCByZXN1bHQiICovCVwKKyNkZWZpbmUgQ01NX1NUT1JFX1NIQVJF
RCh4LCB2KQkJCQkJXAorCV9fZXh0ZW5zaW9uX18JCQkJCQlcCisJKHsJCQkJCQkJXAorCQlf
X3R5cGVvZl9fKHgpIHcgPSB2OwkJCQlcCisJCV9fYXRvbWljX3N0b3JlKCZ4LCAmdywgX19B
VE9NSUNfUkVMRUFTRSk7CVwKIAl9KQogCiAjZW5kaWYgLyogX1VSQ1VfU1lTVEVNX0ggKi8K


--------------bY548UJVgry2IfshkFVQC41Y
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------bY548UJVgry2IfshkFVQC41Y--
