From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules and LTTng-UST 2.12.0-rc3 (International
 Stay At Home Month)
Date: Fri, 27 Mar 2020 11:02:40 -0400 (EDT)
Message-ID: <1562486575.14695.1585321360704.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lwn <lwn@lwn.net>
List-Id: lttng-dev@lists.lttng.org

Hi,

This release announcement of LTTng-modules 2.12.0-rc3 and LTTng-UST 2.12.0-rc3
comes at an interesting time, where the entire EfficiOS team bringing you this
release is working from home, following the physical distancing guidelines from
Quebec's government.

Those are likely the very last release candidates before we reach 2.12.0.
There has been very little issues on the tracer side recently, and open
issues which remained within LTTng tools are fixed in the 2.12-rc2 release.

The only bug fix [1] really worth mentioning here is a change to the way the
LTTng modules (kernel tracer) dumps the kernel file descriptor tables.
Because it adds/removes fields to LTTng events, it is only introduced within
LTTng-modules 2.12 and onwards, and not backported to prior LTTng versions.

The lttng_statedump_process_state event gains a new field "file_table_address"
to allow trace post-processing to distinguish between threads sharing the file
descriptor table (created with CLONE_FILES) and the relatively less common
scenario where they do not.

The lttng_statedump_file_descriptor event also gains a new "file_table_address"
field (which matches the addresses of the field with the same name in
lttng_statedump_process_state). The "pid" field is removed from the
lttng_statedump_file_descriptor event because it is semantically inaccurate.

Now that a large part of the world is sitting home trying not to get
infected and propagate COVID-19, you might as well use this time to
download and try the latest LTTng 2.12 release candidates.

Feedback is welcome!

Thanks, and please stay home,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

[1] https://bugs.lttng.org/issues/1245

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
