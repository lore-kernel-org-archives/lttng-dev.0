From: David Goulet <dgoulet@efficios.com>
Subject: Re: Segmentation fault in lttng-sessiond which is fixed
 in master
Date: Mon, 03 Dec 2012 14:41:14 -0500
Message-ID: <50BD005A.70303__38408.2126118757$1354563719$gmane$org@efficios.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F88254@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TfbtI-00007e-1o
	for lttng-dev@lists.lttng.org; Mon, 03 Dec 2012 14:41:20 -0500
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F88254@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Follow up. Just pushed a fix.

Please ping me if any problem occurs!

commit df3f5eb071e2af70de8a207ac41ea3cd5c1d44c3
Author: David Goulet <dgoulet@efficios.com>
Date:   Mon Dec 3 14:34:45 2012 -0500

    Fix: Delete UST app session on ustctl create error

    This has been updated in upstream master (see commit:
    0f83395d5e0e927fdab025eae023e68e9021af26).

    There was also a check missing at one of the callsite.

    http://lists.lttng.org/pipermail/lttng-dev/2012-December/019208.html

    Reported-by: David OShea <David.OShea@quantum.com>
    Signed-off-by: David Goulet <dgoulet@efficios.com>

Thanks!
David

David OShea:
> Hi all,
> 
> I'm using lttng-tools-2.0.4.  I got a segmentation fault in lttng-sessiond with this stack trace:
> 
> """
> #0  delete_ust_app_session (sock=-1, ua_sess=0xffffffffffffffff) at ust-app.c:147
> #1  0x000000000040cab5 in create_ust_app_session (usess=0x148adc10, app=0x148c0ef0) at ust-app.c:914
> #2  0x000000000040db14 in ust_app_global_update (usess=0x148adc10, sock=187) at ust-app.c:2309
> #3  0x0000000000412c96 in update_ust_app (app_sock=<optimized out>) at main.c:855
> #4  thread_manage_apps (data=<optimized out>) at main.c:1257
> #5  0x00002b872bffb617 in start_thread () from /lib64/libpthread.so.0
> #6  0x00002b872c2e3c2d in clone () from /lib64/libc.so.6
> #7  0x0000000000000000 in ?? ()
> """
> 
> It looks like in create_ust_app_session() this code must have executed:
> 
> """
> 	if (ua_sess->handle == -1) {
> 		ret = ustctl_create_session(app->sock);
> 		if (ret < 0) {
> 			ERR("Creating session for app pid %d", app->pid);
> 			/* This means that the tracer is gone... */
> 			ua_sess = (void*) -1UL;
> 			goto error;
> """
> 
> as this is the location of the call to delete_ust_app_session():
> 
> """
> error:
> 	delete_ust_app_session(-1, ua_sess);
> """
> 
> I see that in git master, this seems to have been fixed by:
> 
> """
> commit 0f83395d5e0e927fdab025eae023e68e9021af26
> Author: David Goulet <dgoulet@efficios.com>
> Date:   Mon Oct 29 14:49:50 2012 -0400
> 
>     Fix: Cleanup UST app session on ustctl create session error
> """
> 
> which ensures that ua_sess is not set to -1 until after delete_ust_app_session() is called.
> 
> I have two queries about this:
> 
> 1. Why is this error handling code being reached - what does the comment /* This means that the tracer is gone... */ mean - does it mean lttng-ust in a user process connected to the session daemon but the process went away or something like that?
> 
> 2. Should the above commit be merged into the stable branch?  I'm not concerned either way as I'll probably just apply the patch to 2.0.4 when I get a chance.
> 
> Thanks!
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
