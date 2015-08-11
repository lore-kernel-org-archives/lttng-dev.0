From: Antoine Busque <abusque@efficios.com>
Subject: [RFC lttng-ust v2] Add memory size, build id,
 and debug link info to statedump and dl
Date: Tue, 11 Aug 2015 16:24:39 -0400
Message-ID: <CA+MZcXsVx9hezOf7F4RT_qqGdrt4tTQ0jSsVRA_pwnBVq81mgw__42762.0457172909$1439324778$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZPG6K-0000nY-If
 for lttng-dev@lists.lttng.org; Tue, 11 Aug 2015 16:24:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 178DA34057A
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 20:24:43 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 0IeKGUQSr2kf for <lttng-dev@lists.lttng.org>;
 Tue, 11 Aug 2015 20:24:42 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DD23A34057F
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 20:24:41 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Uu6DHyjfopQX for <lttng-dev@lists.lttng.org>;
 Tue, 11 Aug 2015 20:24:41 +0000 (UTC)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by mail.efficios.com (Postfix) with ESMTPSA id 62E8E34057A
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 20:24:41 +0000 (UTC)
Received: by iodb91 with SMTP id b91so154752648iod.1
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 13:24:39 -0700 (PDT)
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
https://github.com/abusque/lttng-ust/tree/elf-info-v2

Also included are unit tests covering x86, x86_64, armeb, and aarch_64
targets.

Changes from version 1:

- Fixed coding style issues
- More rigorous error handling
- Field reordering in tracepoints and structs for optimization

Regards,
Antoine Busque
