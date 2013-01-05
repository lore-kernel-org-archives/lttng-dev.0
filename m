From: Alexander Kampmann <alexander.kampmann@gmx.de>
Subject: Reading cache misses in Userspace?
Date: Sat, 05 Jan 2013 20:47:25 +0100
Message-ID: <50E8834D.1010802__14532.1930679076$1357415866$gmane$org@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexander.kampmann@gmx.de>) id 1TrZiP-0005Gx-Fo
	for lttng-dev@lists.lttng.org; Sat, 05 Jan 2013 14:47:33 -0500
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
	(mrigmx001) with ESMTP (Nemesis) id 0Lnmkr-1TMOMT486h-00hz9G for
	<lttng-dev@lists.lttng.org>; Sat, 05 Jan 2013 20:47:27 +0100
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

hey,

I would like to find out which part of my application causes most cache 
misses. So I tried to add userspace events to my application. I hoped 
LTTng would give me some mean of determining between which tracepoints 
the most cache misses occur.

I started a session like that:

sudo lttng create session
sudo lttng enable-event -a -u
sudo lttng add-context -u -t perf:LLC-load-misses -t 
perf:LLC-store-misses -t perf:LLC-prefetch-misses

I get:

Error: perf:LLC-prefetch-misses: UST invalid context
Error: perf:LLC-store-misses: UST invalid context
Error: perf:LLC-load-misses: UST invalid context

Does this mean I can not add perf:LLC-* context to my userspace events? 
Is there any way to figure out which part of my application causes cache 
misses?

If I use

sudo lttng add-context -k -t perf:LLC-load-misses -t 
perf:LLC-store-misses -t perf:LLC-prefetch-misses

instead, I don't get an error, but the babeltrace output does not 
contain any cache miss counts as well.

I would appreciate any help,

Alex
