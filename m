From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Building out-of-tree tracepoint modules on Ubuntu
Date: Tue, 13 Aug 2013 15:30:06 -0400
Message-ID: <520A893E.4070300__24115.7902208672$1376422272$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1V9KII-00071x-Kh
	for lttng-dev@lists.lttng.org; Tue, 13 Aug 2013 15:30:20 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5312730pdi.5
	for <lttng-dev@lists.lttng.org>; Tue, 13 Aug 2013 12:30:08 -0700 (PDT)
Received: from [132.207.220.194] (Sansfil-Public-Lassonde-220-194.polymtl.ca.
	[132.207.220.194])
	by mx.google.com with ESMTPSA id ia5sm4910743pbc.42.2013.08.13.12.30.07
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 13 Aug 2013 12:30:08 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

The lttng-modules addons stopped working on Ubuntu 12.10 with Linux 3.8.
Tracepoints defined in these modules were listed by "lttng list -k", no
error was return when enabling, but events were not written to the trace.

This problem is caused by the option CONFIG_MODULE_SIG=y on Ubuntu
kernels. Because the signing key is not available, it's not possible to
sign LTTng modules, and they are flagged as TAINT_FORCED. This flag is
checked on tracepoints registration [1].

/*
 * We skip modules that taint the kernel, especially those with
 * different module headers (for forced load), to make sure we don't
 * cause a crash. Staging and out-of-tree GPL modules are fine.
 */
if (mod->taints & ~((1 << TAINT_OOT_MODULE) | (1 << TAINT_CRAP)))
	return 0;

In consequence, it's not possible to have out-of-tree tracepoint module
with the default Ubuntu kernel.

What about generating a new x.509 certificate and sign modules with it?
I tried to use keyctl to add a signing key, but I didn't found a way to
add the key to the special ".module_sign" keyring [2]. It seems internal
and inaccessible, but if somebody knows how to deal with this, that
would be the best solution.

As a last resort solution, I did a small module that embed the
certificate and loads it. Then, signed modules loaded after this one are
not marked as TAINTE_FORCED, and thus works correctly [3].

$ cat /proc/modules
[...]
lttng_addons 14418 0 - Live 0x0000000000000000 (O)
lttng_modsign 12623 0 - Live 0x0000000000000000 (OF)

$ lttng create
$ lttng enable-event -k inet_sock_create
$ lttng start
$ echo bidon | netcat localhost 1234
$ lttng stop
$ lttng view
$ [15:03:40.850792507] (+?.?????????) ubuntu inet_sock_create: { cpu_id
= 0 }, { sk = 0xFFFF88003C670E00 }

So, even if this is a dirty hack, it works ;-)

Could it be possible to relax checks to add tracepoint module if they
are not signed? Then a new flag TAINT_UNTRUSTED (or something) shall be
added to distinguish such situation from the more general TAINT_FORCED.
At least, there should be some warning message when inserting the module
and enabling such event should be failing.

Thoughts?

Thanks!

Francis Giraldeau

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c#n634
[2]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/kernel/modsign_pubkey.c#n33
[3]
https://github.com/giraldeau/lttng-modules/blob/addons-modsign/lttng-signature.c
