From: Antoine Busque <abusque@efficios.com>
Subject: [RFC lttng-ust] Add memory size, build id,
 and debug link info to statedump and dl
Date: Wed, 5 Aug 2015 15:12:52 -0400
Message-ID: <CA+MZcXuc3rOoM7cCvoBL4POx73t5MrERCpyYU1DfXKjQpFm+kA__24093.6173279353$1438802051$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZN47Y-0007PD-Uy
 for lttng-dev@lists.lttng.org; Wed, 05 Aug 2015 15:13:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 758363403A3
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:12:55 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 3j-eXKzEF2WV for <lttng-dev@lists.lttng.org>;
 Wed,  5 Aug 2015 19:12:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5B1073403C9
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:12:54 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LA_hb01vL_44 for <lttng-dev@lists.lttng.org>;
 Wed,  5 Aug 2015 19:12:54 +0000 (UTC)
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
 [209.85.223.169])
 by mail.efficios.com (Postfix) with ESMTPSA id E544734029F
 for <lttng-dev@lists.lttng.org>; Wed,  5 Aug 2015 19:12:53 +0000 (UTC)
Received: by iodd187 with SMTP id d187so59176561iod.2
 for <lttng-dev@lists.lttng.org>; Wed, 05 Aug 2015 12:12:52 -0700 (PDT)
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
https://github.com/abusque/lttng-ust/tree/elf-info

Also included are unit tests covering x86, x86_64, armeb, and aarch_64
targets.

Regards,
Antoine Busque
