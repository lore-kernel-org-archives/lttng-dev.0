From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Update on fedora packaging
Date: Tue, 26 Jun 2012 13:39:45 -0400
Message-ID: <4FE9F3E1.5070906__45627.1443320022$1340732424$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f50.google.com ([209.85.213.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SjZk1-0003FR-EJ
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 13:39:53 -0400
Received: by yhjj63 with SMTP id j63so231246yhj.37
	for <lttng-dev@lists.lttng.org>; Tue, 26 Jun 2012 10:39:47 -0700 (PDT)
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

Hi all,

A small progress update on the packaging of LTTng for Fedora.

Latest Userspace RCU package is in the testing-update queue for Fedora
17 (and in available in rawhide)
(https://admin.fedoraproject.org/updates/FEDORA-2012-9686/userspace-rcu-0.7.3-1.fc17)

LTTng-UST is now in rawhide. I will push in F17 when URCU get out of the
testing queue.

LTTng-tools is pending a Review Request
(https://bugzilla.redhat.com/show_bug.cgi?id=834481)

My plan is to package babeltrace when it reaches 1.0 and lttv when the
initial LTTng 2.0 support is finished.

Yannicl
