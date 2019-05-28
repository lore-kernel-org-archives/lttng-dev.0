From: Carlo Caione <carlo.caione@gmail.com>
Subject: babeltrace python binding and multiple streams with out
 of order samples
Date: Tue, 28 May 2019 14:11:22 +0100
Message-ID: <ee93b1b8-6e02-d40a-067a-99ab88b2cadf__17085.395408661$1559049109$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by lists.lttng.org (Postfix) with ESMTPS id 45CvPB2Lgrz128t
 for <lttng-dev@lists.lttng.org>; Tue, 28 May 2019 09:11:25 -0400 (EDT)
Received: by mail-wr1-x430.google.com with SMTP id m3so20185099wrv.2
 for <lttng-dev@lists.lttng.org>; Tue, 28 May 2019 06:11:25 -0700 (PDT)
Received: from ?IPv6:2a00:23c4:f78c:d00:1570:f96d:dab8:76ae?
 ([2a00:23c4:f78c:d00:1570:f96d:dab8:76ae])
 by smtp.gmail.com with ESMTPSA id j82sm2889542wmj.40.2019.05.28.06.11.23
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 May 2019 06:11:23 -0700 (PDT)
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
I'm using the babeltrace python bindings (v1.5.x) to convert some raw 
data I have into a CTF file.

This raw data is organized in fixed data chunks composed by serializing 
the events for each CPU:

[cpu0, cpu0, cpu0, ..., cpu1, cpu1, cpu1, ..., cpu2,... ]

Each event for each CPU has a timestamp that is monotonic within each 
CPU set.

I wanted to create one stream per CPU and since the events are the same 
for each CPU, I was using a single stream_class linked to a stream 
object for each CPU. Something in the structure similar to [0] with:

stream_cpu0 = writer.create_stream(stream_class)
stream_cpu1 = writer.create_stream(stream_class)
stream_cpu2 = writer.create_stream(stream_class)
...

The problem is that being the clock one for the stream_class when 
feeding the events to the library I get a:

ValueError: Invalid time value

When the first event on cpu1 is parsed, because the timestamp is in the 
past with respect to the timestamp of the latest event of the cpu0.

I can sort the events before feeding them to babeltrace but this seems 
sub-optimal to me. My question is: am I using the library correctly or 
there is any way to achieve this?

Thank you,

[0] https://lists.lttng.org/pipermail/lttng-dev/2015-November/025231.html

--
Carlo Caione
