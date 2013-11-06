From: Paul Thomas <paul.thomas@ise.bc.ca>
Subject: Building Babeltrace
Date: Wed, 6 Nov 2013 19:00:58 +0000
Message-ID: <F98AC8DFC04DC741915F3DFB00515DBEE897275C__27398.0183214464$1383764530$gmane$org@Thetis.ISE-DOM.local>
References: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com
	([213.199.154.188] helo=db8outboundpool.messaging.microsoft.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.thomas@ise.bc.ca>) id 1Ve8Ll-0007Zm-Q4
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 14:01:15 -0500
Received: from mail60-db8 (localhost [127.0.0.1])	by mail60-db8-R.bigfish.com
	(Postfix) with ESMTP id 9351330030A	for <lttng-dev@lists.lttng.org>;
	Wed,  6 Nov 2013 19:01:03 +0000 (UTC)
Received: from DB8EHSMHS003.bigfish.com (unknown [10.174.8.233])	by
	mail60-db8.bigfish.com (Postfix) with ESMTP id 397A7B8004E	for
	<lttng-dev@lists.lttng.org>; Wed,  6 Nov 2013 19:01:02 +0000 (UTC)
In-Reply-To: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "'lttng-dev@lists.lttng.org'" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello:

I get the following when building babeltrace from git:

make[4]: Entering directory `/rt_linux/babeltrace/formats/ctf/writer'
  CC     writer.lo
writer.c: In function 'bt_ctf_writer_create':
writer.c:118: error: 'O_DIRECTORY' undeclared (first use in this function)
writer.c:118: error: (Each undeclared identifier is reported only once
writer.c:118: error: for each function it appears in.)
writer.c: In function 'validate_identifier':
writer.c:564: warning: implicit declaration of function 'g_hash_table_contains'
writer.c: In function 'writer_init':
writer.c:741: warning: implicit declaration of function 'g_hash_table_add'
make[4]: *** [writer.lo] Error 1
make[4]: Leaving directory `/rt_linux/babeltrace/formats/ctf/writer'
make[3]: *** [all-recursive] Error 1
make[3]: Leaving directory `/rt_linux/babeltrace/formats/ctf'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/rt_linux/babeltrace/formats'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/rt_linux/babeltrace'
make: *** [all] Error 2

I am running Debian:  gcc/g++ 4.4.5-8
Linux debian-rt 2.6.31.51 #1 SMP PREEMPT i686 GNU/Linux

Should I be compiling from a tarball instead?

Thanks,

Paul
