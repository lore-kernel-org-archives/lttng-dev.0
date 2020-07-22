Return-Path: <SRS0=tnGF=BB=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF05C433E6
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:53 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9A720717
	for <lttng-dev@archiver.kernel.org>; Wed, 22 Jul 2020 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="pjX06ZFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9A720717
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4BBbb723VLz1djW;
	Wed, 22 Jul 2020 09:16:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1595423811;
	bh=9pV+FTgfnUcMRPrWzALNsQNXTXCt1VsPbRHptodlFKI=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=pjX06ZFWas6hk+myd9BwcSxFJWHQOBqjysULZsnUvwP8yIeGU+rInV58pLjnsyCNe
	 UQXHlsxdiIunnYuv2IbmJOqsGlJqB51VQpK0kjPOFB3EA1wCCFDO5MsxE+AILbxl+W
	 7yi/K0cBwYe71IJ296ikcnWdiyRUfe8YCEA/YK3+QwcjTsEXtoi7mme9oWfguO5cR/
	 CPc+3ePd/fuOFyMa3nFvQ1x4dH4yEoRTzqVBtfmoXIsSomsWog3o6NA9YPY6oyP6QS
	 N+ePFfv2ZfeYTnB3iFRJxnlZJX1A9qFOUI1s906klflH3Bycv8UxE043t6/qJJRo3n
	 JwJJ6oIH3m0Jg==
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.5])
 by lists.lttng.org (Postfix) with ESMTP id 4BBR096l1Mz1dt5
 for <lttng-dev@lists.lttng.org>; Wed, 22 Jul 2020 02:49:29 -0400 (EDT)
Received: from [100.112.128.231] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-5.bemta.az-a.us-west-2.aws.symcld.net id CB/95-15041-BFCD71F5;
 Wed, 22 Jul 2020 06:30:19 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRWlGSWpSXmKPExsVyqPAOq+7vO+L
 xBkf/cFt0XO9hdmD0eL/gD3MAYxRrZl5SfkUCa8bifVPYCiZpVKza8JC5gfG0YhcjF4eQwBZG
 iY+flzPDOY8OnGPvYuQEcg4ySnSeEgKx2QR0JV49eMoMYosIWEtcW3QPzBYWcJM4c/oDVNxb4
 vK1V1C2nsSJ+zPAbBYBVYnHc/eB2bwC7hJbP/5gBLEZBcQkvp9awwRiMwuIS9x6Mh/MlhAQkF
 iy5zwzhC0q8fLxP1YI20Bi69J9LBC2nMSy7c+henUkFuz+xAZha0ssW/gaapegxMmZT1ggflG
 WmLXiC9sERpFZSNbNQtI+C0n7LCTtCxhZVjFaJBVlpmeU5CZm5ugaGhjoGhoa6RoaG+oaGZrp
 JVbpJuqVFuuWpxaX6BrpJZYX6xVX5ibnpOjlpZZsYgRGTkpB840djLPefNA7xCjJwaQkyst9U
 jxeiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTv89tAOcGi1PTUirTMHGAUw6QlOHiURHi1gJEsxF
 tckJhbnJkOkTrFaM8x4eXcRcwcO4/OA5IHwWTznSWLmIVY8vLzUqXEeZVA2gRA2jJK8+CGwpL
 OJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvDwgU3gy80rgdr8COosJ6Czlu6IgZ5UkIqSk
 GpjOdC5x+nScYd/MGwK7i/uy5qWvdHk4oyfpeeHEDqWC7VrXgzLDrdJK592dl+5+aN69f7Ndn
 Br+cxk6Xc+/HWO7nClp8nv/54KLbncHJrDHl0QltGjmHHVnvPtuNpteeP0RW2aZBzILKvn95s
 0//cU+Ooq7p9367Sf/Lyl+5n88Qy4G+dVm9n/6t77p7rGOx8sLZ/NF/E9fuetmk+V+0ZKs19J
 y96xK3wXwh0vIZ57uyZE6Js2/RD/GoXd70eqvoo4R/Z+nh65Vm7GmWKKL+1jWmUbhoPtTWOdN
 7k6vm7X1ss1EzgvfuIumN2nfc5i8+FEiV90qvumW9cyt9zu/yaRaP/vd4Wz5oeXmLZMp8Uosx
 RmJhlrMRcWJAI5AFXa1AwAA
X-Env-Sender: Seongab.Kim@harman.com
X-Msg-Ref: server-15.tower-322.messagelabs.com!1595399412!49128!4
X-Originating-IP: [194.113.220.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11733 invoked from network); 22 Jul 2020 06:30:18 -0000
Received: from unknown (HELO HIMDWSMB09.ad.harman.com) (194.113.220.5)
 by server-15.tower-322.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted
 SMTP; 22 Jul 2020 06:30:18 -0000
Received: from HIMDWSMB02.ad.harman.com (10.70.50.112) by
 HIMDWSMB09.ad.harman.com (10.70.50.214) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 08:30:14 +0200
Received: from HIMDWSMB06.ad.harman.com (10.70.50.116) by
 HIMDWSMB02.ad.harman.com (10.70.50.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 08:30:14 +0200
Received: from HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452]) by
 HIMDWSMB06.ad.harman.com ([fe80::2dc6:6a23:2959:1452%16]) with mapi id
 15.00.1497.000; Wed, 22 Jul 2020 08:30:14 +0200
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Thread-Topic: difference of timestamp between babeltrace and python binding
Thread-Index: AdZf72o/s/LXsJAhT1adO+MrPIV8+Q==
Date: Wed, 22 Jul 2020 06:30:14 +0000
Message-ID: <15ed8d31ec16483db50928860aa4a4e5@HIMDWSMB06.ad.harman.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.70.50.4]
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Jul 2020 09:16:49 -0400
Subject: [lttng-dev] difference of timestamp between babeltrace and python
 binding
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.31
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200722063014.2nX6RkRyNQTZNg1tTuQ1KlaoBj9OGl6hOPETkICPSKg@z>

Hi,

I found that the timestamps from babeltrace and python binding are different in nanoseconds level.

skim@d54030999178:~/ssd_work/traces$ python3 test.py ./trace/ | head -n 10
2019-12-12 13:45:40.098212096 (+0.000000 s): syscall_exit_ppoll
2019-12-12 13:45:40.098213608 (+0.000001 s): rcu_utilization
2019-12-12 13:45:40.098214632 (+0.000001 s): syscall_entry_ioctl
2019-12-12 13:45:40.098214888 (+0.000000 s): kmem_kfree
2019-12-12 13:45:40.098214144 (+0.000000 s): rcu_utilization
2019-12-12 13:45:40.098215168 (+0.000001 s): sched_stat_runtime
2019-12-12 13:45:40.098220776 (+0.000004 s): sched_switch
2019-12-12 13:45:40.098221312 (+0.000002 s): timer_hrtimer_cancel
2019-12-12 13:45:40.098221312 (+0.000000 s): kmem_kmalloc
2019-12-12 13:45:40.098223360 (+0.000002 s): kmem_kfree
Traceback (most recent call last):
  File "test.py", line 33, in <module>
    print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))
BrokenPipeError: [Errno 32] Broken pipe
skim@d54030999178:~/ssd_work/traces$ babeltrace2 ./trace/ | head -n 10
[13:45:40.098211969] (+?.?????????) test-sys syscall_exit_ppoll: { cpu_id = 3 }, { ret = 0, nfds = 1, fds_length = 0, overflow = 0, fds =[ ] }
[13:45:40.098212481] (+0.000000512) test-sys rcu_utilization: { cpu_id = 5 }, { s = "Start context switch" }
[13:45:40.098213729] (+0.000001248) test-sys syscall_entry_ioctl: { cpu_id = 2 }, { fd = 24, cmd = 1075331408, arg = 547894601712 }
[13:45:40.098213953] (+0.000000224) test-sys kmem_kfree: { cpu_id = 3 }, { call_site = 0xFFFFFF800153B274, ptr = 0x0 }
[13:45:40.098214017] (+0.000000064) test-sys rcu_utilization: { cpu_id = 5 }, { s = "End context switch" }
[13:45:40.098215201] (+0.000001184) test-sys sched_stat_runtime: { cpu_id = 5 }, { comm = "Positioning", tid = 1056, runtime = 38048, vruntime = 2125241692 }
[13:45:40.098219681] (+0.000004480) test-sys sched_switch: { cpu_id = 5 }, { prev_comm = "Positioning", prev_tid = 1056, prev_prio = 15, prev_state = 1, next_comm = "Sensor", next_tid = 1061, next_prio = 15 }
[13:45:40.098221313] (+0.000001632) test-sys timer_hrtimer_cancel: { cpu_id = 5 }, { hrtimer = 0xFFFFFFC257807CD8 }
[13:45:40.098221409] (+0.000000096) test-sys kmem_kmalloc: { cpu_id = 0 }, { call_site = 0xFFFFFF80014A27EC, ptr = 0xFFFFFFC04EDFA400, bytes_req = 739, bytes_alloc = 1024, gfp_flags = 37748928 }
[13:45:40.098223361] (+0.000001952) test-sys kmem_kfree: { cpu_id = 5 }, { call_site = 0xFFFFFF8008164C58, ptr = 0x0 }

The difference is not consistent and Trace Compass shows the same timestamp with the babeltrace output, so I think something is wrong in my python code.
I just modified the example script from https://babeltrace.org/docs/v2.0/python/bt2/examples.html#get-an-event-s-time to show nanoseconds as below.

diff:

32,33c32,33
<         fmt = '{} (+{:.6f} s): {}'
<         print(fmt.format(dt, diff_s, msg.event.name))
---
>         fmt = '{}{:03.0f} (+{:.6f} s): {}'
>         print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))

Full code:

import bt2
import sys
import datetime

# Create a trace collection message iterator from the first command-line
# argument.
msg_it = bt2.TraceCollectionMessageIterator(sys.argv[1])

# Last event's time (ns from origin).
last_event_ns_from_origin = None

# Iterate the trace messages.
for msg in msg_it:
    # `bt2._EventMessageConst` is the Python type of an event message.
    if type(msg) is bt2._EventMessageConst:
        # Get event message's default clock snapshot's ns from origin
        # value.
        ns_from_origin = msg.default_clock_snapshot.ns_from_origin

        # Compute the time difference since the last event message.
        diff_s = 0

        if last_event_ns_from_origin is not None:
            diff_s = (ns_from_origin - last_event_ns_from_origin) / 1e9

        # Create a `datetime.datetime` object from `ns_from_origin` for
        # presentation. Note that such an object is less accurate than
        # `ns_from_origin` as it holds microseconds, not nanoseconds.
        dt = datetime.datetime.fromtimestamp(ns_from_origin / 1e9)

        # Print line.
        fmt = '{}{:03.0f} (+{:.6f} s): {}'
        print(fmt.format(dt, ns_from_origin % 1e3, diff_s, msg.event.name))

        # Update last event's time.
        last_event_ns_from_origin = ns_from_origin
 
Could someone help what was wrong in the python code? Or is this a bug in ns_from_origin implementation?
I'm using below version.

skim@d54030999178:~/work/tmp$ babeltrace2 -V
Babeltrace 2.0.4 "Amqui"

Amqui (/_mkwi_/) is a town in eastern Qu_bec, Canada, at the base of the Gasp_ peninsula in Bas-Saint-Laurent. Located at the confluence
of the Humqui and Matap_dia Rivers, its proximity to woodlands makes it a great destination for outdoor activities such as camping, hiking,
and mountain biking.
skim@d54030999178:~/work/tmp$ apt list python3-bt2
Listing... Done
python3-bt2/bionic,now 2.0.x+stable+git4134+202007172102~ubuntu18.04.1 amd64 [installed]

Best regards,
Seongab Kim

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
