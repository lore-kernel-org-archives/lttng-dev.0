From: David OShea <David.OShea@quantum.com>
Subject: Segmentation fault in lttng-sessiond which is fixed in
	master
Date: Mon, 3 Dec 2012 04:39:55 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F88254__38812.6803598881$1354509644$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=86843c8789=david.oshea@quantum.com>)
	id 1TfNp2-0001Nh-VX
	for lttng-dev@lists.lttng.org; Sun, 02 Dec 2012 23:40:01 -0500
Received: from pps.filterd (m0030277 [127.0.0.1])
	by mx0a-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qB34bWHN007820
	for <lttng-dev@lists.lttng.org>; Sun, 2 Dec 2012 20:39:59 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
	by mx0a-000ceb01.pphosted.com with ESMTP id 190ctm0r10-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Sun, 02 Dec 2012 20:39:59 -0800
Content-Language: en-US
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

I'm using lttng-tools-2.0.4.  I got a segmentation fault in lttng-sessiond with this stack trace:

"""
#0  delete_ust_app_session (sock=-1, ua_sess=0xffffffffffffffff) at ust-app.c:147
#1  0x000000000040cab5 in create_ust_app_session (usess=0x148adc10, app=0x148c0ef0) at ust-app.c:914
#2  0x000000000040db14 in ust_app_global_update (usess=0x148adc10, sock=187) at ust-app.c:2309
#3  0x0000000000412c96 in update_ust_app (app_sock=<optimized out>) at main.c:855
#4  thread_manage_apps (data=<optimized out>) at main.c:1257
#5  0x00002b872bffb617 in start_thread () from /lib64/libpthread.so.0
#6  0x00002b872c2e3c2d in clone () from /lib64/libc.so.6
#7  0x0000000000000000 in ?? ()
"""

It looks like in create_ust_app_session() this code must have executed:

"""
	if (ua_sess->handle == -1) {
		ret = ustctl_create_session(app->sock);
		if (ret < 0) {
			ERR("Creating session for app pid %d", app->pid);
			/* This means that the tracer is gone... */
			ua_sess = (void*) -1UL;
			goto error;
"""

as this is the location of the call to delete_ust_app_session():

"""
error:
	delete_ust_app_session(-1, ua_sess);
"""

I see that in git master, this seems to have been fixed by:

"""
commit 0f83395d5e0e927fdab025eae023e68e9021af26
Author: David Goulet <dgoulet@efficios.com>
Date:   Mon Oct 29 14:49:50 2012 -0400

    Fix: Cleanup UST app session on ustctl create session error
"""

which ensures that ua_sess is not set to -1 until after delete_ust_app_session() is called.

I have two queries about this:

1. Why is this error handling code being reached - what does the comment /* This means that the tracer is gone... */ mean - does it mean lttng-ust in a user process connected to the session daemon but the process went away or something like that?

2. Should the above commit be merged into the stable branch?  I'm not concerned either way as I'll probably just apply the patch to 2.0.4 when I get a chance.

Thanks!
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
