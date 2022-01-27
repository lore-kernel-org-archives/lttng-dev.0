Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F82C433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 27 Jan 2022 20:35:50 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JlC5w5dllzQ9t;
	Thu, 27 Jan 2022 15:35:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1643315749;
	bh=ROz/Xw4q1sd/J4zA7HloQFGZYmih0a0hP8l/2Y3P3LI=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=s750z7yDPMmgLJT55MxFPnGz8BAnubYaSJZtB+PZ50g0nGdKWMLSYNUW4kG1waqUj
	 Dj9crPk1Xd3xIuJOsBZJsvVFcWgysoOaRydu5msZabdNnO7RXECaSdxs5nHCZT/L2j
	 oaMCaT/c3J/ROvfuQCPtwf5zBJqjd+pBlf8S7rl53v+icVvRTc4KeNykOrIyKJDHw1
	 dvPkfIlFEYBSupGT48eII3Jbegck3gvU3HcZ8ijsyg9v6EFsYdAhSyzD0sIPKs5bDr
	 c95xxjrI1cDqRX4b+VRRxEPVXNWraa/LaSUEcSOTOdHVylWH8MkEISQZd/6S6cGPqc
	 eHaS3Zw2grIEg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JlC5v0GmszQpd
 for <lttng-dev@lists.lttng.org>; Thu, 27 Jan 2022 15:35:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4DD10378926
 for <lttng-dev@lists.lttng.org>; Thu, 27 Jan 2022 15:35:40 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZEbCELoJEu9F; Thu, 27 Jan 2022 15:35:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6FC8D378981;
 Thu, 27 Jan 2022 15:35:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6FC8D378981
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id FLMgEnkUHnMT; Thu, 27 Jan 2022 15:35:39 -0500 (EST)
Received: from Mercury (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 411A2378980;
 Thu, 27 Jan 2022 15:35:39 -0500 (EST)
Date: Thu, 27 Jan 2022 15:35:39 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <YfMCG9NUWn+iIXV8@Mercury>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng-tools_2=2E13=2E4_?=
 =?iso-8859-1?q?-_Nordicit=E9?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi all,

We have just released the third bug-fix release of LTTng-tools 2.13 - Nordi=
cit=E9.
This release addresses a number of issues listed below.

2022-01-26 lttng-tools 2.13.4 (National Peanut Brittle Day)
    * Build fix: hashtable: hashtable.cpp does not exist
    * Fix: _lttng_variant_statedump should expect lttng_ust_ctl_atype_varia=
nt_nestable
    * Fix context mismatch across UST version due to legacy array context f=
ield
    * Relicence all source and header files included in LGPL code
    * Move utils_expand_path and utils_expand_path_keep_symlink to libpath.=
la
    * Link lttng executable on libcommon-lgpl.a
    * Introduce libcommon-lgpl for liblttng-ctl
    * Rename libcommon.so to libcommon-gpl.so
    * Copyright ownership transfer
    * Copyright ownership transfer
    * Fix: relayd: erroneous rundir permission logging message
    * Fix: sessiond: rotation thread: fatal error when not finding a session
    * Fix: relayd: rotation failure for multi-domain session
    * Fix: lttng-ctl: lttng_list_sessions: initialize out_sessions to NULL =
when returning 0
    * Fix: lttng: initialize variable in run_command_string
    * Fix: consumer-stream: live viewers observe timestamps going backwards
    * Fix: relayd: ressource leaks on viewer_stream_create error
    * Fix: relayd: live: erroneous message timestamp observed from live vie=
wer
    * Fix: relayd: failure to open chunk files concurrently with session cl=
ear
    * Fix: relayd: live: metadata stream reference count < 0 assert

Note that v2.13.3 was tagged nearly simultaneously as this release, but
unannounced since a bad backport caused the generation of the tarball to fa=
il.
The change log above combines the changes relevant to both releases.

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.4.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.4.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
