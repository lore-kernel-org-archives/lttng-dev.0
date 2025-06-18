Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9153C71157
	for <lttng-dev@archiver.kernel.org>; Wed, 18 Jun 2025 15:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMnY56V9hz2GBY
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1750260156;
	b=OoPiOGatjUtz8u9eom5ZzTCOCSXNiECW6hUxBbUT0QYONM5G0K0WPxZ11GwOR8jfleLu
	 bRlnf1Wpsvu8RWbA9dJ+eWi17NE4L3WGZ/Chgqd7V0MecA3HOpwzfGAtSE0l+ARTVXeyq
	 uTy1m8JszGog4UKDso/kZFYGf8UMvg34qf7TiUhaZlBc1RQGPj+jECdycor2o0NzULILy
	 w8dTSSGOg8HPVYPxaS3s0XADtYDGCcNAj5N1tS4jBzih85o5Y2ZgECIf6UTeiDrtZoIn0
	 wdkh2x3mhIFPpkxS3+qEO90J2ody8pKsqkVCKkfvVjVBo85UQo/Nryb7SeBw1z1TchA==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1750260156;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=NjVZFGkNRWFWNf4crq9XKZFITwPvwVoDSVXOFvSyGZs=;
	b=QKCNKCMquCtFLuvuyCa8LZ+ctS07R0miMtmRO0XlB59j5QgIoHQw3xX7Y6xredCWx+Jc
	 Ikn2nRWrXXpNuon93tiG36g4MKazaqRQ1qzWF/4CVsMhUOMZ/sEZmwRohJetES3NZEf6C
	 MtxgH9PDC3Uty9CZdQOK4w9x3uV0jKH/bc3mk2Wah4XvvA1LJ31BrdxO1I5v+wUuNYajK
	 7wEDvapigjCB6dfVxboVlo19C/isI9qMI8iqp6ywlnhUctek0DRhQdHURePIwrUCsLmgW
	 7X9KBkgXYaHNQubKOtfsdWVy2reyNbY7+p/2zGTTHcRxuCTXQkBEcX1WIGCJ4XvbJyg==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMnY56V9hz2GBY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1750260156;
	bh=NjVZFGkNRWFWNf4crq9XKZFITwPvwVoDSVXOFvSyGZs=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=tJIGlisX/Syush5Jks1gHzaY+GHF4i4jlZ+aXSQFfdDl8ocSNMTncGAKiVL5aSlp/
	 f5XnO02ZQ/zBjF3XS48WWSflJIcSMsHrQ9aaER5HxlMzJ33AU+I40cWZjbxBXAnl1Y
	 IxqI7F8EGpEX9soFkDSEKgZqU7cOdq6lzhwkR1VbfaVsdXkDmlO9Skec1FUdxKOoo6
	 e1cu5/d/H+bbEKIgIY6rCcRZwB2dnI0o1198xSIRrINEikuD3bGusUH3Z5qPjNPuI0
	 UaFqdP0Ve3cf5Qd0H/mAV39xTNm2v6pn7SOTJmFcXXxHDk6tprD7fK915SYIp/p1YL
	 23aL6gX/S+w5A==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4bMnY56V9hz2GBY;
	Wed, 18 Jun 2025 11:22:33 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4bMnY36cDPz2G7m
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4bMnY36cDPz2G7m
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by lists.lttng.org (Postfix) with ESMTPS id 4bMnY36cDPz2G7m
 for <lttng-dev@lists.lttng.org>; Wed, 18 Jun 2025 11:22:31 -0400 (EDT)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-32b7cf56cacso7774721fa.1
 for <lttng-dev@lists.lttng.org>; Wed, 18 Jun 2025 08:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750260149; x=1750864949;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NjVZFGkNRWFWNf4crq9XKZFITwPvwVoDSVXOFvSyGZs=;
 b=RwqLdYgrh9CfDk3OGqhR2Njlao5+ZKDIW4Ly9010p/Xxo90ZFyxPbzA+XiyQUQeggB
 84S6SKaSDKyvXHfGtBMS8rJnuSdJrBJGrwPLgi89C3RQzI3Qvb6HqIktMQBUPVV1toZm
 5WtcNHSN9mEnFu52BWsGybqz6io/+LjwaOUlVadP1aKLuYqTgWOFvw7HLApL7wzolFx1
 qrfhGTL0Ba46xCcra2h6dtHFmnFpdnaO+wEBXhoe/xWcsHnfjAlO9sIyRxKoJbBLc5xI
 mXXIjslWB17dlRN4svBDhGJGXyBzsl6+A8IgaJMJ3X14vrE21sxIONUWYNzNewrGyleV
 JE1g==
X-Gm-Message-State: AOJu0YyvMCVO8qUKNI8i0IF96pX55gn6/J2Lx9ss8HXHJCldHg41SE3S
 doCDUzeLRH6jzjN6k4R6IvC8yo5QdNgPKEkS/o3ves+fufS+9VVZggyclKZrUdwNBkpXUaiDxEc
 n93WUmLAOYQOsGImEOZTPIHjNivS2qKJVkgC1
X-Gm-Gg: ASbGncvCxRmbiAKJ6WfRtXl3YJGDjIDkyqIFvHndFrx6gQ0X/DzbXwRKbVFfVDK1rJ8
 Fv2YsVCL+i9Piq73754lOUE38x/edI6ajt4WOzaTRLcPr0gmQuHOIfU1ybhyHLYWuO36hW2n+7l
 rQaBeIoRh/TslX/ljQ1zK0Ga/+z4S7tsQ11ryKISzuzkg=
X-Google-Smtp-Source: AGHT+IFlapxdMQBLrUfNexfxXqYFa+OEqWDKhlO1WRr/TNBobkT7lnTLcYSYcQ1yYg8Bd8/UVVlpM/02xdbZgti/ngM=
X-Received: by 2002:a05:651c:504:b0:30b:ecfc:78bf with SMTP id
 38308e7fff4ca-32b4a300321mr45927851fa.5.1750260148440; Wed, 18 Jun 2025
 08:22:28 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 18 Jun 2025 17:22:16 +0200
X-Gm-Features: AX0GCFvN9fB3LFl8FLvNVkc30bOrSyLdAASA4a3I0uEMi8dcKcSSQvK3m90QTDY
Message-ID: <CADYdroMBu0gocZXpeaMWqr3TG4p5FW71eeN1+y-XM_8bDxijzw@mail.gmail.com>
Subject: Method to get LTTNG-UST version during runtime?
To: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: text/plain; charset="UTF-8"
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
From: Norbert Lange via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Norbert Lange <nolange79@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

there are some substantial changes in 2.14.0 that afffect how/if
tracing is possible.
For ex. c246521ddcba1d1d28cfa0482aa500b9122e7264 allows doing more work upfront
by calling lttng_ust_init_thread().
With 2.13.x the same code will instead do various syscalls or
allocations during the first tracepoints, violating realtime
constraints and possible abort the process.

I miss an easy method to inspect the Lttng UST Version for checks or
workarounds.

There is the lttng_ust_loaded variable that could be abused to carry
an packed version instead of 1. (Of course that could always cause
fallout)

Regards, Norbert
