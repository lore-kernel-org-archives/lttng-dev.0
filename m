From: Carlo Caione <carlo.caione@gmail.com>
Subject: events injection / merging traces
Date: Wed, 3 Jul 2019 13:30:58 +0100
Message-ID: <ed6a7951-d2eb-71ff-be87-dcdb07be7881__10178.4172629536$1562157082$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by lists.lttng.org (Postfix) with ESMTPS id 45f0nz4RN0z18FW
 for <lttng-dev@lists.lttng.org>; Wed,  3 Jul 2019 08:31:03 -0400 (EDT)
Received: by mail-wm1-x333.google.com with SMTP id v19so2175864wmj.5
 for <lttng-dev@lists.lttng.org>; Wed, 03 Jul 2019 05:31:03 -0700 (PDT)
Received: from ?IPv6:2a00:23c4:f78c:d00:1570:f96d:dab8:76ae?
 ([2a00:23c4:f78c:d00:1570:f96d:dab8:76ae])
 by smtp.gmail.com with ESMTPSA id n14sm5414804wra.75.2019.07.03.05.30.58
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 05:30:58 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,
is there an easy way to "inject" new events in a LLTng trace? (you can 
also read that as: is there an easy way to merge two LLTng traces?).

I see that I can use [python] babeltrace.TraceCollection() + add_trace() 
to merge multiple traces, but it seems that I cannot output the 
resultant merged trace again as CTF.

Any hint how to do that if possible at all?

Thank you,

--
Carlo Caione
