Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-8.mailgun.net (m43-8.mailgun.net [69.72.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E896D2168B
	for <lttng-dev@archiver.kernel.org>; Thu,  4 Dec 2025 15:15:38 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764861337; x=1764868537;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=5m+dtOtOQd76gI/8m1hxk8IIhXk6PgZ2A6T+/sIPFUk=;
 b=wGnzSew4UjSewwANO+LiYa75JDaKu1yAHlytClslf9wJPspbN1pmNhc7e2nZue9dOjG1Rl9iU2sQ5AhLKJPTlOv3ASJsyNb8DqnjPOAHd+xzSSoMMTYdPo/cS1PhyOaulG06s9q7bxVOtYfl3RaF5TF7GBN5Ii5JwPcFfL2u6nYnySC2tmklO44qeJxQAGfZmQ8oloKzjq4DVQcIDYi+lovAfiIisQoPCrGtil6rfgwsFIGbANd/qt8SMVaWvyiW83VudFFTvmpDmZ06i5ArzQEBqPet4YkVrwGkl5GMU8PNuIGMsItDwJx3DizV5195Y0EWmikB7djZuLI7ZXS7XA==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 e668b2f4a3a44d7c342c6b2069e812a86e9708d32f443ded2fdf4b734d0b24bd with SMTP id
 6931a599555abd625bb1390c (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 04 Dec 2025 15:15:37 GMT
X-Mailgun-Sending-Ip: 69.72.43.8
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMdP31VgYz10Yp
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1764861336;
	b=naDASFXIcZohwFJlwhNhxQe4fMLICIWt/PXhYtjOJPptPl9KgjXM0/yoKcIwqZvnj6L8
	 5jpj2yWv/JB7qrlq2J9LvLWg11tSU0fRr/fxwMnoQqyJLV0Dh6Hl2zecnBod70fZZAZYW
	 namX9SR2A00FVEd5ox9zOM8/HQk9Jzqq6iqYqTHhHAZbc8C/wtaDuXiphz3ekSoftYfBy
	 VRSqZliiRrZksU/+dX7PNvdhAMgPrYTMWaXXPI4cISHNBvFmUnvekLjseONjNZbn5g0pN
	 PJ4w7BKFmWfokuklD1q9TYT5tfUBn52nwswCipHwL3fQqNM/3ODRqe3mnFg+IWOck8Q==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764861336;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=WcfLHRIxYcfkF+cu6OZmEzLxuTUX7719zH6lWl2IXko=;
	b=dPlw0vRfZW3iT1UKZlLuAugGZyrQQJacOek3WOe6JKUDLAYisI/YkW10K3cX8VXpaJ3z
	 oTMUtjdmKNobEJVqF1tpS2Mb4BxLXPeN38tOBkjtQiHlgD+TECidsXj2CZwQVS4pHe4gb
	 4twx3S2Ye+cAuA/GmvGXfauL7QAjpq4bKTInf2KISV9bsQtoMQAHEfsUZsj32HPYcgdvc
	 +gUwHlgo/Et0S664UH6HAGDfEH0jK3jvRQWimT7ZuyGBiCzOuzFVO8a37Qhe4+aEUDaKi
	 6Qr9UnjNOoLk2c0frEUB34rzGKWqGucutMZn8YYDUKM93aqAKhomXP44f2rANVaGebA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMdP31VgYz10Yp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764861336;
	bh=WcfLHRIxYcfkF+cu6OZmEzLxuTUX7719zH6lWl2IXko=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FwT0QaqymHTXK5qts68XllqvXo6jKqDgcHWw4l4bvGPTENFVeSN+K+AJjFrN4B7uV
	 xtfmsr1LlBnsY3uuBerl94H0R7wxH5N7DYoS3Vu/2YbJpNxV0fmTliwGHcpOjyJwXp
	 Ad1UYrd80ML2Tsyi1433gUnz7eCyV0qDEV1s8wg4y3bGyZ6kQdkqE4DJdPw33+ISm2
	 WTK3c9O303/9+vQ4Z75ZNE46/STp8SyjAd/nxU4n+FXweYiifxrgKqhyLvj4V2GvSD
	 Vf0fqoPMEpuTtGIwFZOnwWrgoYvNACr7MdFoSMuKBJIL/1d/4/B2i4fNnAiZWPCEVw
	 7zwmhW0Ppl+4A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dMdP31VgYz10Yp;
	Thu,  4 Dec 2025 10:15:35 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dMdP12P98z10Yl
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dMdP12P98z10Yl
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by lists.lttng.org (Postfix) with ESMTPS id 4dMdP12P98z10Yl
 for <lttng-dev@lists.lttng.org>; Thu,  4 Dec 2025 10:15:33 -0500 (EST)
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5958187fa55so821483e87.3
 for <lttng-dev@lists.lttng.org>; Thu, 04 Dec 2025 07:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764861330; x=1765466130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5m+dtOtOQd76gI/8m1hxk8IIhXk6PgZ2A6T+/sIPFUk=;
 b=V9ZKcvof9HiN9aDnKuBLKcmxRnA+rdkEi1PDH1PGXohd42rkHHwNTe7O94PsIl+awe
 kfhATNP98IbqOV/XQS0nKuZRLNeTwwcAjjbUW6ht48ilt8+JoBY9gFwxIU6lDsSLfTr3
 cb7mnsg7wa7w/31GUKC8uyeL+F+KxA+HWTnkaA9YSSfsDhAdctc9Gzs0AuvzH0Jve9Y6
 WRREGeJcBrmSw4y5ff9AA5x5YISRYYBLP1cgCsly9MxFtC/5BkYV7ejfwXiHip2XKdtU
 VqLQTfcd5Hjsj5fkgGfSWnKLLyMAY5Jc6JvGkUY14X2UoKcvK6FlUUmqCflK+dQuQjha
 hI3w==
X-Gm-Message-State: AOJu0YwVGnld4up5zvD73pODuCwda9fjK3sVlzFILwVSiEwC3H+pGkxL
 XCjKFhml7DicH7pTUfwHVxHaRbn+ZZlSc7MdtLNvhDETBDKp5y1eOwSsZxl8ruwIebmiRCu6sgT
 mFEWYf5P60427dX3PFMmPn1cm2JN1OWQ=
X-Gm-Gg: ASbGncsaEjtNog8ZiVq82DDBUmczt6O3we4nWxclUAE9VPNz9AouGWY/HLzxjtV50rp
 x5S4wOSYB0yhlRGHg4LvsXuJj9R9dKDBs/QYZ/Nq8jqJOryuOWuLQbaJoRqjxW4Bmy4T/Mnhspq
 LPYBt62WNByxLlgHDXE+LyptoSXNc4aP3gPdWudhlgTkl2PeBEseH+ahtFPMoZvFEpwK9WqL8B0
 +xzZiKUBr9kyoJAZUwKWHlVwVHKog8mrZBNPI7PzcM5Md4HOwNdl8lmzpp/MedxqFfkiDk=
X-Google-Smtp-Source: AGHT+IFjP3GkgZMKfvmXx/jLZf18POmuZJY7jGZI447zAlkSBIoPuJEaqpGAAnvov14q6rAbCC/Lb4K5s+UGRldfd+8=
X-Received: by 2002:a05:6512:3f1f:b0:595:7d86:f654 with SMTP id
 2adb3069b0e04-597d66c8293mr1209404e87.26.1764861329644; Thu, 04 Dec 2025
 07:15:29 -0800 (PST)
MIME-Version: 1.0
References: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
In-Reply-To: <ea1ffe7eed8afeed551e52e1d6dcac5d8e244c0b.camel@siemens.com>
Date: Thu, 4 Dec 2025 10:15:27 -0500
X-Gm-Features: AWmQ_bmeKc3tqLdJ5wT1QZ_8vXQfVAbovJue5ebOv41xfoKMcUEzaRDMIoM77B8
Message-ID: <CAB4xu_3fbK=-+B1=oo5oLk7jXVZgBEQjr99N6jpygX0SkuxAfA@mail.gmail.com>
Subject: Re: babeltrace | sink.ctf.fs escaping of struct member names
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>, 
 "Poljakow, Andre" <andre.poljakow@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Philippe Proulx via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Philippe Proulx <eeppeliteloop@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On Thu, Dec 4, 2025 at 5:10=E2=80=AFAM MOESSBAUER, Felix via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> In my opinion, the escaping of the struct member names in the CTF
> writer is not correct according to the CTF 1.8.3 spec: Section 4.2.1
> states, that reserved keywords must not be used and the recommended
> escaping is a underscore prefix. However, the spec does not state any
> other names that need to be escaped and by that also not names starting
> with an underscore itself.
>
> IOW: The CTF writer currently unconditionally escapes all struct member
> names, which I assume to be incorrect

It's not incorrect per se.

Underscore as a member name escaping mechanism has always been a
nightmare in CTF 1.8. For example, given:

    uint8 _len;
    string _strings[length here];

Should we use `_len` or `len`? And what about this:

    struct {
        uint8 meow;
        uint8 _meow;
    } _mix;

LTTng chooses to escape everything with `_`, except the packet header,
packet context, and event record header names it knows. We did exactly
the same in `sink.ctf.fs`.

CTF 1.8 doesn't specify `cpu_id` by the way; it's an LTTngism.

CTF 2 solves all of that!

Since CTF 1.8 is pretty much deprecated at this point, I want to invest
as little time as possible in anything related to this legacy format,
whatever the project. Just make it work considering the known use cases.

Therefore, for your specific problem, I suggest that you specifically
avoid the "protection" (escaping) for `cpu_id` in the packet context
field class _only for LTTng traces_. It should be good enough and make
Trace Compass work. Trace Compass could also unescape packet context
member names, but it will be faster to do this in Babeltrace 2 and it
will match the LTTng behaviour more closely.

>
> I tried fixing this with the attached patch,

If you need comments on a patch, even if it's an RFC, please prefer
Gerrit so that we can comment specific lines and follow the discussion
more easily.

BR,

Philippe
