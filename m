Return-Path: <SRS0=nP6W=AE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5740C433DF
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 14:42:00 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D88A20720
	for <lttng-dev@archiver.kernel.org>; Tue, 23 Jun 2020 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.lttng.org header.i=@lists.lttng.org header.b="YjuKaf0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D88A20720
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 49rprk40Gtz130k;
	Tue, 23 Jun 2020 10:41:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1592923319;
	bh=fqJ/94rkWvpT0pm0xPD4ZK8Cn/iOvsQfP0B0becDtWo=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=YjuKaf0qZiafWcyN+YkEla/VgCraxyl5AFAtCdYzeLxnmfp1eAIKBSbED7IIv1Pmg
	 NU4j1afyh3+NSdRtuC7xjQ6XXBoi7AEVOj8qgawlxHL8HG3XMqwLtp44En09Bn/7EL
	 7caTKRSCkyg6aiZg3Mwo09kU4nzccyA6/PjNPhtJ1Be/eZbIh2uM61eWiIfe9YtObO
	 xo2YWJOtXDiat10vr7H+UIUb84kfJ9W7AjB7b+DMwQBivua8ivZSeOESu6AsyqeXhk
	 sqMYqATrSXXgPrusdWzu+c/HmcGkplyv0C/x06pD8St297W6J0z9sivdL//aFra3y8
	 komt1vFe9LgNg==
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by lists.lttng.org (Postfix) with ESMTPS id 49rprg6tGmz13NB
 for <lttng-dev@lists.lttng.org>; Tue, 23 Jun 2020 10:41:55 -0400 (EDT)
IronPort-SDR: O9fIR4v7AmXL0xNmbxeadA0p3ecBKCQB4oR1UItSjrdMYq3U3vv0gkScDy+O7JKr3Jx9s7rTAt
 w5ia5KeBfL5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="143158712"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="143158712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 07:41:47 -0700
IronPort-SDR: mFlNBMOPfpazrDEPIKzKBxD0j8Xy4tisz/694YqOQERp+xsKLv1mIp61roZLi3MpScX/pe0q0/
 WGk4rS9Qa5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="478881784"
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.121])
 by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2020 07:41:47 -0700
Date: Tue, 23 Jun 2020 22:37:58 +0800
To: lttng-dev@lists.lttng.org
Cc: changcheng.liu@intel.com
Message-ID: <20200623143758.GB4160129@jerryopenix>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Subject: [lttng-dev] get function names with lttng-ust-cyg-profile
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
From: "Liu, Changcheng via lttng-dev" <lttng-dev@lists.lttng.org>
Reply-To: "Liu, Changcheng" <changcheng.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
Message-ID: <20200623143758.NfZwEUuD127q5XnnxOIW9w33Sp6vuPNCMgKA8TiOoeU@z>

Hi all,
   I'm trying to use lttng-ust-cyg-profile to trace program.
   Does anyone know how to get function names and offset through lttng-ust-cyg-profile?

   In below example, the babeltrace could only get the function entry/exit value.
   1. Source program: instrument.c
         1 #include <stdio.h>
         2 
         3 int add3(int val) {
         4         return val + 3;
         5 }
         6 
         7 int main(int argc, char **argv) {
         8     int x = 4;
         9     
        10     puts("Press Enter to continue...");
        11     getchar();
        12     
        13     x = add3(x);
        14     
        15     return 0;
        16 }

   2. build source code:
        $ gcc -g -finstrument-functions instrument.c -o instrument

   3. run program:
       $ LD_PRELOAD=/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so ./instrument

   4. start trace process:
       trace@trace:~/cc$ sudo lttng create instrument
       Session instrument created.
       Traces will be output to /root/lttng-traces/instrument-20200623-222917

       trace@trace:~/cc$ sudo lttng enable-channel user_func_trace --userspace
       UST channel user_func_trace enabled for session instrument

       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_profile:func_entry --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_entry created in channel user_func_trace
       trace@trace:~/cc$ sudo lttng enable-event --userspace lttng_ust_cyg_profile:func_exit --channel user_func_trace
       UST event lttng_ust_cyg_profile:func_exit created in channel user_func_trace

       trace@trace:~/cc$ sudo lttng start
       Tracing started for session instrument

       trace@trace:~/cc$ sudo lttng destroy
       Destroying session instrument..
       Session instrument destroyed

       trace@trace:~/cc$ sudo babeltrace /root/lttng-traces/instrument-20200623-222917
       [22:29:55.388607059] (+?.?????????) trace lttng_ust_cyg_profile:func_entry: { cpu_id = 2 }, { addr = 0x5625C88B01A9, call_site = 0x5625C88B0237 }
       [22:29:55.388612293] (+0.000005234) trace lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01A9, call_site = 0x5625C88B0237 }
       [22:29:55.388613215] (+0.000000922) trace lttng_ust_cyg_profile:func_exit: { cpu_id = 2 }, { addr = 0x5625C88B01EE, call_site = 0x7FE40BD5C0B3 }

B.R.
Changcheng
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
