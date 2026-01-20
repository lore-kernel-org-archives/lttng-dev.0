Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65342CA5FA2
	for <lttng-dev@archiver.kernel.org>; Tue, 20 Jan 2026 16:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dwXR71bX5z2N7y
ARC-Seal: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=fail; t=1768925557;
	b=NVI0FZUTBCrLNyeb7xNdafc68+df2UUXcbzEHpeAzBZ3oJvpydVkW2DlJiOwvROGNZAm
	 lqdNQ2Ot5y/Mxuf9cAZACr/j5/jN+wA+rqjlAXjlrc5HO679rKSPG9nstoT645DKap8EQ
	 XPe57H7EfbPx8Fii12LRC4eFNELwL1X5WHYvcJPgCPABdnFOYVbjMiEHJM18N6aZQcugd
	 4t0oVtujqIbM0rORCuqg09GzM/QML+PX4OzC3sSbjlIc9rwJUEwzAy1jHDXYwO87ZjgZC
	 /Ioc6tmBEkEHdrPUY3FeF11OILKl9ADTSh7gG/RoyViCciSff8MWwJoFVswLA983GfA==
ARC-Message-Signature: i=2; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1768925557;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=6S2z9sw08UyGYbChkZmQCtYEpITJ1i9E3/QYRR+JRE0=;
	b=IW03N39HXb3e4i0rBVbCv7RLmRW+iS9BpJGAXwVg1kJNji3+pJsVsHNYqRYzxCbVzUP/
	 mLZAc8NxE3dsrUnKl8yI/jxadxEAqgLJtPwDO5itPUA79KaHH0jd1e9vTjlxhRnxaFysz
	 RnzW3MzvMzUs+R1JP2vCJbVf1ZQYdLL7VEw+hZcwESRRbtguPL1HyXbbFeFuLPRNrH8/i
	 W1oDFv93fYao5oefMk+o6Dd3XdNEspfM2qZiG8Ej2rMv5A1UROBEzbLgbake4CgwnnByJ
	 cAcX1CNJuH64SaBPCVsNbARSjtAKk6uIc2H17TL8iotbjlaYk8KWoT5Daen5cCKgUhg==
ARC-Authentication-Results: i=2; lists.lttng.org; arc=fail smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dwXR71bX5z2N7y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1768925557;
	bh=6S2z9sw08UyGYbChkZmQCtYEpITJ1i9E3/QYRR+JRE0=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EP3YxZeBlbpIxKF7Y2OiPCSpNjVAfRiNNrlvIv6f66PwwHTu/ylITH1vusklYqBcV
	 vi9DvAE6eciZy8kERdaiG2D3OJhKt/cJCP+L7pKKqJoZa13qlgHpIaF9j8YV2F2u81
	 0QLwIN6f8g2kcD/jHtN6N7pU2KGCrJlJwye4lGUb5ovM3ULI777Ydg9rbzfe2NuJIh
	 xeV+7w3LqrGJttgGdPRkMM5K4eazVz5NeHhTAQ/KSufd+hDZUNFrgxlOVGO0LS75Lf
	 AmrBMm1EIfPM8aejrJZTMrICw38Ht3NsWpFm/tBE8sGdVnV7W/Q+lM8x72DM9ULADf
	 W08jSab02pZ8g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4dwXR71bX5z2N7y;
	Tue, 20 Jan 2026 11:12:35 -0500 (EST)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4dwXR50b5sz2Mx3
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4dwXR50b5sz2Mx3
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by lists.lttng.org (Postfix) with ESMTPS id 4dwXR50b5sz2Mx3
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jan 2026 11:12:32 -0500 (EST)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7927b1620ddso79269757b3.0
 for <lttng-dev@lists.lttng.org>; Tue, 20 Jan 2026 08:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768925547; cv=none;
 d=google.com; s=arc-20240605;
 b=SGOV22J+GNdTTi0iPii5MS9SvZmW1Tr8/yYkePhRH5k+6b5lFhRX8u/UBnUbRxP1hI
 J2xg/NWdOVJYhXH9sUB3IhYpAr0dm8jjGJhtaeThAFr5b+Tsibzt3SOmh9THwz/a+fQr
 xdaPz48ftS86It0uiVn2t1fdIYN8Q6AfhxvmAdmOb2X2EphkGwRkMQnIWudPNfuGG9JM
 pHrLHYbwzLGu/LTW+MCwanodTbxZwWEtTGAnG45BPKsUCMolgxdf3DNU+sb+r+6cO2MI
 EUg4kD7A2byIJ0RGjE18ESFHptOFk6yVpZcyVic2b4gR0zmK5Arhlwc4UXMzDWH/P1Fl
 E0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6S2z9sw08UyGYbChkZmQCtYEpITJ1i9E3/QYRR+JRE0=;
 fh=FM0hhjoL92AKLDnTdeUseI6571NwqH6GCT46XuS1yXQ=;
 b=aWGgiblwnxz+tFGTyq5rUbssELKYducf7biKRx0fnLDuaH1J9E66fl8qyDo+3vsXst
 wpwAIDSdkJIhfOrhnuewKlE/BE8RgNEKQvloZ4IlRTvbA/nbdf165Hb/OtEZGd1fxK61
 ogM96Pp4Gc98Tnc08xDKithMWsvnKSiDWgRFtoGtsKeStFQWnoL9YLC3D3c7OPZ8MhSZ
 KRBN9yEiagox+FNjF42eQVWz3COZwXDEke3i2A3twwtVfM5vzeBHD6Jk6+k38188WXR4
 NJ+JsYL2/+nLnh7djDgy5/NveMpqWu41x73oVJ7f36ntKnck4BO8FgoT+G3OKUGRDR8Z
 /B3A==; darn=lists.lttng.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768925547; x=1769530347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6S2z9sw08UyGYbChkZmQCtYEpITJ1i9E3/QYRR+JRE0=;
 b=H43rWzzXzsBX2MkfKHeUIA6PYFX/AL3B8kRMeBHXdWmwvDbWkZVUGFLk9YmChsnWn3
 9UjZ5n+jiA/XiBQpP4s2Po1jG2fsF62S3vk25DI7JgaxPqL5sHmQDPQHaIbMnPpIUkq8
 0Wl8Ycu55zEH9W5jz3UjZyPEYpe1uW0FHp+BTchtGyZA9s08YZa/mMiJgJdG9IEMRbbN
 8EcJAsuYib+d/MDQlvke6WwsnFm3gEtC5aBbsudUEUiv3DWZPVBtQrVAFOX0RBq3Rbtl
 MA3V7Cpd3Xh9OOHiFL4voHSiPrGEzAUlR9h209fIak0oQQFumNu9QhCiaNxNvPuYNxTH
 820g==
X-Gm-Message-State: AOJu0YxkelibVvQCIqdDR7d+VFCf8P2q7nUaAnpjKBOvAUezT8IJdVG/
 QKAuOPoM3G1PYk3bKBpLELxCBiGzJZSOYOLrmacjF66hobtLDc8VqTdD8ESKiv6TVLWZ77XTG0i
 DogXpWgRcO46NYj0kYgDts5INdpfONKJjYhq5
X-Gm-Gg: AZuq6aKVeCfuBmqHRm0pVzFQeOy/E5NILMBuXmhNrK9SxVoxtBiZ4tOMxfXULu781pB
 sqvMHBXGLMXvOKrXxxuiQfk8b+hYdIxQgFeAv9BLRu9fPtj7goq/4viesVOKMIwjT3w8p0YR25i
 zyDiOZUCdXKIQ9cZJ+TbA0SpvTP6WEdouvGnJIS0lV1XXzGSzI6ut7O33C4hZ1BRK2SCx+tj2uC
 KwevRidZda5onL+E+RqBgrZiflO7R/rQe/CkbP0c9EJlSlY8dABg7/uyv/BMzBAcaXfDx+xog==
X-Received: by 2002:a05:690c:4d45:b0:78f:fcfa:c966 with SMTP id
 00721157ae682-793b3565bd0mr158767027b3.30.1768925546925; Tue, 20 Jan 2026
 08:12:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJK_ieh7GpnMBe-J3ktiU4EmE2puqafgx4pmEBoJsbqKz9LEEA@mail.gmail.com>
 <c3a11b9b-5cd1-4a0c-b15c-d86a5f0d3924@efficios.com>
 <CAJK_ieg60p6=3sdLSQGoPPEYGx8J=VdFS5vHx-=0APvpnOUmuw@mail.gmail.com>
In-Reply-To: <CAJK_ieg60p6=3sdLSQGoPPEYGx8J=VdFS5vHx-=0APvpnOUmuw@mail.gmail.com>
Date: Tue, 20 Jan 2026 16:12:15 +0000
X-Gm-Features: AZwV_Qg1jWfgTi0UUHIaNpdgUo9SsA_bR1jyfa8uE5OoOzB1d_07xtV-9Lx7ai0
Message-ID: <CAJK_iehfzujSUOUjh4WqWwP9-fndEDHaNXitmgKE80gUhbJ5cw@mail.gmail.com>
Subject: Re: How to build lttng on RHEL 9?
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org
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
From: David Aldrich via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: David Aldrich <david.aldrich.ntml@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Kienan

I have updated to the latest kernel version for RHEL 9.6, which is:

5.14.0-611.24.1.el9_7.x86_64

AI suggests 'RHEL 9.7 backported into its 5.14.z stream: dev_base_lock
was removed from the networking core' which I guess causes the
problem?

Is it possible to provide a fix for this?

Best regards
David

On Mon, Jan 19, 2026 at 5:14=E2=80=AFPM David Aldrich
<david.aldrich.ntml@gmail.com> wrote:
>
> Hi Kienan
>
> > What's the exact version number of the kernel you're trying to build fo=
r?
>
> Thanks for your reply. Our kernel version is:
>
> $ uname -r
> 5.14.0-570.60.1.el9_6.x86_64
>
> David
