Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA59C3ABC0
	for <lttng-dev@archiver.kernel.org>; Wed,  7 May 2025 21:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zt7DT0tvFz1ZTf
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1746652159;
	b=ImTj/vwKJYVWT7G1RG9XBw2hIJL56jf9MUrZ0l6KxJyqXzVAg+OOjIlQxGXejS40Umj4
	 zyxxsfZaU0gnegk6qXwB7an+tnpoowbzbrNGO2y/dc4natww7TGnm5J2Gp4Y55CYx92lX
	 +CJaLSRsdQNsK+oVLNDM/iQZO4IuxhuuGLUjmIRFiBUXUu0JbJKo+8L5OVf/EP4TqBo22
	 e7Wz80mg7eZM+05O6loeZeX4hrWp4e8rr7mk7sMFOScz00oNXTzy4xHJeTNK3R0pyYExo
	 RrOpme/KFacPOKHjxw84FrU5XGd+ABXqvTubRTULPe7l2PEKs71xtPibscNv4kHuG8w==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1746652159;
	h=DKIM-Signature:MIME-Version:Date:Message-ID:Subject:To:From:From;
	bh=a27u96cx+ra7U9wwGurcBSuWMM+pXX2NCa95fGW2kJ0=;
	b=SMg2OAw4krJNb6kGTKVP0HUgS33uZj7yRygab6k/86amMMwOo0OmmTSM+KVse9T4tH99
	 J6W9OkyObSqM+qgotr+ZdGMV8lEXtdCCm9mxc8XMaC8cBRwjM3u4ABd3AoLj7Zp2ieC0g
	 XfjzBMhLH5q/CZYPfqYn+0Yvs/PrCvup+R0QHSmDcvEslAJBbZRPb9tjAdsQT3XlHDWrD
	 ZKtWrkMK2vPGi5nT7j0gpxIcLLJEKtTvxOHrTRsR0brXEYcT3efgXUoQJzpIbn4usulCk
	 jJ841qsSsSeOKlgQjSJdxUpo9vsle0ij99K5Aj9vPVmtzD4SIiuL2j80ew/YuXyhsaw==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zt7DT0tvFz1ZTf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1746652159;
	bh=a27u96cx+ra7U9wwGurcBSuWMM+pXX2NCa95fGW2kJ0=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=APY1e+9pEkU1d8yy9lFqy/kVZlN6Zh5FRXB+0sqVNFJLBLEujYxmIMUAbAn5+v0I9
	 IpB5nA1TdKXIkn0YsJ8T+JGjyfjI7gCrWE5evTrTFi46tTGG/HJrjjxh+h0Ds/GQ4+
	 sU4wOC0iBfL4d/KEv+8HuWTN6hAeHCyuUR9P/BWmPa9suRsbV+yYp4zbjaOM7zaua+
	 9QwK0tAFnbWNDuy9QuO/6ckLlxlMtcjWcEVrT2bSY1J3R7Nk/SO+0s+TDX6FjDhmma
	 QV0t3TIotnescuEtETSlehJVVJU/0HUR3Kt3waV7nsKYHhA1TWMlai9hiiel1G9Kh4
	 5AvXApjoVq7Fw==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Zt7DT0tvFz1ZTf;
	Wed,  7 May 2025 17:09:13 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4Zt1VF3V1Xz1X02
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4Zt1VF3V1Xz1X02
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by lists.lttng.org (Postfix) with ESMTPS id 4Zt1VF3V1Xz1X02
 for <lttng-dev@lists.lttng.org>; Wed,  7 May 2025 12:50:45 -0400 (EDT)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-708b31650ffso732507b3.0
 for <lttng-dev@lists.lttng.org>; Wed, 07 May 2025 09:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746636644; x=1747241444;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SeJiC7QOryHDDOeGr6T5HKxXi32WwSmBknvQ2uk7/pE=;
 b=b6VqIEhKfWxRLSDq1wn2beI/zECTvyO3AezACSz/yuN8Ps8nr/p5AhZMm4q71A8kMo
 BarUvEbvjLbL2rYacSxtilQT3PAodyNtFMMg0Vhise87c13eFufDOGBPiax2M6spZiKt
 oGkO4+VfmHrlcJvI9hwDNEcN+jAhppRZrcyxClUROSEiXZ82bcc0xfE7Ri1ZoSezVbUe
 wA82SHq/NMt+NpxNzS9/Aobht1ioqEUH/IFCATUKZUOHLwD0BuZJNmMhO8uPPjOhS+mg
 5G5IrW7yh3BB0+RTlP6kv1KBexEL6GbG1Lkv34QZj18JqpL1HDcX8mNpLg3u9xXitrHb
 qycA==
X-Gm-Message-State: AOJu0YzuJ0iCG2yUGqlfZuSnfO4nstXAUPrzggZWaZ6nH568cGN/FQMr
 rVuRRFcY6RQXuesRZF+9PgvGPu8bRlj+x8aZc4RGDfUqY5iCx/WK/gjn31u/l6sju6LL1DonRdI
 oENUag+XpYvxeih9kCUhfzzfEiXHbC/8Q
X-Gm-Gg: ASbGncuMhujxFYpsMVr7wx8Se2fP6ukf2npjnI+Xs8CwLvPjpOKat5OxjQrqRLwwZqe
 LaKoh/0FVhYt2y8AzX+hqA3yRax2zB67AS+kV1/S+W/gPsWIVrN+9aFQJv54L/DemYjE9pAxjj3
 Dz+vBaxV0QAuh5lgatMDud7jQ=
X-Google-Smtp-Source: AGHT+IGVPM0E/1uso3w7pWItVKXT9KSdyJNXrKyQ9ZLeyC7AbkoiRnF8ieMhspIbSf2O2eD0iRdV9oTI2MsR8uAnO20=
X-Received: by 2002:a05:690c:6207:b0:702:627c:94ec with SMTP id
 00721157ae682-70a2d0f15d9mr1899647b3.35.1746636643748; Wed, 07 May 2025
 09:50:43 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 7 May 2025 17:50:33 +0100
X-Gm-Features: ATxdqUFiuKZQeTWJpeMTRUCGfQYXSr_kFSrw3qBdVQdGJDbfQ17gTd2Iamp9BzA
Message-ID: <CAJK_iejrz-U0-XK1hmoH9=TCLcErZTVE16XdyKzXX0buJuuoCQ@mail.gmail.com>
Subject: Not capturing ust events
To: lttng-dev@lists.lttng.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 May 2025 17:09:10 -0400
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

I am just getting started with LTTng. I am trying to use
lttng_ust_tracef() initially.

I am running LTTng version 2.13 on Ubuntu 24.04 LTS, and viewing using
TraceCompass 10.3.0 on Windows 11.

I use  lttng_ust_tracef() in just one source file:

#include <lttng/tracef.h>
<snip>
{
    int my_integer = 0;
    string my_string = "Normal";
    lttng_ust_tracef("TaskManager: %d (%s)", my_integer, my_string.c_str());
}

I build with CMake and link to the lttng-ust library:

target_link_libraries(${_lib_name} lttng-ust)

On the target I created a session and enabled the event:

$ lttng create my_proj
$ lttng enable-event --userspace 'lttng_ust_tracef:*'

I have to run the application as root:

sudo -E lttng-record-trace -a ./my_app

When I import the trace directory into TraceCompass I tick both the
kernel and ust event boxes, and create an experiment, but then only
'kernel' shows under the experiments and Traces in the tree view, no
ust branch is shown.

I guess this isn't much to go on, but if anyone has any ideas why it's
not capturing ust events, I would be grateful.

Finally, which 'event_type' should I search for in the event viewer
for lttng_ust_tracef events?

Best regards
David
