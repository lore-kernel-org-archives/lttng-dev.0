From: Antoine Busque <abusque@efficios.com>
Subject: [RFC lttng-tools] Add regressions tests for UST ELF
	parser
Date: Wed, 5 Aug 2015 15:16:56 -0400
Message-ID: <CA+MZcXtD-CwyAE-PzdQoSHjP=RTbN4OXG755-NxH60HwW-ph_w__13894.769040826$1438802288$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZN4BV-0007Tn-Ns
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 15:17:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 58A703403BD
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:17:00 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3X-5ufM9LN21 for <lttng-dev@lists.lttng.org>;
 Wed,  5 Aug 2015 19:16:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 1937D3403F7
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:16:59 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id F9Ww5yRYGm8l for <lttng-dev@lists.lttng.org>;
 Wed,  5 Aug 2015 19:16:59 +0000 (UTC)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by mail.efficios.com (Postfix) with ESMTPSA id 6B6183403BD
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:16:58 +0000 (UTC)
Received: by ioeg141 with SMTP id g141so59338051ioe.3
 for <lttng-dev@lists.lttng.org>; Wed, 05 Aug 2015 12:16:57 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

This patch set implements regression tests for lttng-ust
statedump and dl helper, with support for the new ELF info events.
Please pull from:
https://github.com/abusque/lttng-tools/tree/ust-elf-tests


See also https://github.com/abusque/lttng-ust/tree/elf-info for the
latest implementation of the UST ELF parser.

Regards,
Antoine Busque
