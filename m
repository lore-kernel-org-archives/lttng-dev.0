Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032ACC3ABC3
	for <lttng-dev@archiver.kernel.org>; Fri,  9 May 2025 16:11:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZvDWg68Lzz12XK
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1746807073;
	b=nug4xGGfheXJnkWQABrvebH9HBkMqq0bLDE7eNOGN6swr6MSro0C/iiFn1H5n56fBmBY
	 AEPtojvEKwmcQZ7a+2+HmYP/I+KEla0ZiiI0DeGqPMzH28Pvkx31eMeHrLP9NYyoyzC1N
	 P4FylJADP+nRsdYRJfW1y4PQEZZZ+SY1G9FtBkyeEXezOtufKCSVgUT/6JbMVoBuXJ41u
	 Cp3Y/eUo+6gRgApymL56CwvBvalsl/h04DEVqbd7qdk5ItELTyl1VpOCvqAMft0bhSGBV
	 kUbaMSttqfdWcLV64S/SkkoA/72aauvwJKk4yqjiezWGbvMrwEUGlVTXxMvI51P1QsQ==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746807073;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=pmFQaNjy1U4vOGh/OiNUsZJYrvMGjFcJnVLsw6X0PnE=;
	b=SsX2XWgyiPcEUk3E4ejgED2pZSnzxS5kYO4dSelT/tBLlL623BHwALrlEx/hRwtUI/TR
	 OSdZbCGnCNwUY1dpqTfOrIDIDlulE/fRJrDHjQ2jeBaSZQRyH9SldRVTrXQ/kYhkIkX3y
	 XdAMbe+DTuIR3gx8H7a/TwjhdTgTf84uFiyu6wTzaRI6gU8EDddvLTaJkVjbzNqZQvOxt
	 9Iy9KZsctZ4hJ0r5wrRkFgazQN41M71+Yov7qIETeCjH3207Kki02x/s8QxJrJAByn80c
	 Bmx1sXoGFC1LLKpf9F//juLUS0Cs7i8rKhS3tQQ8BuDHMH4gpdkZ/Pe3GWm/LkgNAHQ==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZvDWg68Lzz12XK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746807073;
	bh=pmFQaNjy1U4vOGh/OiNUsZJYrvMGjFcJnVLsw6X0PnE=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=T4COJ35EcZD5JgJ3j1D8Awg0IOoOKVguXWz3Leg6uIHJ/MPnpekmDN4l/wotIdl3Y
	 puc1eVNDXo2biUdfZojuUMRrDR0sOuxGHHLSZL9On/Z8yE3XPwnevGBACWD8JiHN25
	 RwZ/mqf84qQhIK3OKXJ6igcaDUjgDjXm56b9/S6pQgLw34tdPzRl9pbxgmz74dO9rl
	 KRxnC70Z8Tl6CKLF3q3473yStNacl8ZV473Z0g9levtpUn+KlACLnHl3Z2S9J7AFyi
	 74ymTh+uUPOV/IoJHI4ix7cNeJnyMhuJ+L3iDRfHGGz4tQEktYWSKAxcOAn3nx3EI+
	 gcKRbHuyJexdw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4ZvDWg68Lzz12XK;
	Fri,  9 May 2025 12:11:11 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4ZvDHL70fVz11yy
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4ZvDHL70fVz11yy
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by lists.lttng.org (Postfix) with ESMTPS id 4ZvDHL70fVz11yy
 for <lttng-dev@lists.lttng.org>; Fri,  9 May 2025 12:00:30 -0400 (EDT)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7082ad1355bso20582847b3.1
 for <lttng-dev@lists.lttng.org>; Fri, 09 May 2025 09:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746806429; x=1747411229;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmFQaNjy1U4vOGh/OiNUsZJYrvMGjFcJnVLsw6X0PnE=;
 b=iIM/PBSMuoL4r2w8CdzDZgzOZYjILQis6Gk22u/mHM5VBIHuj7MpYeOsfeBHZTs1Qz
 gILX+GDElpnGlwfyZ922fLVyc8uhcMMvGSjX0STfhvORLgTNrFqDa4JE1fTYnep+bAfh
 CCtK1Pl2avdgXyYaVl3y/jeSytwQIpSylA/yi2WCJeUAf+doAcjhbVl1jsWiR/7EeX+2
 g5uPWGf90or15kn02L/rPed7x7iSd1nfp0l0SmW2xO9yDcTABWLfV49UQ839z8J9sand
 tVF080/TbWSK1Doo58XVpFtNuCa8Qj3kFczQvadi+fDMvZhWF/+9SvlmjDFcPL52gv5E
 GDGA==
X-Gm-Message-State: AOJu0YxmT269v56SkqjVmZyE7mH7yFJldr7ug9jxYncYFjzyO8TXmKOc
 k6u4ZZRqh0PBrxG4CqKlV47oykZkIeL3lkr4+ZruSai40T03OmuXwL0hQxQx02wdeboXljGrb/7
 Cl1WxqicJyhn/9k4uIW8x0HQfka0v/w==
X-Gm-Gg: ASbGncsJ0n4iYRb2xlcJc7C/skG9RBuEOftoriShouy5gWls6rLx1Cb6alPMWe9hCo9
 KJVdwkxVURTQZTDB5x7wa/EzGsLihbO4zkCtqhBM+9jlzY8qA3NCvVmmSTrhs8YtKcmayRuVmly
 2WvHhtRSfAcbejnCR5DtTZEnw=
X-Google-Smtp-Source: AGHT+IF107Esa8Po/zjjPWD9D9tSJZvNK8ChNdEbQDSTmntAXZ0U230lst8POfamJurlIjSOHeW6K3RSBcc5w3T4Kb4=
X-Received: by 2002:a05:690c:6f09:b0:708:7b42:7b98 with SMTP id
 00721157ae682-70a3fa1f1cfmr53149397b3.9.1746806429281; Fri, 09 May 2025
 09:00:29 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 9 May 2025 17:00:17 +0100
X-Gm-Features: AX0GCFs2qvXEm2I1fz6hUQ4wIpnEmwztq1SjP4_ZJhOyxh3mHqiJiH4kkkWk4KU
Message-ID: <CAJK_iegCiWpZcD8fyLCpkRtzOzv_nxyn8WBUs9gr5WDYQ1sK_w@mail.gmail.com>
Subject: Understanding SOFT IRQ 1
To: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 09 May 2025 12:11:09 -0400
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

Hi

I am just getting started with LTTng and Trace Compass. I can capture
Kernel and UST events.

My purpose is to investigate why a periodic task, running on an
isolated core, has occasional blips i.e. it's period (duration)
extends.

I have inserted tracepoints to mark normal and extended durations. In
Trace Compass the blip tracepoint is preceded by a brown state that is
'SOFT IRQ 1'. This extends down all cores. It lasts 105us and is
likely to be the reason for the blip.

Please could someone explain to me what may be happening here and how
can I find out the reason for this SOFT IRQ?

Best regards
David
