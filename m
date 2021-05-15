Return-Path: <SRS0=4/8y=KK=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FABC433B4
	for <lttng-dev@archiver.kernel.org>; Sat, 15 May 2021 05:26:35 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC4C61264
	for <lttng-dev@archiver.kernel.org>; Sat, 15 May 2021 05:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4C61264
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4Fhv5P4Gvgz1pHZ;
	Sat, 15 May 2021 01:26:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1621056394;
	bh=zx8zrTrvW8ABOFJM956XQ6FRDhGuzGDgZXZy35m8iRw=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=N9cTrVra4x24NohH8t+3ux2RtchORsAek9ieb6CffrUv5q/gOAc3MpX9DJed4ajnh
	 XipgvJ4eb8BFOgwciCasRp4jTR66ZKCX/UvEWuamIhJWDee0weT5dXKutF7PrODe3o
	 Rl6eYOzGHP3AybkifcqAYgKJBwgLAaBH8KzoyT571mG521ZR9+DwU/dIvb9DzcjG8p
	 dj7l1g9GbINKe4zvpMonQOGkWrzYZ1wHQglviYuqG+2hHELuGr46uWshkYhvoBvsr+
	 lc4Lo+qAbwjYU5DsqMaKWdL5nyiLbidpjFQTL74SvnVnvWqgP1JUyduPavsDTqpHfB
	 1E2LiZJtNQVrA==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4Fhv5N1NV8z1pF8
 for <lttng-dev@lists.lttng.org>; Sat, 15 May 2021 01:26:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B53202BCA0B
 for <lttng-dev@lists.lttng.org>; Sat, 15 May 2021 01:26:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id EsxluEzGqOFd; Sat, 15 May 2021 01:26:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9D6EC2BCB07;
 Sat, 15 May 2021 01:26:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9D6EC2BCB07
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id U214ZKN5NQl9; Sat, 15 May 2021 01:26:24 -0400 (EDT)
Received: from Mercury (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 7C4022BCB06;
 Sat, 15 May 2021 01:26:24 -0400 (EDT)
Date: Sat, 15 May 2021 01:26:24 -0400
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org,
 linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <YJ9bgH7uw24flNDD@Mercury>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] =?iso-8859-1?q?=5BRELEASE=5D_LTTng_2=2E13=2E0-rc2_-_?=
 =?iso-8859-1?q?Nordicit=E9_-_Linux_kernel_and_user-space_tracer?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
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

Hi everyone,

Today marks the release of the second LTTng 2.13 - Nordicit=E9 release cand=
idate.

A prettyfied version of this annoucement is available here:
https://github.com/lttng/lttng-tools/releases/tag/v2.13.0-rc2

If you were already testing the first release candidate of this release, pl=
ease
note that LTTng-UST and LTTng-tools must be updated to "rc2" in locked-step
due to ABI changes. Also note that probe providers must be rebuilt against
LTTng-UST 2.13.0-rc2.

Have a look at the first release candidate's release notes for an
overview of the features introduced in LTTng 2.13.

https://github.com/lttng/lttng-tools/releases/tag/v2.13.0-rc1


What's new in LTTng-UST (Linux application tracer) 2.13.0-rc2?
---

- Allow explicit tracepoint instance provider name. Allow re-using a tracep=
oint
  class from tracepoint instances in other providers.

  This is a localized API-breaking change introduced very early in the
  2.13-rc cycle. The LTTNG_UST_TRACEPOINT_EVENT_INSTANCE macro newly introd=
uced
  in LTTng-UST 2.13-rc1 now takes an extra "template_provider" argument.

  This changes the ABI exposed by the probe providers, so bump the probe
  provider major version, and make newer LTTng-UST reject old incompatible
  major.

  Probe providers built against LTTng-UST 2.13-rc1 must be rebuilt against
  LTTng-UST 2.13-rc2 to be traced.

- Add probe descriptor field to enumeration and event class

  Also breaks the ABI exposed by probe providers (provider major version al=
ready
  bumped for rc2). This enables additional validation of probe provider
  compatibility when using event class and enumerations across providers.

- Validate provider version for event class.

- Validate provider version for event enumeration field types.

- Introduce api0 and api1 compilation tests. This tests whether the API 0
  compatibility API works. See ust-api-compat.h for details.

- Fix Java (JUL and log4j) application context segmentation fault and leaks.

- liblttng-ust-ctl: implement SIGBUS handling:

  This fixes a long-standing DoS where an unprivileged application could ca=
use
  a SIGBUS in the consumer daemon by truncating the shared memory files it
  receives from the session daemon. This requires that LTTng-tools be upgra=
ded
  to 2.13-rc2 in locked-step with LTTng-UST 2.13-rc2.

- Restore communication protocol backward compatibility with LTTng-UST 2.12

  - liblttng-ust-ctl: keep using lttng-ust-sock-8 and lttng-ust-wait-8 file=
name

    LTTng-UST 2.13-rc1 erroneously changed the file names of those socket a=
nd
    pipe files from [...]-8 to [...]-9, even though we intended to keep pro=
tocol
    compatibility between LTTng-UST 2.12 and LTTng-tools/ust 2.13. This cha=
nges
    reverts back to the prior filenames to make sure LTTng-UST 2.12 applica=
tions
    can be traced by a 2.13 LTTng-tools using 2.13 LTTng-UST.

  - Fix: add missing fields in struct lttng_ust_abi_channel_config

    Three fields were removed by mistake from this structure which is ABI
    between the consumer daemon and applications traced with LTTng-UST. Add=
 them
    back to allow tracing 2.12 LTTng-UST applications with a 2.13 LTTng-too=
ls
    using 2.13 LTTng-UST.

- Fix LTTng-UST communication protocol variable-length data handling

  When mixing older (e.g. 2.12) and newer versions of LTTng-UST talking to =
each
  other between application and LTTng-tools, situations where commands are
  unknown lead to out-of-sync communication protocol.

  Change the protocol for commands new to LTTng-UST 2.13 so they acknowledg=
e the
  fixed-size commands before the variable-sized data is sent, so the
  communication protocol is kept in sync even when unknown command error
  happens. This also happens for more ancient commands released in prior
  versions for which we cannot change the protocol. Shutdown the socket fro=
m the
  session daemon side when we detect such errors, because there is no point=
 in
  trying to communicate further on an out-of-sync socket.

- Detect mixed liblttng-ust and liblttng-ust-tracepoint .so.0 and .so.1 lib=
raries

  Detect and report with a new "critical" logging message whether .so.0 and
  .so.1 tracer libraries are loaded within a single process, which is an
  unsupported use-case. Note that the LTTNG_UST_DEBUG environment variable =
must
  be set to allow users to observe those critical messages.

  We also introduce a new LTTNG_UST_ABORT_ON_CRITICAL environment variable =
to
  allow the tracer to abort() the process whenever a critical logging state=
ment
  is encountered. This is meant to facilitate discovering problematic
  deployments where an application indirectly loads different soname major
  numbers of LTTng-UST through its instrumented shared libraries.

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-ust/blob/13861e2d/ChangeLog


What's new in LTTng-modules (Linux kernel tracer) 2.13.0-rc2?
---

- There are refactoring commits that were introduced after 2.13-rc1 to alig=
n the
  code of LTTng-modules with the refactoring that was done in LTTng-UST pri=
or to
  2.13-rc1. Given that LTTng-modules does not expose its kernel APIs to ext=
ernal
  users, it was possible to do this refactoring even after rc1.

- Compiling the system call tracing code has typically been a resource-heavy
  endeavour both in terms of memory usage (~1G memory required) and CPU tim=
e. It
  has been split into smaller compile units to allow parallel compilation a=
nd
  lessen the memory requirements on the compiler.

- Bitwise enumerations are now disabled by default. Only compiled in with m=
ake
  CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM=3Dy.

- Fix: increment buffer offset when failing to copy from user-space.

- Implement ring buffer Pascal string copy: allows taking C-strings as inpu=
ts
  and record them to ctf_array_text and ctf_sequence_text fields (which are
  Pascal strings) without causing out-of-bound reads of the C-strings of th=
ose
  are smaller than the size reserved for the pascal strings. This mirrors t=
he
  behaviour introduced in LTTng-UST 2.13-rc1.

- Support for 5.12 Linux kernels,

- Support recent stable kernel branches 4.14, 4.19, 5.4,

- Support for newer Ubuntu 4.15, 5.4, and RHEL 8.2/8.3 kernels,

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-modules/blob/f982b51a/ChangeLog


What's new in LTTng-tools 2.13.0-rc2?
---

- The new features introduced in the 2.13 release are now fully documented =
as
  part of the installed man pages. A number of improvements were also made =
to
  the existing documentation such as adding examples for the lttng-add-cont=
ext
  command.

- lttng client messages referring to "event rule hit" conditions have been
  changed to use the correct "event-rule matches" condition name.

- An example was added under doc/examples/trigger-condition-event-matches. =
It
  contains an application instrumented with LTTng-UST, a script that adds
  triggers to notify external clients whenever the application's events occ=
ur,
  and a notification client which consumes the resulting notification along=
 with
  any captured payload.

  See https://github.com/lttng/lttng-tools/tree/c3195dc0/doc/examples/trigg=
er-condition-event-matches#readme

- A bug resulting in the production of erroneous path hierarchies when a
  snapshot is streamed to a relay daemon was fixed. This bug resulted in
  duplicated domain names being present in the final path of a snapshot
  ("ust/ust" or "kernel/kernel") which could cause some automation scripts =
to
  fail.

- A bug that caused some trace data to be invisible to live viewers has been
  fixed.

  See https://lists.lttng.org/pipermail/lttng-dev/2021-May/029953.html

- A number of bugs that could result, under rare circumstances, in a hang w=
hen
  using the lttng-clear command against a session that contains kernel chan=
nels
  was fixed.

- Miscellaneous stability improvements.

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-tools/blob/4be5babe/ChangeLog


Links
---

Project website:
https://lttng.org

Download links:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc2.tar.bz2
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc2.tar.bz2
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc2.tar.bz2

GPG signatures:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc2.tar.bz2.asc
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc2.tar.bz2.asc
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc2.tar.bz2.asc
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
