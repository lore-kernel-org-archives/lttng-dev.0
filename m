Return-Path: <bounce+b7b410.602323-lttng-dev=archiver.kernel.org@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from m43-10.mailgun.net (m43-10.mailgun.net [69.72.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E595D116F3
	for <lttng-dev@archiver.kernel.org>; Mon,  1 Dec 2025 14:38:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=lists.lttng.org; q=dns/txt; s=mx; t=1764599897; x=1764607097;
 h=Sender: Sender: Reply-To: From: From: List-Subscribe: List-Help: List-Post: List-Archive: List-Unsubscribe: List-Id: Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject: Message-ID: Date: In-Reply-To: References: MIME-Version;
 bh=ET6grLCtsujTZMtzZo/TazRdOlp7cfvV9t3jvs0Cans=;
 b=UtIw4LtUKvb9/9Ndu1VayrdFNVouadVJttgbZnAUIrytyEdoDUAmZM9nkndP7sHehtKbse6khswIE+xJYZxdHnEc2EmOJn2DaTreJgFsi/GH9uPpYpQ1v9ECKoxet95qJQN5TJ7MAq/UymAEN86uoiBX5Md+IeBo6zwMnEiyYyxFDaHoHErgxFd36+UQurfhrrdFC7Tu2JhHN+HANTyuuuwuOKxz0ID51f6ZLCmxYFa2CRqR88qhZdhfTArARhABI6+di7Zb6D/TiJeX44RbKt0Mtt7SWICEmXWq/4Jm2JeocQyKhidhai9IKldi0qG+57WiSNMCrGHFl5k/tbNSHQ==
X-Mailgun-Sid: WyJlYzgxZCIsImx0dG5nLWRldkBhcmNoaXZlci5rZXJuZWwub3JnIiwiNjAyMzIzIl0=
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29]) by
 a767d96b175d3596c9b99f39835b9079365bbd60790adc3f9905f574be66856f with SMTP id
 692da859e56432b4caf98dac (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 01 Dec 2025 14:38:17 GMT
X-Mailgun-Sending-Ip: 69.72.43.10
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dKmjM5TD3z1Vxx
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1764599897;
	b=g+/zvuZmmuQF5bkNQE4yWf/vts41rCRh1YjYqClVqHZSF6EwsCKs/dbLip/bAVL2+ftq
	 bgRqkk4cBEZIQHyQ+JUWuob8SW19VcRT+OAqLeP0DncLFxWxSH1KZR9/LD4xPfB0ZaNUQ
	 MatflEY4g4/B4My06VdzR6SCnAoOgG0Dh1NJ8AQ1M76E9BCNJIWXF/xpKOBP8ZcszR843
	 NMn1IeqoUl+PBjGbORerR07yRZgXKAJDAYf4G3ZKj+moGQP8fTRz1/12QlfV5J1tXW1yA
	 Gk3TnXaKSTczLOVyuTPQIKme/irg6AjncQevSYxaNbfRm1PxTE3E5WYIuyOiL7LWKGQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1764599897;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=ukNbAIMk8UKniLvm2xCpwImsEKrV6BobfpnltvWHq8U=;
	b=OVjUq2G1mDOqa4j3rpccDrLjA9/agSjMkKLIs/9tYNPY3Vr8EW3r3kKHPxSlACjBzdqd
	 KYjrr8ynJObpG2tzbaWNIq7D+/1sqtr3HUQa0lJz5LsJ5lvn+JzAsQ8bNwkiPjKhGmw+g
	 qSgKv79Om0O+1kYirh4YKfB5IW9pAZE86cfBFvpQl7MZq6WVSQadShXrx7WYX154lP+5R
	 CmHojTjSy9oANgjgzdS12ncsjjFBJL1fd9myvRfm6ZNzyzJAbu7TAiAAWhYwitfZ9I8Kx
	 ninEH3km44PFgjnIBc3KfUtzyvLJ35emulSDQqgx1i5U/ORiMfcVJ3XbGMi2bxXH21g==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dKmjM5TD3z1Vxx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1764599897;
	bh=ukNbAIMk8UKniLvm2xCpwImsEKrV6BobfpnltvWHq8U=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ZxB1WgPoNf7hvYVlRWGYByyjWzxd/cfPATWn5yqGxxFUh/ArW6LCwyviR8dQzu8lw
	 NWlAGxbCJRdA80D7Fi6i6L6ch56Lo/Nev/Oy8F52ROvZYgJ+6c5F/y08OqyreAE4WP
	 MtPH5osWLkLhb6OrPxZLd7ZcC6jQ1d7kgNVD3i75VgyOuOX9eyKuUld9cpA9dyz/Oj
	 7SD+tacGrA52+rlRJNnRzW5oq7MTCwNIWrGeYAHP4lVRC7ueX+uLoi2mfMQDlaQJWK
	 GbNlXFX+drZPSOpbDpgQ/oj41IDKA7EYDC/xXLZY+wGqcR4ANOYEWSBE+BtjrkbU8R
	 LBwTevKE0wUAA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dKmjM5TD3z1Vxx;
	Mon,  1 Dec 2025 09:38:15 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dKmjL1hGdz1WRJ
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dKmjL1hGdz1WRJ
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by lists.lttng.org (Postfix) with ESMTPS id 4dKmjL1hGdz1WRJ
 for <lttng-dev@lists.lttng.org>; Mon,  1 Dec 2025 09:38:13 -0500 (EST)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-37a34702a20so34476251fa.3
 for <lttng-dev@lists.lttng.org>; Mon, 01 Dec 2025 06:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764599891; x=1765204691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ET6grLCtsujTZMtzZo/TazRdOlp7cfvV9t3jvs0Cans=;
 b=j73ZK7kBqnI5vkVKBQClxPKSMumvzI3SpV/Ar+DOgoiLAV2JdTGHRgheaK3PDMEcBC
 j9Arht9EJeU7yl4HN/ZhKsHhhLS7Tk8MJMzwoLVk6+61t/+9L09kz71T7W7CBzLfrENI
 t8jxJjLJLoLVi3x4YLTHZ/yA3yljXdN41X/GLCeGd8wuFPam1+gYkEtjiVxUX0JwIfqr
 0valEzwRETNaUuxXE04BCdCJ056glcaX0nVILv8L/ML6jFCPfBAx9Ly2pxWRM1A/6Re4
 /zL0HHI5dREqPkoF45SALpVnpDoy/hFRolyHKoioQI5TUBsLNMJC8TniGrgzJ4Kk17y1
 WmsA==
X-Gm-Message-State: AOJu0YzalTyXUmO9vxU0q+E3RTTgmwj6hlGsNNuzB9V1iD4JlbLU6k9f
 CUsp2vvO5tDSThfvB6YVU7wyzAc5rf3pC4dMvxksvpdAJPVyIEZjOKeqqq1jx2GzFon1Y5gwWbd
 cwdYTGVHXBj6ddd/xndpzIr788tFdBDE=
X-Gm-Gg: ASbGncuCSEajYHloSSEzci24WzJSklK7eUqeR9vUnM5UXWyX1FHb2bQYoDXFHUFavmo
 A6eqLEnQkgRPdqtniQSoOIfyZoIB9kbxGDjCFKE8yXHZ9Vh5Wt6iXHcjyeFcpgMl+h+3NDpuZjI
 w3dtEezez9NbflVK6B+5i35NZb0tCX6B83rShpQPbvUpMb+jfSoiwx68V/fY2LwZBW6xH7v7swX
 p0u7eRplfogMDs+FLW4PGmFnAHrMEFrl4l5h1wLzfCuP97TJ5q4KMCkLj7ujofE34bEIWc=
X-Google-Smtp-Source: AGHT+IF9hGlsIR+Tjqicpdg0HNHIQVhupbnpbW1NhMLtLSJ7+B7VWzXr7tvm9xk6SJC2WyfrTWXQ/lqxicXOtjvPki4=
X-Received: by 2002:a05:6512:3ba0:b0:57b:8a82:1e27 with SMTP id
 2adb3069b0e04-596b4e52a2emr9939523e87.13.1764599890509; Mon, 01 Dec 2025
 06:38:10 -0800 (PST)
MIME-Version: 1.0
References: <cd2f473df84132beca2d926819e15de514e10589.camel@siemens.com>
In-Reply-To: <cd2f473df84132beca2d926819e15de514e10589.camel@siemens.com>
Date: Mon, 1 Dec 2025 09:38:12 -0500
X-Gm-Features: AWmQ_bk8TKYgqlG6wA2k23A9BGkFk_5efIl9sJfKZDjDuiv04U2Rm9Dy0xMuqlw
Message-ID: <CAB4xu_0SBjk5xKXt_Q5gYWDC+iHg=oi08MyGyFhcBvvVmoAfvQ@mail.gmail.com>
Subject: Re: babeltrace | sink.ctf.fs: add support to create LTTng index
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
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

On Mon, Dec 1, 2025 at 4:34=E2=80=AFAM MOESSBAUER, Felix via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
>
> Hi,
>
> I recently created a babeltrace pull request that adds support to
> create an CTF LTTng index file along the CTF files [1].
>
> It would be great, if someone could review it.

Thank you for your pull requests.

I'll need to look at this in detail, but I'm not against the idea,
especially if it's guarded behind a no-by-default
initialization parameter.

That being said:

=E2=80=A2 We won't review on GitHub: please submit your change to our Gerri=
t
  Code Review system (<https://review.lttng.org/>).

  I know it's a bit more initial work on your side if you're not
  familiar with Gerrit, but the review process will be much easier.

  See <https://review.lttng.org/Documentation/user-upload.html> to learn
  how to upload a change.

  For this reason, I'll close the PRs immediately.

=E2=80=A2 You'll need to add a few tests to validate your feature.

=E2=80=A2 I'll deal with the documentation (manual pages) myself.

=E2=80=A2 Given our current workload before the end of the year, I'm not su=
re
  I'll be able to review this before 2026.

Thank you for your contribution and for your patience with our
review process.

Philippe Proulx
EfficiOS

>
> [1] https://github.com/efficios/babeltrace/pull/123
>
> Best regards,
> Felix Moessbauer
>
> --
> Siemens AG
> Linux Expert Center
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
>
