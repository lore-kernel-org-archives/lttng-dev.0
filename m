From: Antoine Busque <abusque@efficios.com>
Subject: [RFC lttng-ust v3] Add memory size, build id,
 and debug link info to statedump and dl
Date: Fri, 14 Aug 2015 17:49:31 -0400
Message-ID: <CA+MZcXsHBR_0wju=9z2RsY9LgyNrjQ4RQxaHSJZa+87nGXbEoA__21463.4419455708$1439589034$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZQMr5-0005vb-V6
 for lttng-dev@lists.lttng.org; Fri, 14 Aug 2015 17:49:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 988CE34028D
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2015 21:49:34 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5Sn_HlD-wGB4 for <lttng-dev@lists.lttng.org>;
 Fri, 14 Aug 2015 21:49:33 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 471543403D1
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2015 21:49:33 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id SR6qZyLaVmGx for <lttng-dev@lists.lttng.org>;
 Fri, 14 Aug 2015 21:49:33 +0000 (UTC)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
 [209.85.213.181])
 by mail.efficios.com (Postfix) with ESMTPSA id D975F34028D
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2015 21:49:32 +0000 (UTC)
Received: by igxp17 with SMTP id p17so21145157igx.1
 for <lttng-dev@lists.lttng.org>; Fri, 14 Aug 2015 14:49:31 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This patch set implements a minimal ELF parser to add extra
information necessary for callsite analysis to the statedump and dl
helper. Please pull from
https://github.com/abusque/lttng-ust/tree/elf-info-v3

Also included are unit tests covering x86, x86_64, armeb, and aarch_64
targets.

Changes from version 1:

- More uniform and thorough error handling (i.e. always return -1 on failure,
  0 on success)
- Make distinction between information not found in ELF file and
  actual errors (found status is returned through an out parameter on
  function success)
- Functions have no side-effects on failure
- Add more cases to the unit tests for better coverage
- Minor style issues

Changes from version 1:

- Fixed coding style issues
- More rigorous error handling
- Field reordering in tracepoints and structs for optimization

Regards,
Antoine Busque
