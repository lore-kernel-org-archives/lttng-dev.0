Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [158.69.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501C8F4181F
	for <lttng-dev@archiver.kernel.org>; Mon,  9 Mar 2026 17:10:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV3Rc1WSQz1ZRM
ARC-Seal: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256; cv=none; t=1773076222;
	b=T1xiiAqKXu90MMvNmXnqjuKQftIIgqGe/xeU5hsDvv5Ja01YQ0ULQcIJUsGwrDWW/7SN
	 aIB38vuHV2BJ7UKIxSCxvYz68yEeViFa+au0xg78kHoapSRhUtYNUfP4ovmDSnwK0Nkol
	 MfpOz+IVsc37eaLhXeioBYDz8BiMDja+j+SMmsVYesg58yZf6UlnWo73wpU5rGVRqO2mK
	 SAdhjcVFO6lIKPvDyB9AjGq5r84ezD6xYEJ6/rCq4mx05sSOYI2yr0LwAOmp6GY7/nBme
	 6Nfv8MRLKOwVgayLf+zalDPcaUC2Ww4am/F3o/cYo7fTozIdOBnens4Mks8hFeKyfOg==
ARC-Message-Signature: i=1; d=lists.lttng.org; s=arc1; a=rsa-sha256;
	c=relaxed/simple; t=1773076222;
	h=DKIM-Signature:Date:To:Subject:Message-ID:MIME-Version:From:From;
	bh=EUsve3+iBahDPvQCNSwPfR3R5f03tCHXogkdeCcNqO4=;
	b=H3k0+Ysd6TvJ/Taj7Dbpgq1iuxcSvY/3TxBKas3FyutEUl40cBT62yroBm9/MbCnxDgn
	 yLtZ9Y67zSSE62gqpn6SrkynLztWP9EgSlFzPYkt1RxvTFINhbn4GbAt5F1eRQhOnAkT+
	 daoVMfxtEeAqG1lj6JFMKPsDggseEnlQX+QMJnFqGccm0DOMsiuszMbvNmRGWoEEu5zyc
	 JCcMKZ3u1No5zJtMEUhpaI85in1UVq3p67qNEDWDGDfw/8xrpk4I2cFnPBVV5iEarTK6f
	 XQ9nchUAStulgP+5aAfDAjEvk3CD5kV5zXP2XziBpWTbMXg3aV87w2C1czFJDrWpRIA==
ARC-Authentication-Results: i=1; lists.lttng.org; arc=none smtp.remote-ip="::1"
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV3Rc1WSQz1ZRM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.lttng.org;
	s=default; t=1773076222;
	bh=EUsve3+iBahDPvQCNSwPfR3R5f03tCHXogkdeCcNqO4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=0u17Of7Oul0FskZFW2UJdGL2a49bqmHOuRFJJEbrN1HthKd53qcadabct9biEBjv7
	 r8f6Gy5U9jhR/AVZH+ABTNrgykG3N7WrV0CW9Wf0t85Q4+P2M3Tp5r6Qwvv/swsENm
	 1HPnuKA5FnCk4xvBPQDvtjtQuUSG2u6fI2ab9vlm8POGRW92J92zk5aLLxctDtpKht
	 R+hexfP59SFQIlpPcMk6EgDxmcVb8EvT7loIiVeh7cjWp2/mL6CFM9YriSxM/yKB+5
	 mDI4QaFofVGqK1kOgSTUU7m/wa8SAlG7u5i23IdlJB8X7J96mIVyFzW2nQAQwwnCoz
	 lbbTo/QUmxj0g==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4fV3Rc1WSQz1ZRM;
	Mon,  9 Mar 2026 13:10:20 -0400 (EDT)
ARC-Filter: OpenARC Filter v1.2.1 lists.lttng.org 4fV3RZ110zz1ZRL
DKIM-Filter: OpenDKIM Filter v2.11.0 lists.lttng.org 4fV3RZ110zz1ZRL
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by lists.lttng.org (Postfix) with ESMTPS id 4fV3RZ110zz1ZRL
 for <lttng-dev@lists.lttng.org>; Mon,  9 Mar 2026 13:10:17 -0400 (EDT)
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <sanvila@debian.org>)
 id 1vze7N-002N2F-VW
 for lttng-dev@lists.lttng.org; Mon, 09 Mar 2026 17:10:10 +0000
Date: Mon, 9 Mar 2026 18:10:08 +0100
To: lttng-dev@lists.lttng.org
Subject: Build-time tests fail if machine has a single CPU
Message-ID: <aa7-8LHGez9Bi0UQ@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Debian-User: sanvila
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
From: Santiago Vila via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Santiago Vila <sanvila@debian.org>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello.

When I try to build (the Debian package of) lttng-tools (which in
Debian is called ltt-control for the source package name) on AWS
instances of type m7a.medium or r7a.medium (which incidentally have a
single vCPU) I get the following error while running the tests:

make[7]: Entering directory '/<<PKGBUILDDIR>>/tests/regression'
FAIL: tools/lttng-ctl/test_robust_protocol.py 1 - test_simple - Exception: ('enable-channel --session session_lrmmg1mr --userspace channel_qmx5kx61 --buffer-allocation=per-cpu --buffer-ownership=user', '<?xml version="1.0" encoding="UTF-8"?>\n<command xmlns="https://lttng.org/xml/ns/lttng-mi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://lttng.org/xml/ns/lttng-mi https://lttng.org/xml/schemas/lttng-mi/4/lttng-mi-4.2.xsd" schemaVersion="4.2"><name>enable-channel</name><output><channels/><success>false</success></output></command>\n', "Error: Exception when getting CPU count: Failed to parse possible CPU mask: mask_contents=`0\n`\nError: Not enough system memory available for channel 'channel_qmx5kx61'. At least 0MiB required, 0MiB available\n")
ERROR: tools/lttng-ctl/test_robust_protocol.py - exited with status 1
ERROR: ust/test_no_event_timestamps.py - Bail out! Missing 1 test cases
PASS: ust/ust-constructor/test_ust_constructor_cpp_static.py 1 - Create a session
FAIL: ust/ust-constructor/test_ust_constructor_cpp_static.py 2 - Add a channel to session `session_dx6uww4i`
ERROR: ust/ust-constructor/test_ust_constructor_cpp_static.py - Bail out! Missing 42 test cases
PASS: ust/ust-constructor/test_ust_constructor_cpp_dynamic.py 1 - Create a session
FAIL: ust/ust-constructor/test_ust_constructor_cpp_dynamic.py 2 - Add a channel to session `session_nwjtsjz6`
ERROR: ust/ust-constructor/test_ust_constructor_cpp_dynamic.py - Bail out! Missing 42 test cases
PASS: ust/ust-constructor/test_ust_constructor_c_static.py 1 - Create a session
FAIL: ust/ust-constructor/test_ust_constructor_c_static.py 2 - Add a channel to session `session_xwec7bzr`
ERROR: ust/ust-constructor/test_ust_constructor_c_static.py - Bail out! Missing 22 test cases
ERROR: ust/high-throughput/test_high_throughput_snapshot.py - Bail out! Missing 3 test cases
SKIP: ust/high-throughput/test_high_throughput.py 1 # SKIP : Long regression tests not enabled
ERROR: tools/client/test_reclaim_memory.py - Bail out! Missing 2 test cases
PASS: tests.serial 1 - Test script 'tools/base-path/test_ust' returned code 0. 42 passed, 0 failed, 0 skipped, 42 planned [total: 42]
FAIL: tests.serial 2 - Test script 'tools/channel/test_channel' returned code 1. 15 passed, 1 failed, 0 skipped, 16 planned [total: 16]
FAIL: tests.serial 3 - Test script 'tools/channel/test_cli_legacy_channel_buffering_policies.py' returned code 1. 0 passed, 0 failed, 0 skipped, 6 planned [total: 0]


Note 1: the message saying "Not enough system memory available" is
probably false, as the machine has 4GB or 8GB of RAM, and I don't get
those messages when using the same amount of memory with 2 CPUs.

Note 2: One way to reproduce this easily on any machine is to configure
GRUB with GRUB_CMDLINE_LINUX="nr_cpus=1".

Thanks.
