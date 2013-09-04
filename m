From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.3.0 stable - Dominus Vobiscum
Date: Tue, 3 Sep 2013 21:33:49 -0400
Message-ID: <20130904013349.GA9497__24882.307687267$1378258479$gmane$org@ev0ke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VH1yo-0004RV-KM
	for lttng-dev@lists.lttng.org; Tue, 03 Sep 2013 21:34:01 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
Cc: lwn@lwn.net
List-Id: lttng-dev@lists.lttng.org

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

This is finally the 2.3.0 STABLE release! The Dominus Vobiscum is the
codename! Please check a description of that beer and microbrewery with
"lttng version" :).

With 2.3.0 comes the snapshot feature that you can use either on disk or
over the network (with a lttng-relayd). Here is a small example on how
to use it:

$ lttng create --snapshot
$ lttng enable-event -a -u
$ lttng start
[...]
$ lttng snapshot record

The --snapshot creates a special session that is set in no output mode
meaning that no trace files will be created. Also, every channel of that
session are created in overwirte mode and MMAP output since SPLICE is
not supported. More information can be found in the man page lttng(1).

A second extra goodie is the core dump handler script. A custom core
dump program that will be called when a core dump occurs. The program
will save the core data in CORE_PATH and also, if a root session daemon
is running, will record a snapshot of tracing data using the lttng
command line utility. You can find more information in
extras/core-handler/README in the tarball.

In the git repository, a branch "stable-2.3" has been created for this
release.

Here is the ChangeLog for 2.3.0 stable (a bit short).

2013-09-03 lttng-tools 2.3.0
	* Fix: remove periodical flush test from make check

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.3.0.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
