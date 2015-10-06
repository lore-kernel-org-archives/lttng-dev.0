From: Michael Jeanson <mjeanson@efficios.com>
Subject: [urcu][GIT PULL] Add support for Solaris 10 and 11
Date: Tue, 6 Oct 2015 11:38:54 -0400
Message-ID: <5613EB0E.1010209__14239.7056603388$1444146020$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mjeanson@efficios.com>) id 1ZjUKV-0001Cj-G0
 for lttng-dev@lists.lttng.org; Tue, 06 Oct 2015 11:39:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AC56E3402A3
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2015 15:38:58 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id APrN3v7m4Ztn for <lttng-dev@lists.lttng.org>;
 Tue,  6 Oct 2015 15:38:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6BAD33402F6
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2015 15:38:57 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id A7pVh5EeZ6R0 for <lttng-dev@lists.lttng.org>;
 Tue,  6 Oct 2015 15:38:57 +0000 (UTC)
Received: from [172.16.0.63] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 1AE973402A3
 for <lttng-dev@lists.lttng.org>; Tue,  6 Oct 2015 15:38:57 +0000 (UTC)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

This pull request adds support for Solaris 10 and 11, on Solaris 10 it
requires the OpenCSW open source software distribution for build and
runtime dependencies.

https://github.com/urcu/userspace-rcu/pull/5

	Port: make bootstrap script work on most shell 		c8d0f0f
	Port: replace bzero() by memset()			6e8a583
	Port: Add Solaris support to urcu/syscall-compat.h 	da639cf
	Port: Add Solaris support to tests/common/thread-id.h 	61b8a58
	Port: Add Solaris getcpu support 			03190dc
	Port: Fixes to build system for portability 		114b504
	Port: Detect nproc bin name in benchmark scripts 	fb4b0fc
	Fix: regtest outputs valid TAP protocol 		65fcf96


Feedback is welcome.

Thanks,

Michael
