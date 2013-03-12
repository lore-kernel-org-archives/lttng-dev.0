From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: LTTV CTF support work in progress
Date: Tue, 12 Mar 2013 13:27:13 -0400
Message-ID: <513F6571.10301__16980.2441531376$1363109296$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UFSyw-0001ZG-9G
	for lttng-dev@lists.lttng.org; Tue, 12 Mar 2013 13:27:22 -0400
Received: by mail-vc0-f178.google.com with SMTP id m8so41811vcd.37
	for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2013 10:27:17 -0700 (PDT)
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

Hi all,

Some of you want to know what is the current status of LTTV.
The current port to use libbabeltrace to read the CTF file produced by
LTTng 2.x is going well, but there are still issues remaining.

If you want to try the current version, you can grab the babelproto
branch in the LTTV git repo:
http://git.lttng.org/?p=lttv.git;a=shortlog;h=refs/heads/babelproto
You will need the master branch of the babeltrace git to compile it.

The textview is working and a basic Control Flow view (state view) is
showing. We have some bugs in the display of the state (Some redraw
problem, and some values seems to not be displayed correctly), so you
should not rely on the information displayed.

Performance wise, it's still costly to open a big trace. You might get
some improvment with some addition I did for babeltrace, which are
available in my personal babeltrace repo, in the branch iter_equals_pos :
http://git.dorsal.polymtl.ca/~ybrosseau?p=babeltrace.git;a=shortlog;h=refs/heads/iter_equals_pos

I will keep you posted when it runs better... :)

Yannick
